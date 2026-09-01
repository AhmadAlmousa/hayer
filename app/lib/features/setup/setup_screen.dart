import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:hayer_client/hayer_client.dart';

import '../../app/theme.dart';
import '../../core/providers.dart';
import '../../core/widgets/content_shell.dart';
import '../../l10n/generated/app_localizations.dart';
import 'setup_data.dart';

class SetupScreen extends ConsumerStatefulWidget {
  const SetupScreen({super.key});

  @override
  ConsumerState<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends ConsumerState<SetupScreen> {
  int _step = 0;
  String? _categoryId;
  final _subcategories = <String>{};
  double? _latitude;
  double? _longitude;
  String? _address;
  int _radiusIndex = 2;
  int? _priceLevel;
  int _deckSize = 20;
  SessionMode _mode = SessionMode.solo;
  ConsensusRule _consensus = ConsensusRule.majority;
  bool _instant = false;
  bool _loading = false;
  String? _error;
  final _displayName = TextEditingController();
  final _locationSearch = TextEditingController();
  List<LocationSuggestion> _suggestions = const [];
  Timer? _debounce;

  static const _radii = [500, 1000, 3000, 5000, 10000];

  @override
  void dispose() {
    _debounce?.cancel();
    _displayName.dispose();
    _locationSearch.dispose();
    super.dispose();
  }

  bool get _canContinue => switch (_step) {
    0 => _categoryId != null,
    1 => _latitude != null && _longitude != null,
    2 => true,
    3 => _mode == SessionMode.solo || _displayName.text.trim().length >= 2,
    _ => false,
  };

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(strings.appName),
        actions: [
          IconButton(
            onPressed: () => context.push('/join'),
            icon: const Icon(Icons.group_add_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: ContentShell(
          child: Column(
            children: [
              _Timeline(
                step: _step,
                onSelect: (value) => setState(() => _step = value),
              ),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 280),
                  transitionBuilder: (child, animation) => FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween(
                        begin: const Offset(0, .025),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    ),
                  ),
                  child: SingleChildScrollView(
                    key: ValueKey(_step),
                    padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
                    child: switch (_step) {
                      0 => _typeStep(strings),
                      1 => _whereStep(strings),
                      2 => _optionsStep(strings),
                      _ => _modeStep(strings),
                    },
                  ),
                ),
              ),
              if (_error != null)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 4,
                  ),
                  child: Text(
                    _error!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                child: Row(
                  children: [
                    if (_step > 0)
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _loading
                              ? null
                              : () => setState(() => _step--),
                          child: Text(strings.backLabel),
                        ),
                      ),
                    if (_step > 0) const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: FilledButton(
                        onPressed: _canContinue && !_loading ? _advance : null,
                        child: _loading
                            ? const SizedBox.square(
                                dimension: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                _step == 3
                                    ? (_mode == SessionMode.solo
                                          ? strings.startSwiping
                                          : strings.createSession)
                                    : strings.continueLabel,
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _typeStep(AppLocalizations strings) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Heading(strings.setupWhatTitle),
        for (final category in setupCategories) ...[
          _CategoryCard(
            category: category,
            selected: _categoryId == category.id,
            onTap: () => setState(() {
              if (_categoryId != category.id) _subcategories.clear();
              _categoryId = category.id;
            }),
          ),
          if (_categoryId == category.id)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  FilterChip(
                    label: Text('All ${category.label}'),
                    selected: _subcategories.isEmpty,
                    onSelected: (_) => setState(_subcategories.clear),
                  ),
                  for (final item in category.subcategories.entries)
                    FilterChip(
                      label: Text(item.value),
                      selected: _subcategories.contains(item.key),
                      onSelected: (selected) => setState(() {
                        if (selected && _subcategories.length < 5) {
                          _subcategories.add(item.key);
                        } else {
                          _subcategories.remove(item.key);
                        }
                      }),
                    ),
                ],
              ),
            ),
        ],
      ],
    );
  }

  Widget _whereStep(AppLocalizations strings) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Heading(strings.setupWhereTitle),
        TextField(
          controller: _locationSearch,
          onChanged: _searchLocations,
          decoration: InputDecoration(
            hintText: strings.searchLocation,
            prefixIcon: const Icon(Icons.search_rounded),
          ),
        ),
        if (_suggestions.isNotEmpty)
          Card(
            child: Column(
              children: [
                for (final suggestion in _suggestions)
                  ListTile(
                    leading: const Icon(Icons.location_on_outlined),
                    title: Text(suggestion.mainText),
                    subtitle: suggestion.secondaryText == null
                        ? null
                        : Text(suggestion.secondaryText!),
                    onTap: () => setState(() {
                      _latitude = suggestion.latitude;
                      _longitude = suggestion.longitude;
                      _address = suggestion.fullText;
                      _locationSearch.text = suggestion.fullText;
                      _suggestions = const [];
                    }),
                  ),
              ],
            ),
          ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: _useLocation,
          icon: const Icon(Icons.my_location_rounded),
          label: Text(strings.useCurrentLocation),
        ),
        if (_latitude != null) ...[
          const SizedBox(height: 16),
          Card(
            color: HayerTheme.success.withValues(alpha: .12),
            child: ListTile(
              leading: const Icon(
                Icons.check_circle_rounded,
                color: HayerTheme.success,
              ),
              title: Text(_address ?? 'Current location'),
              subtitle: Text(
                '${_latitude!.toStringAsFixed(4)}, ${_longitude!.toStringAsFixed(4)}',
              ),
            ),
          ),
        ],
        const SizedBox(height: 24),
        Text(
          '${strings.radius}: ${_formatDistance(_radii[_radiusIndex])}',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
        ),
        Slider(
          value: _radiusIndex.toDouble(),
          min: 0,
          max: 4,
          divisions: 4,
          onChanged: (value) => setState(() => _radiusIndex = value.round()),
        ),
      ],
    );
  }

  Widget _optionsStep(AppLocalizations strings) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Heading(strings.setupOptionsTitle),
        Text(
          strings.price,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          children: [
            for (var price = 0; price <= 4; price++)
              ChoiceChip(
                label: Text(price == 0 ? strings.anyPrice : r'$' * price),
                selected:
                    (price == 0 && _priceLevel == null) || _priceLevel == price,
                onSelected: (_) =>
                    setState(() => _priceLevel = price == 0 ? null : price),
              ),
          ],
        ),
        const SizedBox(height: 28),
        Text(
          strings.deckSize,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (final size in const [10, 20, 30, 40, 50])
              ChoiceChip(
                label: SizedBox(
                  width: 36,
                  child: Text('$size', textAlign: TextAlign.center),
                ),
                selected: _deckSize == size,
                onSelected: (_) => setState(() => _deckSize = size),
              ),
          ],
        ),
      ],
    );
  }

  Widget _modeStep(AppLocalizations strings) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Heading(strings.setupModeTitle),
        Row(
          children: [
            Expanded(
              child: _ModeCard(
                label: strings.solo,
                emoji: '🎯',
                selected: _mode == SessionMode.solo,
                onTap: () => setState(() => _mode = SessionMode.solo),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _ModeCard(
                label: strings.multiplayer,
                emoji: '👥',
                selected: _mode == SessionMode.multiplayer,
                onTap: () => setState(() => _mode = SessionMode.multiplayer),
              ),
            ),
          ],
        ),
        if (_mode == SessionMode.multiplayer) ...[
          const SizedBox(height: 18),
          TextField(
            controller: _displayName,
            onChanged: (_) => setState(() {}),
            maxLength: 30,
            decoration: InputDecoration(
              labelText: strings.displayName,
              prefixIcon: const Icon(Icons.person_outline),
            ),
          ),
          Wrap(
            spacing: 8,
            children: [
              ChoiceChip(
                label: Text(strings.majority),
                selected: _consensus == ConsensusRule.majority,
                onSelected: (_) =>
                    setState(() => _consensus = ConsensusRule.majority),
              ),
              ChoiceChip(
                label: Text(strings.unanimous),
                selected: _consensus == ConsensusRule.unanimous,
                onSelected: (_) =>
                    setState(() => _consensus = ConsensusRule.unanimous),
              ),
            ],
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(strings.stopOnFirstMatch),
            value: _instant,
            onChanged: (value) => setState(() => _instant = value),
          ),
        ],
      ],
    );
  }

  Future<void> _advance() async {
    if (_step < 3) {
      setState(() => _step++);
      return;
    }
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final bundle = await ref
          .read(sessionRepositoryProvider)
          .create(
            CreateSessionRequest(
              mode: _mode,
              categoryId: _categoryId!,
              subcategoryIds: _subcategories.toList(),
              priceLevel: _priceLevel,
              anchorLatitude: _latitude!,
              anchorLongitude: _longitude!,
              anchorAddress: _address,
              radiusMeters: _radii[_radiusIndex],
              deckSize: _deckSize,
              displayName: _mode == SessionMode.multiplayer
                  ? _displayName.text.trim()
                  : 'Solo',
              consensusRule: _consensus,
              matchingTiming: _instant
                  ? MatchingTiming.instant
                  : MatchingTiming.afterDeck,
            ),
          );
      if (!mounted) return;
      final route = _mode == SessionMode.solo ? 'swipe' : 'lobby';
      context.go('/$route/${bundle.session.sessionId}', extra: bundle);
    } catch (error) {
      setState(() => _error = _friendlyError(error));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _searchLocations(String value) {
    _debounce?.cancel();
    if (value.trim().length < 3) {
      setState(() => _suggestions = const []);
      return;
    }
    _debounce = Timer(const Duration(milliseconds: 350), () async {
      try {
        final client = ref.read(clientProvider);
        final values = await client.place.suggest(
          query: value,
          latitude: _latitude,
          longitude: _longitude,
          countryCode: 'SA',
        );
        if (mounted && _locationSearch.text == value) {
          setState(() => _suggestions = values);
        }
      } catch (_) {}
    });
  }

  Future<void> _useLocation() async {
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      setState(
        () => _error =
            'Location permission is required to use your current location.',
      );
      return;
    }
    final position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );
    setState(() {
      _latitude = position.latitude;
      _longitude = position.longitude;
      _address = 'Current location';
      _locationSearch.text = _address!;
    });
  }

  String _friendlyError(Object error) {
    if (error is ApiException) return error.message;
    return AppLocalizations.of(context)!.temporarySourceError;
  }

  String _formatDistance(int meters) =>
      meters < 1000 ? '$meters m' : '${meters ~/ 1000} km';
}

