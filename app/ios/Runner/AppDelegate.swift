import AVFoundation
import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  private var qrScannerChannel: FlutterMethodChannel?
  private var qrScannerController: NativeQrScannerViewController?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)

    let channel = FlutterMethodChannel(
      name: "sa.almou.hayer/qr_scanner",
      binaryMessenger: engineBridge.applicationRegistrar.messenger()
    )
    qrScannerChannel = channel
    channel.setMethodCallHandler { [weak self] call, result in
      guard call.method == "scanQr" else {
        result(FlutterMethodNotImplemented)
        return
      }
      self?.presentQrScanner(result: result)
    }
  }

  private func presentQrScanner(result: @escaping FlutterResult) {
    guard qrScannerController == nil else {
      result(FlutterError(
        code: "scanner_busy",
        message: "A QR scan is already running.",
        details: nil
      ))
      return
    }
    guard let presenter = topViewController() else {
      result(FlutterError(
        code: "scanner_failed",
        message: "The QR scanner could not be presented.",
        details: nil
      ))
      return
    }

    let controller = NativeQrScannerViewController { [weak self] outcome in
      self?.qrScannerController = nil
      switch outcome {
      case .code(let value):
        result(value)
      case .cancelled:
        result(nil)
      case .failure(let code, let message):
        result(FlutterError(code: code, message: message, details: nil))
      }
    }
    qrScannerController = controller
    controller.modalPresentationStyle = .fullScreen
    presenter.present(controller, animated: true)
  }

  private func topViewController() -> UIViewController? {
    let windowScene = UIApplication.shared.connectedScenes
      .compactMap { $0 as? UIWindowScene }
      .first { $0.activationState == .foregroundActive }
    let root = windowScene?.windows.first { $0.isKeyWindow }?.rootViewController
    return topViewController(from: root)
  }

  private func topViewController(from controller: UIViewController?) -> UIViewController? {
    if let presented = controller?.presentedViewController {
      return topViewController(from: presented)
    }
    if let navigation = controller as? UINavigationController {
      return topViewController(from: navigation.visibleViewController)
    }
    if let tabs = controller as? UITabBarController {
      return topViewController(from: tabs.selectedViewController)
    }
    return controller
  }
}

private enum NativeQrScannerOutcome {
  case code(String)
  case cancelled
  case failure(code: String, message: String)
}

