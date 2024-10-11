import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_locker_windows/ui/widgets/session_listener.dart';

import '../../../data/bloc/admin_details_bloc/admin_details_bloc.dart';
import '../../../data/bloc/employee_locker_details_bloc/employee_locker_details_bloc.dart';
import '../../../data/bloc/user_model_bloc/user_model_bloc.dart';
import '../../../data/helper/sessiontimeout/sessiontimeout_helper.dart';
import '../../../routes/route_constants.dart';
import '../../../routes/routes.dart';
import '../../widgets/logout_widget.dart';

class InitScreen extends StatefulWidget {
  const InitScreen({Key? key}) : super(key: key);

  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> with WidgetsBindingObserver {
  final _navigatorKey = GlobalKey<NavigatorState>();

  // int sessionTime = 120;
  bool userAvailable = false;

  // Future<void> showTimeoutDialog(BuildContext context) async {
  //   await showDialog(
  //     context: context,
  //     barrierDismissible: false, // user must tap button!
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('ALERT'),
  //         content: const Text(
  //           'Your session has been timed out.\n Please click on OK to continue.',
  //           style: TextStyle(fontSize: 20),
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //               setState(() {
  //                 userAvailable = true;
  //               });
  //             },
  //             child: const Text('OK'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  void startConfirmationCountdown() async {
    if (_navigatorKey.currentState?.canPop() == true) {
      userAvailable = true;
      // showTimeoutDialog(_navigatorKey.currentState!.context);

      await Future.delayed(Duration(seconds: sessionDialogDuration)).then((_) {
        if (!userAvailable) {
          manageLogsApiCall(
            personId: BlocProvider.of<UserModelBloc>(
                        _navigatorKey.currentState!.context)
                    .state
                    .userModel
                    ?.personId ??
                "",
            userId: BlocProvider.of<UserModelBloc>(
                        _navigatorKey.currentState!.context)
                    .state
                    .userModel
                    ?.id ??
                "",
            userUniqueId: BlocProvider.of<UserModelBloc>(
                        _navigatorKey.currentState!.context)
                    .state
                    .userModel
                    ?.userUniqueId ??
                "",
          );

          BlocProvider.of<UserModelBloc>(_navigatorKey.currentState!.context)
              .add(
            const UserModelChangeEvent(
              userModel: null,
            ),
          );

          Navigator.pushNamedAndRemoveUntil(
            _navigatorKey.currentState!.context,
            LOGIN_RFID_SCANNER_SCREEN_ROUTE,
            (_) => false,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SessionTimeoutListener(
      duration: Duration(seconds: sessionDuration),
      onTimeOut: () => startConfirmationCountdown(),
      child: MultiBlocProvider(
        providers: [
          // Since we are instantiating (creating) the InternetBloc inside the BlocProvider,
          // BlocProvider will take care of the Bloc's dispose and other such stuff.
          BlocProvider<UserModelBloc>(
            create: (context) => UserModelBloc(),
          ),

          BlocProvider<EmployeeLockerDetailsBloc>(
            create: (context) => EmployeeLockerDetailsBloc(),
          ),

          BlocProvider<AdminDetailsBloc>(
            create: (context) => AdminDetailsBloc(),
          ),
        ],
        child: Builder(
          builder: (context) {
            return Sizer(
              builder: (context, orientation, deviceType) {
                return MaterialApp(
                  navigatorKey: _navigatorKey,
                  debugShowCheckedModeBanner: false,

                  // Defining the named routes and declaring the initial route of the application.
                  onGenerateRoute: AppRouter.generateRoute,
                  initialRoute: LOGIN_RFID_SCANNER_SCREEN_ROUTE,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
