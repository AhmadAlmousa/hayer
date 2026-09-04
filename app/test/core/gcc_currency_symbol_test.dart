import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_currency/gcc_currency.dart';
import 'package:hayer_app/core/gcc_currency_symbol.dart';

void main() {
  test('maps every GCC country to its official currency symbol', () {
    // Behavior under test: GCC amounts never fall back to dollar signs.
    // Arrange / Act / Assert
    expect(gccCurrencyForCountryCode('SA'), GCCCurrency.sar);
    expect(gccCurrencyForCountryCode('AE'), GCCCurrency.aed);
    expect(gccCurrencyForCountryCode('QA'), GCCCurrency.qar);
    expect(gccCurrencyForCountryCode('OM'), GCCCurrency.omr);
    expect(gccCurrencyForCountryCode('KW'), GCCCurrency.kwd);
    expect(gccCurrencyForCountryCode('BH'), GCCCurrency.bhd);
    expect(gccCurrencyForCountryCode('US'), isNull);
  });
}
