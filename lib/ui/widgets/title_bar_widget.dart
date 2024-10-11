import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TitleBarWidget extends StatefulWidget {
  final String? logoEmirates;
  final String titleText;
  final String? subtitleText;
  final bool showTimer;

  const TitleBarWidget({
    Key? key,
    this.logoEmirates,
    required this.titleText,
    this.subtitleText,
    this.showTimer = true,
  }) : super(key: key);

  @override
  State<TitleBarWidget> createState() => _TitleBarWidgetState();
}

class _TitleBarWidgetState extends State<TitleBarWidget>
    with WidgetsBindingObserver {
  // late int _remainingTime;
  // bool _isActive = true;

  @override
  void initState() {
    super.initState();
    // _remainingTime = 250; // Set the initial time in seconds
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   super.didChangeAppLifecycleState(state);

  // if (state == AppLifecycleState.resumed) {
  //   // App active
  //   setState(() {
  //     _isActive = true;
  //   });
  // } else {
  //   // App inactive background
  //   setState(() {
  //     _isActive = false;
  //   });
  // }
  // }

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Image.asset(
            widget.logoEmirates ?? 'assets/img/Logo_emirates.png',
            height: 120,
            width: 120,
          ),
        ),

        //
        if ((widget.titleText.isNotEmpty) ||
            (widget.subtitleText != null && widget.subtitleText!.isNotEmpty))
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 70),
                Text(
                  widget.titleText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 16),

                //
                Text(
                  widget.subtitleText ?? "",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

        //
        const Expanded(
          flex: 1,
          child: SizedBox(),
        ),

        //
        // if (widget.showTimer)
        //   Column(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       const SizedBox(height: 25),
        //       Image.asset(
        //         "assets/img/timer.png",
        //         height: 50,
        //         width: 50,
        //       ),
        //       const Text(
        //         "Remaining Time",
        //         style: TextStyle(
        //           color: Colors.white,
        //           fontSize: 15,
        //         ),
        //       ),
        //       Countdown(
        //         seconds: _remainingTime,
        //         build: (_, double time) => Text(
        //           '${(time ~/ 60).toString().padLeft(2, '0')}:${(time % 60).toInt().toString().padLeft(2, '0')}',
        //           style: const TextStyle(
        //             color: Colors.white,
        //             fontSize: 15,
        //           ),
        //         ),
        //         interval: Duration(seconds: 1),
        //         onFinished: () {
        //           print('Timer Finished!');
        //           if (_isActive) {
        //             // _showTimerFinishedMessage();
        //           }
        //         },
        //       ),
        //     ],
        //   ),
      ],
    );
  }

  // void _showTimerFinishedMessage() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text("Timer Finished"),
  //         content: Text("The timer has compl"),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: Text("OK"),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}

double imageSize() {
  if (Platform.isWindows || kIsWeb) {
    return 20.h;
  } else {
    return 24.h;
  }
}

double imageSizeWidth() {
  if (Platform.isWindows || kIsWeb) {
    return 45.h;
  } else {
    return 24.h;
  }
}

double imageSizeSmall() {
  if (Platform.isWindows || kIsWeb) {
    return 24.h;
  } else {
    return 20.h;
  }
}

double fontSize() {
  if (Platform.isWindows || kIsWeb) {
    return 9.sp;
  } else {
    return 20;
  }
}

double sizedBoxesHeight() {
  if (Platform.isWindows || kIsWeb) {
    return 2.h;
  } else {
    return 12;
  }
}

double sizedBoxesLargeHeight() {
  if (Platform.isWindows || kIsWeb) {
    return 2.5.h;
  } else {
    return 50;
  }
}

double buttonHeight() {
  if (Platform.isWindows || kIsWeb) {
    return 2.h;
  } else {
    return 20;
  }
}
