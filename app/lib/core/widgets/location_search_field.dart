import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hayer_client/hayer_client.dart';
import 'package:material_3_expressive/material_3_expressive.dart';
import 'package:material_ui/material_ui.dart';

import '../../l10n/generated/app_localizations.dart';
import '../providers.dart';

/// The shortest text the server will answer. Anything shorter asks nothing.
const _minimumQuery = 3;

/// How long typing pauses before the server is asked.
const _debounceDelay = Duration(milliseconds: 350);

/// A location field whose suggestions come from the shared place search.
///
/// Typing at least [_minimumQuery] characters asks the server once the typing
/// pauses. Every reply is dropped unless it answers the newest keystroke, so a
/// slow reply can never overwrite a newer list. Both modes use this: "In a
/// Quick Pick chooses a swipe area, while Explore moves the map.
///
/// The field's text belongs to the caller, which also decides what choosing a
/// suggestion means; the suggestions themselves belong here. Clear them
/// through [LocationSearchFieldState.clearSuggestions] with a [GlobalKey] when
/// something other than typing has settled the location.
class LocationSearchField extends ConsumerStatefulWidget {
  const LocationSearchField({
    super.key,
    required this.controller,
    required this.onSelected,
    this.onTyped,
    this.latitude,
    this.longitude,
    this.onUseCurrentLocation,
    this.locating = false,
    this.autofocus = false,
    this.hintText,
  });

  final TextEditingController controller;

  /// Called with the chosen suggestion. The caller owns what happens next,
  /// including what the field then reads.
  final ValueChanged<LocationSuggestion> onSelected;

  /// Called as soon as the text changes, before any search is sent.
  ///
  /// Typing settles the location as surely as picking a suggestion does, so an
  /// owner with work already in flight against the old one — reverse
  /// geocoding an address to put in this very field — uses this to abandon it
  /// rather than let it land on top of what was typed.
  final VoidCallback? onTyped;

  /// Where to bias the search, when somewhere is already chosen.
  final double? latitude;
  final double? longitude;

  /// Offered as the field's trailing action when set.
  final VoidCallback? onUseCurrentLocation;

  /// Whether a location fix is being taken, which the trailing action shows.
  final bool locating;
  final bool autofocus;

  /// Overrides the default prompt.
  final String? hintText;

  @override
  ConsumerState<LocationSearchField> createState() =>
      LocationSearchFieldState();
}

class LocationSearchFieldState extends ConsumerState<LocationSearchField> {
  List<LocationSuggestion> _suggestions = const [];
  bool _searching = false;
  bool _failed = false;
  bool _complete = false;

  /// Counts searches, so only the newest one's reply is shown.
  int _revision = 0;
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  /// Drops the suggestions, and any reply still on its way.
  void clearSuggestions() {
    _debounce?.cancel();
    _revision++;
    if (!mounted) return;
    setState(() {
      _suggestions = const [];
      _searching = false;
      _failed = false;
      _complete = false;
    });
  }

  /// Searches for [value], after the typing pause.
  void search(String value) {
    widget.onTyped?.call();
    _debounce?.cancel();
    final revision = ++_revision;
    final query = value.trim();
    setState(() {
      _suggestions = const [];
      _searching = query.length >= _minimumQuery;
      _failed = false;
      _complete = false;
    });
    if (!_searching) return;
    _debounce = Timer(_debounceDelay, () async {
      try {
        final values = await ref
            .read(locationRepositoryProvider)
            .suggest(
              query: query,
              latitude: widget.latitude,
              longitude: widget.longitude,
            );
        if (!mounted || revision != _revision) return;
        setState(() {
          _suggestions = values;
          _searching = false;
          _complete = true;
        });
      } catch (_) {
        if (!mounted || revision != _revision) return;
        setState(() {
          _searching = false;
          _failed = true;
        });
      }
    });
  }

  void _select(LocationSuggestion suggestion) {
    clearSuggestions();
    widget.onSelected(suggestion);
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          key: const ValueKey('location-search-field'),
          controller: widget.controller,
          autofocus: widget.autofocus,
          onChanged: search,
          onSubmitted: search,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            hintText: widget.hintText ?? strings.searchLocation,
            prefixIcon: const Icon(Icons.search_rounded),
            suffixIcon: switch (widget.onUseCurrentLocation) {
              final onUseCurrentLocation? => M3EIconButton(
                tooltip: strings.useCurrentLocation,
                onPressed: widget.locating ? null : onUseCurrentLocation,
                icon: widget.locating
                    ? const Padding(
                        padding: EdgeInsets.all(12),
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.my_location_rounded),
              ),
              null => null,
            },
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
        if (_failed)
          Semantics(
            liveRegion: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(strings.locationSearchFailed),
                TextButton.icon(
                  onPressed: () => search(widget.controller.text),
                  icon: const Icon(Icons.refresh_rounded),
                  label: Text(strings.tryAgain),
                ),
              ],
            ),
          ),
        if (_complete && _suggestions.isEmpty)
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
                    onTap: () => _select(suggestion),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}
