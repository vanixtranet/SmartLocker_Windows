import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_locker_windows/ui/widgets/logout_widget.dart';
import 'package:smart_locker_windows/ui/widgets/title_bar_widget.dart';

import '../../data/bloc/user_model_bloc/user_model_bloc.dart';
import 'package:sizer/sizer.dart';

class BottomRowWidget extends StatelessWidget {
  final bool showBackButton;
  final bool showLockerImage;
  final bool showLogoutWidget;
  final bool showText;
  final Function()? backOnTap;

  const BottomRowWidget({
    Key? key,
    this.showBackButton = true,
    this.showLockerImage = true,
    this.showLogoutWidget = true,
    this.showText = false,
    this.backOnTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (showBackButton)
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: backOnTap ?? () => Navigator.pop(context),
                child: Image.asset(
                  "assets/img/backbutton.png",
                  height: 5.h,
                  width: 5.h,
                ),
              ),

              //
              const SizedBox(height: 8),
              //
              const Text(
                "Back",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        Flexible(
          child: Container(
            padding:
                showBackButton ? EdgeInsets.zero : EdgeInsets.only(left: 10.w),
            alignment: Alignment.center,
            child: Visibility(
              visible: showLockerImage,
              child: Image.asset(
                "assets/img/locker.png",
                height: imageSize(),
                width: imageSizeWidth(),
              ),
            ),
          ),
        ),
        if (showText)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 7),
            child: const Text(
              "Click here to logout else, You will be auto logged out in 30 sec.",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
        if (showLogoutWidget)
          Container(
            alignment: Alignment.bottomCenter,
            margin: const EdgeInsets.only(bottom: 10),
            child: LogoutWidget(
              personId: BlocProvider.of<UserModelBloc>(context)
                      .state
                      .userModel
                      ?.personId ??
                  "",
              userId:
                  BlocProvider.of<UserModelBloc>(context).state.userModel?.id ??
                      "",
              userUniqueId: BlocProvider.of<UserModelBloc>(context)
                      .state
                      .userModel
                      ?.userUniqueId ??
                  "",
            ),
          ),
      ],
    );
  }
}
