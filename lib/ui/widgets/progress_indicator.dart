// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatelessWidget {
  final String? loadingText;

  const CustomProgressIndicator({
    this.loadingText,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircularProgressIndicator(
                  color: Color.fromARGB(255, 250, 108, 10),
                ),
                const SizedBox(width: 16),
                Text(
                  loadingText ?? "Please Wait...",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 16.0,
                      ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          )),
    );
  }
}
