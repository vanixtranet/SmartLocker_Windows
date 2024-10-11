// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart';
// import 'package:flutter_pos_printer_platform_image_3/flutter_pos_printer_platform_image_3.dart';
// import 'package:smart_locker_windows/routes/route_constants.dart';
// import 'package:smart_locker_windows/themes/theme_config.dart';
// import 'package:smart_locker_windows/ui/widgets/title_bar_widget.dart';
// import '../../../data/bloc/user_model_bloc/user_model_bloc.dart';
// import '../../widgets/progress_indicator.dart';

// class BinPrintBarcodeScreen extends StatefulWidget {
//   const BinPrintBarcodeScreen({Key? key}) : super(key: key);

//   @override
//   State<BinPrintBarcodeScreen> createState() => _BinDropItemsScreenState();
// }

// class _BinDropItemsScreenState extends State<BinPrintBarcodeScreen> {
//   bool showCPI = true;

//   // printer params
//   var defaultPrinterType = PrinterType.usb;
//   var devices = <UsbPrinter>[];
//   var printerManager = PrinterManager.instance;
//   StreamSubscription<PrinterDevice>? _subscription;
//   UsbPrinter? selectedPrinter;

//   @override
//   void initState() {
//     _scan();

//     super.initState();
//   }

//   @override
//   void dispose() {
//     _subscription?.cancel();
//     super.dispose();
//   }

//   // PRINTER CODE START

//   // method to scan devices according PrinterType
//   void _scan() async {
//     devices.clear();

//     await Future.delayed(const Duration(seconds: 1));
//     _subscription = printerManager
//         .discovery(type: PrinterType.usb, isBle: false)
//         .listen((device) {
//       devices.add(UsbPrinter(
//         deviceName: device.name,
//         address: device.address,
//         isBle: false,
//         vendorId: device.vendorId,
//         productId: device.productId,
//         typePrinter: defaultPrinterType,
//       ));
//     });

//     await Future.delayed(const Duration(seconds: 5));

//     // select printer
//     for (var i = 0; i < devices.length; i++) {
//       if ((devices[i].deviceName?.toLowerCase().contains("masung") ?? false) ||
//           (devices[i].deviceName?.toLowerCase().contains("printer") ?? false)) {
//         selectedPrinter = devices[i];
//         break;
//       }
//     }

//     // connect to the printer
//     _connectDevice();

//     // print
//     _printReceiveTest();
//   }

//   Future _printReceiveTest() async {
//     List<int> bytes = [];

//     // Xprinter XP-N160I
//     final profile = await CapabilityProfile.load();
//     final generator = Generator(PaperSize.mm80, profile);
//     bytes += generator.setGlobalCodeTable('CP1252');
//     bytes += generator.text(
//       'Accessory Device Return',
//       styles: const PosStyles(align: PosAlign.center),
//     );

//     final List<int> barData = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
//     bytes += generator.barcode(Barcode.codabar(barData));

//     _printEscPos(bytes, generator);
//   }

//   /// print ticket
//   void _printEscPos(List<int> bytes, Generator generator) async {
//     if (selectedPrinter == null) return;

//     var bluetoothPrinter = selectedPrinter!;

//     bytes += generator.feed(1);
//     bytes += generator.cut();

//     await printerManager.connect(
//       type: bluetoothPrinter.typePrinter,
//       model: UsbPrinterInput(
//         name: bluetoothPrinter.deviceName,
//         productId: bluetoothPrinter.productId,
//         vendorId: bluetoothPrinter.vendorId,
//       ),
//     );

//     await Future.delayed(const Duration(seconds: 3));
//     printerManager.send(type: bluetoothPrinter.typePrinter, bytes: bytes);

//     setState(() {
//       showCPI = false;
//     });
//   }

//   /// connect to printer
//   _connectDevice() async {
//     if (selectedPrinter == null) return;

//     await printerManager.connect(
//       type: selectedPrinter!.typePrinter,
//       model: UsbPrinterInput(
//         name: selectedPrinter!.deviceName,
//         productId: selectedPrinter!.productId,
//         vendorId: selectedPrinter!.vendorId,
//       ),
//     );
//   }

//   // PRINTER CODE END

