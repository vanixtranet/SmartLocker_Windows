import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:smart_locker_windows/routes/route_constants.dart';

import '../../../data/bloc/employee_locker_details_bloc/employee_locker_details_bloc.dart';
import '../../../data/bloc/locker_bloc/locker_bloc.dart';
import '../../../data/bloc/user_model_bloc/user_model_bloc.dart';
import '../../../data/models/employee_locker_details_model/employee_locker_details_response.dart';
import '../../../themes/theme_config.dart';
import '../../widgets/bottom_row_widget.dart';
import '../../widgets/custom_alert_dialog.dart';
import '../../widgets/progress_indicator.dart';
import '../../widgets/title_bar_widget.dart';

class VendingOpenScreen extends StatefulWidget {
  const VendingOpenScreen({Key? key}) : super(key: key);

  @override
  State<VendingOpenScreen> createState() => _VendingOpenScreenState();
}

class _VendingOpenScreenState extends State<VendingOpenScreen> {
  bool canPop = true;
  bool isVendingClosed = false;
  bool showOpenBinButton = true;
  bool showCPI = false;

  String? binName;

  String logData = "Initialized log";
  String receivedData = "Initialized comm";
  int lockerOpenAlertCount = 0;
  final String portName = "COM1";
  SerialPort? serialPort;
  EmployeeLockerDetailResponse? data;

  SerialPortReader? portReader;

  bool isPortOpen = false;

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
      data = BlocProvider.of<EmployeeLockerDetailsBloc>(context)
          .state
          .lockerDetailData!;

