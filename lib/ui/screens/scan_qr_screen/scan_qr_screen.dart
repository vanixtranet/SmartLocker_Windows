// import 'package:flutter/material.dart';
// import 'package:smart_locker_windows/routes/route_constants.dart';
// import 'package:smart_locker_windows/ui/widgets/bottom_row_widget.dart';
// // import 'package:smart_locker_windows/ui/widgets/logout_widget.dart';
// import 'package:flutter/services.dart';
// import '../../widgets/title_bar_widget.dart';

// class ScanQrScreen extends StatefulWidget {
//   final bool isCollect;

//   const ScanQrScreen({
//     Key? key,
//     this.isCollect = false,
//   }) : super(key: key);

//   @override
//   State<ScanQrScreen> createState() => _ScanQrScreenState();
// }

// class _ScanQrScreenState extends State<ScanQrScreen> {
//   final FocusNode _focusNode = FocusNode();

//   bool isBarCodeDataAvailable = false;

//   String _controller = '';
//   String scannerText = "Please scan the QR code using the scanner";

//   @override
//   void initState() {
//     isBarCodeDataAvailable = false;
//     _controller = "";
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _focusNode.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     FocusScope.of(context).requestFocus(_focusNode);
//     return Scaffold(
//       backgroundColor: Colors.redAccent[700],
//       body: Container(
//         margin: const EdgeInsets.only(
//           top: 20,
//           left: 10,
//           right: 10,
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const TitleBarWidget(
//               titleText: "Scan QR Code",
//             ),

//             //
//             Expanded(
//               child: Column(
//                 children: [
//                   const Text(
//                     "Please scan QR code sent to you via email",
//                     style: TextStyle(
//                       color: Colors.yellow,
//                       fontSize: 20,
//                     ),
//                   ),

//                   //
//                   const SizedBox(height: 24),

//                   //
//                   scannerWidget(),

//                   //
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       isBarCodeDataAvailable
//                           ? ElevatedButton(
//                               onPressed: () => _handleSubmitOnTap(),
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.yellow,
//                                 padding: const EdgeInsets.symmetric(
//                                   horizontal: 80,
//                                   vertical: 20,
//                                 ),
//                               ),
//                               child: const Text(
//                                 "Submit",
//                                 style: TextStyle(
//                                   fontSize: 21,
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             )
//                           : const SizedBox(),

//                       //
//                       SizedBox(width: isBarCodeDataAvailable ? 16 : 1),

//                       //
//                       ElevatedButton(
//                         onPressed: () {
//                           setState(() {
//                             _controller = "";
//                             isBarCodeDataAvailable = false;
//                             scannerText =
//                                 "Please scan the QR code using the scanner";
//                           });
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.yellow,
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 80,
//                             vertical: 20,
//                           ),
//                         ),
//                         child: const Text(
//                           "Reset",
//                           style: TextStyle(
//                             fontSize: 21,
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),

//             //
//             const BottomRowWidget(
//               showText: false,
//             ),

//             //
//           ],
//         ),
//       ),
//     );
//   }

//   // _handleScanOnTap() async {
//   //   String code = await Navigator.of(context).push(
//   //     MaterialPageRoute(
//   //       builder: (BuildContext context) {
//   //         // return HardwareBarcodeScanner();
//   //         return QRScannerWidget(isCollect: widget.isCollect);
//   //       },
//   //     ),
//   //   );
//   // }

//   Widget scannerWidget() {
//     final TextTheme textTheme = Theme.of(context).textTheme;
//     return DefaultTextStyle(
//       style: textTheme.bodyLarge!,
//       child: RawKeyboardListener(
//         focusNode: _focusNode,
//         onKey: (RawKeyEvent event) {
//           if (event is RawKeyDownEvent) {
//             _controller += event.data.keyLabel;

//             if (event.data.keyLabel == "\n" && !isBarCodeDataAvailable) {
//               scannerText = "Scanning complete.";
//               isBarCodeDataAvailable = true;
//             }
//             setState(() {});
//           }
//         },
//         child: Column(
//           mainAxisSize: MainAxisSize.max,
//           children: [
//             const SizedBox(height: 16),

//             //
//             Image.asset(
//               // "assets/img/barcode_1.png",
//               "assets/img/scanner_image.jpeg",
//               height: 200,
//               width: 200,
//             ),

//             //
//             const SizedBox(height: 16),

//             //
//             Text(
//               scannerText,
//               style: const TextStyle(
//                 fontSize: 20.0,
//                 color: Colors.white,
//               ),
//             ),

//             //
//             const SizedBox(height: 32),
//           ],
//         ),
//       ),
//     );
//   }

//   _handleSubmitOnTap() {
//     isBarCodeDataAvailable = false;
//     _controller = "";

//     Navigator.pushNamed(
//       context,
//       AUTHENTICATE_ROUTE,
//     );
//   }
// }
