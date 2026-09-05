import 'dart:async';

import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hayer_client/hayer_client.dart';
import 'package:material_3_expressive/material_3_expressive.dart';

import '../../core/providers.dart';
import '../../core/page_title.dart';
import '../../core/session_code.dart';
import '../../core/widgets/content_shell.dart';
import '../../l10n/generated/app_localizations.dart';

class JoinScreen extends ConsumerStatefulWidget {
  const JoinScreen({super.key, this.initialCode});
  final String? initialCode;

  @override
  ConsumerState<JoinScreen> createState() => _JoinScreenState();
}

class _JoinScreenState extends ConsumerState<JoinScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _code;
  final _name = TextEditingController();
  final _nameFocus = FocusNode();
  bool _loading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _code = TextEditingController(
      text: extractSessionCode(widget.initialCode ?? '') ?? '',
    );
    unawaited(_restoreDisplayName());
  }

  @override
  void dispose() {
    _code.dispose();
    _name.dispose();
    _nameFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    setBrowserPageTitle('${strings.joinSession} — ${strings.appName}');
    return Scaffold(
      appBar: M3EAppBar.top(
        automaticallyImplyLeading: true,
        title: Text(strings.joinSession),
        actions: [
          M3EIconButton(
            tooltip: strings.scanQrCode,
            onPressed: () => context.push('/scan'),
            icon: const Icon(Icons.qr_code_scanner_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: ContentShell(
          child: ListView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.all(24),
            children: [
              const SizedBox(height: 28),
              Icon(
                Icons.group_add_rounded,
                size: 64,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 28),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _code,
                      autofocus: widget.initialCode == null,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textCapitalization: TextCapitalization.characters,
                      textInputAction: TextInputAction.next,
                      onChanged: (_) => _clearError(),
                      onFieldSubmitted: (_) => _nameFocus.requestFocus(),
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.ltr,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 8,
                      ),
                      inputFormatters: [
                        _LocalizedSessionCodeFormatter(),
                        LengthLimitingTextInputFormatter(
                          maxSessionCodeLength,
                        ),
                        FilteringTextInputFormatter.allow(
                          RegExp('[A-Za-z0-9]'),
                        ),
                        _UpperCaseFormatter(),
                      ],
                      validator: (value) => isValidSessionCode(value ?? '')
                          ? null
                          : strings.invalidSessionCode,
                      decoration: InputDecoration(
                        labelText: strings.sessionCode,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _name,
                      focusNode: _nameFocus,
                      autofocus: widget.initialCode != null,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      maxLength: 30,
                      textInputAction: TextInputAction.done,
                      onChanged: (_) => _clearError(),
                      onFieldSubmitted: (_) => _loading ? null : _join(),
                      validator: (value) {
                        final length = value?.trim().length ?? 0;
                        return length >= 2 && length <= 30
                            ? null
                            : strings.invalidDisplayName;
                      },
                      decoration: InputDecoration(
                        labelText: strings.displayName,
                        prefixIcon: const Icon(Icons.person_outline),
                      ),
                    ),
                    if (_error != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Text(
                          _error!,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ),
                    M3EButton.filled(
                      onPressed: _loading ? null : _join,
                      size: M3EButtonSize.md,
                      child: _loading
                          ? const SizedBox.square(
                              dimension: 22,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(strings.join),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _join() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final bundle = await ref
          .read(sessionRepositoryProvider)
          .join(extractSessionCode(_code.text)!, _name.text.trim());
      if (!mounted) return;
      await ref.read(displayNameStoreProvider).write(_name.text.trim());
      if (!mounted) return;
      context.go('/lobby/${bundle.session.sessionId}', extra: bundle);
    } catch (error) {
      setState(
        () => _error = error is ApiException
            ? error.message
            : AppLocalizations.of(context)!.joinFailed,
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _clearError() {
    if (_error != null) setState(() => _error = null);
  }

  Future<void> _restoreDisplayName() async {
    final value = await ref.read(displayNameStoreProvider).read();
    if (!mounted || value == null || _name.text.isNotEmpty) return;
    setState(() => _name.text = value);
  }
}

class _LocalizedSessionCodeFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) => newValue.copyWith(
    text: normalizeSessionCodeCharacters(newValue.text),
    selection: newValue.selection,
  );
}

class _UpperCaseFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) => newValue.copyWith(
    text: newValue.text.toUpperCase(),
    selection: newValue.selection,
  );
}