private final class NativeQrScannerViewController: UIViewController,
  AVCaptureMetadataOutputObjectsDelegate
{
  private let completion: (NativeQrScannerOutcome) -> Void
  private let captureSession = AVCaptureSession()
  private let metadataOutput = AVCaptureMetadataOutput()
  private let sessionQueue = DispatchQueue(label: "sa.almou.hayer.qr-capture")
  private lazy var previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
  private let scanFrameLayer = CAShapeLayer()
  private var captureDevice: AVCaptureDevice?
  private var hasFinished = false

  private lazy var cancelButton: UIButton = {
    let button = scannerButton(systemName: "xmark")
    button.accessibilityLabel = "Cancel"
    button.addTarget(self, action: #selector(cancel), for: .touchUpInside)
    return button
  }()

  private lazy var torchButton: UIButton = {
    let button = scannerButton(systemName: "flashlight.off.fill")
    button.accessibilityLabel = "Toggle flashlight"
    button.isEnabled = false
    button.addTarget(self, action: #selector(toggleTorch), for: .touchUpInside)
    return button
  }()

  init(completion: @escaping (NativeQrScannerOutcome) -> Void) {
    self.completion = completion
    super.init(nibName: nil, bundle: nil)
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .black

    previewLayer.videoGravity = .resizeAspectFill
    view.layer.addSublayer(previewLayer)

    scanFrameLayer.fillColor = UIColor.clear.cgColor
    scanFrameLayer.strokeColor = UIColor.white.cgColor
    scanFrameLayer.lineWidth = 4
    view.layer.addSublayer(scanFrameLayer)

    view.addSubview(cancelButton)
    view.addSubview(torchButton)
    NSLayoutConstraint.activate([
      cancelButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
      cancelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
      cancelButton.widthAnchor.constraint(equalToConstant: 52),
      cancelButton.heightAnchor.constraint(equalTo: cancelButton.widthAnchor),
      torchButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
      torchButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
      torchButton.widthAnchor.constraint(equalToConstant: 52),
      torchButton.heightAnchor.constraint(equalTo: torchButton.widthAnchor),
    ])

    requestCameraAccess()
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    previewLayer.frame = view.bounds

    let side = min(view.bounds.width * 0.72, 320)
    let frame = CGRect(
      x: (view.bounds.width - side) / 2,
      y: (view.bounds.height - side) / 2,
      width: side,
      height: side
    )
    scanFrameLayer.path = UIBezierPath(roundedRect: frame, cornerRadius: 28).cgPath
    metadataOutput.rectOfInterest = previewLayer.metadataOutputRectConverted(fromLayerRect: frame)
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    stopCaptureSession()
  }

  func metadataOutput(
    _ output: AVCaptureMetadataOutput,
    didOutput metadataObjects: [AVMetadataObject],
    from connection: AVCaptureConnection
  ) {
    guard
      let object = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
      object.type == .qr,
      let value = object.stringValue
    else {
      return
    }
    finish(with: .code(value))
  }

  private func requestCameraAccess() {
    switch AVCaptureDevice.authorizationStatus(for: .video) {
    case .authorized:
      configureCaptureSession()
    case .notDetermined:
      AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
        DispatchQueue.main.async {
          guard let self else { return }
          if granted {
            self.configureCaptureSession()
          } else {
            self.finish(with: .failure(
              code: "camera_permission_denied",
              message: "Camera access is required to scan a session QR code."
            ))
          }
        }
      }
    case .denied, .restricted:
      finish(with: .failure(
        code: "camera_permission_denied",
        message: "Camera access is required to scan a session QR code."
      ))
    @unknown default:
      finish(with: .failure(
        code: "scanner_failed",
        message: "The camera is unavailable."
      ))
    }
  }

  private func configureCaptureSession() {
    sessionQueue.async { [weak self] in
      guard let self, !self.hasFinished else { return }
      guard
        let device = AVCaptureDevice.default(
          .builtInWideAngleCamera,
          for: .video,
          position: .back
        ) ?? AVCaptureDevice.default(for: .video)
      else {
        self.failCaptureSetup("No camera is available on this device.")
        return
      }

      do {
        let input = try AVCaptureDeviceInput(device: device)
        self.captureSession.beginConfiguration()
        defer { self.captureSession.commitConfiguration() }

        guard self.captureSession.canAddInput(input) else {
          self.failCaptureSetup("The camera input could not be configured.")
          return
        }
        self.captureSession.addInput(input)

        guard self.captureSession.canAddOutput(self.metadataOutput) else {
          self.failCaptureSetup("QR detection is unavailable.")
          return
        }
        self.captureSession.addOutput(self.metadataOutput)
        self.metadataOutput.setMetadataObjectsDelegate(self, queue: .main)
        self.metadataOutput.metadataObjectTypes = [.qr]
        self.captureDevice = device

        DispatchQueue.main.async {
          self.torchButton.isEnabled = device.hasTorch
          self.view.setNeedsLayout()
        }
        self.captureSession.startRunning()
      } catch {
        self.failCaptureSetup(error.localizedDescription)
      }
    }
  }

  private func failCaptureSetup(_ message: String) {
    DispatchQueue.main.async { [weak self] in
      self?.finish(with: .failure(code: "scanner_failed", message: message))
    }
  }

  private func stopCaptureSession() {
    sessionQueue.async { [weak self] in
      guard let self, self.captureSession.isRunning else { return }
      self.captureSession.stopRunning()
    }
  }

  @objc private func cancel() {
    finish(with: .cancelled)
  }

  @objc private func toggleTorch() {
    guard let device = captureDevice, device.hasTorch else { return }
    do {
      try device.lockForConfiguration()
      let enable = device.torchMode != .on
      device.torchMode = enable ? .on : .off
      device.unlockForConfiguration()
      torchButton.setImage(
        UIImage(systemName: enable ? "flashlight.on.fill" : "flashlight.off.fill"),
        for: .normal
      )
    } catch {
      torchButton.isEnabled = false
    }
  }

  private func finish(with outcome: NativeQrScannerOutcome) {
    guard !hasFinished else { return }
    hasFinished = true
    stopCaptureSession()
    dismiss(animated: true) { [completion] in
      completion(outcome)
    }
  }

  private func scannerButton(systemName: String) -> UIButton {
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.tintColor = .white
    button.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    button.layer.cornerRadius = 26
    button.setImage(UIImage(systemName: systemName), for: .normal)
    return button
  }
}
