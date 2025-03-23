import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../core/local_data/session_management.dart';
import '../../core/utility/strings.dart';
import '../../core/utility/theme.dart';
import '../scan/scanner_border_painter.dart';

class QRCodeScanner extends StatefulWidget {
  final Function(String) onScanned;
  final bool useBackCamera;

  const QRCodeScanner({
    Key? key,
    required this.onScanned,
    this.useBackCamera = true,
  }) : super(key: key);

  @override
  State<QRCodeScanner> createState() => _QRCodeScannerState();
}

class _QRCodeScannerState extends State<QRCodeScanner> {
  CameraController? _cameraController;
  late List<CameraDescription> _cameras;
  final BarcodeScanner _barcodeScanner = BarcodeScanner();
  bool _isProcessing = false;
  late bool _useBackCamera; // Use a local variable to track the camera

  @override
  void initState() {
    super.initState();
    _useBackCamera = widget.useBackCamera;
    _initializeCamera();
  }

  @override
  void didUpdateWidget(covariant QRCodeScanner oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.useBackCamera != widget.useBackCamera) {
      _useBackCamera = widget.useBackCamera;
      _switchCamera();
    }
  }

  Future<void> _initializeCamera() async {
    try {
      _cameras = await availableCameras();
      if (_cameras.isEmpty) {
        print("No cameras available.");
        return;
      }
      _startCamera(_useBackCamera ? _cameras.first : _cameras.last);
    } catch (e) {
      print("Error getting available cameras: $e");
    }
  }

  void _startCamera(CameraDescription camera) async {
    if (!mounted) return; // Check if the widget is still mounted

    _cameraController = CameraController(
      camera,
      ResolutionPreset.max,
      enableAudio: false,
    );

    try {
      await _cameraController?.initialize();

      if (mounted) {
        setState(() {});
        _startScanning();
      }
    } on CameraException catch (e) {
      print("Camera initialization error: ${e.description}");
    } catch (e) {
      print("Error starting camera: $e");
    }
  }

  void _switchCamera() async {
    if (_cameraController == null) return;
    await _cameraController?.dispose();
    _useBackCamera = !_useBackCamera;
    SessionManagement.setCamFacing(!_useBackCamera);
    _startCamera(_useBackCamera ? _cameras.first : _cameras.last);
  }

  void _startScanning() async {
    // Add a check to ensure the controller is initialized and not already streaming
    if (_cameraController == null ||
        !_cameraController!.value.isInitialized ||
        _cameraController!.value.isStreamingImages) {
      return;
    }
    await Future.delayed(const Duration(milliseconds: 500));

    _cameraController!.startImageStream((CameraImage image) async {
      if (_isProcessing) return;
      _isProcessing = true;

      // Log or check image data validity here
      if (image.planes.isEmpty) {
        print("Camera image has no planes.");
        return;
      }
      await _cameraController?.setFocusMode(FocusMode.auto);


      final barcode = await _detectQRCode(image);
      if (barcode != null) {
        widget.onScanned(barcode);
      }

      await Future.delayed(const Duration(seconds: 2));
      _isProcessing = false;
    });
  }

  Future<String?> _detectQRCode(CameraImage image) async {
    final inputImage = _convertCameraImage(image);
    if (inputImage == null) return null;

    try {
      final barcodes = await _barcodeScanner.processImage(inputImage);
      if (barcodes.isNotEmpty) {
        return barcodes.first.rawValue;
      }
    } catch (e) {
      print("Error processing image: $e");
    }
    return null;
  }

  InputImage? _convertCameraImage(CameraImage image) {
    try {
      if (image.planes.isEmpty) {
        print("Camera image has no planes.");
        return null;
      }

      final WriteBuffer writeBuffer = WriteBuffer();
      for (final Plane plane in image.planes) {
        writeBuffer.putUint8List(plane.bytes);
      }
      final Uint8List bytes = writeBuffer.done().buffer.asUint8List();

      final inputImageData = InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: InputImageRotation.rotation0deg,
        format: Platform.isIOS? InputImageFormat.bgra8888 : InputImageFormat.nv21,
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
/*
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
              painter: ScannerOverlayPainter(deviceOrientation, isTablet),
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
              ],
            ),
          ),
        ],
      ),
    );
  }*/
  @override
  Widget build(BuildContext context) {
    var deviceType = getDeviceType(MediaQuery.of(context).size);
    var isTablet = deviceType == DeviceScreenType.tablet ||
        deviceType == DeviceScreenType.desktop;
    var deviceOrientation = MediaQuery.of(context).orientation;

    return Scaffold(
      body: Stack(
        children: [
          // Replace Expanded with Positioned.fill or SizedBox.expand
          Positioned.fill(
            child: _cameraController?.value.isInitialized == true
                ? CameraPreview(_cameraController!)
                : const Center(child: CircularProgressIndicator()),
          ),
          Positioned.fill(
            child: CustomPaint(
              painter: ScannerOverlayPainter(deviceOrientation, isTablet),
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
                    top: deviceOrientation == Orientation.portrait ? 10.sh : 2.5.sh,
                    bottom: deviceOrientation == Orientation.portrait ? 10.sh : .5.sh,
                  ),
                  child: Text(
                    StringConst.scanInfoText,
                    style: scannerInfoTextStyle(isTablet),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
