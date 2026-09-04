import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/features/setup/setup_preferences.dart';

void main() {
  test('maps the three visit-time choices to the request value', () {
    final now = DateTime(2026, 9, 4, 18, 30);
    final custom = DateTime(2026, 9, 5, 20);

    expect(
      visitAtForSelection(VisitTimeChoice.anyTime, now: now),
      isNull,
    );
    expect(
      visitAtForSelection(VisitTimeChoice.openNow, now: now),
      now.toUtc(),
    );
    expect(
      visitAtForSelection(
        VisitTimeChoice.custom,
        now: now,
        customTime: custom,
      ),
      custom.toUtc(),
    );
  });

  test('formats price levels as increasing dollar signs', () {
    expect(priceLevelLabel(null, anyPriceLabel: 'Any'), 'Any');
    expect(priceLevelLabel(1, anyPriceLabel: 'Any'), r'$');
    expect(priceLevelLabel(4, anyPriceLabel: 'Any'), r'$$$$');
  });
}
