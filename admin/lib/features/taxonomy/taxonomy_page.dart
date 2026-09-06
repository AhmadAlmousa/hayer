import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hayer_client/hayer_client.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

import '../../admin_operations.dart';
import '../analytics/analytics_pages.dart';

class TaxonomyPage extends StatefulWidget {
  const TaxonomyPage({super.key, required this.operations});

  final AdminOperations operations;

  @override
  State<TaxonomyPage> createState() => _TaxonomyPageState();
}

class _TaxonomyPageState extends State<TaxonomyPage> {
  AdminTaxonomyVersion? _draft;
  List<AdminTaxonomyVersion> _history = const [];
  TaxonomyKind? _kind;
  Object? _error;
  bool _busy = false;
  bool _dirty = false;
  final _locationSearch = TextEditingController();
  List<LocationSuggestion> _suggestions = const [];
  Timer? _searchDebounce;
  AdminMapLocation? _location;
  String _country = 'SA';
  int _radius = 3000;
  MapLibreMapController? _map;

  @override
  void initState() {
    super.initState();
    unawaited(_load());
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    _locationSearch.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() => _busy = true);
    try {
      final values = await Future.wait<Object>([
        widget.operations.taxonomyDraft(),
        widget.operations.taxonomyHistory(),
      ]);
      if (!mounted) return;
      final draft = values[0] as AdminTaxonomyVersion;
      setState(() {
        _draft = draft;
        _history = values[1] as List<AdminTaxonomyVersion>;
        _location = draft.validationLocation;
        _radius = draft.validationRadiusMeters ?? _radius;
        if (_location != null) {
          _country = _location!.countryCode;
          _locationSearch.text = _location!.address;
        }
        _dirty = false;
        _error = null;
      });
    } catch (error) {
      if (mounted) setState(() => _error = error);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) => AdminPageFrame(
    title: 'Taxonomy',
    subtitle: 'Versioned categories, cuisines, and place types · bilingual consumer labels',
    trailing: IconButton(
      tooltip: 'Reload taxonomy',
      onPressed: _busy ? null : _load,
      icon: const Icon(Icons.refresh_rounded),
    ),
    child: _error != null && _draft == null
        ? AdminErrorPanel(_error!)
        : _draft == null
        ? const Center(child: CircularProgressIndicator())
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _statusCard(),
              const SizedBox(height: 16),
              _editorCard(),
              const SizedBox(height: 16),
              _canaryCard(),
              const SizedBox(height: 16),
              _historyCard(),
            ],
          ),
  );

  Widget _statusCard() {
    final draft = _draft!;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Wrap(
          spacing: 18,
          runSpacing: 10,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Icon(
              draft.validationPassed
                  ? Icons.verified_rounded
                  : Icons.edit_note_rounded,
              color: draft.validationPassed ? Colors.teal : Colors.orange,
            ),
            Text(
              '${draft.version} · revision ${draft.revision}',
              style: const TextStyle(fontWeight: FontWeight.w900),
            ),
            Text('${draft.items.where((item) => item.enabled).length} enabled'),
            if (_dirty) const Chip(label: Text('Unsaved changes')),
            const SizedBox(width: 20),
            FilledButton.icon(
              onPressed: _busy || !_dirty ? null : _save,
              icon: const Icon(Icons.save_outlined),
              label: const Text('Save draft'),
            ),
            FilledButton.tonalIcon(
              onPressed: _busy || !draft.validationPassed || _dirty
                  ? null
                  : _publish,
              icon: const Icon(Icons.publish_outlined),
              label: const Text('Publish'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _editorCard() {
    final categories = _draft!.items
        .where((item) => item.kind == TaxonomyKind.category)
        .toList();
    final visible =
        _draft!.items
            .where((item) => _kind == null || item.kind == _kind)
            .toList()
          ..sort((left, right) {
            final byKind = left.kind.index.compareTo(right.kind.index);
            return byKind != 0
                ? byKind
                : left.sortOrder.compareTo(right.sortOrder);
          });
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                ChoiceChip(
                  label: const Text('All'),
                  selected: _kind == null,
                  onSelected: (_) => setState(() => _kind = null),
                ),
                for (final kind in TaxonomyKind.values)
                  ChoiceChip(
                    label: Text(_kindLabel(kind)),
                    selected: _kind == kind,
                    onSelected: (_) => setState(() => _kind = kind),
                  ),
                const SizedBox(width: 8),
                OutlinedButton.icon(
                  onPressed: _busy ? null : () => _addItem(categories),
                  icon: const Icon(Icons.add_rounded),
                  label: const Text('Add entry'),
                ),
              ],
            ),
            const SizedBox(height: 14),
            if (_draft!.validationErrors.isNotEmpty)
              _ValidationMessages(errors: _draft!.validationErrors),
            for (final item in visible)
              Card.outlined(
                child: ListTile(
                  leading: Text(
                    item.emoji,
                    style: const TextStyle(fontSize: 25),
                  ),
                  title: Text(
                    '${item.labelEn} · ${item.labelAr}',
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                  subtitle: Text(
                    '${_kindLabel(item.kind)} · ${item.id}'
                    '${item.parentCategoryIds.isEmpty ? '' : ' · ${item.parentCategoryIds.join(', ')}'}\n'
                    '${item.searchQueryEn}${item.searchQueryAr == null ? '' : ' / ${item.searchQueryAr}'}',
                  ),
                  isThreeLine: true,
                  trailing: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Switch(
                        value: item.enabled,
                        onChanged: (value) =>
                            _replace(item, item.copyWith(enabled: value)),
                      ),
                      IconButton(
                        tooltip: 'Edit ${item.labelEn}',
                        onPressed: () => _editItem(item, categories),
                        icon: const Icon(Icons.edit_outlined),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _canaryCard() => Card(
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Validation location',
            style: Theme.of(context).textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 4),
          const Text(
            'Search an address or click the map. Structural checks and live place-search canaries must pass before publishing.',
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              SizedBox(
                width: 160,
                child: DropdownButtonFormField<String>(
                  initialValue: _country,
                  decoration: const InputDecoration(labelText: 'Country'),
                  items: [
                    for (final code in ['SA', 'AE', 'KW', 'QA', 'BH', 'OM'])
                      DropdownMenuItem(value: code, child: Text(code)),
                  ],
                  onChanged: (value) =>
                      setState(() => _country = value ?? 'SA'),
                ),
              ),
              SizedBox(
                width: 480,
                child: TextField(
                  controller: _locationSearch,
                  decoration: const InputDecoration(
                    labelText: 'Search validation address',
                    prefixIcon: Icon(Icons.search_rounded),
                  ),
                  onChanged: _searchLocation,
                ),
              ),
            ],
          ),
          if (_suggestions.isNotEmpty)
            Card.outlined(
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
          const SizedBox(height: 12),
          SizedBox(
            height: 330,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: MapLibreMap(
                styleString: 'https://tiles.openfreemap.org/styles/liberty',
                initialCameraPosition: CameraPosition(
                  target: _location == null
                      ? const LatLng(24.2, 45.2)
                      : LatLng(_location!.latitude, _location!.longitude),
                  zoom: _location == null ? 4.5 : 12,
                ),
                onMapCreated: (value) {
                  _map = value;
                  unawaited(_drawLocation());
                },
                onStyleLoadedCallback: () => unawaited(_drawLocation()),
                onMapClick: (_, coordinates) => _selectMap(coordinates),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Slider(
                  value: _radius.toDouble(),
                  min: 500,
                  max: 10000,
                  divisions: 19,
                  label: '${(_radius / 1000).toStringAsFixed(1)} km',
                  onChanged: (value) => setState(() => _radius = value.round()),
                ),
              ),
              Text('${(_radius / 1000).toStringAsFixed(1)} km'),
              const SizedBox(width: 14),
              FilledButton.icon(
                onPressed: _busy || _dirty || _location == null
                    ? null
                    : _validate,
                icon: const Icon(Icons.fact_check_outlined),
                label: const Text('Validate draft'),
              ),
            ],
          ),
          if (_location != null)
            Text(
              '${_location!.address}\n'
              '${_location!.latitude.toStringAsFixed(5)}, ${_location!.longitude.toStringAsFixed(5)}',
            ),
        ],
      ),
    ),
  );

  Widget _historyCard() => Card(
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Published history',
            style: Theme.of(context).textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 10),
          if (_history.isEmpty)
            const Text('No published versions yet.')
          else
            for (final version in _history)
              ListTile(
                leading: Icon(
                  version.status == TaxonomyStatus.active
                      ? Icons.check_circle_rounded
                      : Icons.history_rounded,
                ),
                title: Text(version.version),
                subtitle: Text(
                  '${version.status.name} · ${version.items.length} entries'
                  '${version.publishedAt == null ? '' : ' · ${version.publishedAt!.toLocal()}'}',
                ),
                trailing: version.status == TaxonomyStatus.superseded
                    ? OutlinedButton(
                        onPressed: _busy ? null : () => _rollback(version),
                        child: const Text('Restore'),
                      )
                    : null,
              ),
        ],
      ),
    ),
  );

  void _replace(AdminTaxonomyItem previous, AdminTaxonomyItem next) {
    final items = List<AdminTaxonomyItem>.of(_draft!.items);
    items[items.indexOf(previous)] = next;
    setState(() {
      _draft = _draft!.copyWith(items: items, validationPassed: false);
      _dirty = true;
    });
  }

  Future<void> _editItem(
    AdminTaxonomyItem item,
    List<AdminTaxonomyItem> categories,
  ) async {
    final edited = await showDialog<AdminTaxonomyItem>(
      context: context,
      builder: (context) =>
          _TaxonomyItemDialog(item: item, categories: categories),
    );
    if (edited != null) _replace(item, edited);
  }

  Future<void> _addItem(List<AdminTaxonomyItem> categories) async {
    final item = await showDialog<AdminTaxonomyItem>(
      context: context,
      builder: (context) => _TaxonomyItemDialog(categories: categories),
    );
    if (item == null) return;
    setState(() {
      _draft = _draft!.copyWith(
        items: [..._draft!.items, item],
        validationPassed: false,
      );
      _dirty = true;
    });
  }

  Future<void> _save() async {
    final reason = await _askReason(context, 'Save taxonomy draft');
    if (reason == null) return;
    await _run(() async {
      _draft = await widget.operations.saveTaxonomyDraft(
        reason: reason,
        version: _draft!.version,
        revision: _draft!.revision,
        items: _draft!.items,
      );
      _dirty = false;
    });
  }

  Future<void> _validate() async {
    final reason = await _askReason(context, 'Validate taxonomy draft');
    if (reason == null) return;
    await _run(() async {
      final result = await widget.operations.validateTaxonomyDraft(
        reason: reason,
        version: _draft!.version,
        revision: _draft!.revision,
        location: _location!,
        radiusMeters: _radius,
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            result.passed
                ? '${result.samples.length} live canaries passed.'
                : result.errors.join('\n'),
          ),
        ),
      );
      await _load();
    });
  }

  Future<void> _publish() async {
    final reason = await _askReason(context, 'Publish taxonomy');
    if (reason == null) return;
    await _run(() async {
      await widget.operations.publishTaxonomy(
        reason: reason,
        version: _draft!.version,
        revision: _draft!.revision,
      );
      await _load();
    });
  }

  Future<void> _rollback(AdminTaxonomyVersion version) async {
    final reason = await _askReason(context, 'Restore ${version.version}');
    if (reason == null) return;
    await _run(() async {
      await widget.operations.rollbackTaxonomy(
        reason: reason,
        version: version.version,
      );
      await _load();
    });
  }

  Future<void> _run(Future<void> Function() action) async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await action();
    } catch (error) {
      if (mounted) {
        setState(() => _error = error);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('$error')));
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _searchLocation(String value) {
    _searchDebounce?.cancel();
    if (value.trim().length < 3) {
      setState(() => _suggestions = const []);
      return;
    }
    _searchDebounce = Timer(const Duration(milliseconds: 350), () async {
      try {
        final result = await widget.operations.suggestAdminLocation(
          query: value,
          countryCode: _country,
        );
        if (mounted && _locationSearch.text == value) {
          setState(() => _suggestions = result);
        }
      } catch (_) {}
    });
  }

  void _selectSuggestion(LocationSuggestion value) {
    setState(() {
      _location = AdminMapLocation(
        address: value.fullText,
        latitude: value.latitude,
        longitude: value.longitude,
        countryCode: value.countryCode,
      );
      _country = value.countryCode;
      _locationSearch.text = value.fullText;
      _suggestions = const [];
    });
    unawaited(_drawLocation(move: true));
  }

  Future<void> _selectMap(LatLng coordinates) async {
    await _run(() async {
      final value = await widget.operations.reverseAdminLocation(
        latitude: coordinates.latitude,
        longitude: coordinates.longitude,
        countryCode: _country,
      );
      if (!mounted) return;
      setState(() {
        _location = value;
        _country = value.countryCode;
        _locationSearch.text = value.address;
        _suggestions = const [];
      });
      await _drawLocation();
    });
  }

  Future<void> _drawLocation({bool move = false}) async {
    final controller = _map;
    final location = _location;
    if (controller == null || location == null) return;
    await controller.clearCircles();
    await controller.addCircle(
      CircleOptions(
        geometry: LatLng(location.latitude, location.longitude),
        circleColor: '#0E9594',
        circleRadius: 9,
        circleStrokeColor: '#FFFFFF',
        circleStrokeWidth: 3,
      ),
    );
    if (move) {
      await controller.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(location.latitude, location.longitude),
          12,
        ),
      );
    }
  }
}

