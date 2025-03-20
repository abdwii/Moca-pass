import 'package:MocaPass/core/local_data/session_management.dart';
import 'package:MocaPass/features/scan/scanner_border_painter.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../core/utility/strings.dart';
import '../../core/utility/theme.dart';

class QRCodeScannerBasic extends StatefulWidget {
  final Function(String) onScanned;
  final bool isBackCamera;

  const QRCodeScannerBasic({
    Key? key,
    required this.onScanned,
    required this.isBackCamera,
  }) : super(key: key);

  @override
  State<QRCodeScannerBasic> createState() => _QRCodeScannerBasicState();
}

class _QRCodeScannerBasicState extends State<QRCodeScannerBasic> {
  CameraController? _cameraController;
  late List<CameraDescription> _cameras;
  final BarcodeScanner _barcodeScanner = BarcodeScanner();
  bool _isProcessing = false;
  bool _isBackCamera = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  void didUpdateWidget(covariant QRCodeScannerBasic oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isBackCamera != widget.isBackCamera) {
      _switchCamera();
    }
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    _startCamera(widget.isBackCamera ? _cameras.first : _cameras.last);
  }

  void _startCamera(CameraDescription camera) async {
    _cameraController =
        CameraController(camera, ResolutionPreset.max, enableAudio: false);
    _cameraController?.setFocusMode(FocusMode.auto);
    await _cameraController?.initialize();
    if (mounted) {
      setState(() {});
      _startScanning();
    }
  }

  void _switchCamera() async {
    await _cameraController?.dispose();
    _isBackCamera = !_isBackCamera;
    SessionManagement.setCamFacing(!_isBackCamera);
    _startCamera(_isBackCamera ? _cameras.first : _cameras.last);
  }

  void _startScanning() async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (!_cameraController!.value.isStreamingImages) {
      _cameraController!.startImageStream((CameraImage image) async {
        if (_isProcessing) return;
        _isProcessing = true;

        final barcode = await _detectQRCode(image);
        if (barcode != null) {
          widget.onScanned(barcode);
        }

        await Future.delayed(const Duration(seconds: 2));
        _isProcessing = false;
      });
    }
  }

  Future<String?> _detectQRCode(CameraImage image) async {
    final inputImage = _convertCameraImage(image);
    if (inputImage == null) return null;

    final barcodes = await _barcodeScanner.processImage(inputImage);
    if (barcodes.isNotEmpty) {
      return barcodes.first.rawValue;
    }
    return null;
  }

  InputImage? _convertCameraImage(CameraImage image) {
    try {
      final WriteBuffer writeBuffer = WriteBuffer();
      for (final Plane plane in image.planes) {
        writeBuffer.putUint8List(plane.bytes);
      }
      final Uint8List bytes = writeBuffer.done().buffer.asUint8List();

      final inputImageData = InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: InputImageRotation.rotation0deg,
        format: InputImageFormat.nv21,
        bytesPerRow: image.planes.first.bytesPerRow,
      );

      return InputImage.fromBytes(bytes: bytes, metadata: inputImageData);
    } catch (e) {
      print("Error converting image: $e");
      return null;
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _barcodeScanner.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var deviceType = getDeviceType(MediaQuery.of(context).size);
    var isTablet = deviceType == DeviceScreenType.tablet ||
        deviceType == DeviceScreenType.desktop;
    var deviceOrientation = (MediaQuery.of(context).orientation);
    return Scaffold(
      body: Stack(
        children: [
          Expanded(
            child: _cameraController?.value.isInitialized == true
                ? SizedBox.expand(
                    child: CameraPreview(_cameraController!),
                  )
                : const Center(child: CircularProgressIndicator()),
          ),
          Positioned.fill(
            child: CustomPaint(
              painter: ScannerOverlayPainter(deviceOrientation,isTablet),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 35, left: 10, right: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back),
                      color: Colors.white,
                    ),
                    Text("Back", style: scannerInfoTextStyle(isTablet)),
                    const Spacer(),
                    IconButton(
                      onPressed: _switchCamera,
                      color: Colors.white,
                      icon: const Icon(Icons.flip_camera_ios_outlined),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: deviceOrientation == Orientation.portrait
                          ? 10.sh
                          : 2.5.sh,
                      bottom: deviceOrientation == Orientation.portrait
                          ? 10.sh
                          : .5.sh),
                  child: Text(
                    StringConst.scanInfoText,
                    style: scannerInfoTextStyle(isTablet),
                    textAlign: TextAlign.center,
                  ),
                ),
                // Image.asset(
                //   AssetsData.scan,
                //   height: isTablet
                //       ? 40.sh
                //       : deviceOrientation == Orientation.portrait
                //           ? 30.sh
                //           : 25.sh,
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
