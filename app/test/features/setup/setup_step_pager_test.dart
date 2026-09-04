import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/features/setup/setup_step_pager.dart';

void main() {
  testWidgets('incoming page pushes the outgoing page', (tester) async {
    final controller = PageController();
    addTearDown(controller.dispose);
    const first = ValueKey('first-step');
    const second = ValueKey('second-step');

    await tester.pumpWidget(
      MaterialApp(
        home: SizedBox(
          width: 400,
          child: SetupStepPager(
            controller: controller,
            children: const [
              ColoredBox(key: first, color: Colors.red),
              ColoredBox(key: second, color: Colors.blue),
            ],
          ),
        ),
      ),
    );

    controller.animateToPage(
      1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.linear,
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 150));

    expect(tester.getTopLeft(find.byKey(first)).dx, lessThan(0));
    expect(tester.getTopLeft(find.byKey(second)).dx, inInclusiveRange(0, 400));
  });
}
