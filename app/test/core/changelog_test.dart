import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/core/changelog.dart';

void main() {
  test('first install is silent and records the current version', () async {
    // Behavior under test: onboarding is not interrupted on first install.
    String? stored;
    final controller = ChangelogController(
      read: () async => stored,
      write: (value) async => stored = value,
    );

    expect(await controller.unseenChanges('0.1.0', 'en'), isEmpty);
    expect(stored, '0.1.0');
  });

  test('an upgrade returns localized unseen release notes once', () async {
    // Behavior under test: returning Arabic users see the skipped update once.
    var stored = '0.0.9';
    final controller = ChangelogController(
      read: () async => stored,
      write: (value) async => stored = value,
    );

    final changes = await controller.unseenChanges('0.1.0', 'ar');

    expect(changes, isNotEmpty);
    expect(changes.first, contains('روابط'));
    expect(stored, '0.1.0');
    expect(await controller.unseenChanges('0.1.0', 'ar'), isEmpty);
  });
}
