import 'package:material_ui/material_ui.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../session_code.dart';

Uri sessionJoinUri(String code) =>
    Uri.https('hayer.almou.sa', '/join/${formatSessionCode(code)}');

/// A high-contrast, standards-first QR code for a public session link.
class SessionQrCode extends StatelessWidget {
  const SessionQrCode({super.key, required this.code, this.size = 240});

  final String code;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      image: true,
      label: 'Join session ${formatSessionCode(code)}',
      child: SizedBox.square(
        dimension: size,
        child: ColoredBox(
          color: Colors.white,
          child: ExcludeSemantics(
            child: QrImageView(
              key: ValueKey('session-qr-$code'),
              data: sessionJoinUri(code).toString(),
              errorCorrectionLevel: QrErrorCorrectLevel.M,
              backgroundColor: Colors.white,
              eyeStyle: const QrEyeStyle(
                eyeShape: QrEyeShape.square,
                color: Colors.black,
              ),
              dataModuleStyle: const QrDataModuleStyle(
                dataModuleShape: QrDataModuleShape.square,
                color: Colors.black,
              ),
              padding: const EdgeInsets.all(16),
              gapless: true,
            ),
          ),
        ),
      ),
    );
  }
}
