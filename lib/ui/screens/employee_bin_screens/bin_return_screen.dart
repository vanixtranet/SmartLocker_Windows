import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/bloc/employee_locker_details_bloc/employee_locker_details_bloc.dart';
import '../../../data/models/employee_locker_details_model/employee_locker_details_model.dart';
import '../../../data/models/employee_locker_details_model/employee_locker_details_response.dart';
import '../../../routes/route_constants.dart';
import '../../../routes/screen_arguments.dart';
import '../../../themes/theme_config.dart';
import '../../widgets/bottom_row_widget.dart';
import '../../widgets/title_bar_widget.dart';

class BinReturnScreen extends StatefulWidget {
  const BinReturnScreen({Key? key}) : super(key: key);

  @override
  State<BinReturnScreen> createState() => _BinReturnScreenState();
}

class _BinReturnScreenState extends State<BinReturnScreen> {
  EmployeeLockerDetailModel? item;
  List<EmployeeLockerDetailModel>? itemsList;
  String? returnMessage;
  String? collectMessage;

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
        if (data.list?[0].transactionType == "Return") {
          // For RETURNING of accessory
          item = data.list?[0];

          returnMessage =
              "Please return ${data.list?[0].assetDetail ?? ""}\nto bin.";
        }
      } else if (data.list!.length == 2) {
        itemsList = data.list;
        // For REPLACEMENT of device
        for (var i = 0; i < (data.list?.length ?? 0); i++) {
          if (data.list?[i].transactionType == "Return") {
            item = data.list?[i];
            break;
          }
        }

        for (var i = 0; i < (data.list?.length ?? 0); i++) {
          if (data.list?[i].transactionType == "Return") {
            returnMessage =
                "Please return ${data.list?[i].assetDetail ?? ""}\nto Bin.";
          } else if (data.list?[i].transactionType == "Collect") {
            collectMessage =
                "Please collect ${data.list?[i].assetDetail ?? ""}\nfrom Vending Machine.";
          }
        }
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: THEME_COLOR,
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 24),
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
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      BIN_PRINT_BARCODE_SCREEN_ROUTE,
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
              ],
            ),

            const BottomRowWidget(
              showBackButton: true,
              showLockerImage: true,
              showLogoutWidget: true,
            ),
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
