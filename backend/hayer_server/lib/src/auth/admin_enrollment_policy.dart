import 'dart:io';

abstract final class AdminEnrollmentPolicy {
  static const environmentKey = 'HAYER_ADMIN_ENROLLMENT_ENABLED';

  static bool get isEnabled => isEnabledIn(Platform.environment);

  static bool isEnabledIn(Map<String, String> environment) =>
      environment[environmentKey]?.trim().toLowerCase() == 'true';
}
