import 'package:hayer_server/src/auth/admin_enrollment_policy.dart';
import 'package:test/test.dart';

void main() {
  group('AdminEnrollmentPolicy', () {
    test('is disabled by default and for non-explicit values', () {
      expect(AdminEnrollmentPolicy.isEnabledIn(const {}), isFalse);
      expect(
        AdminEnrollmentPolicy.isEnabledIn(
          const {'HAYER_ADMIN_ENROLLMENT_ENABLED': 'false'},
        ),
        isFalse,
      );
      expect(
        AdminEnrollmentPolicy.isEnabledIn(
          const {'HAYER_ADMIN_ENROLLMENT_ENABLED': '1'},
        ),
        isFalse,
      );
    });

    test('accepts only an explicit case-insensitive true value', () {
      expect(
        AdminEnrollmentPolicy.isEnabledIn(
          const {'HAYER_ADMIN_ENROLLMENT_ENABLED': ' TRUE '},
        ),
        isTrue,
      );
    });
  });
}
