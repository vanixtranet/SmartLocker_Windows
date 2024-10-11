import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_locker_windows/data/bloc/user_model_bloc/user_model_bloc.dart';
import 'package:smart_locker_windows/themes/theme_config.dart';

import '../logout_widget.dart';
import 'widget/hardware_barcode_scanner_widget.dart';

class HardwareBarcodeScanner extends StatelessWidget {
  const HardwareBarcodeScanner({Key? key}) : super(key: key);

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/img/Logo_emirates.png',
                  height: 120,
                  width: 120,
                ),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 50),
                    Text(
                      "Scan Barcode",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                //
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(height: 25),
                    Image.asset(
                      "assets/img/timer.png",
                      height: 50,
                      width: 50,
                    ),
                    const Text(
                      "Remaining Time",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    const Text(
                      "01:30",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            //
            const HardwareBarcodeScannerWidget(),

            //
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        "assets/img/backbutton.png",
                        height: 50,
                        width: 50,
                      ),
                    ),

                    //
                    const Text(
                      "Back",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                //
                const SizedBox(width: 16),

                //
                Expanded(
                  flex: 4,
                  child: Image.asset(
                    "assets/img/locker.png",
                    height: 200,
                    width: 400,
                  ),
                ),

                //
                Expanded(
                  child: LogoutWidget(
                    personId: BlocProvider.of<UserModelBloc>(context)
                            .state
                            .userModel
                            ?.personId ??
                        "",
                    userId: BlocProvider.of<UserModelBloc>(context)
                            .state
                            .userModel
                            ?.id ??
                        "",
                    userUniqueId: BlocProvider.of<UserModelBloc>(context)
                            .state
                            .userModel
                            ?.userUniqueId ??
                        "",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
