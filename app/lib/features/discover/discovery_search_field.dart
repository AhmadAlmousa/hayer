import 'dart:async';

import 'package:material_ui/material_ui.dart';

import '../../domain/discovery_url_query.dart';
import '../../l10n/generated/app_localizations.dart';

/// How long typing pauses before the text becomes the committed query.
///
/// Matches the camera's settle: both of these only re-read the catalog, so the
/// delay is about not running a query per keystroke, not about cost.
const discoverySearchDebounce = Duration(milliseconds: 400);

/// The search box over the map.
///
/// It used to live inside the filter sheet and apply only when that sheet was
/// submitted, so finding a place by name meant opening a sheet, typing, and
/// applying. Here it searches as you type, like the map searches as you pan.
/// Its text is part of the committed query, so it survives a shared link and
/// a rebuild.
class DiscoverySearchField extends StatefulWidget {
  const DiscoverySearchField({
    super.key,
    required this.query,
    required this.onApply,
  });

  /// The committed query, whose text the field shows.
  final DiscoveryUrlQuery query;

  /// Commits a changed query.
  final ValueChanged<DiscoveryUrlQuery> onApply;

  @override
  State<DiscoverySearchField> createState() => _DiscoverySearchFieldState();
}

class _DiscoverySearchFieldState extends State<DiscoverySearchField> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.query.text,
  );
  Timer? _debounce;

  @override
  void didUpdateWidget(DiscoverySearchField oldWidget) {
    super.didUpdateWidget(oldWidget);
    // A shared link or Reset can change the text from outside. Adopt it only
    // when it really differs, so typing is never interrupted mid-word.
    final text = widget.query.text;
    if (text != _controller.text.trim()) _controller.text = text;
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _edit(String value) {
    _debounce?.cancel();
    _debounce = Timer(discoverySearchDebounce, () {
      if (!mounted) return;
      final trimmed = value.trim();
      widget.onApply(widget.query.copyWith(text: trimmed));
    });
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final colors = Theme.of(context).colorScheme;
    final hasText = _controller.text.trim().isNotEmpty;
    return TextField(
      key: const ValueKey('discovery-search'),
      controller: _controller,
      textInputAction: TextInputAction.search,
      maxLength: maxDiscoveryTextLength,
      onChanged: _edit,
      onSubmitted: (value) {
        _debounce?.cancel();
        widget.onApply(widget.query.copyWith(text: value.trim()));
      },
      decoration: InputDecoration(
        isDense: true,
        counterText: '',
        filled: true,
        fillColor: colors.surface,
        hintText: strings.discoveryFilterTextHint,
        prefixIcon: const Icon(Icons.search_rounded),
        suffixIcon: hasText
            ? IconButton(
                key: const ValueKey('discovery-search-clear'),
                tooltip: strings.discoverySearchClear,
                icon: const Icon(Icons.close_rounded),
                onPressed: () {
                  _debounce?.cancel();
                  _controller.clear();
                  setState(() {});
                  widget.onApply(widget.query.copyWith(text: ''));
                },
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
