import 'package:flutter/material.dart';
import 'package:smart_locker_windows/themes/theme_config.dart';
import 'package:smart_locker_windows/ui/widgets/bottom_row_widget.dart';
import 'package:smart_locker_windows/ui/widgets/title_bar_widget.dart';
import '../../../../routes/route_constants.dart';

// TODO: Unused file
class ReturnTypeScreen extends StatefulWidget {
  const ReturnTypeScreen({Key? key}) : super(key: key);

  @override
  State<ReturnTypeScreen> createState() => _ReturnTypeScreenState();
}

class _ReturnTypeScreenState extends State<ReturnTypeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: THEME_COLOR,
      body: Container(
        margin: const EdgeInsets.only(
          top: 25,
          left: 10,
          right: 10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const TitleBarWidget(
              logoEmirates: 'assets/img/Logo_emirates.png',
              titleText: "Return Type",
              subtitleText: "Please select your return\ntype item",
            ),

            //
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          SCAN_BARCODE_SCREEN_ROUTE,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 80,
                          vertical: 20,
                        ),
                      ),
                      label: const Text(
                        "Return Standard Item\n(Item with Asset Code)",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      icon: const Icon(
                        Icons.qr_code_scanner,
                        size: 50,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          BIN_PRINT_BARCODE_SCREEN_ROUTE,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 80,
                          vertical: 20,
                        ),
                      ),
                      label: const Text(
                        "Return Loose Item\n(Item without Asset Code)",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      icon: const Icon(
                        Icons.qr_code_scanner,
                        size: 50,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const BottomRowWidget(
              showText: false,
            ),

            //
          ],
        ),
      ),
    );
  }
}
