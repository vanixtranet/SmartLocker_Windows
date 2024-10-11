import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_locker_windows/data/bloc/employee_locker_details_bloc/employee_locker_details_bloc.dart';
import 'package:smart_locker_windows/data/models/employee_locker_details_model/employee_locker_details_model.dart';
import 'package:smart_locker_windows/data/models/employee_locker_details_model/employee_locker_details_response.dart';
import 'package:smart_locker_windows/themes/theme_config.dart';
import 'package:smart_locker_windows/ui/widgets/bottom_row_widget.dart';
import 'package:smart_locker_windows/ui/widgets/title_bar_widget.dart';
import '../../../../routes/route_constants.dart';
import '../../../../routes/screen_arguments.dart';

class LockerReturnCollectScreen extends StatefulWidget {
  const LockerReturnCollectScreen({Key? key}) : super(key: key);

  @override
  State<LockerReturnCollectScreen> createState() =>
      _LockerReturnCollectScreenState();
}

class _LockerReturnCollectScreenState extends State<LockerReturnCollectScreen> {
  bool showReturn = false;
  bool showCollect = false;

  EmployeeLockerDetailModel? item;
  List<EmployeeLockerDetailModel>? itemsList;
  String? collectMessage;
  String? returnMessage;

  @override
  void initState() {
    if (BlocProvider.of<EmployeeLockerDetailsBloc>(context)
                .state
                .lockerDetailData
                ?.list !=
            null &&
        BlocProvider.of<EmployeeLockerDetailsBloc>(context)
            .state
            .lockerDetailData!
            .list!
            .isNotEmpty) {
      EmployeeLockerDetailResponse data =
          BlocProvider.of<EmployeeLockerDetailsBloc>(context)
              .state
              .lockerDetailData!;

      if (data.list!.length == 1) {
        if (data.list?[0].transactionType == "Collect") {
          // For COLLECTING of device
          showCollect = true;
          showReturn = false;
          item = data.list?[0];

          collectMessage =
              "Please collect ${data.list?[0].assetDetail ?? ""}\nfrom locker.";
        } else if (data.list?[0].transactionType == "Return") {
          // For RETURNING of device
          showCollect = false;
          showReturn = true;
          item = data.list?[0];

          returnMessage =
              "Please return ${data.list?[0].assetDetail ?? ""}\nto locker.";
        }
      } else if (data.list!.length == 2) {
        itemsList = data.list;
        // For REPLACEMENT of device
        for (var i = 0; i < (data.list?.length ?? 0); i++) {
          if (data.list?[i].transactionType == "Return") {
            showCollect = false;
            showReturn = true;
            item = data.list?[i];
            break;
          }
        }

        for (var i = 0; i < (data.list?.length ?? 0); i++) {
          if (data.list?[i].transactionType == "Return") {
            returnMessage =
                "Please return ${data.list?[i].assetDetail ?? ""}\nto locker.";
          } else if (data.list?[i].transactionType == "Collect") {
            collectMessage =
                "Please collect ${data.list?[i].assetDetail ?? ""}\nfrom locker.";
          }
        }
      }

      // delayAction();
    }

    super.initState();
  }

  // delayAction() async {
  //   await Future.delayed(const Duration(seconds: 5))
  //       .then((value) => setState(() {
  //             showDialog = false;
  //           }));
  // }

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
              titleText: "Kiosk Services Home",
            ),

            //
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (returnMessage != null) messageCard(returnMessage ?? ""),

                //
                if (collectMessage != null) messageCard(collectMessage ?? ""),

                //
                if (showReturn)
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        BARCODE_MESSAGE_SCREEN_ROUTE,
                        arguments: ScreenArguments(bool1: true),
                      );
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => const LockerDetailsScreen(
                      //       isReturn: true,
                      //     ),
                      //   ),
                      // );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 80,
                        vertical: 20,
                      ),
                    ),
                    child: const Text(
                      "Return Your Item",
                      style: TextStyle(
                        fontSize: 21,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                //
                if (showCollect)
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        LOCKER_DETAIL_SCREEN_ROUTE,
                        arguments: ScreenArguments(bool1: false),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 80,
                        vertical: 20,
                      ),
                    ),
                    child: const Text(
                      "Collect Your Item",
                      style: TextStyle(
                        fontSize: 21,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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

  Widget messageCard(String message) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Center(
        child: Card(
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 20.0,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
