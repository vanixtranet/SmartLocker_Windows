import 'package:flutter/material.dart';
import 'package:smart_locker_windows/themes/theme_config.dart';
import 'package:smart_locker_windows/ui/widgets/bottom_row_widget.dart';

// import 'package:smart_locker_windows/ui/widgets/logout_widget.dart';
import 'package:smart_locker_windows/ui/widgets/title_bar_widget.dart';
import 'package:sizer/sizer.dart';
class BinAdminKeyScreen extends StatelessWidget {
  final bool isVendingScreen;

  const BinAdminKeyScreen({
    Key? key,
    this.isVendingScreen = false,
  }) : super(key: key);

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
              titleText: "Please open the bin using",
              subtitleText: "Admin Key",
            ),

            //
             SizedBox(height: sizedBoxesHeight()),

            //
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/img/admin-key-img.png",
                  height: imageSize(),
                  width: imageSize(),
                ),
              ],
            ),

            const BottomRowWidget(
              showBackButton: true,
              showLockerImage: true,
              showLogoutWidget: true,
            ),

            //
          ],
        ),
      ),
    );
  }
}