//   void handleOnTap(BuildContext context) {
//     if (BlocProvider.of<UserModelBloc>(context)
//             .state
//             .userModel
//             ?.userRoleCodes ==
//         "SL_ADMIN") {
//       Navigator.pushNamedAndRemoveUntil(
//         context,
//         SERVICE_INTERFACE_SCREEN_ROUTE,
//         ModalRoute.withName('/serviceInterfaceScreen'),
//       );
//     } else {
//       Navigator.pushNamedAndRemoveUntil(
//         context,
//         LOCKER_RETURN_COLLECT_SCREEN_ROUTE,
//         ModalRoute.withName('/returnCollectScreen'),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: THEME_COLOR,
//       body: Container(
//         margin: const EdgeInsets.only(
//           top: 25,
//           left: 10,
//           right: 10,
//           bottom: 20,
//         ),
//         child: Stack(
//           children: [
//             Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               mainAxisSize: MainAxisSize.max,
//               children: [
//                 const TitleBarWidget(
//                   // logoEmirates: 'assets/img/Logo_emirates.png',
//                   titleText: "Stick Labels & Drop Items",
//                 ),

//                 //
//                 const Text(
//                   "Please paste the barcode on the accessory",
//                   style: TextStyle(
//                     color: Colors.yellow,
//                     fontSize: 24,
//                   ),
//                 ),

//                 //
//                 Image.asset(
//                   "assets/img/drop-bin.png",
//                   height: 310,
//                   width: 300,
//                 ),

//                 //
//                 const Text(
//                   "After sticking the label. Please drop the item into the Bin",
//                   style: TextStyle(
//                     color: Colors.yellow,
//                     fontSize: 20,
//                   ),
//                 ),

//                 //
//                 const SizedBox(height: 10),

//                 //
//                 // const Text(
//                 //   "Do you want to print another label?",
//                 //   style: TextStyle(
//                 //     color: Colors.white,
//                 //     fontSize: 20,
//                 //     fontWeight: FontWeight.bold,
//                 //   ),
//                 // ),

//                 //
//                 const SizedBox(height: 30),

//                 //
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.pushNamed(
//                       context,
//                       BIN_OPEN_SCREEN_ROUTE,
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.yellow,
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 60,
//                       vertical: 15,
//                     ),
//                   ),
//                   child: const Text(
//                     "Continue",
//                     style: TextStyle(
//                       fontSize: 21,
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Visibility(
//               visible: showCPI,
//               child: const CustomProgressIndicator(
//                 loadingText: "Please wait while the label is printed.",
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class UsbPrinter {
//   int? id;
//   String? deviceName;
//   String? address;
//   String? port;
//   String? vendorId;
//   String? productId;
//   bool? isBle;

//   PrinterType typePrinter;
//   bool? state;

//   UsbPrinter({
//     this.deviceName,
//     this.address,
//     this.port,
//     this.state,
//     this.vendorId,
//     this.productId,
//     this.typePrinter = PrinterType.usb,
//     this.isBle = false,
//   });
// }

//======================================================================================================//
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:smart_locker_windows/routes/route_constants.dart';
import 'package:smart_locker_windows/themes/theme_config.dart';
import 'package:smart_locker_windows/ui/widgets/snack_bar.dart';
import 'package:smart_locker_windows/ui/widgets/title_bar_widget.dart';
import '../../../data/bloc/user_model_bloc/user_model_bloc.dart';
import '../../widgets/progress_indicator.dart';

class BinPrintBarcodeScreen extends StatefulWidget {
  const BinPrintBarcodeScreen({Key? key}) : super(key: key);

  @override
  State createState() => _BinDropItemsScreenState();
}

class _BinDropItemsScreenState extends State {
  // todo turn true for print
  bool showCPI = true;

  @override
  void initState() {
    super.initState();
// todo uncomment  for print
    _scanAndPrint();
  }

  List<String> debugMessage = [];
  Printer? masungPrinter;

  Future<void> _scanAndPrint() async {
    // Get the list of printers
    final printers = await Printing.listPrinters();
    // Printer? saveToPdfPrinter;

    // Find the "Masung" printer
    try {
      setState(() {
        masungPrinter = printers.firstWhere(
          (printer) => printer.name.toLowerCase() == 'w80',
        );
      });
      addDebugMessage('printer detected: ${masungPrinter?.name}');
    } catch (e) {
      masungPrinter = null;
      // saveToPdfPrinter = printers[2];
      addDebugMessage('error detected: $e');
    }

    if (masungPrinter != null) {
      // If the "Masung" printer is found, proceed to print
      await _printToMasungPrinter(printer: masungPrinter!);
      displaySnackBar(context: context, text: masungPrinter?.name);
    } else {
      String? printerName = masungPrinter?.name;
      // Handle the case where the printer is not found
      print('$printerName  printer not found');
      addDebugMessage('$printerName printer not found');
      displaySnackBar(context: context, text: 'Masung printer not found');

      // if (saveToPdfPrinter != null) {
      //   await _printToMasungPrinter(saveToPdfPrinter);
      // }
    }
    // return;
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Text('Accessory Device Return',
                  textAlign: pw.TextAlign.center),
              pw.SizedBox(height: 20),
              pw.BarcodeWidget(
                barcode: pw.Barcode.codabar(),
                data: '0123456789',
                width: 200,
                height: 80,
              ),
            ],
          );
        },
      ),
    );
    return await pdf.save();
  }

  Future<void> _printToMasungPrinter({required Printer printer}) async {
    // Create a new PDF document

    const PdfPageFormat pageFormat = PdfPageFormat.roll80;

    try {
      addDebugMessage('printing Started');
      // Print directly to the "Masung" printer
      await Printing.directPrintPdf(
        format: pageFormat,
        dynamicLayout: true,
        forceCustomPrintPaper: true,
        printer: printer,
        onLayout: (PdfPageFormat format) async =>
            await _generatePdf(pageFormat),
      );
      // Send a cut command to the printer after printing
      _sendCutCommandToUsbPrinter();

      setState(() {
        showCPI = false; // Hide the progress indicator
      });
    } catch (e) {
      addDebugMessage('printing Ended with error :$e');
    }
  }

  Future<void> _sendCutCommandToUsbPrinter() async {
    final port = SerialPort('USB001'); // Open the USB port

    if (!port.isOpen) {
      if (!port.openReadWrite()) {
        print('Failed to open port');
        return;
      }
    }

    // Create a generator for the ESC/POS commands
    final Generator generator =
        Generator(PaperSize.mm80, await CapabilityProfile.load());

    // Generate the cut command bytes
    List<int> cutCommandBytes = generator.cut();

    // Write the bytes to the USB port
    final written = port.write(Uint8List.fromList(cutCommandBytes));

    if (written == -1) {
      print('Failed to write to USB port');
    } else {
      print('Cut command sent successfully');
    }

    port.close(); // Close the port when done
  }

