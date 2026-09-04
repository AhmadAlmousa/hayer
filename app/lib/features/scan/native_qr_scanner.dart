import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

abstract interface class QrScanner {
  bool get isSupported;

  Future<String?> scan();
}

final class NativeQrScanner implements QrScanner {
  const NativeQrScanner({
    this.channel = const MethodChannel(_channelName),
  });

  static const _channelName = 'sa.almou.hayer/qr_scanner';

  final MethodChannel channel;

  @override
  bool get isSupported =>
      !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS);

  @override
  Future<String?> scan() async {
    if (!isSupported) {
      throw const NativeQrScannerException('scanner_unavailable');
    }

    try {
      final value = await channel.invokeMethod<String>('scanQr');
      final trimmed = value?.trim();
      return trimmed == null || trimmed.isEmpty ? null : trimmed;
    } on MissingPluginException {
      throw const NativeQrScannerException('scanner_unavailable');
    } on PlatformException catch (error) {
      throw NativeQrScannerException(error.code, message: error.message);
    }
  }
}

final class NativeQrScannerException implements Exception {
  const NativeQrScannerException(this.code, {this.message});

  final String code;
  final String? message;

  @override
  String toString() => 'NativeQrScannerException($code, $message)';
}
