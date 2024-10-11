import 'package:flutter/material.dart';
import 'package:smart_locker_windows/themes/theme_config.dart';
import 'package:smart_locker_windows/ui/widgets/bottom_row_widget.dart';
// import 'package:smart_locker_windows/ui/widgets/logout_widget.dart';
import 'package:smart_locker_windows/ui/widgets/title_bar_widget.dart';

class WaitingScreen extends StatelessWidget {
  const WaitingScreen({Key? key}) : super(key: key);

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
              titleText: "Please wait, labels",
              subtitleText: "printing are in process",
            ),

            //
            const SizedBox(
              height: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/img/waiting-img.png",
                  height: 300,
                  width: 300,
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
