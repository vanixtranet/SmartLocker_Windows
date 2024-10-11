import 'package:flutter/material.dart';

Future<void> customAlertDialog({
  required BuildContext context,
  String title = "",
  String content = "",
  String buttonText = "",
  Function()? onPressed,
}) async {
  await showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: onPressed ?? () {},
            child: Text(buttonText),
          ),
        ],
      );
    },
  );
}