      if (data?.list?[0].transactionType == "Collect") {
        // For RETURNING of accessory
        binName = data?.list?[0].name?.length == 1
            ? "0${data?.list?[0].name}"
            : data?.list?[0].name;
      }
    }
    super.initState();
    listenSerialPort();
  }

  @override
  void dispose() {
    // Dispose of the serial port reader stream and close the port
    portReader?.close();
    if (serialPort != null && serialPort!.isOpen) {
      serialPort!.close();
    }
    serialPort = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      onPopInvoked: (didPop) {
        displaySnackBar(
          text: "Please make sure the locker door is closed",
          duration: 1,
        );
      },
      child: Scaffold(
        backgroundColor: THEME_COLOR,
        body: Container(
          margin: EdgeInsets.symmetric(
            vertical: sizedBoxesHeight(),
            horizontal: 10,
          ),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TitleBarWidget(
                    titleText: "Vending machine Details",
                  ),

                  //
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Please collect your accessory",
                        style: TextStyle(
                          color: Colors.yellow,
                          fontSize: fontSize(),
                        ),
                      ),

                      //
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Bay Number:",
                            style: TextStyle(
                              color: Colors.yellow,
                              fontSize: fontSize(),
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          //
                          const SizedBox(width: 8),

                          //
                          Text(
                            binName ?? "-",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: fontSize(),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      //
                      SizedBox(height: sizedBoxesHeight()),

                      //
                      Image.asset(
                        "assets/img/lockopen.png",
                        height: imageSize(),
                        width: imageSize(),
                      ),

                      //
                      SizedBox(height: sizedBoxesHeight()),

                      //
                      if (!isVendingClosed)
                        Text(
                          "Please close the door when you are done",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: fontSize(),
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                      //
                      SizedBox(height: sizedBoxesHeight()),

                      //
                      if (isVendingClosed)
                        Text(
                          "Do you want to carry out another transaction?",
                          style: TextStyle(
                            color: Colors.yellow,
                            fontSize: fontSize(),
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                      //
                      SizedBox(height: sizedBoxesHeight()),

                      //
                      Visibility(
                        visible: showOpenBinButton,
                        child: ElevatedButton(
                          onPressed: () => _handleSelectBin(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.yellow,
                            padding: EdgeInsets.symmetric(
                              horizontal: 80,
                              vertical: buttonHeight(),
                            ),
                          ),
                          child: Text(
                            "Collect Accessory",
                            style: TextStyle(
                              fontSize: fontSize(),
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      //
                      if (isVendingClosed)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Check user role and navigate accordingly
                                handleUserRoleNavigation();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.yellow,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 60,
                                  vertical: buttonHeight(),
                                ),
                              ),
                              child: Text(
                                "Yes",
                                style: TextStyle(
                                  fontSize: fontSize(),
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            //
                            const SizedBox(width: 20),

                            //
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  THANK_YOU_SCREEN_ROUTE,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.yellow,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 60,
                                  vertical: buttonHeight(),
                                ),
                              ),
                              child: Text(
                                "No",
                                style: TextStyle(
                                  fontSize: fontSize(),
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),

                  Expanded(
                    child: BottomRowWidget(
                      showLockerImage: false,
                      showText: false,
                      showLogoutWidget: false,
                      showBackButton: isVendingClosed ? false : canPop,
                      backOnTap: () => handleUserRoleNavigation(),
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: showCPI,
                child: const CustomProgressIndicator(
                  loadingText:
                      "Please wait while the serial communication\nis set up with the Vending Machine",
                ),
              ),
            ],
          ),

          //
        ),
      ),
    );
  }

  _handleSelectBin() async {
    setState(() {
      showCPI = true;
      canPop = false;
      showOpenBinButton = false;
    });

    if (serialPort != null) {
      await initializeSerialCommunication();
    } else {
      print('No Serial Port Available');
    }

    await Future.delayed(const Duration(seconds: 3));

    setState(() {
      showCPI = false;
    });
  }

  checkLockerStatus() async {
    bool dialogPopped = false;

    // Clear "receivedData"
    // serialCommunication.clearRead();
    serialPort?.flush(SerialPortBuffer.both);

    await Future.delayed(const Duration(seconds: 3));

    if (serialPort != null && serialPort?.isOpen == true) {
      // String message = "90061201${binName}03";
      String statusCommand = "90061201${binName}03";
      sendCommand(command: statusCommand);
    }

    await Future.delayed(const Duration(seconds: 3));
    await listenSerialPort();

    if (receivedData.contains("9007920101${binName}03")) {
      customAlertDialog(
        context: context,
        title: "ALERT",
        content: "Please Close bin",
        buttonText: "CONTINUE",
        onPressed: () {
          dialogPopped = true;
          Navigator.pop(context);
        },
      );

      await Future.delayed(const Duration(seconds: 5)).then(
        (value) {
          if (!dialogPopped) {
            Navigator.pop(context);
          }
        },
      );

      // Update the count of alerts for locker door open
      lockerOpenAlertCount++;

      // Send alert to user after 60 seconds
      if (lockerOpenAlertCount % 4 == 0) {
        postSendLockerNotClosedAlert();
      }

      checkLockerStatus();
    } else if (receivedData.contains("9007920100${binName}03")) {
      setState(() {
        isVendingClosed = true;
        canPop = true;
      });

      await lockerBloc.postCompleteTransaction(
        queryparams: {
          "Id": data?.list?[0].id,
          "userId":
              BlocProvider.of<UserModelBloc>(context).state.userModel?.id ?? "",
        },
      );

      return displaySnackBar(
        text: 'Bay is closed',
        duration: 1,
      );
    } else {
      displaySnackBar(
        text: 'Something went wrong',
        duration: 1,
      );
    }
  }

  void handleUserRoleNavigation() {
    final userModel = BlocProvider.of<UserModelBloc>(context).state.userModel;

    if (userModel != null) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        INITIAL_EMPLOYEE_SCREEN_ROUTE,
        ModalRoute.withName('/initialEmployeeScreen'),
      );
    }
  }

  postSendLockerNotClosedAlert() async {
    await lockerBloc.postSendLockerNotClosedAlert(
      queryparams: {
        "smartLockerId": data?.list?[0].id ?? "",
        "bayNumberId": data?.list?[0].name ?? "",
        // "bayNumberId": selectedBin?.bayNumberId ?? "",
      },
    );
  }

  //*********************** */  serial communication methods ************************************************************//

  // Start listening to the port for incoming data
  Future<void> listenSerialPort() async {
    configurePort();
    portReader = SerialPortReader(serialPort!, timeout: 10000);

    // Convert the bytes to a string
    portReader!.stream.listen((data) async {
      // displaySnackBar(message: data.toString());
      String hexData = hexToString(data).trim();
      if (hexData.isNotEmpty) {
        setState(() {
          receivedData = hexData;
        });

        if (receivedData == "90078501${binName}0103" ||
            receivedData == "9007920101${binName}03") {
          await lockerBloc.postLockerStatus(
            queryparams: {
              "bayNo": binName,
              "transactionStatusCode": "DOOR_OPEN"
            },
          );
        } else if (receivedData == "90078501${binName}0003" ||
            receivedData == "9007920100${binName}03") {
          await lockerBloc.postLockerStatus(
            queryparams: {
              "bayNo": binName,
              "transactionStatusCode": "DOOR_CLOSE"
            },
          );
        }
      }
      // displaySnackBar(message: "Received: $receivedData");
    }, onError: (error) {
      displaySnackBar(text: "Error reading data: $error");
    });
  }

// initialize Serial Comm
  Future<void> initializeSerialCommunication() async {
    try {
      serialPort = SerialPort(portName);
      configurePort();

      if (serialPort!.openReadWrite()) {
        setState(() {
          isPortOpen = true;
        });

        String message = "90060501${binName}03";

        sendCommand(
          command: message,
        );

        // Start reading from the port
        await listenSerialPort();
        checkLockerStatus();
      } else {
        displaySnackBar(text: "Failed to open the port");
      }
    } catch (e) {
      displaySnackBar(text: "Error opening port: $e");
    }
  }

  // Configure the serial port settings
  void configurePort() {
    final config = SerialPortConfig();
    config.baudRate = 9600;
    config.bits = 8;
    config.stopBits = 1;
    config.parity = 0;
    serialPort!.config = config;
  }

  // send command
  void sendCommand({required String command}) {
    if (!isPortOpen || serialPort == null) {
      return;
    }
    Uint8List hexString = hexToBytes(command);
    print('Sending command: $command');
    try {
      serialPort?.write(hexString);
    } catch (e) {
      displaySnackBar(text: "Error sending command: $e");
    }
  }

  Uint8List hexToBytes(String hex) {
    final bytes = <int>[];
    for (var i = 0; i < hex.length; i += 2) {
      bytes.add(int.parse(hex.substring(i, i + 2), radix: 16));
    }
    return Uint8List.fromList(bytes);
  }

  String hexToString(List<int> hexList) {
    return hexList.map((e) => e.toRadixString(16).padLeft(2, '0')).join('');
  }

  // Display a snackbar message
  void displaySnackBar({required String text, int? duration}) {
    final snackBar = SnackBar(
      content: Text(text),
      duration: Duration(seconds: duration ?? 2),
      behavior: SnackBarBehavior.floating,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
