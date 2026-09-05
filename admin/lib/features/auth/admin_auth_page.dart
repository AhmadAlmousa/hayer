import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'admin_auth_controller.dart';
import 'enrollment_navigation.dart';

class AdminAuthPage extends StatelessWidget {
  const AdminAuthPage({
    super.key,
    required this.controller,
    required this.enrollment,
  });

  final AdminAuthController controller;
  final bool enrollment;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: AnimatedBuilder(
                  animation: controller,
                  builder: (context, _) => Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(14),
                            child: Icon(
                              Icons.admin_panel_settings_rounded,
                              size: 34,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        enrollment ? 'Enroll a passkey' : 'Hayer Admin',
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        enrollment
                            ? 'Use the recovery credentials once, then save a passkey in your browser, phone, or security key.'
                            : 'Sign in with a passkey. Your private key and biometrics stay on your device.',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      if (enrollment) ...[
                        const SizedBox(height: 16),
                        const _SecurityNote(),
                      ],
                      if (controller.error != null) ...[
                        const SizedBox(height: 18),
                        MaterialBanner(
                          content: Text(controller.error!),
                          leading: const Icon(Icons.error_outline_rounded),
                          actions: const [SizedBox.shrink()],
                        ),
                      ],
                      const SizedBox(height: 24),
                      FilledButton.icon(
                        key: Key(
                          enrollment ? 'enroll-passkey' : 'sign-in-passkey',
                        ),
                        onPressed: controller.isBusy
                            ? null
                            : enrollment
                            ? controller.enroll
                            : controller.signIn,
                        icon: controller.isBusy
                            ? const SizedBox.square(
                                dimension: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(Icons.key_rounded),
                        label: Text(
                          enrollment
                              ? 'Continue with recovery credentials'
                              : 'Sign in with passkey',
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: controller.isBusy
                            ? null
                            : () => enrollment
                                  ? context.go('/login')
                                  : openEnrollment(context),
                        child: Text(
                          enrollment
                              ? 'Back to sign in'
                              : 'Enroll or recover a passkey',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

class _SecurityNote extends StatelessWidget {
  const _SecurityNote();

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.tertiaryContainer,
      borderRadius: BorderRadius.circular(14),
    ),
    child: const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.shield_outlined),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            'The browser will request the break-glass Basic Auth credentials. They are never stored by Hayer. The temporary enrollment session is revoked after registration.',
          ),
        ),
      ],
    ),
  );
}
