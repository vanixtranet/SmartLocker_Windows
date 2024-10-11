import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:smart_locker_windows/data/bloc/user_model_bloc/user_model_bloc.dart';
import 'package:smart_locker_windows/routes/route_constants.dart';

import '../../data/bloc/locker_bloc/locker_bloc.dart';

class LogoutWidget extends StatelessWidget {
  final String personId;
  final String userId;
  final String userUniqueId;

  const LogoutWidget({
    Key? key,
    required this.personId,
    required this.userId,
    required this.userUniqueId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            manageLogsApiCall(
              personId: personId,
              userId: userId,
              userUniqueId: userUniqueId,
            );

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
          },
          child: Image.asset(
            "assets/img/logout-button.png",
            height: 60,
            width: 60,
          ),
        ),
        const Text(
          "Logout",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

/// API call to track user behaviour
/// Invoked during LOGOUT
manageLogsApiCall({
  required String personId,
  required String userId,
  required String userUniqueId,
}) {
  lockerBloc.postManageLogs(
    queryparams: {
      "transactionName": "LogOut",
      "transactionId": personId,
      "userId": userId,
      "smartLockerId": userUniqueId,
    },
  );
}
