import 'package:flutter/material.dart';
import 'package:smart_locker_windows/routes/route_constants.dart';
import 'package:smart_locker_windows/themes/theme_config.dart';
import 'package:smart_locker_windows/ui/widgets/bottom_row_widget.dart';
import 'package:smart_locker_windows/ui/widgets/title_bar_widget.dart';
import '../../../../routes/screen_arguments.dart';

class StoreRetunScreen extends StatelessWidget {
  const StoreRetunScreen({Key? key}) : super(key: key);

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
              titleText: "Kiosk Services Home",
              subtitleText: "Please select an interface\nto continue",
            ),

            //
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.pushNamed(
                        context,
                        BARCODE_MESSAGE_SCREEN_ROUTE,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 80,
                          vertical: 20,
                        ),
                      ),
                      child: const Text(
                        "Store",
                        style: TextStyle(
                          fontSize: 21,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    //
                    const SizedBox(width: 30),

                    //
                    ElevatedButton(
                      onPressed: () => Navigator.pushNamed(
                        context,
                        LOCKER_SELECTION_SCREEN_ROUTE,
                        arguments: ScreenArguments(bool1: true),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 80,
                          vertical: 20,
                        ),
                      ),
                      child: const Text(
                        "Return",
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
                const SizedBox(height: 30),

                //
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.pushNamed(
                        context,
                        ANY_LOCKER_SCREEN_ROUTE,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 80,
                          vertical: 20,
                        ),
                      ),
                      child: const Text(
                        "Any",
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

            const Expanded(
              child: BottomRowWidget(
                showText: false,
              ),
            ),

            //
          ],
        ),
      ),
    );
  }
}
