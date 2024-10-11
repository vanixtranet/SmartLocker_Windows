import 'package:flutter/material.dart';

displaySnackBar({
  String? text,
  Color? snackBarcolor,
  BuildContext? context,
  int? duration,
  double? fontSize,
}) {
  return ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
    content: Text(
      text!,
      style: TextStyle(fontSize: fontSize ?? 20),
    ),
    duration: Duration(seconds: duration ?? 3),
    backgroundColor: snackBarcolor,
  ));
}
