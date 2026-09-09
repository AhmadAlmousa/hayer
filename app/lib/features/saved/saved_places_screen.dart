import 'package:cached_network_image/cached_network_image.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_3_expressive/material_3_expressive.dart';

import '../../core/page_title.dart';
import '../../core/widgets/content_shell.dart';
import '../../domain/saved_place.dart';
import '../../domain/shortlist_draft.dart';
import '../../l10n/generated/app_localizations.dart';
import 'saved_places_controller.dart';

class SavedPlacesScreen extends ConsumerStatefulWidget {
  const SavedPlacesScreen({super.key});

  @override
  ConsumerState<SavedPlacesScreen> createState() => _SavedPlacesScreenState();
}

class _SavedPlacesScreenState extends ConsumerState<SavedPlacesScreen> {
  SavedPlaceCollection _collection = SavedPlaceCollection.wantToTry;
  final _selectedIds = <String>{};

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final state = ref.watch(savedPlacesControllerProvider);
    final visible = state.places
        .where((saved) => saved.collection == _collection)
        .toList(growable: false);
    setBrowserPageTitle('${strings.savedPlaces} — ${strings.appName}');
    return Scaffold(
      appBar: AppBar(title: Text(strings.savedPlaces)),
      body: SafeArea(
        child: ContentShell(
          child: RefreshIndicator(
            onRefresh: ref.read(savedPlacesControllerProvider.notifier).reload,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
              children: [
                Card.filled(
                  child: ListTile(
                    leading: const Icon(Icons.phonelink_lock_rounded),
                    title: Text(
                      strings.privateOnDeviceTitle,
                      style: const TextStyle(fontWeight: FontWeight.w900),
                    ),
                    subtitle: Text(strings.privateOnDeviceMessage),
                  ),
                ),
                if (state.error != null) ...[
                  const SizedBox(height: 12),
                  Semantics(
                    liveRegion: true,
                    child: Row(
                      children: [
                        Icon(
                          Icons.error_outline_rounded,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        const SizedBox(width: 12),
                        Expanded(child: Text(strings.savedPlaceFailed)),
                        TextButton(
                          onPressed: ref
                              .read(savedPlacesControllerProvider.notifier)
                              .reload,
                          child: Text(strings.tryAgain),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 12),
                M3ESegmentedButton<SavedPlaceCollection>(
                  showSelectedIcon: false,
                  segments: [
                    M3ESegment(
                      value: SavedPlaceCollection.wantToTry,
                      label: strings.wantToTry,
                      icon: const Icon(Icons.bookmark_outline_rounded),
                    ),
                    M3ESegment(
                      value: SavedPlaceCollection.favorites,
                      label: strings.favorites,
                      icon: const Icon(Icons.star_outline_rounded),
                    ),
                  ],
                  selected: {_collection},
                  onSelectionChanged: (values) => setState(() {
                    _collection = values.single;
                  }),
                ),
                const SizedBox(height: 16),
                Text(
                  strings.selectForShortlist,
                  style:
                      Theme.of(
                            context,
                          ).textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w900),
                ),
                if (_selectedIds.isNotEmpty)
                  Text(strings.selectedPlacesCount(_selectedIds.length)),
                if (state.loading && state.places.isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(32),
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (visible.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 48),
                    child: Column(
                      children: [
                        const Icon(Icons.bookmarks_outlined, size: 48),
                        const SizedBox(height: 12),
                        Text(
                          strings.noSavedPlaces,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                else
                  for (final saved in visible)
                    _SavedPlaceTile(
                      saved: saved,
                      selected: _selectedIds.contains(saved.place.placeId),
                      saving: state.savingPlaceIds.contains(
                        saved.place.placeId,
                      ),
                      onSelected: (selected) => setState(() {
                        if (selected) {
                          _selectedIds.add(saved.place.placeId);
                        } else {
                          _selectedIds.remove(saved.place.placeId);
                        }
                      }),
                      onEdit: () => _edit(saved),
                    ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: FilledButton.icon(
          onPressed: _selectedIds.length >= 2 ? _startShortlist : null,
          icon: const Icon(Icons.playlist_add_check_circle_rounded),
          label: Text(strings.startShortlist(_selectedIds.length)),
        ),
      ),
    );
  }

  void _startShortlist() {
    final strings = AppLocalizations.of(context)!;
    final selected = ref
        .read(savedPlacesControllerProvider)
        .places
        .where((saved) => _selectedIds.contains(saved.place.placeId))
        .toList(growable: false);
    if (selected.length < 2) {
      _message(strings.minimumShortlist);
      return;
    }
    final draft = ShortlistDraft.fromSavedPlaces(selected);
    if (!draft.fitsSupportedArea) {
      _message(strings.shortlistAreaTooWide);
      return;
    }
    if (draft.categoryId == null) {
      _message(strings.shortlistCategoryUnavailable);
      return;
    }
    context.push('/saved/start', extra: draft);
  }

  Future<void> _edit(SavedPlace saved) async {
    final strings = AppLocalizations.of(context)!;
    final action = await showDialog<_SavedPlaceAction>(
      context: context,
      builder: (context) => _EditSavedPlaceDialog(saved: saved),
    );
    if (action == null || !mounted) return;
    try {
      final controller = ref.read(savedPlacesControllerProvider.notifier);
      switch (action) {
        case _SavedPlaceDelete():
          await controller.remove(saved.place.placeId);
          if (mounted) setState(() => _selectedIds.remove(saved.place.placeId));
        case _SavedPlaceSave(:final collection, :final note):
          await controller.update(
            placeId: saved.place.placeId,
            collection: collection,
            note: note,
          );
      }
    } catch (_) {
      if (mounted) _message(strings.savedPlaceFailed);
    }
  }

  void _message(String value) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(value)));
  }
}

class _EditSavedPlaceDialog extends StatefulWidget {
  const _EditSavedPlaceDialog({required this.saved});

  final SavedPlace saved;

  @override
  State<_EditSavedPlaceDialog> createState() => _EditSavedPlaceDialogState();
}

class _EditSavedPlaceDialogState extends State<_EditSavedPlaceDialog> {
  late final TextEditingController _note;
  late SavedPlaceCollection _collection;

  @override
  void initState() {
    super.initState();
    _note = TextEditingController(text: widget.saved.note);
    _collection = widget.saved.collection;
  }

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Text(strings.editSavedPlace),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.saved.place.name,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 12),
            M3ESegmentedButton<SavedPlaceCollection>(
              showSelectedIcon: false,
              segments: [
                M3ESegment(
                  value: SavedPlaceCollection.wantToTry,
                  label: strings.wantToTry,
                ),
                M3ESegment(
                  value: SavedPlaceCollection.favorites,
                  label: strings.favorites,
                ),
              ],
              selected: {_collection},
              onSelectionChanged: (values) =>
                  setState(() => _collection = values.single),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _note,
              maxLength: 500,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: strings.privateNote,
                helperText: strings.privateNoteHint,
                alignLabelWithHint: true,
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(
            context,
            const _SavedPlaceAction.delete(),
          ),
          child: Text(strings.deleteSavedPlace),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(
            context,
            _SavedPlaceAction.save(_collection, _note.text),
          ),
          child: Text(strings.saveChanges),
        ),
      ],
    );
  }
}

class _SavedPlaceTile extends StatelessWidget {
  const _SavedPlaceTile({
    required this.saved,
    required this.selected,
    required this.saving,
    required this.onSelected,
    required this.onEdit,
  });

  final SavedPlace saved;
  final bool selected;
  final bool saving;
  final ValueChanged<bool> onSelected;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final place = saved.place;
    return Card(
      child: ListTile(
        enabled: !saving,
        leading: Checkbox(
          value: selected,
          onChanged: saving ? null : (value) => onSelected(value ?? false),
        ),
        title: Text(
          place.name,
          style: const TextStyle(fontWeight: FontWeight.w900),
        ),
        subtitle: Text(
          [
            ?place.formattedAddress,
            ?saved.note,
          ].join('\n'),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: IconButton(
          tooltip: AppLocalizations.of(context)!.editSavedPlace,
          onPressed: saving ? null : onEdit,
          icon: place.photoUrls.isEmpty
              ? const Icon(Icons.edit_note_rounded)
              : ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: place.photoUrls.first,
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                    errorWidget: (_, _, _) =>
                        const Icon(Icons.edit_note_rounded),
                  ),
                ),
        ),
        onTap: saving ? null : () => onSelected(!selected),
      ),
    );
  }
}

sealed class _SavedPlaceAction {
  const _SavedPlaceAction();

  const factory _SavedPlaceAction.save(
    SavedPlaceCollection collection,
    String note,
  ) = _SavedPlaceSave;

  const factory _SavedPlaceAction.delete() = _SavedPlaceDelete;
}

final class _SavedPlaceSave extends _SavedPlaceAction {
  const _SavedPlaceSave(this.collection, this.note);
  final SavedPlaceCollection collection;
  final String note;
}

final class _SavedPlaceDelete extends _SavedPlaceAction {
  const _SavedPlaceDelete();
}