class _ValidationMessages extends StatelessWidget {
  const _ValidationMessages({required this.errors});

  final List<String> errors;

  @override
  Widget build(BuildContext context) => Card(
    color: Theme.of(context).colorScheme.errorContainer,
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [for (final error in errors) Text('• $error')],
      ),
    ),
  );
}

class _TaxonomyItemDialog extends StatefulWidget {
  const _TaxonomyItemDialog({this.item, required this.categories});

  final AdminTaxonomyItem? item;
  final List<AdminTaxonomyItem> categories;

  @override
  State<_TaxonomyItemDialog> createState() => _TaxonomyItemDialogState();
}

class _TaxonomyItemDialogState extends State<_TaxonomyItemDialog> {
  late final _id = TextEditingController(text: widget.item?.id ?? '');
  late final _english = TextEditingController(text: widget.item?.labelEn ?? '');
  late final _arabic = TextEditingController(text: widget.item?.labelAr ?? '');
  late final _emoji = TextEditingController(text: widget.item?.emoji ?? '📍');
  late final _queryEn = TextEditingController(
    text: widget.item?.searchQueryEn ?? '',
  );
  late final _queryAr = TextEditingController(
    text: widget.item?.searchQueryAr ?? '',
  );
  late final _order = TextEditingController(
    text: '${widget.item?.sortOrder ?? 0}',
  );
  late TaxonomyKind _kind = widget.item?.kind ?? TaxonomyKind.poiType;
  late String? _parent =
      widget.item?.parentCategoryIds.firstOrNull ??
      widget.categories.firstOrNull?.id;

