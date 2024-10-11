import 'package:flutter/material.dart';
import 'package:smart_locker_windows/themes/theme_config.dart';
import 'package:smart_locker_windows/ui/widgets/bottom_row_widget.dart';
// import 'package:smart_locker_windows/ui/widgets/logout_widget.dart';

import '../../widgets/title_bar_widget.dart';

class AlertScreen extends StatelessWidget {
  const AlertScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: THEME_COLOR,
      body: Container(
        margin: const EdgeInsets.only(
          top: 25,
          left: 10,
          right: 10,
          bottom: 40,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const TitleBarWidget(
              titleText: "Alert!",
              subtitleText:
                  "Door not closed!\nPlease close the Locker Door.\n Or will receive an alert email",
            ),

            //
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      "00:03:45",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Image.asset(
                      "assets/img/alert.png",
                      height: 200,
                      width: 300,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    const Column(
                      children: [
                        Text(
                          "Vending Machine",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Will not proceed till the Door Closed",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),

            const BottomRowWidget(
              showBackButton: true,
              showLockerImage: false,
              showLogoutWidget: true,
            ),
          ],
        ),
      ),
    );
  }
}
