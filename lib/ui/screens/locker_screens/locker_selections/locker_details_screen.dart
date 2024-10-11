import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
// import 'package:serial_communication/serial_communication.dart';
import 'package:smart_locker_windows/data/bloc/locker_bloc/locker_bloc.dart';
import 'package:smart_locker_windows/data/models/bay_details_model/bay_details_response.dart';
import 'package:smart_locker_windows/themes/theme_config.dart';
import 'package:smart_locker_windows/ui/widgets/bottom_row_widget.dart';
import 'package:smart_locker_windows/ui/widgets/title_bar_widget.dart';
import '../../../../data/bloc/employee_locker_details_bloc/employee_locker_details_bloc.dart';
import '../../../../data/bloc/user_model_bloc/user_model_bloc.dart';
import '../../../../data/models/employee_locker_details_model/employee_locker_details_model.dart';
import '../../../../data/models/employee_locker_details_model/employee_locker_details_response.dart';
import '../../../../routes/route_constants.dart';
import '../../../widgets/custom_alert_dialog.dart';

class LockerDetailsScreen extends StatefulWidget {
  final EmployeeLockerDetailResponse? lockerDetail;
  final bool isReturn;

  const LockerDetailsScreen({
    Key? key,
    this.lockerDetail,
    this.isReturn = false,
  }) : super(key: key);

  @override
  State<LockerDetailsScreen> createState() => _LockerDetailsScreenState();
}

class _LockerDetailsScreenState extends State<LockerDetailsScreen> {
  EmployeeLockerDetailResponse? lockerDetailsData;
  EmployeeLockerDetailModel? lockerDetailsModel;

  //
  BayDetailsResponse? binListDetails;
  String? binName;
  List<bool> checkBoxValues = [];

  bool showCPI = false;
  bool showUnlock = true;
  bool canPop = true;
  bool isLockerClosed = false;

  //
  // SerialCommunication serialCommunication = SerialCommunication();
  String logData = "Initialized log";
  String receivedData = "Initialized comm";

  int lockerOpenAlertCount = 0;
  int itemsCount = 0;
  final String portName = "COM1";
  SerialPort? serialPort;

  SerialPortReader? portReader;

  bool isPortOpen = false;

