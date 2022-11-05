import 'package:flutter/material.dart';
import 'package:locpay/screens/upi_screen.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:locpay/constants.dart';

MobileScannerController cameraController = MobileScannerController();

class qr_code {
  static String code = '';
  static String upi = '';
}

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({Key? key}) : super(key: key);

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => cameraController.toggleTorch(),
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (context, state, child) {
                switch (state) {
                  case TorchState.off:
                    return const Icon(
                      Icons.flash_off,
                      color: Colors.grey,
                    );
                  case TorchState.on:
                    return const Icon(
                      Icons.flash_on,
                      color: Colors.yellow,
                    );
                }
              },
            ),
            iconSize: 32.0,
            color: Colors.white,
          ),
          IconButton(
            onPressed: () => cameraController.switchCamera(),
            icon: ValueListenableBuilder(
              valueListenable: cameraController.cameraFacingState,
              builder: (context, state, child) {
                switch (state) {
                  case CameraFacing.front:
                    return const Icon(Icons.camera_front);
                  case CameraFacing.back:
                    return const Icon(Icons.camera_rear);
                }
              },
            ),
            iconSize: 32.0,
            color: Colors.white,
          ),
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(
            allowDuplicates: false,
            controller: cameraController,
            onDetect: (barcode, args) {
              if (barcode.rawValue == null) {
                debugPrint('Failed to scan Barcode');
              } else {
                qr_code.code = barcode.rawValue!;
                const startIndex = 13;
                final endIndex = qr_code.code.indexOf('&');
                qr_code.upi = qr_code.code.substring(startIndex, endIndex);
                String upi = qr_code.upi;
                debugPrint('Barcode found! $upi');
                debugPrint(qr_code.code);
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => UpiScreen()));
              }
            },
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          color: kCameraColour,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          color: kCameraColour,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.height / 3,
                        height: MediaQuery.of(context).size.height / 3,
                        color: const Color(0x00000000),
                      ),
                      Expanded(
                        child: Container(
                          color: kCameraColour,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          color: kCameraColour,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