  @override
  void dispose() {
    for (final controller in [
      _id,
      _english,
      _arabic,
      _emoji,
      _queryEn,
      _queryAr,
      _order,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(widget.item == null ? 'Add taxonomy entry' : 'Edit entry'),
    content: SizedBox(
      width: 620,
      child: SingleChildScrollView(
        child: Column(
          children: [
            DropdownButtonFormField<TaxonomyKind>(
              initialValue: _kind,
              decoration: const InputDecoration(labelText: 'Kind'),
              items: [
                for (final value in TaxonomyKind.values)
                  DropdownMenuItem(
                    value: value,
                    child: Text(_kindLabel(value)),
                  ),
              ],
              onChanged: widget.item != null
                  ? null
                  : (value) => setState(() => _kind = value ?? _kind),
            ),
            const SizedBox(height: 10),
            if (_kind != TaxonomyKind.category) ...[
              DropdownButtonFormField<String>(
                initialValue: _parent,
                decoration: const InputDecoration(labelText: 'Parent category'),
                items: [
                  for (final value in widget.categories)
                    DropdownMenuItem(
                      value: value.id,
                      child: Text(value.labelEn),
                    ),
                ],
                onChanged: (value) => setState(() => _parent = value),
              ),
              const SizedBox(height: 10),
            ],
            _field(_id, 'Stable ID', enabled: widget.item == null),
            _field(_english, 'English label'),
            _field(_arabic, 'Arabic label', direction: TextDirection.rtl),
            _field(_emoji, 'Emoji'),
            _field(_queryEn, 'English search query'),
            _field(
              _queryAr,
              'Arabic search query',
              direction: TextDirection.rtl,
            ),
            _field(_order, 'Sort order', number: true),
          ],
        ),
      ),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('Cancel'),
      ),
      FilledButton(onPressed: _submit, child: const Text('Apply')),
    ],
  );

  Widget _field(
    TextEditingController controller,
    String label, {
    bool enabled = true,
    bool number = false,
    TextDirection? direction,
  }) => Padding(
    padding: const EdgeInsets.only(top: 10),
    child: TextField(
      controller: controller,
      enabled: enabled,
      keyboardType: number ? TextInputType.number : null,
      textDirection: direction,
      decoration: InputDecoration(labelText: label),
    ),
  );

  void _submit() {
    final order = int.tryParse(_order.text);
    if (_id.text.trim().isEmpty || order == null) return;
    Navigator.pop(
      context,
      AdminTaxonomyItem(
        id: _id.text.trim(),
        kind: _kind,
        parentCategoryIds: _kind == TaxonomyKind.category || _parent == null
            ? const []
            : [_parent!],
        labelEn: _english.text.trim(),
        labelAr: _arabic.text.trim(),
        emoji: _emoji.text.trim(),
        searchQueryEn: _queryEn.text.trim(),
        searchQueryAr: _queryAr.text.trim().isEmpty
            ? null
            : _queryAr.text.trim(),
        sortOrder: order,
        enabled: widget.item?.enabled ?? true,
      ),
    );
  }
}

Future<String?> _askReason(BuildContext context, String title) async {
  final controller = TextEditingController();
  final value = await showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: TextField(
        controller: controller,
        autofocus: true,
        minLines: 2,
        maxLines: 5,
        decoration: const InputDecoration(labelText: 'Reason (required)'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            if (controller.text.trim().length >= 4) {
              Navigator.pop(context, controller.text.trim());
            }
          },
          child: const Text('Continue'),
        ),
      ],
    ),
  );
  controller.dispose();
  return value;
}

String _kindLabel(TaxonomyKind kind) => switch (kind) {
  TaxonomyKind.category => 'Category',
  TaxonomyKind.cuisine => 'Cuisine',
  TaxonomyKind.poiType => 'POI type',
};
