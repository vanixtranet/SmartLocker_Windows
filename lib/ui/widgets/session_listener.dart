// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';

class SessionTimeoutListener extends StatefulWidget {
  Widget child;
  Duration duration;
  VoidCallback onTimeOut;

  SessionTimeoutListener({
    Key? key,
    required this.child,
    required this.duration,
    required this.onTimeOut,
  }) : super(key: key);

  @override
  State<SessionTimeoutListener> createState() => _SessionTimeoutListenerState();
}

class _SessionTimeoutListenerState extends State<SessionTimeoutListener>
    with WidgetsBindingObserver {
  Timer? _timer;

  _startTimer() {
    if (_timer != null) {
      _timer?.cancel();
      _timer = null;
    }

    _timer = Timer(widget.duration, () {
      widget.onTimeOut();
    });
  }

  @override
  void initState() {
    _startTimer();
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    // if (state == AppLifecycleState.resumed) {
    // App is active
    _startTimer();
    // } else {
    //   // App is inactive or in the background
    //   _timer?.cancel();
    //   _timer = null;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (_) {
        _startTimer();
      },
      child: widget.child,
    );
  }
}
