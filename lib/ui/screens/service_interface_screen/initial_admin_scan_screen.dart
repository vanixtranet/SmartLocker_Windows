import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_locker_windows/data/bloc/admin_bloc/admin_bloc.dart';

import '../../../data/bloc/admin_details_bloc/admin_details_bloc.dart';
import '../../../data/bloc/user_model_bloc/user_model_bloc.dart';
import '../../../data/helper/sessiontimeout/sessiontimeout_helper.dart';
import '../../../data/models/admin_initial_model/admin_initial_model.dart';
import '../../../routes/route_constants.dart';
import '../../../themes/theme_config.dart';
import '../../widgets/bottom_row_widget.dart';
import '../../widgets/progress_indicator.dart';
import '../../widgets/title_bar_widget.dart';
import 'package:sizer/sizer.dart';

class InitialAdminScanScreen extends StatefulWidget {
  const InitialAdminScanScreen({Key? key}) : super(key: key);

  @override
  State<InitialAdminScanScreen> createState() => _InitialAdminScanScreenState();
}

class _InitialAdminScanScreenState extends State<InitialAdminScanScreen> {
  AdminInitalDetailModel? adminData;
  final FocusNode _focusNode = FocusNode();

  bool isBarCodeDataAvailable = false;
  bool showCPI = false;

  String _controller = '';
  String scannerText = "Please scan the QR code using the scanner";

  // // Session Timeout variables
  // bool userAvailable = false;
  // Timer? timer;

  // Session Timeout variables
  SessionTimeoutHelper? sessionTimeoutHelper;

  @override
  void initState() {
    isBarCodeDataAvailable = false;
    _controller = "";

    sessionTimeoutHelper = SessionTimeoutHelper(context);
    sessionTimeoutHelper?.resetSessionTimer();
    super.initState();
  }

  // handleSessionTimeout() async {
  //   if (timer != null) {
  //     timer!.cancel();
  //   }
  //   timer = Timer(const Duration(seconds: 120), () {
  //     startConfirmationCountdown();
  //   });

  //   // and later, before the timer goes off...
  //   if (timer != null) {
  //     timer!.cancel();
  //   }
  // }

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
  //               userAvailable = true;
  //               handleSessionTimeout();
  //             },
  //             child: const Text('OK'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // void startConfirmationCountdown() async {
  //   userAvailable = false;
  //   showTimeoutDialog(context);

  //   await Future.delayed(const Duration(seconds: 5)).then((_) {
  //     if (!userAvailable) {
  //       manageLogsApiCall(
  //         personId: BlocProvider.of<UserModelBloc>(context)
  //                 .state
  //                 .userModel
  //                 ?.personId ??
  //             "",
  //         userId:
  //             BlocProvider.of<UserModelBloc>(context).state.userModel?.id ?? "",
  //         userUniqueId: BlocProvider.of<UserModelBloc>(context)
  //                 .state
  //                 .userModel
  //                 ?.userUniqueId ??
  //             "",
  //       );

  //       BlocProvider.of<UserModelBloc>(context).add(
  //         const UserModelChangeEvent(
  //           userModel: null,
  //         ),
  //       );

