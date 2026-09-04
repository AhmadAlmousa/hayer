import 'package:material_ui/material_ui.dart';

/// Moves setup pages as one horizontal strip so incoming pages push outgoing.
class SetupStepPager extends StatelessWidget {
  const SetupStepPager({
    super.key,
    required this.controller,
    required this.children,
  });

  final PageController controller;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => PageView(
    controller: controller,
    physics: const NeverScrollableScrollPhysics(),
    children: children,
  );
}
