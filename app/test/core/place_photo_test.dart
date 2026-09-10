import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hayer_app/core/place_photo.dart';

void main() {
  testWidgets('a square box is bounded wide enough to cover its height', (
    tester,
  ) async {
    // 48 logical pixels of height needs about 85 logical pixels of width
    // before a 16:9 photo is tall enough to cover the box.
    expect(
      await _bound(tester, boxWidth: 48, boxHeight: 48),
      86,
    );
  });

  testWidgets('a wide box is bounded by its own width', (tester) async {
    // 120 logical pixels of height only needs 214 of width, which the box
    // already exceeds, so nothing is added on the photo's account.
    expect(
      await _bound(tester, boxWidth: 328, boxHeight: 120),
      328,
    );
  });

  testWidgets('the bound scales with the device pixel ratio', (tester) async {
    expect(
      await _bound(tester, boxWidth: 328, boxHeight: 120, ratio: 3),
      984,
    );
    expect(
      await _bound(tester, boxWidth: 48, boxHeight: 48, ratio: 3),
      256,
    );
  });

  testWidgets('the bound covers the box for any landscape photo', (
    tester,
  ) async {
    for (final box in const [Size(48, 48), Size(328, 120), Size(360, 640)]) {
      final width = (await _bound(
        tester,
        boxWidth: box.width,
        boxHeight: box.height,
        ratio: 3,
      ))!;
      for (final aspect in const [1.0, 4 / 3, 3 / 2, 16 / 9]) {
        expect(
          width,
          greaterThanOrEqualTo(box.width * 3),
          reason: 'a $aspect photo must fill ${box.width} logical pixels',
        );
        expect(
          width / aspect,
          greaterThanOrEqualTo(box.height * 3),
          reason: 'a $aspect photo must fill ${box.height} logical pixels',
        );
      }
    }
  });

  testWidgets('an unmeasurable box is left unbounded', (tester) async {
    expect(
      await _bound(tester, boxWidth: double.infinity, boxHeight: 120),
      isNull,
    );
    expect(
      await _bound(tester, boxWidth: 328, boxHeight: double.infinity),
      isNull,
    );
    expect(await _bound(tester, boxWidth: 0, boxHeight: 120), isNull);
    expect(await _bound(tester, boxWidth: 328, boxHeight: 0), isNull);
  });
}

Future<int?> _bound(
  WidgetTester tester, {
  required double boxWidth,
  required double boxHeight,
  double ratio = 1,
}) async {
  int? bound;
  await tester.pumpWidget(
    MediaQuery(
      data: MediaQueryData(devicePixelRatio: ratio),
      child: Builder(
        builder: (context) {
          bound = placePhotoDecodeWidth(
            context,
            boxWidth: boxWidth,
            boxHeight: boxHeight,
          );
          return const SizedBox.shrink();
        },
      ),
    ),
  );
  return bound;
}
