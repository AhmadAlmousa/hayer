package sa.almou.hayer

import com.google.mlkit.vision.barcode.common.Barcode
import com.google.mlkit.vision.codescanner.GmsBarcodeScannerOptions
import com.google.mlkit.vision.codescanner.GmsBarcodeScanning
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private var scanInProgress = false

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            QR_SCANNER_CHANNEL,
        ).setMethodCallHandler { call, result ->
            if (call.method != "scanQr") {
                result.notImplemented()
                return@setMethodCallHandler
            }
            if (scanInProgress) {
                result.error("scanner_busy", "A QR scan is already running.", null)
                return@setMethodCallHandler
            }

            scanInProgress = true
            val options =
                GmsBarcodeScannerOptions.Builder()
                    .setBarcodeFormats(Barcode.FORMAT_QR_CODE)
                    .enableAutoZoom()
                    .build()
            GmsBarcodeScanning.getClient(this, options)
                .startScan()
                .addOnSuccessListener { barcode ->
                    scanInProgress = false
                    result.success(barcode.rawValue)
                }.addOnCanceledListener {
                    scanInProgress = false
                    result.success(null)
                }.addOnFailureListener { error ->
                    scanInProgress = false
                    result.error(
                        "scanner_failed",
                        error.localizedMessage ?: "The QR scanner could not start.",
                        null,
                    )
                }
        }
    }

    private companion object {
        const val QR_SCANNER_CHANNEL = "sa.almou.hayer/qr_scanner"
    }
}
