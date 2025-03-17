import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen>
    with WidgetsBindingObserver {
  MobileScannerController controller = MobileScannerController();
  String? scannedData;
  bool _hasPermission = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkCameraPermission();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    controller.dispose();
    super.dispose();
  }

  Future<void> _checkCameraPermission() async {
    final status = await Permission.camera.request();
    setState(() {
      _hasPermission = status.isGranted;
    });
  }

  void _showResultDialog(String data) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Scan Result'),
        content: Text(data),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              controller.start();
            },
            child: const Text('Scan Again'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_hasPermission) {
      return Scaffold(
        appBar: AppBar(title: const Text('QR Scanner')),
        body: const Center(
          child: Text('Camera permission required'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Scanner'),
        actions: [],
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Stack(
            children: [
              MobileScanner(
                controller: controller,
                fit: BoxFit.contain,
                onDetect: (capture) {
                  final List<Barcode> barcodes = capture.barcodes;
                  if (barcodes.isNotEmpty) {
                    final String data =
                        barcodes.first.rawValue ?? 'No data found';
                    setState(() => scannedData = data);
                    controller.stop();
                    _showResultDialog(data);
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class CustomScannerOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isPortrait = screenSize.height > screenSize.width;

    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        Colors.black.withOpacity(0.1),
        BlendMode.srcOut,
      ),
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: Align(
              alignment: Alignment.center,
              child: Container(
                width: isPortrait ? 300 : 400,
                height: isPortrait ? 300 : 400,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