  //       Navigator.pushNamedAndRemoveUntil(
  //         context,
  //         LOGIN_RFID_SCANNER_SCREEN_ROUTE,
  //         (_) => false,
  //       );
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(_focusNode);
    return Scaffold(
      backgroundColor: THEME_COLOR,
      body: GestureDetector(
        onTap: () {
          sessionTimeoutHelper!.userAvailable = true;
          sessionTimeoutHelper!.resetSessionTimer();
        },
        child: Container(
          margin: const EdgeInsets.only(
            top: 20,
            left: 10,
            right: 10,
          ),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TitleBarWidget(
                    titleText: "Scan QR Code",
                  ),

                  //
                  Column(
                    children: [
                      Text(
                        "Please scan QR code sent to you via email",
                        style: TextStyle(
                          color: Colors.yellow,
                          fontSize: fontSize(),
                        ),
                      ),

                      //
                      SizedBox(
                          height: Platform.isWindows
                              ? sizedBoxesHeight()
                              : kIsWeb
                                  ? 1.h
                                  : 24),

                      //
                      scannerWidget(),

                      //
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          isBarCodeDataAvailable
                              ? ElevatedButton(
                                  onPressed: () => _handleSubmitOnTap(context),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.yellow,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 60,
                                      vertical: buttonHeight(),
                                    ),
                                  ),
                                  child: Text(
                                    "Submit",
                                    style: TextStyle(
                                      fontSize: fontSize(),
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              : const SizedBox(),

                          //
                          SizedBox(width: isBarCodeDataAvailable ? 16 : 1),

                          //
                          ElevatedButton(
                            onPressed: () {
                              sessionTimeoutHelper!.resetSessionTimer();
                              setState(() {
                                sessionTimeoutHelper!.userAvailable = true;
                                _controller = "";
                                isBarCodeDataAvailable = false;
                                scannerText =
                                    "Please scan the QR code using the scanner";
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.yellow,
                              padding: EdgeInsets.symmetric(
                                horizontal: 60,
                                vertical: buttonHeight(),
                              ),
                            ),
                            child: Text(
                              "Reset",
                              style: TextStyle(
                                fontSize: fontSize(),
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  //
                  const Expanded(
                    child: BottomRowWidget(
                      showText: false,
                      showBackButton: false,
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: showCPI,
                child: const CustomProgressIndicator(
                  loadingText: "Please wait",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget scannerWidget() {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return DefaultTextStyle(
      style: textTheme.bodyLarge!,
      child: KeyboardListener(
        focusNode: _focusNode,
        onKeyEvent: (KeyEvent event) {
          sessionTimeoutHelper!.resetSessionTimer();
          String? keyBoardEvent;

          if (event.character == null &&
              (event.logicalKey.debugName == "Enter" ||
                  event.logicalKey.keyId == 4294967309)) {
            keyBoardEvent = "\n";
          }

          _controller += event.character ?? keyBoardEvent ?? "";

          if ((event.character == "\n" || keyBoardEvent == "\n") &&
              !isBarCodeDataAvailable) {
            isBarCodeDataAvailable = true;
            scannerText = "Scanning complete.";
          }

          setState(() {
            sessionTimeoutHelper!.userAvailable = true;
          });
        },
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: kIsWeb ? 8 : 16),

            //
            Image.asset(
              "assets/img/scanner_image.jpeg",
              height: imageSizeSmall(),
              width: imageSizeSmall(),
            ),

            //
            const SizedBox(height: kIsWeb ? 8 : 16),

            //
            Text(
              scannerText,
              style: TextStyle(
                fontSize: fontSize(),
                color: Colors.white,
              ),
            ),

            //
            SizedBox(height: sizedBoxesHeight()),
          ],
        ),
      ),
    );
  }

  _handleSubmitOnTap(BuildContext context) async {
    sessionTimeoutHelper!.resetSessionTimer();

    setState(() {
      sessionTimeoutHelper!.userAvailable = true;
      showCPI = true;
    });

    _controller =
        _controller.contains("\n") ? _controller.split("\n")[0] : _controller;

    adminData = await adminBloc.getAdminTaskList(
      queryparams: {
        // "taskId": "d7588d30-e234-409f-b27b-97fff87d9f1b",
        // "taskId": "60eb452c-38cb-4d0e-b2f9-01d50e60d390",
        // "taskId": "49c8906f-6434-407a-b71f-e9a704bf5ce7",
        // "taskId": "6a90da01-b52b-4f4d-90d2-5d6170fdb43f",
        // "taskId": "80304e5c-1e80-4555-8989-4f3a9fafaca4",
        "taskId": _controller, //dynamic
        "transactionId":
            BlocProvider.of<UserModelBloc>(context).state.userModel?.personId ??
                "",
        "userId":
            BlocProvider.of<UserModelBloc>(context).state.userModel?.id ?? "",
        "smartLockerId": BlocProvider.of<UserModelBloc>(context)
                .state
                .userModel
                ?.userUniqueId ??
            "",
      },
    );

    sessionTimeoutHelper!.resetSessionTimer();
    setState(() {
      sessionTimeoutHelper!.userAvailable = true;
      showCPI = false;
    });

    if (adminData != null) {
      BlocProvider.of<AdminDetailsBloc>(context).add(
        AdminDetailsChangeEvent(
          adminInitalDetailModel: adminData,
        ),
      );

      Navigator.pushNamed(
        context,
        SERVICE_INTERFACE_SCREEN_ROUTE,
      );
    }
  }

  @override
  void dispose() {
    if (mounted) {
      _focusNode.dispose();
    }
    super.dispose();
  }
}
