import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../routes/route_constants.dart';

class HardwareBarcodeScannerWidget extends StatefulWidget {
  final bool isCollect;

  const HardwareBarcodeScannerWidget({
    Key? key,
    this.isCollect = false,
  }) : super(key: key);

  @override
  State<HardwareBarcodeScannerWidget> createState() =>
      _HardwareBarcodeScannerWidgetState();
}

class _HardwareBarcodeScannerWidgetState
    extends State<HardwareBarcodeScannerWidget> {
  final FocusNode _focusNode = FocusNode();

  String _controller = '';

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(_focusNode);
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      // color: Colors.white,
      alignment: Alignment.center,
      child: DefaultTextStyle(
        style: textTheme.bodyLarge!,
        child: KeyboardListener(
          focusNode: _focusNode,
          onKeyEvent: (KeyEvent event) {
            String? keyBoardEvent;

            if (event.character == null &&
                (event.logicalKey.debugName == "Enter" ||
                    event.logicalKey.keyId == 4294967309)) {
              keyBoardEvent = "\n";
            }

            _controller += event.character ?? keyBoardEvent ?? "";

            setState(() {});
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text(
              //   _controller.isEmpty
              //       ? "Scan Bar\nCode"
              //       : (_controller.contains("\n")
              //           ? _controller.split('\n')[0]
              //           : _controller),
              //   textAlign: TextAlign.center,
              //   // _message ?? 'Press a key',
              // ),
              scannerWidget(),

              //
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_controller.isEmpty) {
                      } else {
                        String temp = _controller.contains("\n")
                            ? _controller.split('\n')[0]
                            : _controller;

                        if (widget.isCollect) {
                          handleCollectItem();
                        } else {
                          Navigator.pop(context, temp);
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 80,
                        vertical: 20,
                      ),
                    ),
                    child: const Text(
                      "Submit",
                      style: TextStyle(
                        fontSize: 21,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  //

                  const SizedBox(width: 16),

                  //
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _controller = "";
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 80,
                        vertical: 20,
                      ),
                    ),
                    child: const Text(
                      "Reset",
                      style: TextStyle(
                        fontSize: 21,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget scannerWidget() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Image.asset(
          "assets/img/scanner.png",
          height: 150,
          width: 150,
        ),
        const SizedBox(height: 16),
        Text(
          _controller.isNotEmpty
              ? (_controller.contains("\n")
                  ? _controller.split('\n')[0]
                  : _controller)
              : 'Please scan the bar code using the bar code scanner',
          style: const TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  handleCollectItem() {
    Navigator.pushNamed(
      context,
      AUTHENTICATE_ROUTE,
    );
  }
}
