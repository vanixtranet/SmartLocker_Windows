import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
// import 'package:serial_communication/serial_communication.dart';
import 'package:smart_locker_windows/routes/route_constants.dart';

import '../../../data/bloc/employee_locker_details_bloc/employee_locker_details_bloc.dart';
import '../../../data/bloc/locker_bloc/locker_bloc.dart';
import '../../../data/bloc/user_model_bloc/user_model_bloc.dart';
import '../../../data/models/employee_locker_details_model/employee_locker_details_model.dart';
import '../../../data/models/employee_locker_details_model/employee_locker_details_response.dart';
import '../../../themes/theme_config.dart';
import '../../widgets/bottom_row_widget.dart';
import '../../widgets/custom_alert_dialog.dart';
import '../../widgets/progress_indicator.dart';
import '../../widgets/title_bar_widget.dart';

class BinOpenScreen extends StatefulWidget {
  const BinOpenScreen({Key? key}) : super(key: key);

  @override
  State<BinOpenScreen> createState() => _BinOpenScreenState();
}

class _BinOpenScreenState extends State<BinOpenScreen> {
  bool canPop = true;
  bool isBinClosed = false;
  bool showOpenBinButton = true;
  bool showCPI = false;
  final String portName = "COM1";
  SerialPort? serialPort;

  String? binName;

  // SerialCommunication serialCommunication = SerialCommunication();
  String logData = "Initialized log";
  String receivedData = "Initialized comm";

  int lockerOpenAlertCount = 0;
  int itemsCount = 0;

  EmployeeLockerDetailResponse? data;
  EmployeeLockerDetailResponse? lockerDetailsData;
  EmployeeLockerDetailModel? lockerDetailsModel;

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

  // getSerialList() async {
  //   await serialCommunication.getAvailablePorts();
  // }

  // void _updateConnectionStatus(SerialResponse? result) async {
  //   logData = result!.logChannel ?? "Set Log";
  //   receivedData = result.readChannel ?? "Set comm";
  // }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      onPopInvoked: (didPop) {
        displaySnackBar(
          text: "Please make sure the bin is closed",
        );
      },
      child: Scaffold(
        backgroundColor: THEME_COLOR,
        body: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 10,
          ),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TitleBarWidget(
                    titleText: "Bin Details",
                  ),

                  //
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Please perform your task",
                          style: TextStyle(
                            color: Colors.yellow,
                            fontSize: 22,
                          ),
                        ),

                        //
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Bin:",
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
                              binName ?? "-",
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
                        if (!isBinClosed)
                          const Text(
                            "Please close the bin when you are done",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                        //
                        const SizedBox(height: 24),

                        //
                        if (isBinClosed)
                          const Text(
                            "Do you want to carry out another transaction?",
                            style: TextStyle(
                              color: Colors.yellow,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                        //
                        const SizedBox(height: 12),

                        //
                        Visibility(
                          visible: showOpenBinButton,
                          child: ElevatedButton(
                            onPressed: () => _handleSelectBin(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.yellow,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 80,
                                vertical: 20,
                              ),
                            ),
                            child: const Text(
                              "Open Bin",
                              style: TextStyle(
                                fontSize: 21,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        //
                        if (isBinClosed)
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
                    showBackButton: isBinClosed ? false : canPop,
                    backOnTap: () => handleUserRoleNavigation(),
                  ),
                ],
              ),
              Visibility(
                visible: showCPI,
                child: const CustomProgressIndicator(
                  loadingText:
                      "Please wait while the serial communication\nis set up with the Locker",
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
    if (binName == null || binName!.isEmpty) {
      return displaySnackBar(text: 'Please select Locker');
    }

    setState(() {
      showCPI = true;
      canPop = false;
      showOpenBinButton = false;
    });

    await initializeSerialCommunication();

    await Future.delayed(const Duration(seconds: 3));

    setState(() {
      showCPI = false;
    });
  }

  checkLockerStatus() async {
    bool dialogPopped = false;
    String statusCommand = "90061201${binName}03";

    // Clear "receivedData"
    serialPort?.flush(SerialPortBuffer.both);

    await Future.delayed(const Duration(seconds: 3));

    sendCommand(
      command: statusCommand,
    );

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
      await updateCompleteTransaction();

      displaySnackBar(text: 'Bin is closed');

      if (itemsCount == 2) {
        // CONTINUE FLOW FOR REPLACEMENT TASK
        Navigator.pushReplacementNamed(
          context,
          VENDING_COLLECT_SCREEN_ROUTE,
        );
      } else {
        // FLOW FOR TASK COMPLETE
        setState(() {
          isBinClosed = true;
          canPop = true;
          showCPI = false;
        });
      }
    } else {
      displaySnackBar(text: 'Something went wrong');
      // checkLockerStatus();
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
