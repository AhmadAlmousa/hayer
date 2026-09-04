import 'package:flutter/widgets.dart';
import 'package:gcc_currency/gcc_currency.dart';

GCCCurrency? gccCurrencyForCountryCode(String? countryCode) =>
    switch (countryCode?.toUpperCase()) {
      'SA' => GCCCurrency.sar,
      'AE' => GCCCurrency.aed,
      'QA' => GCCCurrency.qar,
      'OM' => GCCCurrency.omr,
      'KW' => GCCCurrency.kwd,
      'BH' => GCCCurrency.bhd,
      _ => null,
    };

IconData? gccCurrencyIconForCountryCode(String? countryCode) {
  final currency = gccCurrencyForCountryCode(countryCode);
  return currency == null ? null : GCCCurrencyText.icon(currency);
}

class GccPriceLevel extends StatelessWidget {
  const GccPriceLevel({
    super.key,
    required this.countryCode,
    required this.level,
    this.fallbackText,
    this.color,
    this.size = 16,
  });

  final String? countryCode;
  final int? level;
  final String? fallbackText;
  final Color? color;
  final double size;

  @override
  Widget build(BuildContext context) {
    final currency = gccCurrencyForCountryCode(countryCode);
    if (currency == null || level == null) {
      return Text(
        fallbackText ?? '',
        style: TextStyle(color: color, fontSize: size),
      );
    }
    return Semantics(
      label: '${currency.name.toUpperCase()} price level $level',
      child: RichText(
        text: TextSpan(
          children: [
            for (var index = 0; index < level!; index++)
              GCCCurrencyText.span(currency, size: size, color: color),
          ],
        ),
      ),
    );
  }
}
