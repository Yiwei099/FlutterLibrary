import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:xiandun/utils/colors.dart';
import 'package:xiandun/widget/com_app_bar.dart';
import 'package:xiandun/widget/scanner_animation.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

/// 基于mobile_scanner(体积太大，暂时不用)
// class _ScannerScreenState extends State<ScannerScreen> with WidgetsBindingObserver {
//   late final MobileScannerController _controller;
//   StreamSubscription<Object?>? _subscription;
//
//   void _handleBarcode(BarcodeCapture barcodes) async {
//     debugPrint('handleBarCode：${barcodes.barcodes.firstOrNull?.rawValue ?? 'is empty'}');
//     if (mounted) {
//       final barcode = barcodes.barcodes.firstOrNull;
//       if (barcode != null) {
//         // 停止扫描并返回
//         await _controller.stop();
//         // 调用回调函数
//         Get.back(result:barcode.rawValue ?? '');
//       }
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = MobileScannerController();
//
//     // Start listening to lifecycle changes.
//     WidgetsBinding.instance.addObserver(this);
//
//     // Start listening to the barcode events.
//     _subscription = _controller.barcodes.listen(_handleBarcode);
//
//     // Finally, start the scanner itself.
//     unawaited(_controller.start());
//   }
//
//   @override
//   Future<void> dispose() async {
//     super.dispose();
//     // Stop listening to lifecycle changes.
//     WidgetsBinding.instance.removeObserver(this);
//     // Stop listening to the barcode events.
//     unawaited(_subscription?.cancel());
//     _subscription = null;
//     // Dispose the widget itself.
//     super.dispose();
//     // Finally, dispose of the controller.
//     await _controller.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: ComAppBar(title: '扫描二维码'),
//       backgroundColor: Colors.black,
//       body: Stack(
//         children: [
//           MobileScanner(
//             controller: _controller,
//             onDetect: _handleBarcode,
//           ),
//           // 条形码扫描动画
//           ScannerAnimation(needBorder: true,),
//         ],
//       ),
//     );
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     // If the controller is not ready, do not try to start or stop it.
//     // Permission dialogs can trigger lifecycle changes before the controller is ready.
//     if (!_controller.value.hasCameraPermission) {
//       return;
//     }
//
//     switch (state) {
//       case AppLifecycleState.detached:
//       case AppLifecycleState.hidden:
//       case AppLifecycleState.paused:
//         return;
//       case AppLifecycleState.resumed:
//       // Restart the scanner when the app is resumed.
//       // Don't forget to resume listening to the barcode events.
//         _subscription = _controller.barcodes.listen(_handleBarcode);
//
//         unawaited(_controller.start());
//       case AppLifecycleState.inactive:
//       // Stop the scanner when the app is paused.
//       // Also stop the barcode events subscription.
//         unawaited(_subscription?.cancel());
//         _subscription = null;
//         unawaited(_controller.stop());
//     }
//   }
// }

/// 基于qr_code_scanner_plus
class _ScannerScreenState extends State<ScannerScreen> {
  final GlobalKey scanKey = GlobalKey(debugLabel: 'SCAN');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ComAppBar(title: '扫描二维码'),
      body: _buildScannerWidget(),
    );
  }

  Widget _buildScannerWidget() {
    return Stack(
      children: [
        QRView(
          key: scanKey,
          onQRViewCreated: _onQRViewCreated,
          overlay: QrScannerOverlayShape(
            borderRadius: 8,
            borderColor: MyColors.primary,
            borderLength: 30,
            borderWidth: 6,
            cutOutSize: 260,
          ),
        ),
        // 条形码扫描动画
        ScannerAnimation(),
      ],
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    controller.scannedDataStream.listen((scanData) {
      // 处理扫描结果
      debugPrint('Scanned data: ${scanData.code}');
      // 可以在这里关闭扫描页面或显示结果
      Get.back(result: scanData.code ?? '');
    });
  }
}
