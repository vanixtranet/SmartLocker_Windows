import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_locker_windows/themes/theme_config.dart';
import 'package:smart_locker_windows/ui/widgets/bottom_row_widget.dart';
import 'package:smart_locker_windows/ui/widgets/title_bar_widget.dart';
import '../../../data/bloc/locker_bloc/locker_bloc.dart';
import '../../../data/bloc/user_model_bloc/user_model_bloc.dart';
import '../../../data/models/employee_locker_details_model/employee_locker_details_response.dart';
import '../../../routes/route_constants.dart';
import '../../../routes/screen_arguments.dart';

// TODO: Unused file
class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  EmployeeLockerDetailResponse? lockerDetailsModel;

  @override
  void initState() {
    lockerDetail();
    super.initState();
  }

  lockerDetail() async {
    lockerDetailsModel = await lockerBloc.getLockerDetail(
      queryparams: {
        "taskId": null,
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

    Navigator.pushNamed(
      context,
      LOCKER_DETAIL_SCREEN_ROUTE,
      arguments: ScreenArguments(lockerDetail: lockerDetailsModel),
    );
  }

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
            const TitleBarWidget(
              logoEmirates: 'assets/img/Logo_emirates.png',
              titleText: "Please wait till you",
              subtitleText: "are authenticated",
            ),

            //
            const SizedBox(height: 2),

            //
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/img/waiting-img.png",
                  height: 300,
                  width: 300,
                ),
              ],
            ),

            const BottomRowWidget(
              showBackButton: true,
              showLockerImage: true,
              showLogoutWidget: true,
            ),
            //
          ],
        ),
      ),
    );
  }
}
