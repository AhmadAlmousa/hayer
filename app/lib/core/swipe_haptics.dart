import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';

abstract final class SwipeHaptics {
  /// Plays a soft single pulse for like and a crisper double pulse for nope.
  static Future<void> play(bool liked) async {
    try {
      if (await Vibration.hasVibrator()) {
        if (liked) {
          await Vibration.vibrate(
            duration: 42,
            amplitude: 96,
            sharpness: .25,
          );
        } else if (await Vibration.hasCustomVibrationsSupport()) {
          await Vibration.vibrate(
            pattern: const [0, 24, 42, 38],
            intensities: const [0, 110, 0, 165],
            sharpness: .7,
          );
        } else {
          await Vibration.vibrate(duration: 70, amplitude: 150);
        }
        return;
      }
    } catch (_) {
      // Web and devices without the plugin continue through Flutter haptics.
    }

    if (liked) {
      await HapticFeedback.selectionClick();
    } else {
      await HapticFeedback.mediumImpact();
    }
  }
}