class _Heading extends StatelessWidget {
  const _Heading(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: Text(
      text,
      style: Theme.of(
        context,
      ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900),
    ),
  );
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({
    required this.category,
    required this.selected,
    required this.onTap,
  });
  final SetupCategory category;
  final bool selected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Card(
      color: selected ? colors.primaryContainer : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: selected ? colors.primary : colors.outlineVariant,
          width: selected ? 2 : 1,
        ),
      ),
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Text(category.emoji, style: const TextStyle(fontSize: 34)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category.label,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text('${category.subcategories.length} types'),
                  ],
                ),
              ),
              Icon(
                selected
                    ? Icons.check_circle_rounded
                    : Icons.chevron_right_rounded,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ModeCard extends StatelessWidget {
  const _ModeCard({
    required this.label,
    required this.emoji,
    required this.selected,
    required this.onTap,
  });
  final String label;
  final String emoji;
  final bool selected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Card(
    color: selected ? Theme.of(context).colorScheme.primaryContainer : null,
    child: InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 36)),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(fontWeight: FontWeight.w900)),
          ],
        ),
      ),
    ),
  );
}

class _Timeline extends StatelessWidget {
  const _Timeline({required this.step, required this.onSelect});
  final int step;
  final ValueChanged<int> onSelect;
  @override
  Widget build(BuildContext context) {
    const labels = ['Type', 'Where', 'Options', 'Mode'];
    return SizedBox(
      height: 84,
      child: Row(
        children: [
          for (var index = 0; index < labels.length; index++) ...[
            Expanded(
              child: InkWell(
                onTap: index <= step ? () => onSelect(index) : null,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: index == step ? 17 : 15,
                      backgroundColor: index <= step
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(
                              context,
                            ).colorScheme.surfaceContainerHighest,
                      foregroundColor: index <= step
                          ? Theme.of(context).colorScheme.onPrimary
                          : Theme.of(context).colorScheme.onSurfaceVariant,
                      child: index < step
                          ? const Icon(Icons.check, size: 18)
                          : Text('${index + 1}'),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      labels[index],
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: index == step
                            ? FontWeight.w900
                            : FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (index < labels.length - 1)
              Container(
                width: 20,
                height: 2,
                color: index < step
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.outlineVariant,
              ),
          ],
        ],
      ),
    );
  }
}