  @override
  void initState() {
    getLockerData();
    super.initState();
    // serialCommunication.startSerial().listen(_updateConnectionStatus);

    // getSerialList();
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

  getLockerData() {
    lockerDetailsData = BlocProvider.of<EmployeeLockerDetailsBloc>(context)
        .state
        .lockerDetailData;

    if (lockerDetailsData?.list != null &&
        lockerDetailsData!.list!.isNotEmpty) {
      itemsCount = lockerDetailsData!.list!.length;

      if (lockerDetailsData!.list!.length == 1) {
        if (lockerDetailsData!.list![0].transactionType?.toLowerCase() ==
            "return") {
          // RETURN
          lockerDetailsModel = lockerDetailsData!.list![0];
          binName = lockerDetailsData!.list![0].name;
        } else if (lockerDetailsData!.list![0].transactionType?.toLowerCase() ==
            "collect") {
          // COLLECT
          lockerDetailsModel = lockerDetailsData!.list![0];
          binName = lockerDetailsData!.list![0].name;
        }
      } else {
        for (var i = 0; i < lockerDetailsData!.list!.length; i++) {
          if (lockerDetailsData!.list![i].transactionType?.toLowerCase() ==
              "return") {
            // REPLACEMENT - RETURN
            lockerDetailsModel = lockerDetailsData!.list![i];
            binName = lockerDetailsData!.list![i].name;
            break;
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      onPopInvoked: (didPop) {
        displaySnackBar(
          text: 'Please make sure the locker door is closed',
          duration: 1,
        );
      },
      child: Scaffold(
        backgroundColor: THEME_COLOR,
        body: Container(
          margin: const EdgeInsets.only(
            top: 25,
            left: 10,
            right: 10,
            bottom: 20,
          ),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TitleBarWidget(
                    titleText: "Locker Details",
                  ),

                  //
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.isReturn
                              ? "Please deposit your assets into"
                              : "Please collect your assets from",
                          style: const TextStyle(
                            color: Colors.yellow,
                            fontSize: 22,
                          ),
                        ),

                        //
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Locker:",
                              style: TextStyle(
                                color: Colors.yellow,
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            //
                            const SizedBox(width: 8),

                            //
                            Text(
                              lockerDetailsModel?.name ?? "-",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        //
                        const SizedBox(height: 24),

                        //
                        Image.asset(
                          "assets/img/lockopen.png",
                          height: 240,
                          width: 240,
                        ),

                        //
                        const SizedBox(height: 24),

                        //
                        if (!isLockerClosed)
                          Text(
                            showUnlock
                                ? "Press Unlock to unlock the locker"
                                : "Please close the locker door when you are done",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                        //
                        if (isLockerClosed)
                          const Text(
                            "Do you want to carry out another transaction?",
                            style: TextStyle(
                              color: Colors.yellow,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                        //
                        const SizedBox(height: 8),

                        //
                        !isLockerClosed
                            ? showUnlock
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () async {
                                          setState(() {
                                            showUnlock = false;
                                            showCPI = true;
                                            canPop = false;
                                          });

                                          _handleUnlockDeposit();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.yellow,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 60,
                                            vertical: 15,
                                          ),
                                        ),
                                        child: const Text(
                                          "Unlock",
                                          style: TextStyle(
                                            fontSize: 21,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : const SizedBox()
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      // Check user role and navigate accordingly
                                      handleUserRoleNavigation();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.yellow,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 60,
                                        vertical: 15,
                                      ),
                                    ),
                                    child: const Text(
                                      "Yes",
                                      style: TextStyle(
                                        fontSize: 21,
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
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 60,
                                        vertical: 15,
                                      ),
                                    ),
                                    child: const Text(
                                      "No",
                                      style: TextStyle(
                                        fontSize: 21,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ),

                  BottomRowWidget(
                    showLockerImage: false,
                    showText: false,
                    showLogoutWidget: false,
                    showBackButton: isLockerClosed ? false : isLockerClosed,
                    backOnTap: () => handleUserRoleNavigation(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void handleUserRoleNavigation() {
    final userModel = BlocProvider.of<UserModelBloc>(context).state.userModel;

    if (userModel != null) {
      if (userModel.userRoleCodes == "SL_ADMIN") {
        Navigator.pushNamedAndRemoveUntil(
          context,
          SERVICE_INTERFACE_SCREEN_ROUTE,
          ModalRoute.withName('/serviceInterfaceScreen'),
        );
      } else {
        Navigator.pushNamedAndRemoveUntil(
          context,
          INITIAL_EMPLOYEE_SCREEN_ROUTE,
          ModalRoute.withName('/initialEmployeeScreen'),
        );
      }
    }
  }

  //
  _handleUnlockDeposit() async {
    await Future.delayed(const Duration(seconds: 3));

    await initializeSerialCommunication();

    await Future.delayed(const Duration(seconds: 3));
  }

  checkLockerStatus() async {
    bool dialogPopped = false;
    String statusCommand = "90061201${binName}03";

    // Clear "receivedData"
    // serialCommunication.clearRead();
    serialPort?.flush(SerialPortBuffer.both);

    await Future.delayed(const Duration(seconds: 3));

    sendCommand(
      command: statusCommand,
    );

    await Future.delayed(const Duration(seconds: 3));
    await listenSerialPort();

    if (receivedData.contains("9007920101${binName}03")) {
      // Command received when locker door is open
      customAlertDialog(
        context: context,
        title: "ALERT",
        content: "Please Close locker door",
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
      // Command received when locker door is closed

      await updateCompleteTransaction();

      displaySnackBar(
        text: 'Locker door is closed',
        duration: 1,
      );

      if (itemsCount == 2) {
        // CONTINUE FLOW FOR REPLACEMENT TASK
        Navigator.pushReplacementNamed(
          context,
          LOCKER_RETURN_COLLECT_SCREEN_ROUTE,
        );
      } else {
        // FLOW FOR TASK COMPLETE
        setState(() {
          isLockerClosed = true;
          canPop = true;
          showCPI = false;
        });
      }
    } else {
      displaySnackBar(
        text: 'Something went wrong',
        duration: 1,
      );
    }
  }

  postSendLockerNotClosedAlert() async {
    await lockerBloc.postSendLockerNotClosedAlert(
      queryparams: {
        "smartLockerId": lockerDetailsModel?.smartLockerId ?? "",
        "bayNumberId": lockerDetailsModel?.name ?? "",
        // "bayNumberId": lockerDetailsModel?.bayNumberId ?? "",
      },
    );
  }

  //
  // getSerialList() async {
  //   // await serialCommunication.getAvailablePorts();
  // }

  // void _updateConnectionStatus(SerialResponse? result) async {
  //   logData = result!.logChannel ?? "Set Log";
  //   receivedData = result.readChannel ?? "Set comm";
  // }

  //
  updateCompleteTransaction() async {
    await lockerBloc.postCompleteTransaction(
      queryparams: {
        "Id": lockerDetailsModel?.id ?? "",
        "userId":
            BlocProvider.of<UserModelBloc>(context).state.userModel?.id ?? "",
      },
    );

    lockerDetailsData?.list!
        .removeWhere((element) => element.id == lockerDetailsModel!.id);

    await Future.delayed(const Duration(seconds: 1));
    BlocProvider.of<EmployeeLockerDetailsBloc>(context).add(
      const EmployeeLockerDetailsChangeEvent(
        lockerDetailData: null,
      ),
    );

    await Future.delayed(const Duration(seconds: 3));
    BlocProvider.of<EmployeeLockerDetailsBloc>(context).add(
      EmployeeLockerDetailsChangeEvent(
        lockerDetailData: lockerDetailsData,
      ),
    );

    await Future.delayed(const Duration(seconds: 2));

    // lockerDetailsData = BlocProvider.of<EmployeeLockerDetailsBloc>(context)
    //     .state
    //     .lockerDetailData;

    // await lockerBloc.postCompleteTransaction(
    //   queryparams: {
    //     "Id": lockerDetailsModel?.id ?? "",
    //     "userId":
    //         BlocProvider.of<UserModelBloc>(context).state.userModel?.id ?? "",
    //   },
    // );
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
