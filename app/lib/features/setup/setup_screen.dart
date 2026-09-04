import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hayer_client/hayer_client.dart';
import 'package:intl/intl.dart';
import 'package:material_3_expressive/material_3_expressive.dart';

import '../../app/theme.dart';
import '../../core/page_title.dart';
import '../../core/providers.dart';
import '../../core/widgets/content_shell.dart';
import '../../core/widgets/search_area_map.dart';
import '../../l10n/generated/app_localizations.dart';
import 'setup_data.dart';
import 'setup_error.dart';
import 'setup_step_pager.dart';
import 'setup_timeline.dart';

class SetupScreen extends ConsumerStatefulWidget {
  const SetupScreen({super.key});

  @override
  ConsumerState<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends ConsumerState<SetupScreen> {
  int _step = 0;
  final _pageController = PageController();
  String? _categoryId;
  final _subcategories = <String>{};
  double? _latitude;
  double? _longitude;
  String? _address;
  int _radiusMeters = 3000;
  int? _priceLevel;
  int _deckSize = 10;
  DateTime? _visitAt;
  SessionMode _mode = SessionMode.solo;
  ConsensusRule _consensus = ConsensusRule.majority;
  bool _instant = false;
  bool _loading = false;
  bool _locating = false;
  String? _error;
  final _displayName = TextEditingController();
  final _locationSearch = TextEditingController();
  List<LocationSuggestion> _suggestions = const [];
  Timer? _debounce;
  Timer? _mapDebounce;

  @override
  void initState() {
    super.initState();
    unawaited(_adoptWarmedLocation());
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _mapDebounce?.cancel();
    _displayName.dispose();
    _locationSearch.dispose();
    _pageController.dispose();
    super.dispose();
  }

  bool get _canContinue => switch (_step) {
    0 => _categoryId != null,
    1 => _latitude != null && _longitude != null,
    2 => _mode == SessionMode.solo || _displayName.text.trim().length >= 2,
    _ => false,
  };

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    setBrowserPageTitle('${strings.newSearch} — ${strings.appName}');
    return Scaffold(
      appBar: M3EAppBar.top(
        automaticallyImplyLeading: true,
        title: Text(strings.appName),
        actions: [
          M3EIconButton(
            tooltip: strings.resumeSession,
            onPressed: _resumeLastSession,
            icon: const Icon(Icons.restore_rounded),
          ),
          M3EIconButton(
            onPressed: () => context.push('/join'),
            icon: const Icon(Icons.group_add_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: ContentShell(
          child: Column(
            children: [
              SetupTimeline(
                step: _step,
                labels: [
                  strings.setupTimelineType,
                  strings.setupTimelineWhere,
                  strings.setupTimelineMode,
                ],
                onSelect: _goToStep,
              ),
              Expanded(
                child: SetupStepPager(
                  controller: _pageController,
                  children: [
                    _stepScrollView(_typeStep(strings)),
                    _stepScrollView(_whereStep(strings)),
                    _stepScrollView(_modeStep(strings)),
                  ],
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
                        child: M3EButton.outlined(
                          onPressed: _loading
                              ? null
                              : () => _goToStep(_step - 1),
                          size: M3EButtonSize.md,
                          child: Text(strings.backLabel),
                        ),
                      ),
                    if (_step > 0) const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: M3EButton.filled(
                        onPressed: _canContinue && !_loading ? _advance : null,
                        size: M3EButtonSize.md,
                        child: _loading
                            ? const SizedBox.square(
                                dimension: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                _step == 2
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
    final languageCode = Localizations.localeOf(context).languageCode;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Heading(strings.setupWhatTitle),
        for (final category in setupCategories) ...[
          _CategoryCard(
            category: category,
            label: category.label(languageCode),
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
                  M3EChip(
                    type: M3EChipType.filter,
                    label:
                        '${strings.allLabel} ${category.label(languageCode)}',
                    selected: _subcategories.isEmpty,
                    onPressed: () => setState(_subcategories.clear),
                  ),
                  for (final item in category.subcategories.entries)
                    M3EChip(
                      type: M3EChipType.filter,
                      label: item.value.label(languageCode),
                      selected: _subcategories.contains(item.key),
                      onPressed: () => setState(() {
                        if (!_subcategories.contains(item.key) &&
                            _subcategories.length < 5) {
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
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            hintText: strings.searchLocation,
            prefixIcon: const Icon(Icons.search_rounded),
            suffixIcon: M3EIconButton(
              tooltip: strings.useCurrentLocation,
              onPressed: _locating ? null : _useLocation,
              icon: _locating
                  ? const Padding(
                      padding: EdgeInsets.all(12),
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.my_location_rounded),
            ),
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
                    onTap: () => _selectSuggestion(suggestion),
                  ),
              ],
            ),
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
              title: Text(_address ?? strings.currentLocation),
              subtitle: Text(strings.locationAddressAttribution),
            ),
          ),
          const SizedBox(height: 12),
          SearchAreaMap(
            latitude: _latitude!,
            longitude: _longitude!,
            radiusMeters: _radiusMeters,
            editable: true,
            onCenterChanged: _moveSearchCenter,
            onRadiusChanged: (value) => setState(() => _radiusMeters = value),
          ),
        ],
        const SizedBox(height: 14),
        Row(
          children: [
            const Icon(Icons.radar_rounded, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                '${strings.radius}: ${_formatDistance(_radiusMeters)}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _fineTuning(AppLocalizations strings) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _OptionSection(
          icon: Icons.payments_rounded,
          title: strings.price,
          description: strings.priceDescription,
          child: _AnimatedOptionSlider(
            value: (_priceLevel ?? 0).toDouble(),
            max: 4,
            icon: _priceLevel == null
                ? Icons.all_inclusive_rounded
                : Icons.payments_rounded,
            label: _priceLevel == null
                ? strings.anyPrice
                : strings.priceLevelValue(_priceLevel!),
            semanticLabel: strings.price,
            onChanged: (value) => setState(
              () => _priceLevel = value.round() == 0 ? null : value.round(),
            ),
          ),
        ),
        const SizedBox(height: 16),
        _OptionSection(
          icon: Icons.style_rounded,
          title: strings.deckSize,
          description: strings.deckSizeDescription,
          child: _AnimatedOptionSlider(
            value: ((_deckSize - 10) / 10).toDouble(),
            max: 4,
            icon: Icons.style_rounded,
            label: strings.placesCount(_deckSize),
            semanticLabel: strings.deckSize,
            onChanged: (value) =>
                setState(() => _deckSize = 10 + value.round() * 10),
          ),
        ),
        const SizedBox(height: 16),
        _OptionSection(
          icon: Icons.event_available_rounded,
          title: strings.visitTime,
          description: strings.visitTimeDescription,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                child: ListTile(
                  key: ValueKey(_visitAt),
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    child: Icon(
                      _visitAt == null
                          ? Icons.schedule_rounded
                          : Icons.event_available_rounded,
                    ),
                  ),
                  title: Text(
                    _visitAt == null
                        ? strings.anyTime
                        : DateFormat.yMMMEd(
                            Localizations.localeOf(context).toLanguageTag(),
                          ).add_jm().format(_visitAt!),
                    style: const TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
              ),
              M3EButton.icon(
                onPressed: _pickVisitTime,
                icon: const Icon(Icons.calendar_month_rounded),
                label: Text(strings.chooseVisitTime),
                style: M3EButtonStyle.tonal,
                size: M3EButtonSize.md,
              ),
              if (_visitAt != null)
                M3EButton.icon(
                  onPressed: () => setState(() => _visitAt = null),
                  icon: const Icon(Icons.clear_rounded),
                  label: Text(strings.clearVisitTime),
                  style: M3EButtonStyle.text,
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _modeStep(AppLocalizations strings) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Heading(strings.setupModeTitle),
        LayoutBuilder(
          builder: (context, constraints) {
            final cards = <Widget>[
              _ModeCard(
                label: strings.solo,
                description: strings.soloDescription,
                icon: Icons.person_rounded,
                selected: _mode == SessionMode.solo,
                onTap: () => setState(() => _mode = SessionMode.solo),
              ),
              _ModeCard(
                label: strings.multiplayer,
                description: strings.multiplayerDescription,
                icon: Icons.groups_rounded,
                selected: _mode == SessionMode.multiplayer,
                onTap: () => setState(() => _mode = SessionMode.multiplayer),
              ),
            ];
            if (constraints.maxWidth < 380) {
              return Column(
                children: [cards.first, const SizedBox(height: 12), cards.last],
              );
            }
            return Row(
              children: [
                Expanded(child: cards.first),
                const SizedBox(width: 12),
                Expanded(child: cards.last),
              ],
            );
          },
        ),
        if (_mode == SessionMode.multiplayer) ...[
          const SizedBox(height: 18),
          TextField(
            controller: _displayName,
            onChanged: (_) => setState(() {}),
            maxLength: 30,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              labelText: strings.displayName,
              prefixIcon: const Icon(Icons.person_outline),
            ),
          ),
          Wrap(
            spacing: 8,
            children: [
              M3EChip(
                type: M3EChipType.filter,
                label: strings.majority,
                selected: _consensus == ConsensusRule.majority,
                onPressed: () =>
                    setState(() => _consensus = ConsensusRule.majority),
              ),
              M3EChip(
                type: M3EChipType.filter,
                label: strings.unanimous,
                selected: _consensus == ConsensusRule.unanimous,
                onPressed: () =>
                    setState(() => _consensus = ConsensusRule.unanimous),
              ),
            ],
          ),
          const SizedBox(height: 8),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Row(
              key: ValueKey(_consensus),
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  size: 17,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 7),
                Expanded(
                  child: Text(
                    _consensus == ConsensusRule.majority
                        ? strings.majorityTip
                        : strings.unanimousTip,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(strings.stopOnFirstMatch),
            onTap: () => setState(() => _instant = !_instant),
            trailing: M3ESwitch(
              value: _instant,
              semanticLabel: strings.stopOnFirstMatch,
              onChanged: (value) => setState(() => _instant = value),
            ),
          ),
        ],
        const SizedBox(height: 18),
        Card(
          clipBehavior: Clip.antiAlias,
          child: ExpansionTile(
            leading: const Icon(Icons.tune_rounded),
            title: Text(
              strings.setupOptionsTitle,
              style: const TextStyle(fontWeight: FontWeight.w900),
            ),
            childrenPadding: const EdgeInsets.fromLTRB(12, 0, 12, 14),
            children: [_fineTuning(strings)],
          ),
        ),
      ],
    );
  }

  Future<void> _advance() async {
    if (_step < 2) {
      _goToStep(_step + 1);
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
              visitAt: _visitAt?.toUtc(),
              radiusMeters: _radiusMeters,
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

  void _selectSuggestion(LocationSuggestion suggestion) {
    setState(() {
      _latitude = suggestion.latitude;
      _longitude = suggestion.longitude;
      _address = suggestion.fullText;
      _locationSearch.text = suggestion.fullText;
      _suggestions = const [];
    });
  }

  void _moveSearchCenter(double latitude, double longitude) {
    _mapDebounce?.cancel();
    setState(() {
      _latitude = latitude;
      _longitude = longitude;
      _address = null;
      _suggestions = const [];
      _locationSearch.text =
          '${latitude.toStringAsFixed(5)}, ${longitude.toStringAsFixed(5)}';
    });
    _mapDebounce = Timer(const Duration(milliseconds: 450), () async {
      try {
        final address = await ref
            .read(clientProvider)
            .place
            .reverseGeocode(
              latitude: latitude,
              longitude: longitude,
              languageCode: Localizations.localeOf(context).languageCode,
            );
        if (!mounted || _latitude != latitude || _longitude != longitude) {
          return;
        }
        setState(() {
          _address = address;
          _locationSearch.text = address;
        });
      } catch (_) {}
    });
  }

  Future<void> _useLocation() async {
    final strings = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).languageCode;
    final client = ref.read(clientProvider);
    setState(() {
      _locating = true;
      _error = null;
    });
    try {
      final position = await ref
          .read(locationWarmupProvider)
          .locate(requestPermission: true);
      if (position == null) {
        if (!mounted) return;
        setState(() => _error = strings.locationPermissionRequired);
        return;
      }
      final address = await client.place.reverseGeocode(
        latitude: position.latitude,
        longitude: position.longitude,
        languageCode: locale,
      );
      if (!mounted) return;
      setState(() {
        _latitude = position.latitude;
        _longitude = position.longitude;
        _address = address;
        _locationSearch.text = address;
        _suggestions = const [];
      });
    } catch (error) {
      if (mounted) setState(() => _error = _friendlyError(error));
    } finally {
      if (mounted) setState(() => _locating = false);
    }
  }

  Future<void> _adoptWarmedLocation() async {
    final position = await ref.read(locationWarmupProvider).ready;
    if (!mounted || position == null || _latitude != null) return;
    setState(() {
      _latitude = position.latitude;
      _longitude = position.longitude;
    });
    try {
      final address = await ref
          .read(clientProvider)
          .place
          .reverseGeocode(
            latitude: position.latitude,
            longitude: position.longitude,
            languageCode: Localizations.localeOf(context).languageCode,
          );
      if (!mounted || _latitude != position.latitude) return;
      setState(() {
        _address = address;
        _locationSearch.text = address;
      });
    } catch (_) {}
  }

  Future<void> _pickVisitTime() async {
    FocusManager.instance.primaryFocus?.unfocus();
    final now = DateTime.now();
    final initial = _visitAt ?? now.add(const Duration(hours: 1));
    final isApple =
        defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS;
    DateTime? selected;
    if (isApple) {
      var candidate = initial;
      final confirmed = await showCupertinoModalPopup<bool>(
        context: context,
        builder: (sheetContext) => Container(
          height: 360,
          color: CupertinoColors.systemBackground.resolveFrom(sheetContext),
          child: SafeArea(
            top: false,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CupertinoButton(
                      onPressed: () => Navigator.pop(sheetContext, false),
                      child: Text(
                        MaterialLocalizations.of(context).cancelButtonLabel,
                      ),
                    ),
                    CupertinoButton(
                      onPressed: () => Navigator.pop(sheetContext, true),
                      child: Text(
                        MaterialLocalizations.of(context).okButtonLabel,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.dateAndTime,
                    initialDateTime: initial,
                    minimumDate: now,
                    maximumDate: now.add(const Duration(days: 90)),
                    use24hFormat: MediaQuery.alwaysUse24HourFormatOf(context),
                    onDateTimeChanged: (value) => candidate = value,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
      if (confirmed == true) selected = candidate;
    } else {
      final date = await showDatePicker(
        context: context,
        initialDate: initial,
        firstDate: DateTime(now.year, now.month, now.day),
        lastDate: now.add(const Duration(days: 90)),
      );
      if (date == null || !mounted) return;
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initial),
      );
      if (time == null) return;
      selected = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    }
    if (!mounted || selected == null) return;
    if (selected.isBefore(now)) {
      setState(
        () => _error = AppLocalizations.of(context)!.futureVisitTime,
      );
      return;
    }
    setState(() {
      _visitAt = selected;
      _error = null;
    });
  }

  void _goToStep(int value) {
    if (value == _step || value < 0 || value > 2) return;
    setState(() => _step = value);
    unawaited(
      _pageController.animateToPage(
        value,
        duration: const Duration(milliseconds: 340),
        curve: Curves.easeOutCubic,
      ),
    );
    if (value == 1 && _latitude == null && !_locating) {
      unawaited(_useLocation());
    }
  }

  Future<void> _resumeLastSession() async {
    try {
      final repository = ref.read(sessionRepositoryProvider);
      final sessionId = await repository.activeSessionId();
      if (sessionId == null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.noSavedSession),
            ),
          );
        }
        return;
      }
      final bundle = await repository.load(sessionId);
      if (!mounted) return;
      if (bundle.session.status != SessionStatus.active) {
        context.go('/results/$sessionId');
      } else if (bundle.session.mode == SessionMode.multiplayer) {
        context.go('/lobby/$sessionId', extra: bundle);
      } else {
        context.go('/swipe/$sessionId', extra: bundle);
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.resumeFailed)),
        );
      }
    }
  }

  Widget _stepScrollView(Widget child) => SingleChildScrollView(
    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
    padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
    child: child,
  );

  String _friendlyError(Object error) =>
      setupErrorMessage(error, AppLocalizations.of(context)!);

  String _formatDistance(int meters) =>
      meters < 1000 ? '$meters m' : '${meters ~/ 1000} km';
}

class _AnimatedOptionSlider extends StatelessWidget {
  const _AnimatedOptionSlider({
    required this.value,
    required this.max,
    required this.icon,
    required this.label,
    required this.semanticLabel,
    required this.onChanged,
  });

  final double value;
  final double max;
  final IconData icon;
  final String label;
  final String semanticLabel;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final progress = value / max;
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 260),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          decoration: BoxDecoration(
            color: Color.lerp(
              colors.surfaceContainerHighest,
              colors.primaryContainer,
              .25 + progress * .75,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween(end: 1 + progress * .22),
                duration: const Duration(milliseconds: 260),
                curve: Curves.easeOutBack,
                builder: (context, scale, child) =>
                    Transform.scale(scale: scale, child: child),
                child: Icon(icon, color: colors.primary),
              ),
              const SizedBox(width: 10),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                transitionBuilder: (child, animation) => FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(scale: animation, child: child),
                ),
                child: Text(
                  label,
                  key: ValueKey(label),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: colors.onPrimaryContainer,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
        ),
        M3ESlider(
          value: value,
          max: max,
          divisions: max.round(),
          haptic: M3EHapticFeedback.light,
          semanticFormatterCallback: (_) => '$semanticLabel: $label',
          onChanged: onChanged,
        ),
      ],
    );
  }
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
    required this.label,
    required this.selected,
    required this.onTap,
  });
  final SetupCategory category;
  final String label;
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
                      label,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(
                        context,
                      )!.typesCount(category.subcategories.length),
                    ),
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
    required this.description,
    required this.icon,
    required this.selected,
    required this.onTap,
  });
  final String label;
  final String description;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: selected ? colors.primaryContainer : colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: selected ? colors.primary : colors.outlineVariant,
          width: selected ? 2 : 1,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          child: Column(
            children: [
              Icon(icon, size: 38, color: colors.primary),
              const SizedBox(height: 10),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OptionSection extends StatelessWidget {
  const _OptionSection({
    required this.icon,
    required this.title,
    required this.description,
    required this.child,
  });

  final IconData icon;
  final String title;
  final String description;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: colors.primaryContainer,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Icon(icon, color: colors.primary),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w900,
                            ),
                      ),
                      Text(
                        description,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}
