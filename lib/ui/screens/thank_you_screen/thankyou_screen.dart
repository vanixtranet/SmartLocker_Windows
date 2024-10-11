import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_locker_windows/routes/route_constants.dart';
import 'package:smart_locker_windows/themes/theme_config.dart';
import 'package:smart_locker_windows/ui/widgets/title_bar_widget.dart';
import '../../../data/bloc/user_model_bloc/user_model_bloc.dart';
import '../../widgets/logout_widget.dart';

class ThankyouScreen extends StatefulWidget {
  const ThankyouScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ThankyouScreenState createState() => _ThankyouScreenState();
}

class _ThankyouScreenState extends State<ThankyouScreen> {
  @override
  void initState() {
    super.initState();
    manageLogsApiCall(
      personId:
          BlocProvider.of<UserModelBloc>(context).state.userModel?.personId ??
              "",
      userId: BlocProvider.of<UserModelBloc>(context).state.userModel?.id ?? "",
      userUniqueId: BlocProvider.of<UserModelBloc>(context)
              .state
              .userModel
              ?.userUniqueId ??
          "",
    );

    Future.delayed(const Duration(seconds: 4), () {
      BlocProvider.of<UserModelBloc>(context).add(
        const UserModelChangeEvent(
          userModel: null,
        ),
      );
      Navigator.pushNamedAndRemoveUntil(
        context,
        LOGIN_RFID_SCANNER_SCREEN_ROUTE,
        ModalRoute.withName('loginRfidScannerScreen'),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: THEME_COLOR,
      body: Container(
        margin: const EdgeInsets.only(top: 25, left: 10, right: 10, bottom: 40),
        child: Column(
          children: [
            const TitleBarWidget(
              titleText: "",
              showTimer: false,
            ),

            //
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 60,
                ),
                Image.asset(
                  "assets/img/thank-you.png",
                  height: 250,
                  width: 300,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "For using ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                    Text(
                      "Kiosk Services Home.",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
