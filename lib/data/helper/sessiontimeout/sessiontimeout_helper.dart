import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_locker_windows/data/bloc/user_model_bloc/user_model_bloc.dart';
import 'package:smart_locker_windows/routes/route_constants.dart';
import 'dart:async';

import 'package:smart_locker_windows/ui/widgets/logout_widget.dart';

// Global variables
int sessionDuration = 120;
int sessionDialogDuration = 10;

class SessionTimeoutHelper {
  // late bool userAvailable;
  // late Timer timer;

  // SessionTimeoutHelper(BuildContext context) {
  //   userAvailable = false;
  //   timer = Timer(Duration(seconds: sessionDuration), () {
  //     startConfirmationCountdown(context);
  //   });
  // }

  // handleSessionTimeout(BuildContext context) async {
  //   if (timer.isActive) {
  //     timer.cancel();
  //   }
  //   timer = Timer(Duration(seconds: sessionDuration), () {
  //     startConfirmationCountdown(context);
  //   });
  // }
  late bool userAvailable;
  late Timer timer;
  final BuildContext context;

  SessionTimeoutHelper(this.context) {
    userAvailable = false;
    startSessionTimer();
  }

  void startSessionTimer() {
    timer = Timer(Duration(seconds: sessionDuration), () {
      startConfirmationCountdown(context);
    });
  }

  void resetSessionTimer() {
    if (timer.isActive) {
      timer.cancel();
    }
    startSessionTimer();
  }

  Future<void> showTimeoutDialog(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ALERT'),
          content: const Text(
            'Your session has been timed out.\n Please click on OK to continue.',
            style: TextStyle(fontSize: 20),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                userAvailable = true;
                // handleSessionTimeout(context);
                resetSessionTimer();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void startConfirmationCountdown(BuildContext context) async {
    userAvailable = false;
    showTimeoutDialog(context);

    await Future.delayed(Duration(seconds: sessionDialogDuration)).then((_) {
      if (!userAvailable) {
        manageLogsApiCall(
          personId: BlocProvider.of<UserModelBloc>(context)
                  .state
                  .userModel
                  ?.personId ??
              "",
          userId:
              BlocProvider.of<UserModelBloc>(context).state.userModel?.id ?? "",
          userUniqueId: BlocProvider.of<UserModelBloc>(context)
                  .state
                  .userModel
                  ?.userUniqueId ??
              "",
        );

        BlocProvider.of<UserModelBloc>(context).add(
          const UserModelChangeEvent(
            userModel: null,
          ),
        );

        Navigator.pushNamedAndRemoveUntil(
          context,
          LOGIN_RFID_SCANNER_SCREEN_ROUTE,
          (_) => false,
        );
      }
    });
  }
}
