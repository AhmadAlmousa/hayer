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
import '../../core/display_formatters.dart';
import '../../core/page_title.dart';
import '../../core/providers.dart';
import '../../core/widgets/content_shell.dart';
import '../../core/widgets/adaptive_actions.dart';
import '../../core/widgets/search_area_map.dart';
import '../../l10n/generated/app_localizations.dart';
import 'setup_data.dart';
import 'setup_error.dart';
import 'multiplayer_decision_options.dart';
import 'setup_preferences.dart';
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
  VisitTimeChoice _visitTimeChoice = VisitTimeChoice.anyTime;
  SessionMode _mode = SessionMode.solo;
  ConsensusRule _consensus = ConsensusRule.majority;
  bool _instant = false;
  bool _loading = false;
  bool _locating = false;
  String? _error;
  final _displayName = TextEditingController();
  final _locationSearch = TextEditingController();
  List<LocationSuggestion> _suggestions = const [];
  bool _searching = false;
  bool _searchFailed = false;
  bool _searchComplete = false;
  int _searchRevision = 0;
  int _locationRevision = 0;
  Timer? _debounce;
  Timer? _mapDebounce;
  List<SetupCategory> _categories = setupCategories;
  bool _journeyStarted = false;

  @override
  void initState() {
    super.initState();
    unawaited(_adoptWarmedLocation());
    unawaited(_restoreDisplayName());
    unawaited(_loadTaxonomy());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_journeyStarted) return;
    _journeyStarted = true;
    unawaited(
      ref
          .read(sessionRepositoryProvider)
          .beginJourney(
            entryPoint: 'setup',
            language: Localizations.localeOf(context).languageCode,
          ),
    );
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
      body: SafeArea(
        child: ContentShell(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 14),
                child: SetupTimeline(
                  step: _step,
                  labels: [
                    strings.setupTimelineType,
                    strings.setupTimelineWhere,
                    strings.setupTimelineMode,
                  ],
                  onSelect: _goToStep,
                ),
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
                  child: Semantics(
                    liveRegion: true,
                    child: Text(
                      _error!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                child: AdaptiveActions(
                  children: [
                    if (_step > 0)
                      OutlinedButton(
                        onPressed: _loading ? null : () => _goToStep(_step - 1),
                        child: Text(strings.backLabel),
                      ),
                    FilledButton(
                      onPressed: _canContinue && !_loading ? _advance : null,
                      child: _loading
                          ? const SizedBox.square(
                              dimension: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            )
                          : _step == 2 && _mode == SessionMode.solo
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(child: Text(strings.startSwiping)),
                                const SizedBox(width: 8),
                                const Icon(Icons.arrow_forward_rounded),
                              ],
                            )
                          : Text(
                              _step == 2
                                  ? strings.createSession
                                  : strings.continueLabel,
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
        for (final category in _categories) ...[
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: FilterChip(
                      label: Text(
                        '${strings.allLabel} ${category.label(languageCode)}',
                      ),
                      selected: _subcategories.isEmpty,
                      onSelected: (_) => setState(_subcategories.clear),
                    ),
                  ),
                  if (category.cuisines.isNotEmpty)
                    _taxonomyOptions(
                      strings.cuisinesLabel,
                      category.cuisines,
                      languageCode,
                    ),
                  if (category.types.isNotEmpty)
                    _taxonomyOptions(
                      strings.poiTypesLabel,
                      category.types,
                      languageCode,
                    ),
                ],
              ),
            ),
        ],
      ],
    );
  }

  Widget _taxonomyOptions(
    String title,
    Map<String, SetupSubcategory> values,
    String languageCode,
  ) => Padding(
    padding: const EdgeInsets.only(top: 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 7),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final item in values.entries)
              FilterChip(
                label: Text(item.value.label(languageCode)),
                selected: _subcategories.contains(item.key),
                onSelected: (_) => setState(() {
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
      ],
    ),
  );

  Future<void> _loadTaxonomy() async {
    try {
      final snapshot = await ref.read(clientProvider).taxonomy.current();
      final categories = setupCategoriesFromSnapshot(snapshot);
      if (!mounted || categories.isEmpty) return;
      setState(() {
        _categories = categories;
        if (_categoryId != null &&
            !_categories.any((category) => category.id == _categoryId)) {
          _categoryId = null;
          _subcategories.clear();
        } else if (_categoryId != null) {
          final valid = _categories
              .firstWhere((category) => category.id == _categoryId)
              .subcategories
              .keys;
          _subcategories.removeWhere((id) => !valid.contains(id));
        }
      });
    } catch (_) {
      // The bundled taxonomy remains available for cold starts and old servers.
    }
  }

  Widget _whereStep(AppLocalizations strings) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Heading(strings.setupWhereTitle),
        TextField(
          controller: _locationSearch,
          onChanged: _searchLocations,
          onSubmitted: _searchLocations,
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
        if (_searching)
          Semantics(
            liveRegion: true,
            label: strings.searchingLocations,
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: LinearProgressIndicator(),
            ),
          ),
        if (_searchFailed)
          Semantics(
            liveRegion: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(strings.locationSearchFailed),
                TextButton.icon(
                  onPressed: () => _searchLocations(_locationSearch.text),
                  icon: const Icon(Icons.refresh_rounded),
                  label: Text(strings.tryAgain),
                ),
              ],
            ),
          ),
        if (_searchComplete && _suggestions.isEmpty)
          Semantics(
            liveRegion: true,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(strings.noLocationResults),
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
              // The audit's F29 names this step: it is where a location is
              // chosen, so it is where the account of what happens to it
              // belongs.
              trailing: IconButton(
                key: const ValueKey('setup-data-and-privacy'),
                tooltip: strings.dataAndPrivacy,
                onPressed: () => context.push('/data'),
                icon: const Icon(Icons.privacy_tip_outlined),
              ),
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
                '${strings.radius}: ${formatDistance(context, _radiusMeters)}',
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
        _CompactOptionSlider(
          title: strings.price,
          value: (_priceLevel ?? 0).toDouble(),
          max: 4,
          label: priceLevelLabel(
            _priceLevel,
            anyPriceLabel: strings.anyPrice,
          ),
          onChanged: (value) => setState(
            () => _priceLevel = value.round() == 0 ? null : value.round(),
          ),
        ),
        const SizedBox(height: 12),
        _CompactOptionSlider(
          title: strings.deckSize,
          value: ((_deckSize - 10) / 10).toDouble(),
          max: 4,
          label: strings.placesCount(_deckSize),
          onChanged: (value) =>
              setState(() => _deckSize = 10 + value.round() * 10),
        ),
        const SizedBox(height: 16),
        Text(
          strings.visitTime,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 8),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: M3ESplitButton<VisitTimeChoice>.tonal(
            label: switch (_visitTimeChoice) {
              VisitTimeChoice.anyTime => strings.anyTime,
              VisitTimeChoice.openNow => strings.openNow,
              VisitTimeChoice.custom => strings.customTime,
            },
            leadingIcon: switch (_visitTimeChoice) {
              VisitTimeChoice.anyTime => Icons.all_inclusive_rounded,
              VisitTimeChoice.openNow => Icons.schedule_rounded,
              VisitTimeChoice.custom => Icons.event_available_rounded,
            },
            size: M3EButtonSize.md,
            selectedValue: _visitTimeChoice,
            onPressed: _visitTimeChoice == VisitTimeChoice.custom
                ? _pickVisitTime
                : () {},
            onSelected: (value) {
              if (value == VisitTimeChoice.custom) {
                _pickVisitTime();
              } else {
                setState(() {
                  _visitTimeChoice = value;
                  _visitAt = null;
                });
              }
            },
            items: [
              M3ESplitButtonItem<VisitTimeChoice>(
                value: VisitTimeChoice.anyTime,
                child: Text(strings.anyTime),
              ),
              M3ESplitButtonItem<VisitTimeChoice>(
                value: VisitTimeChoice.openNow,
                child: Text(strings.openNow),
              ),
              M3ESplitButtonItem<VisitTimeChoice>(
                value: VisitTimeChoice.custom,
                child: Text(strings.customTime),
              ),
            ],
          ),
        ),
        if (_visitTimeChoice == VisitTimeChoice.custom && _visitAt != null) ...[
          const SizedBox(height: 8),
          Text(
            DateFormat.yMMMEd(
              Localizations.localeOf(context).toLanguageTag(),
            ).add_jm().format(_visitAt!),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ],
    );
  }

  Widget _modeStep(AppLocalizations strings) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Heading(strings.setupModeTitle),
        AdaptiveActions(
          children: [
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
          ],
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
          MultiplayerDecisionOptions(
            majoritySelected: _consensus == ConsensusRule.majority,
            stopOnFirstMatch: _instant,
            onSelectMajority: () =>
                setState(() => _consensus = ConsensusRule.majority),
            onSelectUnanimous: () =>
                setState(() => _consensus = ConsensusRule.unanimous),
            onToggleStopOnFirstMatch: () =>
                setState(() => _instant = !_instant),
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
              visitAt: visitAtForSelection(
                _visitTimeChoice,
                now: DateTime.now(),
                customTime: _visitAt,
              ),
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
            language: Localizations.localeOf(context).languageCode,
          );
      if (!mounted) return;
      if (_mode == SessionMode.multiplayer) {
        await ref
            .read(displayNameStoreProvider)
            .write(_displayName.text.trim());
      }
      if (!mounted) return;
      final route = _mode == SessionMode.solo ? 'swipe' : 'lobby';
      context.go('/$route/${bundle.session.sessionId}', extra: bundle);
    } catch (error) {
      if (mounted) setState(() => _error = _friendlyError(error));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _searchLocations(String value) {
    _debounce?.cancel();
    final revision = ++_searchRevision;
    ++_locationRevision;
    final query = value.trim();
    setState(() {
      _suggestions = const [];
      _searching = query.length >= 3;
      _searchFailed = false;
      _searchComplete = false;
    });
    if (!_searching) return;
    _debounce = Timer(const Duration(milliseconds: 350), () async {
      try {
        final values = await ref
            .read(locationRepositoryProvider)
            .suggest(
              query: query,
              latitude: _latitude,
              longitude: _longitude,
            );
        if (mounted && revision == _searchRevision) {
          setState(() {
            _suggestions = values;
            _searching = false;
            _searchComplete = true;
          });
        }
      } catch (_) {
        if (mounted && revision == _searchRevision) {
          setState(() {
            _searching = false;
            _searchFailed = true;
          });
        }
      }
    });
  }

  void _cancelSuggestions() {
    _debounce?.cancel();
    ++_searchRevision;
    _suggestions = const [];
    _searching = false;
    _searchFailed = false;
    _searchComplete = false;
  }

  void _selectSuggestion(LocationSuggestion suggestion) {
    ++_locationRevision;
    _mapDebounce?.cancel();
    setState(() {
      _cancelSuggestions();
      _latitude = suggestion.latitude;
      _longitude = suggestion.longitude;
      _address = suggestion.fullText;
      _locationSearch.text = suggestion.fullText;
      _error = null;
    });
  }

  void _moveSearchCenter(double latitude, double longitude) {
    _mapDebounce?.cancel();
    final revision = _selectCoordinates(latitude, longitude);
    _mapDebounce = Timer(const Duration(milliseconds: 450), () {
      unawaited(_enrichLocation(latitude, longitude, revision));
    });
  }

  int _selectCoordinates(double latitude, double longitude) {
    final revision = ++_locationRevision;
    setState(() {
      _cancelSuggestions();
      _latitude = latitude;
      _longitude = longitude;
      _address = null;
      _error = null;
      _locationSearch.text =
          '${latitude.toStringAsFixed(5)}, ${longitude.toStringAsFixed(5)}';
    });
    return revision;
  }

  Future<void> _enrichLocation(
    double latitude,
    double longitude,
    int revision,
  ) async {
    if (!mounted || revision != _locationRevision) return;
    try {
      final address = await ref
          .read(locationRepositoryProvider)
          .reverseGeocode(
            latitude: latitude,
            longitude: longitude,
            languageCode: Localizations.localeOf(context).languageCode,
          );
      if (!mounted || revision != _locationRevision || address.trim().isEmpty) {
        return;
      }
      setState(() {
        _address = address;
        _locationSearch.text = address;
      });
    } catch (_) {
      // The coordinates remain usable when optional address enrichment fails.
    }
  }

  Future<void> _useLocation() async {
    final strings = AppLocalizations.of(context)!;
    final revision = ++_locationRevision;
    _mapDebounce?.cancel();
    setState(() {
      _locating = true;
      _error = null;
    });
    try {
      final position = await ref
          .read(locationWarmupProvider)
          .locate(requestPermission: true);
      if (!mounted || revision != _locationRevision) return;
      if (position == null) {
        setState(() => _error = strings.locationPermissionRequired);
        return;
      }
      final selected = _selectCoordinates(
        position.latitude,
        position.longitude,
      );
      unawaited(
        _enrichLocation(position.latitude, position.longitude, selected),
      );
    } catch (error) {
      if (mounted) setState(() => _error = _friendlyError(error));
    } finally {
      if (mounted) setState(() => _locating = false);
    }
  }

  Future<void> _adoptWarmedLocation() async {
    final revision = _locationRevision;
    final position = await ref.read(locationWarmupProvider).ready;
    if (!mounted ||
        position == null ||
        _latitude != null ||
        revision != _locationRevision) {
      return;
    }
    final selected = _selectCoordinates(position.latitude, position.longitude);
    await _enrichLocation(position.latitude, position.longitude, selected);
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
      _visitTimeChoice = VisitTimeChoice.custom;
      _error = null;
    });
  }

  Future<void> _restoreDisplayName() async {
    final value = await ref.read(displayNameStoreProvider).read();
    if (!mounted || value == null || _displayName.text.isNotEmpty) return;
    setState(() => _displayName.text = value);
  }

  void _goToStep(int value) {
    if (value == _step || value < 0 || value > 2) return;
    setState(() => _step = value);
    if (MediaQuery.disableAnimationsOf(context)) {
      _pageController.jumpToPage(value);
    } else {
      unawaited(
        _pageController.animateToPage(
          value,
          duration: const Duration(milliseconds: 340),
          curve: Curves.easeOutCubic,
        ),
      );
    }
    if (value == 1 && _latitude == null && !_locating) {
      unawaited(_useLocation());
    }
  }

  Widget _stepScrollView(Widget child) => SingleChildScrollView(
    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
    padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
    child: child,
  );

  String _friendlyError(Object error) =>
      setupErrorMessage(error, AppLocalizations.of(context)!);
}

class _CompactOptionSlider extends StatelessWidget {
  const _CompactOptionSlider({
    required this.title,
    required this.value,
    required this.max,
    required this.label,
    required this.onChanged,
  });

  final String title;
  final double value;
  final double max;
  final String label;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
              ),
            ),
            Flexible(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 160),
                child: Text(
                  label,
                  key: ValueKey(label),
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ],
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            showValueIndicator: ShowValueIndicator.never,
          ),
          child: Slider(
            value: value,
            max: max,
            divisions: max.round(),
            semanticFormatterCallback: (_) => '$title: $label',
            onChanged: onChanged,
          ),
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
