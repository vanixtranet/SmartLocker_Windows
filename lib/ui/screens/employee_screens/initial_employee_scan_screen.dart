
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_locker_windows/themes/theme_config.dart';
import 'package:smart_locker_windows/ui/widgets/bottom_row_widget.dart';
import 'package:flutter/services.dart';
import '../../../data/bloc/employee_locker_details_bloc/employee_locker_details_bloc.dart';
import '../../../data/bloc/locker_bloc/locker_bloc.dart';
import '../../../data/bloc/user_model_bloc/user_model_bloc.dart';
import '../../../data/helper/sessiontimeout/sessiontimeout_helper.dart';
import '../../../data/models/employee_locker_details_model/employee_locker_details_response.dart';
import '../../../routes/route_constants.dart';
import '../../widgets/custom_alert_dialog.dart';
import '../../widgets/progress_indicator.dart';
import '../../widgets/title_bar_widget.dart';

class InitialEmployeeScanScreen extends StatefulWidget {
  final bool isCollect;

  const InitialEmployeeScanScreen({
    Key? key,
    this.isCollect = false,
  }) : super(key: key);

  @override
  State<InitialEmployeeScanScreen> createState() =>
      _InitialEmployeeScanScreenState();
}

class _InitialEmployeeScanScreenState extends State<InitialEmployeeScanScreen> {
  EmployeeLockerDetailResponse? lockerDetailsData;
  final FocusNode _focusNode = FocusNode();

  bool isBarCodeDataAvailable = false;
  bool showCPI = false;

  String _controller = '';
  String scannerText = "Please scan the QR code using the scanner";

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

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(_focusNode);
    return Scaffold(
      backgroundColor: THEME_COLOR,
      body: Container(
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
                    SizedBox(height: sizedBoxesHeight()),

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
                              horizontal: 80,
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
    );
  }

  Widget scannerWidget() {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return DefaultTextStyle(
      style: textTheme.bodyLarge!,
      child: KeyboardListener(
        focusNode: _focusNode,
        onKeyEvent: (KeyEvent event) {
          String? keyBoardEvent;
          sessionTimeoutHelper!.resetSessionTimer();

          if (event.character == null &&
              (event.logicalKey.debugName == "Enter" ||
                  event.logicalKey.keyId == 4294967309)) {
            keyBoardEvent = "\n";
          }

          _controller += (event.character) ?? keyBoardEvent ?? "";

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
            SizedBox(height: sizedBoxesHeight()),

            //
            Image.asset("assets/img/scanner_image.jpeg",
                height: imageSizeSmall(), width: imageSizeSmall()),

            //
            SizedBox(height: sizedBoxesHeight()),

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

    lockerDetailsData = await lockerBloc.getLockerDetail(
      queryparams: {
        //bypass
        // "taskId": "2f1fadf9-f601-4c55-877a-2de4d18b827c", //collect
        //bypass
        // "taskId": "80304e5c-1e80-4555-8989-4f3a9fafaca4", // return new

        // "taskId": "dfb2ea12-0123-4689-847e-bfdf8a43e3b7", //return
        // "taskId": "ed8d0722-3f18-4443-8f6e-eeca70cb48c4", //replacement
        // "taskId": "9b5e972e-dd39-4ee1-8edb-cdc599c72551", //vending
        // "taskId": "44cf9d03-c8d8-4656-8210-0af0ce99b6dc", //vending replacement
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

    if (lockerDetailsData != null &&
        lockerDetailsData!.list != null &&
        lockerDetailsData!.list!.isNotEmpty) {
      BlocProvider.of<EmployeeLockerDetailsBloc>(context).add(
        EmployeeLockerDetailsChangeEvent(
          lockerDetailData: lockerDetailsData,
        ),
      );

      if (lockerDetailsData?.list?[0].assetType
              ?.toLowerCase()
              .contains("device") ??
          false) {
        Navigator.pushNamed(
          context,
          LOCKER_RETURN_COLLECT_SCREEN_ROUTE,
        );
      } else if (lockerDetailsData?.list?[0].assetType
              ?.toLowerCase()
              .contains("accessory") ??
          false) {
        if (lockerDetailsData?.list?.length == 2) {
          for (var element in lockerDetailsData!.list!) {
            if (element.transactionType?.toLowerCase().contains("return") ??
                false) {
              Navigator.pushNamed(
                context,
                BIN_RETURN_SCREEN_ROUTE,
              );
            }
          }
        } else {
          if (lockerDetailsData?.list?[0].transactionType
                  ?.toLowerCase()
                  .contains("return") ??
              false) {
            Navigator.pushNamed(
              context,
              BIN_RETURN_SCREEN_ROUTE,
            );
          } else if (lockerDetailsData?.list?[0].transactionType
                  ?.toLowerCase()
                  .contains("collect") ??
              false) {
            Navigator.pushNamed(
              context,
              VENDING_COLLECT_SCREEN_ROUTE,
            );
          }
        }
      }
    } else {
      customAlertDialog(
        context: context,
        content:
            "QR code not valid. please try again\nor contact Emirates IT Service Center",
        buttonText: "OK",
        onPressed: () {
          Navigator.pop(context);
        },
      );

      // displaySnackBar(
      //   context: context,
      //   text:
      //       'QR code not valid. please try again\nor contact Emirates IT Service Center',
      //   duration: 1,
      // );
    }
  }
}
