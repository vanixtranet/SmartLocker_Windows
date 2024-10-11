import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_locker_windows/routes/route_constants.dart';
import 'package:smart_locker_windows/themes/theme_config.dart';
import 'package:smart_locker_windows/ui/widgets/bottom_row_widget.dart';
import 'package:smart_locker_windows/ui/widgets/title_bar_widget.dart';
import '../../../../routes/screen_arguments.dart';

class BarcodeMessageScreen extends StatefulWidget {
  final bool isEmployee;
  const BarcodeMessageScreen({
    Key? key,
    this.isEmployee = false,
  }) : super(key: key);

  @override
  State<BarcodeMessageScreen> createState() => _BarcodeMessageScreenState();
}

class _BarcodeMessageScreenState extends State<BarcodeMessageScreen> {
  final FocusNode _focusNode = FocusNode();

  bool isBarCodeDataAvailable = false;

  String _controller = '';
  String scannerText = "Please scan the bar code using the bar code scanner";

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
        margin: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const TitleBarWidget(
              titleText: "Scan Barcode",
            ),

            //
            const SizedBox(height: 24),

            //
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Please scan the asset code to store the device in the locker",
                      style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 20,
                      ),
                    ),

                    //
                    const SizedBox(height: 20),

                    //
                    scannerWidget(),

                    //
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        isBarCodeDataAvailable
                            ? ElevatedButton(
                                onPressed: () => _handleSubmitOnTap(),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.yellow,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 80,
                                    vertical: 20,
                                  ),
                                ),
                                child: const Text(
                                  "Submit",
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

                    //
                    // const SizedBox(height: 30),

                    // //
                    // const Text(
                    //   "Please write your custom message",
                    //   style: TextStyle(
                    //     color: Colors.white,
                    //     fontSize: 20,
                    //   ),
                    // ),

                    // //
                    // TextFormField(
                    //   maxLines: 3,
                    //   decoration: InputDecoration(
                    //     fillColor: Colors.white,
                    //     filled: true,
                    //     hintText:
                    //         "For any queries please call the help desk contact: 1234567890",
                    //     enabledBorder: OutlineInputBorder(
                    //       borderSide: const BorderSide(
                    //         width: 5,
                    //         color: Color.fromARGB(255, 186, 10, 10),
                    //       ),
                    //       borderRadius: BorderRadius.circular(20.0),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),

            //
            const BottomRowWidget(
              showLockerImage: false,
              showLogoutWidget: false,
            ),

            //
          ],
        ),
      ),
    );
  }

  _handleSubmitOnTap() async {
    if (widget.isEmployee) {
      Navigator.pushNamed(
        context,
        LOCKER_DETAIL_SCREEN_ROUTE,
        arguments: ScreenArguments(bool1: true),
      );
    } else {
      Navigator.pushNamed(
        context,
        LOCKER_SELECTION_SCREEN_ROUTE,
      );
    }
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
            isBarCodeDataAvailable = true;
            scannerText = "Scanning complete.";
          }
          setState(() {});
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
            const SizedBox(height: 16),
            Text(
              scannerText,
              style: const TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
