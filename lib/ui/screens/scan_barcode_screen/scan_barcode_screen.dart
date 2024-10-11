import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_locker_windows/themes/theme_config.dart';
import 'package:smart_locker_windows/ui/widgets/bottom_row_widget.dart';
import 'package:smart_locker_windows/ui/widgets/title_bar_widget.dart';
import '../../../routes/route_constants.dart';

class ScanBarcodeScreen extends StatefulWidget {
  const ScanBarcodeScreen({Key? key}) : super(key: key);

  @override
  State<ScanBarcodeScreen> createState() => _ScanBarcodeScreenState();
}

class _ScanBarcodeScreenState extends State<ScanBarcodeScreen> {
  final FocusNode _focusNode = FocusNode();

  bool isBarCodeDataAvailable = false;

  String _controller = '';
  String scannerText = "Please scan the bar code using the bar code scanner";

  @override
  void initState() {
    isBarCodeDataAvailable = false;
    _controller = "";
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(_focusNode);
    return Scaffold(
      backgroundColor: THEME_COLOR,
      body: Container(
        margin: const EdgeInsets.only(
          top: 20,
          left: 10,
          right: 10,
          bottom: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const TitleBarWidget(
              titleText: "Scan Barcode",
            ),

            //
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Please scan each item and",
                      style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 20,
                      ),
                    ),

                    //
                    const Text(
                      "Click on Deposit once all items scanned",
                      style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 20,
                      ),
                    ),

                    //
                    const SizedBox(height: 24),

                    //
                    scannerWidget(),

                    //
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        isBarCodeDataAvailable
                            ? ElevatedButton(
                                onPressed: () {
                                  // Clear data
                                  isBarCodeDataAvailable = false;
                                  _controller = "";

                                  Navigator.pushNamed(
                                    context,
                                    LOCKER_DETAIL_SCREEN_ROUTE,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.yellow,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 80,
                                    vertical: 20,
                                  ),
                                ),
                                child: const Text(
                                  "Deposit",
                                  style: TextStyle(
                                    fontSize: 21,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            : const SizedBox(),

                        //

                        SizedBox(width: isBarCodeDataAvailable ? 16 : 1),

                        //
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _controller = "";
                              isBarCodeDataAvailable = false;
                              scannerText =
                                  "Please scan the bar code using the bar code scanner";
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.yellow,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 80,
                              vertical: 20,
                            ),
                          ),
                          child: const Text(
                            "Reset",
                            style: TextStyle(
                              fontSize: 21,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const BottomRowWidget(
              showBackButton: true,
              showLockerImage: false,
              showLogoutWidget: true,
              showText: false,
            ),

            //
          ],
        ),
      ),
    );
  }

  Widget scannerWidget() {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return DefaultTextStyle(
      style: textTheme.bodyLarge!,
      child: KeyboardListener(
        focusNode: _focusNode,
        onKeyEvent: (KeyEvent event) {
          String? keyBoardEvent;

          if (event.character == null &&
              (event.logicalKey.debugName == "Enter"||
              event.logicalKey.keyId == 4294967309)) {
            keyBoardEvent = "\n";
          }

          _controller += event.character ?? keyBoardEvent ?? "";

          if ((event.character == "\n" || keyBoardEvent == "\n") &&
              !isBarCodeDataAvailable) {
            scannerText = "Scanning complete.";
            isBarCodeDataAvailable = true;

            setState(() {});
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(
              "assets/img/barcode_1.png",
              // "assets/img/scanner.png",
              height: 250,
              width: 250,
            ),

            //
            const SizedBox(height: 16),

            //
            Text(
              scannerText,
              style: const TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),

            //
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
