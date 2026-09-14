import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hayer_client/hayer_client.dart';

import '../../core/providers.dart';
import '../../l10n/generated/app_localizations.dart';

Future<void> showReportPlaceIssue(
  BuildContext context, {
  required String sessionId,
  required PlaceSnapshot place,
}) => _showReport(
  context,
  ReportPlaceIssueSheet(sessionId: sessionId, place: place),
);

/// Reports a place found outside any session, such as in Discover, by its
/// catalog id.
Future<void> showCatalogPlaceIssue(
  BuildContext context, {
  required int catalogId,
  required PlaceSnapshot place,
}) => _showReport(
  context,
  ReportPlaceIssueSheet.catalog(catalogId: catalogId, place: place),
);

Future<void> _showReport(BuildContext context, Widget sheet) async {
  FocusManager.instance.primaryFocus?.unfocus();
  final sent = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (_) => sheet,
  );
  if (sent == true && context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context)!.reportThanks)),
    );
  }
}

class ReportPlaceIssueSheet extends ConsumerStatefulWidget {
  const ReportPlaceIssueSheet({
    super.key,
    required String this.sessionId,
    required this.place,
  }) : catalogId = null;

  const ReportPlaceIssueSheet.catalog({
    super.key,
    required int this.catalogId,
    required this.place,
  }) : sessionId = null;

  /// The swipe session the place is reported from, when it is from one.
  final String? sessionId;

  /// The reported place's catalog id, when it is reported outside a session.
  final int? catalogId;
  final PlaceSnapshot place;

  @override
  ConsumerState<ReportPlaceIssueSheet> createState() =>
      _ReportPlaceIssueSheetState();
}

class _ReportPlaceIssueSheetState extends ConsumerState<ReportPlaceIssueSheet> {
  static const _uuid = Uuid();

  final _formKey = GlobalKey<FormState>();
  final _details = TextEditingController();
  PoiIssueType? _type;
  bool _submitting = false;
  String? _error;

  /// The catalog report last sent and the key it was sent with. Sending the
  /// same report again reuses the key, so a report whose answer was lost is
  /// filed once; a changed report is a new one.
  (PoiIssueType, String?)? _catalogReport;
  String? _catalogKey;

  @override
  void dispose() {
    _details.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  strings.reportDataIssue,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.place.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(strings.reportDataIssueExplanation),
                const SizedBox(height: 12),
                RadioGroup<PoiIssueType>(
                  groupValue: _type,
                  onChanged: (value) {
                    if (_submitting) return;
                    setState(() {
                      _type = value;
                      _error = null;
                    });
                  },
                  child: Column(
                    children: [
                      for (final type in PoiIssueType.values)
                        RadioListTile<PoiIssueType>(
                          key: ValueKey('poi-issue-${type.name}'),
                          value: type,
                          contentPadding: EdgeInsets.zero,
                          title: Text(_label(strings, type)),
                        ),
                    ],
                  ),
                ),
                TextFormField(
                  key: const ValueKey('poi-issue-details'),
                  controller: _details,
                  enabled: !_submitting,
                  minLines: 2,
                  maxLines: 4,
                  maxLength: 500,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    labelText: strings.reportDetailsLabel,
                    hintText: strings.reportDetailsHint,
                    helperText: strings.reportPrivacyHint,
                    alignLabelWithHint: true,
                  ),
                  validator: (value) {
                    final length = value?.trim().length ?? 0;
                    if (_type == PoiIssueType.other && length == 0) {
                      return strings.reportDetailsRequired;
                    }
                    if (length != 0 && length < 4) {
                      return strings.reportDetailsLength;
                    }
                    return null;
                  },
                ),
                if (_error != null) ...[
                  const SizedBox(height: 8),
                  Semantics(
                    liveRegion: true,
                    child: Text(
                      _error!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 14),
                FilledButton.icon(
                  key: const ValueKey('submit-poi-issue'),
                  onPressed: _submitting ? null : _submit,
                  icon: _submitting
                      ? const SizedBox.square(
                          dimension: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.outlined_flag_rounded),
                  label: Text(strings.submitReport),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    final strings = AppLocalizations.of(context)!;
    final type = _type;
    if (type == null) {
      setState(() => _error = strings.reportReasonRequired);
      return;
    }
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _submitting = true;
      _error = null;
    });
    final details = _details.text.trim().isEmpty ? null : _details.text.trim();
    final repository = ref.read(poiIssueRepositoryProvider);
    try {
      if (widget.catalogId case final catalogId?) {
        final report = (type, details);
        if (report != _catalogReport) {
          _catalogReport = report;
          _catalogKey = _uuid.v7();
        }
        await repository.submitCatalog(
          catalogId: catalogId,
          issueType: type,
          details: details,
          idempotencyKey: _catalogKey!,
        );
      } else {
        await repository.submit(
          sessionId: widget.sessionId!,
          placeId: widget.place.placeId,
          issueType: type,
          details: details,
        );
      }
      if (mounted) Navigator.pop(context, true);
    } on ApiException catch (error) {
      if (!mounted) return;
      final catalog = widget.catalogId != null;
      setState(() {
        _error = switch (error.code) {
          'rate_limited' => strings.reportRateLimited,
          'feature_disabled' when catalog => strings.reportUnavailable,
          'not_found' when catalog => strings.reportPlaceGone,
          _ => strings.reportFailed,
        };
        _submitting = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _error = strings.reportFailed;
        _submitting = false;
      });
    }
  }

  String _label(AppLocalizations strings, PoiIssueType type) => switch (type) {
    PoiIssueType.wrongCategory => strings.reportWrongCategory,
    PoiIssueType.closed => strings.reportClosed,
    PoiIssueType.wrongLocation => strings.reportWrongLocation,
    PoiIssueType.duplicate => strings.reportDuplicate,
    PoiIssueType.misleadingPhoto => strings.reportMisleadingPhoto,
    PoiIssueType.other => strings.reportOtherDataIssue,
  };
}
