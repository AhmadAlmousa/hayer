enum VisitTimeChoice { anyTime, openNow, custom }

DateTime? visitAtForSelection(
  VisitTimeChoice choice, {
  required DateTime now,
  DateTime? customTime,
}) => switch (choice) {
  VisitTimeChoice.anyTime => null,
  VisitTimeChoice.openNow => now.toUtc(),
  VisitTimeChoice.custom => customTime?.toUtc(),
};

String priceLevelLabel(int? priceLevel, {required String anyPriceLabel}) =>
    priceLevel == null
    ? anyPriceLabel
    : List<String>.filled(priceLevel, r'$').join();
