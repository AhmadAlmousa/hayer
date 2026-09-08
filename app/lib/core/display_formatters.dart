import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../l10n/generated/app_localizations.dart';

String formatDistance(BuildContext context, int meters) {
  final strings = AppLocalizations.of(context)!;
  final locale = Localizations.localeOf(context).toLanguageTag();
  return meters < 1000
      ? strings.distanceMetersLabel(
          NumberFormat.decimalPattern(locale).format(meters),
        )
      : strings.distanceKilometersLabel(
          NumberFormat('0.#', locale).format(meters / 1000),
        );
}

String formatCount(BuildContext context, num value) =>
    NumberFormat.decimalPattern(
      Localizations.localeOf(context).toLanguageTag(),
    ).format(value);

String formatLocalDateTime(BuildContext context, DateTime value) =>
    DateFormat.yMMMd(
      Localizations.localeOf(context).toLanguageTag(),
    ).add_jm().format(value.toLocal());

String formatPhoneNumber(String value) {
  final hasPlus = value.trimLeft().startsWith('+');
  final digits = value.replaceAll(RegExp(r'\D'), '');
  if (digits.isEmpty) return value;

  final gccMatch = RegExp(
    r'^(966|971|974|968|965|973)(\d+)$',
  ).firstMatch(digits);
  if (gccMatch != null) {
    final country = gccMatch.group(1)!;
    final local = gccMatch.group(2)!;
    final groups = <String>[];
    if (local.length >= 2) {
      groups.add(local.substring(0, 2));
      final remainder = local.substring(2);
      if (remainder.length > 4) {
        groups
          ..add(remainder.substring(0, remainder.length - 4))
          ..add(remainder.substring(remainder.length - 4));
      } else if (remainder.isNotEmpty) {
        groups.add(remainder);
      }
    } else {
      groups.add(local);
    }
    return '+$country ${groups.join(' ')}'.trimRight();
  }

  final groups = <String>[];
  var end = digits.length;
  while (end > 0) {
    final start = (end - 3).clamp(0, end);
    groups.insert(0, digits.substring(start, end));
    end = start;
  }
  return '${hasPlus ? '+' : ''}${groups.join(' ')}';
}
