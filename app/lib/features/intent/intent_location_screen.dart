import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hayer_client/hayer_client.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/providers.dart';
import '../../core/widgets/content_shell.dart';
import '../../core/widgets/location_search_field.dart';
import '../../core/widgets/search_area_map.dart';
import 'intent_copy.dart';
import 'intent_process_timeline.dart';
import 'place_intent_controller.dart';

class IntentLocationScreen extends ConsumerStatefulWidget {
  const IntentLocationScreen({super.key});

  @override
  ConsumerState<IntentLocationScreen> createState() =>
      _IntentLocationScreenState();
}

class _IntentLocationScreenState extends ConsumerState<IntentLocationScreen> {
  final _search = TextEditingController();
  final _searchKey = GlobalKey<LocationSearchFieldState>();
  bool _choosing = false;
  bool _locating = false;
  String? _error;
  int _revision = 0;
  Timer? _mapDebounce;

  @override
  void initState() {
    super.initState();
    final intent = ref.read(placeIntentProvider);
    _search.text = intent.address ?? '';
  }

  @override
  void dispose() {
    _mapDebounce?.cancel();
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final copy = IntentCopy(context);
    final intent = ref.watch(placeIntentProvider);
    if (!intent.hasWhat) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) context.go('/');
      });
    }
    final latitude = intent.latitude ?? 24.7136;
    final longitude = intent.longitude ?? 46.6753;
    void back() => context.go('/');
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) back();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(copy.where),
          leading: BackButton(onPressed: back),
        ),
        bottomNavigationBar: IntentStepActions(
          onBack: back,
          onNext: intent.hasWhere ? () => context.go('/next') : null,
        ),
        body: SafeArea(
          child: ContentShell(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
              children: [
                IntentProcessTimeline(step: 1, onStep: (_) => back()),
                Text(
                  copy.wherePrompt,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 18),
                FilledButton.icon(
                  key: const ValueKey('intent-current-location'),
                  onPressed: _locating ? null : _useCurrent,
                  icon: _locating
                      ? const SizedBox.square(
                          dimension: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.my_location_rounded),
                  label: Text(copy.currentLocation),
                ),
                const SizedBox(height: 10),
                OutlinedButton.icon(
                  key: const ValueKey('intent-choose-area'),
                  onPressed: () {
                    setState(() => _choosing = !_choosing);
                  },
                  icon: const Icon(Icons.map_outlined),
                  label: Text(copy.chooseArea),
                ),
                if (_error case final error?) ...[
                  const SizedBox(height: 12),
                  Text(
                    error,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ],
                if (_choosing) ...[
                  const SizedBox(height: 18),
                  LocationSearchField(
                    key: _searchKey,
                    controller: _search,
                    latitude: latitude,
                    longitude: longitude,
                    locating: _locating,
                    onUseCurrentLocation: _useCurrent,
                    onSelected: _selectSuggestion,
                  ),
                  const SizedBox(height: 12),
                  SearchAreaMap(
                    latitude: latitude,
                    longitude: longitude,
                    radiusMeters: intent.radiusMeters,
                    editable: true,
                    onCenterChanged: _moveCenter,
                    onRadiusChanged: ref
                        .read(placeIntentProvider.notifier)
                        .setRadius,
                  ),
                  const SizedBox(height: 14),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _useCurrent() async {
    final revision = ++_revision;
    setState(() {
      _locating = true;
      _error = null;
    });
    try {
      final position = await ref
          .read(locationWarmupProvider)
          .locate(requestPermission: true);
      if (!mounted || revision != _revision) return;
      if (position == null) {
        setState(
          () => _error = IntentCopy(context).ar
              ? 'اسمح بالوصول إلى الموقع أو اختر منطقة.'
              : 'Allow location access or choose another area.',
        );
        return;
      }
      ref
          .read(placeIntentProvider.notifier)
          .setLocation(
            latitude: position.latitude,
            longitude: position.longitude,
          );
      _search.text =
          '${position.latitude.toStringAsFixed(5)}, ${position.longitude.toStringAsFixed(5)}';
      unawaited(_enrich(position.latitude, position.longitude, revision));
    } catch (_) {
      if (mounted) {
        setState(
          () => _error = IntentCopy(context).ar
              ? 'تعذر تحديد الموقع الآن.'
              : 'Could not determine your location.',
        );
      }
    } finally {
      if (mounted) setState(() => _locating = false);
    }
  }

  void _selectSuggestion(LocationSuggestion suggestion) {
    final revision = ++_revision;
    _search.text = suggestion.fullText;
    ref
        .read(placeIntentProvider.notifier)
        .setLocation(
          latitude: suggestion.latitude,
          longitude: suggestion.longitude,
          address: suggestion.fullText,
        );
    setState(() => _error = null);
    unawaited(_enrich(suggestion.latitude, suggestion.longitude, revision));
  }

  void _moveCenter(double latitude, double longitude) {
    _mapDebounce?.cancel();
    final revision = ++_revision;
    _searchKey.currentState?.clearSuggestions();
    _search.text =
        '${latitude.toStringAsFixed(5)}, ${longitude.toStringAsFixed(5)}';
    ref
        .read(placeIntentProvider.notifier)
        .setLocation(
          latitude: latitude,
          longitude: longitude,
        );
    _mapDebounce = Timer(
      const Duration(milliseconds: 450),
      () => unawaited(_enrich(latitude, longitude, revision)),
    );
  }

  Future<void> _enrich(
    double latitude,
    double longitude,
    int revision,
  ) async {
    try {
      final address = await ref
          .read(locationRepositoryProvider)
          .reverseGeocode(
            latitude: latitude,
            longitude: longitude,
            languageCode: Localizations.localeOf(context).languageCode,
          );
      if (!mounted || revision != _revision || address.trim().isEmpty) return;
      ref
          .read(placeIntentProvider.notifier)
          .setLocation(
            latitude: latitude,
            longitude: longitude,
            address: address,
          );
      _search.text = address;
    } catch (_) {}
  }
}
