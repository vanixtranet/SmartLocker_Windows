import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_locker_windows/themes/theme_config.dart';
import 'package:smart_locker_windows/ui/widgets/snack_bar.dart';
import 'package:smart_locker_windows/ui/widgets/title_bar_widget.dart';
import '../../../data/bloc/authentication_bloc/authentication_bloc.dart';
import '../../../data/bloc/user_model_bloc/user_model_bloc.dart';
import '../../../data/models/user_models/user_model.dart';

class LoginScan extends StatefulWidget {
  const LoginScan({Key? key}) : super(key: key);

  @override
  State<LoginScan> createState() => _LoginScanState();
}

class _LoginScanState extends State<LoginScan> {
  @override
  void initState() {
    loginRequest(context: context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/img/Employee ID Scan.jpg',
            fit: BoxFit.cover,
          ),
          const Positioned(
            top: 20.0,
            left: 20.0,
            child: TitleBarWidget(
              titleText: "",
              showTimer: false,
            ),
          ),
          Positioned(
            bottom: -4.0,
            right: 15.0,
            child: Card(
              color: THEME_COLOR,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(70.0),
                  topRight: Radius.circular(70.0),
                  bottomLeft: Radius.circular(2.0),
                  bottomRight: Radius.circular(2.0),
                ),
              ),
              child: SizedBox(
                width: 340.0,
                height: 700.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      const Text(
                        'Welcome to ',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        'Kiosk Smart Locker',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20.0),
                      Image.asset(
                        'assets/img/lock.png',
                        // 'assets/lock-removebg-preview.png',
                        width: 130.0,
                        height: 130.0,
                      ),
                      const SizedBox(height: 18.0),
                      InkWell(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) =>
                          //           const LoginAuthenticate()),
                          // );
                        },
                        child: Image.asset(
                          "assets/img/scanner.png",
                          height: 150,
                          width: 150,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        'We are scanning your Card.',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  loginRequest({
    String? rfidData,
    BuildContext? context,
  }) async {
    UserModel? data = await authenticationBloc
        .authenticateUser(queryparams: {"rfid": rfidData ?? "5566"});

    if (data != null) {
      displaySnackBar(
        context: context!,
        text: 'Login Successful',
      );

      BlocProvider.of<UserModelBloc>(context).add(
        UserModelChangeEvent(
          userModel: data,
        ),
      );

      // Navigator.pushReplacementNamed(
      //   context,
      //   LOGIN_AUTHENTICATE_SCREEN_ROUTE,
      // );
    } else {
      displaySnackBar(
        context: context!,
        text: 'Something went wrong, please try again later.',
      );
    }
  }
}
