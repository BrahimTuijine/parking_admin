import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pfe_parking_admin/screens/qrcode_scanner/scan_animation.dart';
import 'package:pfe_parking_admin/screens/qrcode_scanner/scanner_overlay.dart';
import 'package:pfe_parking_admin/services/qr_code_service.dart';

class BarcodeScanner extends HookWidget {
  BarcodeScanner({Key? key}) : super(key: key);
  static String routeName = "/scanner";

  bool isScanedOnce = false;

  final Duration delay = const Duration(milliseconds: 700);
  final Duration duration = const Duration(milliseconds: 2800);

  final MobileScannerController cameraController = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates, autoStart: true);

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(duration: duration)
      ..repeat(reverse: true);

    useEffect(() {
      cameraController.stop();
      isScanedOnce = false;
      return () {};
    }, const []);

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          actions: [
            IconButton(
              color: Colors.white,
              icon: ValueListenableBuilder(
                valueListenable: cameraController.torchState,
                builder: (context, state, child) {
                  switch (state) {
                    case TorchState.off:
                      return const Icon(Icons.flash_off, color: Colors.grey);
                    case TorchState.on:
                      return const Icon(Icons.flash_on, color: Colors.white);
                  }
                },
              ),
              iconSize: 32.0,
              onPressed: () => cameraController.toggleTorch(),
            ),
          ],
        ),
        body: Stack(
          children: [
            MobileScanner(
              controller: cameraController,
              onDetect: (capture) async {
                final List<Barcode> barcodes = capture.barcodes;

                if (barcodes.isNotEmpty) {
                  if (isScanedOnce == false) {
                    final result = await FirebaseQrCode.getPaymentWithId(
                        barcodes[0].rawValue!);
                    if (result != null) {
                      print(result);
                      if (context.mounted) {
                        context.go("/airoports/qrCode", extra: result);
                      }
                    }
                    isScanedOnce = true;
                    // if (context.mounted) {
                    //   context.pop();
                    // }
                  }
                }
              },
            ),

            QRScannerOverlay(
              overlayColour: Colors.black.withOpacity(.5),
            ),

            ScannerAnimation(
              animation: animationController,
              scanningColor: Colors.cyan,
              scanningHeightOffset: 900,
            ),

            // AnimatedPositioned(height: 40,child: Image.asset('assets/images/img_24.png'),duration: Duration(microseconds: 200),),
          ],
        ));
  }
}
