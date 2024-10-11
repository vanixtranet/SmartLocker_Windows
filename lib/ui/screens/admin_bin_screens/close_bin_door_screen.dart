import 'package:flutter/material.dart';
import 'package:smart_locker_windows/themes/theme_config.dart';
import 'package:smart_locker_windows/ui/widgets/bottom_row_widget.dart';
// import 'package:smart_locker_windows/ui/widgets/logout_widget.dart';
import 'package:smart_locker_windows/ui/widgets/title_bar_widget.dart';

class CloseBinDoorScreen extends StatelessWidget {
  const CloseBinDoorScreen({Key? key}) : super(key: key);

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
              titleText: "Please remove accessories",
              subtitleText: "and close the bin door",
            ),

            //
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/img/drop-bin.png",
                  height: 310,
                  width: 320,
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