//preview
  Future<Uint8List> _generatePreviewPdf() async {
    final pdf = pw.Document();
    const PdfPageFormat pageFormat = PdfPageFormat(
      100 * PdfPageFormat.mm,
      double.infinity,
    );

    pdf.addPage(
      pw.Page(
        pageFormat: pageFormat,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Text('Accessory Device Return',
                    textAlign: pw.TextAlign.center),
                pw.SizedBox(height: 20),
                pw.BarcodeWidget(
                  barcode: pw.Barcode.codabar(),
                  data: '0123456789',
                  width: 160,
                  height: 80,
                ),
              ],
            ),
          );
        },
      ),
    );
    return await pdf.save();
  }

  void handleOnTap(BuildContext context) {
    if (BlocProvider.of<UserModelBloc>(context)
            .state
            .userModel
            ?.userRoleCodes ==
        "SL_ADMIN") {
      Navigator.pushNamedAndRemoveUntil(
        context,
        SERVICE_INTERFACE_SCREEN_ROUTE,
        ModalRoute.withName('/serviceInterfaceScreen'),
      );
    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        LOCKER_RETURN_COLLECT_SCREEN_ROUTE,
        ModalRoute.withName('/returnCollectScreen'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: THEME_COLOR,
      body: Container(
        margin: const EdgeInsets.only(
          top: 25,
          left: 10,
          right: 10,
          bottom: 20,
        ),
        child: Stack(
          children: [
            showCPI
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        flex: 4,
                        child: PdfPreview(
                          allowSharing: false,
                          canChangeOrientation: false,
                          allowPrinting: false,
                          canChangePageFormat: false,
                          padding: DEFAULT_PADDING,
                          build: (format) => _generatePreviewPdf(),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: debugMessage.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Text(debugMessage[index]);
                          },
                        ),
                      )
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const TitleBarWidget(
                        titleText: "Stick Labels & Drop Items",
                      ),
                      const Text(
                        "Please paste the barcode on the accessory",
                        style: TextStyle(
                          color: Colors.yellow,
                          fontSize: 24,
                        ),
                      ),
                      Image.asset(
                        "assets/img/drop-bin.png",
                        height: 310,
                        width: 300,
                      ),
                      const Text(
                        "After sticking the label. Please drop the item into the Bin",
                        style: TextStyle(
                          color: Colors.yellow,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          // _printReceiptTest();
                          Navigator.pushNamed(
                            context,
                            BIN_OPEN_SCREEN_ROUTE,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 60,
                            vertical: 15,
                          ),
                        ),
                        child: const Text(
                          "Continue",
                          style: TextStyle(
                            fontSize: 21,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
            Visibility(
              visible: showCPI,
              child: const CustomProgressIndicator(
                loadingText: "Please wait while the label is printed.",
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addDebugMessage(String message) {
    setState(() {
      debugMessage.add(message);
    });
  }
}
