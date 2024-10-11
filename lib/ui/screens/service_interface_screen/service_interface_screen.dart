import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_locker_windows/data/bloc/admin_details_bloc/admin_details_bloc.dart';
import 'package:smart_locker_windows/data/models/admin_initial_model/admin_initial_model.dart';
import 'package:smart_locker_windows/routes/route_constants.dart';
import 'package:smart_locker_windows/routes/screen_arguments.dart';
import 'package:smart_locker_windows/themes/theme_config.dart';
import 'package:smart_locker_windows/ui/widgets/bottom_row_widget.dart';
import '../../../data/bloc/user_model_bloc/user_model_bloc.dart';
import '../../widgets/logout_widget.dart';
import '../../widgets/title_bar_widget.dart';

class ServiceInterfaceScreen extends StatefulWidget {
  const ServiceInterfaceScreen({Key? key}) : super(key: key);

  @override
  State<ServiceInterfaceScreen> createState() => _ServiceInterfaceScreenState();
}

class _ServiceInterfaceScreenState extends State<ServiceInterfaceScreen> {
  AdminInitalDetailModel adminInitalDetailModel = AdminInitalDetailModel();

  @override
  void initState() {
    adminInitalDetailModel = BlocProvider.of<AdminDetailsBloc>(context)
        .state
        .adminInitalDetailModel!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserModelBloc, UserModelState>(
      builder: (context, state) {
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
              mainAxisSize: MainAxisSize.max,
              children: [
                const TitleBarWidget(
                  titleText: "Kiosk Services Home",
                  subtitleText: "Please select an interface\nto continue",
                ),

                Column(
                  children: [
                    (adminInitalDetailModel.locker ?? false) ||
                            (adminInitalDetailModel.vending ?? false)
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              (adminInitalDetailModel.locker ?? false)
                                  ? ElevatedButton(
                                      onPressed: () => Navigator.pushNamed(
                                        context,
                                        STORE_RETURN_SCREEN_ROUTE,
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.yellow,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 60,
                                          vertical: buttonHeight(),
                                        ),
                                      ),
                                      child: Text(
                                        "Locker",
                                        style: TextStyle(
                                          fontSize: fontSize(),
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),

                              //
                              SizedBox(
                                width: (adminInitalDetailModel.locker ?? false)
                                    ? 20
                                    : 0.1,
                              ),

                              //
                              (adminInitalDetailModel.vending ?? false)
                                  ? ElevatedButton(
                                      onPressed: () => _handleVendingOnTap(),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.yellow,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 60,
                                          vertical: buttonHeight(),
                                        ),
                                      ),
                                      child: Text(
                                        "Vending",
                                        style: TextStyle(
                                          fontSize: fontSize(),
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          )
                        : const SizedBox(),

                    //
                    SizedBox(
                      height: (adminInitalDetailModel.locker ?? false) ||
                              (adminInitalDetailModel.vending ?? false)
                          ? sizedBoxesHeight()
                          : 0.1,
                    ),

                    const SizedBox(
                      height: 200,
                    ),

                    //
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        (adminInitalDetailModel.bin ?? false)
                            ? ElevatedButton(
                                onPressed: () => Navigator.pushNamed(
                                  context,
                                  BIN_SELECTION_SCREEN_ROUTE,
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.yellow,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 60,
                                    vertical: buttonHeight(),
                                  ),
                                ),
                                child: Text(
                                  "  Bin   ",
                                  style: TextStyle(
                                    fontSize: fontSize(),
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            : const SizedBox(),

                        //
                        SizedBox(
                          width: (adminInitalDetailModel.vending ?? false)
                              ? 20
                              : 0.1,
                        ),

                        //
                        ElevatedButton(
                          onPressed: () {
                            manageLogsApiCall(
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
                              userUniqueId:
                                  BlocProvider.of<UserModelBloc>(context)
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
                              ModalRoute.withName('loginRfidScannerScreen'),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.yellow,
                            padding: EdgeInsets.symmetric(
                              horizontal: 60,
                              vertical: buttonHeight(),
                            ),
                          ),
                          child: Text(
                            "Logoff ",
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
                    showBackButton: false,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _handleVendingOnTap() async {
    Navigator.pushNamed(
      context,
      BIN_ADMIN_KEY_ROUTE,
      arguments: ScreenArguments(
        bool1: true,
      ),
    );

    await Future.delayed(const Duration(seconds: 5));

    Navigator.pushNamed(
      context,
      VENDING_SELECTION_SCREEN_ROUTE,
    );
  }
}
