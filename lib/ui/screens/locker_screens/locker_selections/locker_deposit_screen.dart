import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_locker_windows/data/bloc/user_model_bloc/user_model_bloc.dart';
import 'package:smart_locker_windows/data/models/locker_details_model/locker_details_model.dart';
import 'package:smart_locker_windows/themes/theme_config.dart';
import 'package:smart_locker_windows/ui/widgets/title_bar_widget.dart';
import '../../../../routes/route_constants.dart';

class LockerDepositScreen extends StatefulWidget {
  const LockerDepositScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LockerDepositScreen> createState() => _LockerDepositScreenState();
}

class _LockerDepositScreenState extends State<LockerDepositScreen> {
  LockerDetailsModel? lockerDetailsModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: THEME_COLOR,
      body: Container(
        margin: const EdgeInsets.only(
          top: 25,
          left: 10,
          right: 10,
          bottom: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const TitleBarWidget(
              titleText: "Locker Details",
            ),

            //
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't forget to close the locker after collecting the items.",
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 22,
                    ),
                  ),

                  //
                  (lockerDetailsModel?.success ?? false)
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Locker:",
                              style: TextStyle(
                                color: Colors.yellow,
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            //
                            const SizedBox(width: 8),

                            //
                            Text(
                              lockerDetailsModel?.lockerdetail ?? "-",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      : Text(
                          lockerDetailsModel == null ? "" : "Invalid Data",
                          style: const TextStyle(
                            color: Colors.yellow,
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                  //
                  const SizedBox(height: 24),

                  //
                  Image.asset(
                    "assets/img/lockopen.png",
                    height: 240,
                    width: 240,
                  ),

                  //
                  const SizedBox(height: 24),

                  //
                  const Text(
                    "Do you want to carry out another transaction?",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  //
                  const SizedBox(height: 8),

                  //

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Check user role and navigate accordingly
                          handleUserRoleNavigation();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 60,
                            vertical: 15,
                          ),
                        ),
                        child: const Text(
                          "Yes",
                          style: TextStyle(
                            fontSize: 21,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      //
                      const SizedBox(width: 20),

                      //
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            THANK_YOU_SCREEN_ROUTE,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 60,
                            vertical: 15,
                          ),
                        ),
                        child: const Text(
                          "No",
                          style: TextStyle(
                            fontSize: 21,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // const SizedBox(height: 6),

            // const BottomRowWidget(
            //   showBackButton: false,
            //   showLockerImage: false,
            //   showText: true,
            // ),
          ],
        ),
      ),
    );
  }

  void handleUserRoleNavigation() {
    final userModel = BlocProvider.of<UserModelBloc>(context).state.userModel;

    if (userModel != null) {
      if (userModel.userRoleCodes == "SL_ADMIN") {
        Navigator.pushNamedAndRemoveUntil(
          context,
          SERVICE_INTERFACE_SCREEN_ROUTE,
          ModalRoute.withName('/serviceInterfaceScreen'),
        );
      } else {
        Navigator.pushNamedAndRemoveUntil(
          context,
          LOCKER_RETURN_COLLECT_SCREEN_ROUTE,
          ModalRoute.withName('/returnCollectScreen'),
        );
      }
    }
  }
}
