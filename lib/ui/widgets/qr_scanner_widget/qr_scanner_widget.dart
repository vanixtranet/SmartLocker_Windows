// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
// import '../../../routes/route_constants.dart';
// import '../progress_indicator.dart';
// import 'qr_overlay.dart';

// class QRScannerWidget extends StatefulWidget {
//   final bool isCollect;

//   const QRScannerWidget({
//     Key? key,
//     this.isCollect = false,
//   }) : super(key: key);

//   @override
//   State<QRScannerWidget> createState() => _QRScannerWidgetState();
// }

// class _QRScannerWidgetState extends State<QRScannerWidget> {
//   final GlobalKey key = GlobalKey();
//   bool showCPI = false;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         title: const Text("Scan QR code"),
//         centerTitle: true,

//         // Aesthetics
//         backgroundColor: Colors.transparent,
//         foregroundColor: Colors.white,
//         systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
//           statusBarColor: Colors.transparent,
//         ),
//       ),
//       body: _qrScannerWidget(context),
//     );
//   }

//   Widget _qrScannerWidget(BuildContext context) => Stack(
//         alignment: Alignment.center,
//         children: [
//           MobileScanner(
//             allowDuplicates: false,
//             onDetect: (code, args) {
//               if (code.rawValue == null) {
//                 debugPrint('Failed to scan Barcode');
//               } else {
//                 if (widget.isCollect) {
//                   handleCollectItem();
//                 } else {
//                   Navigator.pop(context, code.rawValue);
//                 }
//               }
//             },
//           ),

//           //
//           Container(
//             decoration: ShapeDecoration(
//               shape: QrScannerOverlayShape(
//                 borderColor: Colors.red.shade900,
//                 borderRadius: 12,
//                 borderLength: 24,
//                 borderWidth: 12,
//               ),
//             ),
//           ),

//           Visibility(
//             visible: showCPI,
//             child: const Center(
//               child: CustomProgressIndicator(),
//             ),
//           ),
//         ],
//       );

//   handleCollectItem() {
//     Navigator.pushNamed(
//       context,
//       AUTHENTICATE_ROUTE,
//     );
//   }
// }
