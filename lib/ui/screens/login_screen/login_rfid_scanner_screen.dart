import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gif_view/gif_view.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smart_locker_windows/themes/theme_config.dart';
import 'package:smart_locker_windows/ui/widgets/snack_bar.dart';
import '../../../data/bloc/authentication_bloc/authentication_bloc.dart';
import '../../../data/bloc/user_model_bloc/user_model_bloc.dart';
import '../../../data/models/user_models/user_model.dart';
import '../../../routes/route_constants.dart';
import 'package:sizer/sizer.dart';

class LoginRfidScannerScreen extends StatefulWidget {
  const LoginRfidScannerScreen({Key? key}) : super(key: key);

  @override
  State<LoginRfidScannerScreen> createState() => _LoginRfidScannerScreenState();
}

class _LoginRfidScannerScreenState extends State<LoginRfidScannerScreen> {
  final FocusNode _focusNode = FocusNode();
  String _controller = '';
  String scannerText =
      "Scan the Emirates Group Employee ID to start the transaction";

  bool isBarCodeDataAvailable = false;
  bool showRfidScanner = true;
  bool showFaceDetector = false;
  bool isLoadingVisible = false;

  int invalidLoginCount = 0;

  // Device info plugin to get the serial number from android device attached to the locker unit
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};

  // String serialNumber = "";

  @override
  void initState() {
    initPlatformState();
    super.initState();
  }

  //--------------------------- Logger code -----------------------------//
  var logger = Logger(
    printer: PrettyPrinter(),
  );

  var loggerNoStack = Logger(
    printer: PrettyPrinter(methodCount: 0),
  );

  //-----------------------------************--------------------------------//

  //--------------------------- Path provider code --------------------------//
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    print(path);

    return File('$path/log${DateTime.now()}.txt');
  }

  Future<File> writeLog(String log) async {
    final file = await _localFile;
    return file.writeAsString('$log\n', mode: FileMode.append);
  }

  void logData(String message) async {
    await writeLog(message);
  }
  //-----------------------------************--------------------------------//

  Future<void> initPlatformState() async {
    var deviceData = <String, dynamic>{};

    try {
      if (kIsWeb) {
        deviceData = _readWebBuildData(await deviceInfoPlugin.webBrowserInfo);
      } else {
        deviceData = Platform.isWindows
            ? _readWindowsBuildData(await deviceInfoPlugin.windowsInfo)
            : _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }

    if (!mounted) return;

    _deviceData = deviceData;
    _deviceData.forEach((key, value) {
      if (value is Map) {
        value.forEach((subKey, subValue) {
          if (subValue.toString().isNotEmpty && subValue is String) {
            logger.d('$subKey: $subValue');
            logData('$subKey: $subValue');
          }
        });
      } else {
        print('$key: $value');
      }
    });
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'serialNumber': build.serialNumber,
    };
  }

  Map<String, dynamic> _readWindowsBuildData(WindowsDeviceInfo build) {
    return <String, dynamic>{
      // 'productId': build.productId,
      'deviceId': build.data
    };
  }

  Map<String, dynamic> _readWebBuildData(WebBrowserInfo build) {
    return <String, dynamic>{
      'productSub': build.productSub,
    };
  }

  @override
  Widget build(BuildContext context) {
    if (showRfidScanner) {
      FocusScope.of(context).requestFocus(_focusNode);
    }
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/img/Employee ID Scan.jpg',
            fit: BoxFit.cover,
          ),

          //
          Positioned(
            top: 20.0,
            left: 20.0,
            child: Image.asset(
              'assets/img/Logo_emirates.png',
              height: 120,
              width: 120,
            ),
          ),

          //
          Positioned(
            bottom: -4.0,
            right: 15.0,
            child: Card(
              color: THEME_COLOR,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(70.0),
                  topRight: Radius.circular(70.0),
                  bottomLeft: Radius.circular(2.0),
                  bottomRight: Radius.circular(2.0),
                ),
              ),
              child: SizedBox(
                width: 46.w,
                height: 90.h,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 50),

                      //
                      const Text(
                        'Welcome to ',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),

                      //
                      const SizedBox(height: 15),

                      //
                      const Text(
                        'Kiosk Smart Locker',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      //
                      const SizedBox(height: 32.0),

                      //
                      // !showRfidScanner && !showFaceDetector
                      //     ? optionsWidget()
                      //     : const SizedBox(),

                      //
                      showRfidScanner ? scannerWidget() : loadingWidget(),

                      //
                      // showFaceDetector
                      //     ? faceDetectionWidget()
                      //     : const SizedBox(),

                      //
                      // SizedBox(height: showFaceDetector ? 24 : 1),

                      // showFaceDetector || showRfidScanner
                      //     ? InkWell(
                      //         onTap: () => setState(() {
                      //           showFaceDetector = false;
                      //           showRfidScanner = false;
                      //         }),
                      //         child: Image.asset(
                      //           "assets/img/backbutton.png",
                      //           height: 50,
                      //           width: 50,
                      //         ),
                      //       )
                      //     : const SizedBox(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget optionsWidget() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(height: 40),

        //
        buttons(
          onPressed: () {
            setState(() {
              showRfidScanner = true;
              showFaceDetector = false;
            });
          },
          title: "RFID Scanner",
        ),

        //
        const SizedBox(height: 24),

        //
        buttons(
          onPressed: () {
            setState(() {
              showRfidScanner = false;
              showFaceDetector = true;
            });
          },
          title: "Face Detector",
        ),
      ],
    );
  }

  Widget buttons({
    required Function onPressed,
    required String title,
  }) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.yellow,
        minimumSize: const Size(200.0, 50.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20.0,
          color: Colors.black,
        ),
      ),
    );
  }

  // Widget faceDetectionWidget() {
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 40),
  //     child: buttons(
  //       onPressed: () => getImage(context),
  //       title: "Open Camera",
  //     ),
  //   );
  // }

  // Future<void> getImage(BuildContext context) async {
  //   final XFile? image = await ImagePicker().pickImage(
  //     source: ImageSource.camera,
  //   );

  //   setState(() {
  //     if (image != null) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text(
  //             'Image captured successfully',
  //             style: TextStyle(fontSize: 24),
  //           ),
  //         ),
  //       );
  //       _image = File(image.path);

  //       // Save the image to the gallery if it's captured from the camera
  //       GallerySaver.saveImage(image.path).then((bool? success) {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: Text(
  //               success == true
  //                   ? "Image Saved to Gallery"
  //                   : "Failed to Save Image",
  //               style: const TextStyle(fontSize: 24),
  //             ),
  //           ),
  //         );
  //       });

  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => const LoginAuthenticate(),
  //         ),
  //       );
  //     }
  //   });
  // }

  Widget scannerWidget() {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return DefaultTextStyle(
      style: textTheme.bodyLarge!,
      child: KeyboardListener(
        autofocus: true,
        focusNode: _focusNode,
        onKeyEvent: (KeyEvent event) async {
          _deviceData.forEach((key, value) {
            if (value is Map) {
              value.forEach((subKey, subValue) {
                if (subValue.toString().isNotEmpty && subValue is String) {
                  logger.d('$subKey: $subValue');
                  logData('$subKey: $subValue');
                }
              });
            } else {
              print('$key: $value');
            }
          });
          // _deviceData.forEach((key, value) {
          //   if (value is Map) {
          //     value.forEach((subKey, subValue) {
          //       if (subValue.toString().isNotEmpty && subValue is String) {
          //         logger.d('$subKey: $subValue');
          //       }
          //     });
          //   } else {
          //     print('$key: $value');
          //   }
          // });

          String? keyBoardEvent;

          if (event.character == '\n' ||
              event.physicalKey.debugName == "Enter" ||
              event.logicalKey.keyId == 4294967309) {
            keyBoardEvent = "\n";
          }

          _controller += event.character ?? keyBoardEvent ?? "";
          print(event.logicalKey.debugName);

          if ((event.character == "\n" || keyBoardEvent == "\n") &&
              !isBarCodeDataAvailable) {
            isBarCodeDataAvailable = true;
            setState(() {
              scannerText = "";
              showRfidScanner = false;
            });

            // Uncomment when implemented with RFID
            loginRequest();
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(
              "assets/img/scanner.png",
              height: 150,
              width: 150,
            ),

            //
            const SizedBox(height: 16),

            //
            Text(
              scannerText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),

            //
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget loadingWidget() {
    return isLoadingVisible
        ? Column(
            children: [
              Image.asset(
                'assets/img/lock.png',
                // 'assets/lock-removebg-preview.png',
                width: 150.0,
                height: 150.0,
              ),

              //
              const SizedBox(height: 40),

              //
              const Text(
                'Authenticated',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),

              //
              Image.asset(
                "assets/img/authenticated.png",
                height: 180,
                width: 180,
              ),
            ],
          )
        : Column(
            children: [
              const Text(
                "Please wait till you are\nauthenticated..",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  // fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              GifView.asset(
                'assets/img/loader.gif',
                height: 180,
                width: 180,
                frameRate: 15, // default is 15 FPS
              ),
            ],
          );
  }

  loginRequest({
    String? rfidData,
  }) async {
    UserModel? data = await authenticationBloc.authenticateUser(
      queryparams: {
        // "rfid": (_controller.contains("\n")
        //     ? _controller.split('\n')[0]
        //     : _controller),
        "unitCode": "fca028de07",
        // "unitCode": "RR549013231",
        // "unitCode": "ACR1281UC2",

        // "rfid": ((_controller.contains("\n")
        //             ? _controller.split('\n')[0]
        //             : _controller) ==
        //         "04 3c 81 82 d8 4e 80")
        //     ? "5566"
        //     : ((_controller.contains("\n")
        //                 ? _controller.split('\n')[0]
        //                 : _controller) ==
        //             "04 15 d9 2a 35 5b 80")
        //         ? "5656"
        //         : _controller.contains("\n")
        //             ? _controller.split('\n')[0]
        //             : _controller,
        "rfid": ((_controller.contains("\n")
                    ? _controller.split('\n')[0]
                    : _controller) ==
                "59 9c 19 ef") // employee card
            ? "5566"
            : ((_controller.contains("\n")
                        ? _controller.split('\n')[0]
                        : _controller) ==
                    "04 cc b8 32 b5 57 80") // admin card
                ? "5656"
                : _controller.contains("\n")
                    ? _controller.split('\n')[0]
                    : _controller,
        // "unitCode": Platform.isWindows
        //     ? _deviceData['deviceId']
        //     : _deviceData["serialNumber"],
      },
    );

    if (data != null && data.isSuccess == true) {
      displaySnackBar(
        context: context,
        text: 'Login Successful',
        fontSize: 24,
      );

      BlocProvider.of<UserModelBloc>(context).add(
        UserModelChangeEvent(
          userModel: data,
        ),
      );

      setState(() {
        isLoadingVisible = true;
      });

      navigateOnDelay();
      // Navigator.pushReplacementNamed(
      //   context,
      //   LOGIN_AUTHENTICATE_SCREEN_ROUTE,
      // );
    } else {
      invalidLoginCount++;
      isBarCodeDataAvailable = false;
      setState(() {
        scannerText =
            "Scan the Emirates Group Employee ID to start the transaction";
        showRfidScanner = true;
        _controller = "";
      });

      displaySnackBar(
        context: context,
        text: data.error ?? 'Something went wrong, please try again later.',
      );

      if (invalidLoginCount == 3) {
        postSendUnauthorizedAccessAlert();
      }
    }
  }

  postSendUnauthorizedAccessAlert() async {
    await authenticationBloc.postSendUnauthorizedAccessAlert(
      queryparams: {
        "smartLockerId": BlocProvider.of<UserModelBloc>(context)
                .state
                .userModel
                ?.userUniqueId ??
            "",
      },
    );
  }

  navigateOnDelay() async {
    await Future.delayed(const Duration(seconds: 3));

    if (BlocProvider.of<UserModelBloc>(context)
            .state
            .userModel
            ?.userRoleCodes ==
        "SL_ADMIN") {
      // Navigator.popAndPushNamed(
      //   context,
      //   INITIAL_ADMIN_SCREEN_ROUTE,
      // );
      Navigator.pushNamedAndRemoveUntil(
        context,
        INITIAL_ADMIN_SCREEN_ROUTE,
        ModalRoute.withName('initialAdminScanScreen'),
      );
      // Navigator.pushNamedAndRemoveUntil(
      //   context,
      //   SERVICE_INTERFACE_SCREEN_ROUTE,
      //   ModalRoute.withName('/serviceInterfaceScreen'),
      // );
    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        INITIAL_EMPLOYEE_SCREEN_ROUTE,
        ModalRoute.withName('/initialEmployeeScreen'),
      );
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}
