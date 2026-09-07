import 'package:flutter/material.dart';
import 'package:hayer_client/hayer_client.dart';

import '../../l10n/generated/app_localizations.dart';

Future<RouteOriginMode?> showRouteOriginChoice(
  BuildContext context, {
  required RouteOriginMode initialOrigin,
  bool requiredChoice = false,
}) => showModalBottomSheet<RouteOriginMode>(
  context: context,
  isDismissible: !requiredChoice,
  enableDrag: !requiredChoice,
  showDragHandle: true,
  builder: (_) => RouteOriginChoiceSheet(initialOrigin: initialOrigin),
);

class RouteOriginChoiceSheet extends StatefulWidget {
  const RouteOriginChoiceSheet({
    super.key,
    required this.initialOrigin,
  });

  final RouteOriginMode initialOrigin;

  @override
  State<RouteOriginChoiceSheet> createState() => _RouteOriginChoiceSheetState();
}

class _RouteOriginChoiceSheetState extends State<RouteOriginChoiceSheet> {
  late RouteOriginMode _origin;

  @override
  void initState() {
    super.initState();
    _origin = widget.initialOrigin;
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              strings.routeOriginTitle,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 6),
            Text(strings.routeOriginDescription),
            const SizedBox(height: 12),
            RadioGroup<RouteOriginMode>(
              groupValue: _origin,
              onChanged: _select,
              child: Column(
                children: [
                  RadioListTile<RouteOriginMode>(
                    key: const ValueKey('route-origin-host'),
                    value: RouteOriginMode.sessionAnchor,
                    title: Text(strings.useHostLocation),
                    subtitle: Text(strings.useHostLocationDescription),
                    secondary: const Icon(Icons.group_outlined),
                  ),
                  RadioListTile<RouteOriginMode>(
                    key: const ValueKey('route-origin-current'),
                    value: RouteOriginMode.participantLocation,
                    title: Text(strings.useMyLocation),
                    subtitle: Text(strings.useMyLocationDescription),
                    secondary: const Icon(Icons.my_location_rounded),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            FilledButton(
              key: const ValueKey('route-origin-continue'),
              onPressed: () => Navigator.pop(context, _origin),
              child: Text(strings.continueLabel),
            ),
          ],
        ),
      ),
    );
  }

  void _select(RouteOriginMode? value) {
    if (value != null) setState(() => _origin = value);
  }
}
