import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
// import 'package:serial_communication/serial_communication.dart';
import 'package:smart_locker_windows/data/bloc/admin_bloc/admin_bloc.dart';
import 'package:smart_locker_windows/data/bloc/bin_employee_bloc/bin_employee_bloc.dart';
import 'package:smart_locker_windows/data/models/bay_details_model/bay_details_model.dart';
import 'package:smart_locker_windows/routes/route_constants.dart';
import 'package:smart_locker_windows/themes/theme_config.dart';
import 'package:smart_locker_windows/ui/widgets/bottom_row_widget.dart';
// import 'package:smart_locker_windows/ui/widgets/logout_widget.dart';
import 'package:smart_locker_windows/ui/widgets/title_bar_widget.dart';

import '../../../data/bloc/locker_bloc/locker_bloc.dart';
import '../../../data/bloc/user_model_bloc/user_model_bloc.dart';
import '../../../data/models/bay_details_model/bay_details_response.dart';
import '../../widgets/custom_alert_dialog.dart';
import '../../widgets/empty_list_widget.dart';
import '../../widgets/progress_indicator.dart';

class BinSelectionScreen extends StatefulWidget {
  const BinSelectionScreen({Key? key}) : super(key: key);

  @override
  State<BinSelectionScreen> createState() => _BinSelectionScreenState();
}

class _BinSelectionScreenState extends State<BinSelectionScreen> {
  BayDetailsResponse? binListDetails;
  String? binName;
  int? binNumber;
  List<bool> checkBoxValues = [];

  bool showButtons = false;
  bool showList = true;
  bool isBinClosed = false;
  bool showCPI = false;
  bool canPop = true;
  SerialPortReader? portReader;

  bool isPortOpen = false;

  // SerialCommunication serialCommunication = SerialCommunication();
  String logData = "Initialized log";
  String receivedData = "Initialized comm";

  int lockerOpenAlertCount = 0;
  final String portName = "COM1";
  SerialPort? serialPort;

  @override
  void initState() {
    listapiCall();
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

  listapiCall() async {
    await adminBloc.getBinUser(
      queryparams: {
        "actionName": "Employeereturnitem",
        "transactionId":
            BlocProvider.of<UserModelBloc>(context).state.userModel?.personId ??
                "",
        "userId":
            BlocProvider.of<UserModelBloc>(context).state.userModel?.id ?? "",
        "smartLockerId": BlocProvider.of<UserModelBloc>(context)
                .state
                .userModel
                ?.userUniqueId ??
            "",
      },
    );
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
          child: showList ? _binSelectionWidget() : _detailsWidget(),
        ),
      ),
    );
  }

  Widget _binSelectionWidget() {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const TitleBarWidget(
              titleText: "Select Bin",
            ),

            //
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Please select bin to collect the accessories.",
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: fontSize(),
                    ),
                  ),

                  //
                  Expanded(child: _streamBuilderWidget()),

                  //
                  SizedBox(height: sizedBoxesLargeHeight()),

                  //
                  Visibility(
                    visible: showButtons,
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
                        "Open Bin",
                        style: TextStyle(
                          fontSize: fontSize(),
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            BottomRowWidget(
              showBackButton: isBinClosed ? false : true,
              showLockerImage: false,
              showLogoutWidget: true,
              showText: false,
            ),

            //
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
    );
  }

  Widget _detailsWidget() {
    return Column(
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
              Text(
                "Please perform your task",
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
                    "Bin:",
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
              if (!isBinClosed)
                Text(
                  "Please close the bin when you are done",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: fontSize(),
                    fontWeight: FontWeight.bold,
                  ),
                ),

              //
              SizedBox(height: sizedBoxesHeight()),

              //
              if (isBinClosed)
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
        ),
      ],
    );
  }

  // List
  Widget _streamBuilderWidget() {
    return StreamBuilder<BayDetailsResponse?>(
      stream: adminBloc.subjectDetails.stream,
      builder: (context, AsyncSnapshot<BayDetailsResponse?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CustomProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }

        if (snapshot.hasData) {
          if (snapshot.data?.list == null || snapshot.data!.list!.isEmpty) {
            showButtons = false;
            return const Center(
              child: EmptyListWidget(),
            );
          }

          binListDetails = snapshot.data;
          showButtons = true;

          return _listViewWidget();
        } else {
          return const Center(
            child: CustomProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _listViewWidget() {
    if (binListDetails!.list != null &&
        binListDetails!.list!.isNotEmpty &&
        checkBoxValues.isEmpty) {
      for (var element in binListDetails!.list!) {
        element;
        checkBoxValues.add(false);
      }
    }
    return ListView.builder(
      itemCount: binListDetails?.list?.length,
      itemBuilder: (BuildContext context, int index) {
        return _elementCardListWidget(
          data: binListDetails!.list![index],
          index: index,
        );
      },
    );
  }

  Widget _elementCardListWidget({
    required BayDetailsModel data,
    required int index,
  }) {
    return Card(
      elevation: 20,
      child: CheckboxListTile(
        // controlAffinity: ListTileControlAffinity.leading,
        value: checkBoxValues[index],
        title: Row(
          children: [
            Text(
              "Bin Name: ",
              style: TextStyle(
                color: Colors.amber.shade800,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            //
            Text(
              data.name ?? "-",
              style: TextStyle(
                color: Colors.amber.shade900,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        onChanged: (value) {
          binName = (value ?? false) ? data.name : null;
          binNumber = (value ?? false) ? index : null;

          checkBoxValues.fillRange(0, checkBoxValues.length, false);

          setState(() {
            checkBoxValues[index] = value ?? false;
          });
        },
      ),
    );
  }

  _handleSelectBin() async {
    if (binName == null || binName!.isEmpty) {
      return displaySnackBar(
        text: 'Please select Bin',
      );
    }

    setState(() {
      showCPI = true;
      canPop = false;
    });

    await initializeSerialCommunication();

    await Future.delayed(const Duration(seconds: 3));

    setState(() {
      showCPI = false;
      showList = false;
    });
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
      customAlertDialog(
        context: context,
        title: "ALERT",
        content: "Please Close the bin",
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
      // if (lockerOpenAlertCount % 4 == 0) {
      //   postSendLockerNotClosedAlert();
      // }

      checkLockerStatus();
    } else if (receivedData.contains("9007920100${binName}03")) {
      setState(() {
        isBinClosed = true;
        canPop = true;
      });

      // binListDetails?.list[0].code;
      await binEmployeeBloc.getCompleteCollectedAccessory(
        queryparams: {
          "actionName": "",
          "transactionId": BlocProvider.of<UserModelBloc>(context)
                  .state
                  .userModel
                  ?.personId ??
              "",
          "smartLockerId":
              binListDetails?.list?[binNumber ?? 0].smartLockerId ?? "",
          "binNumber": binListDetails?.list?[binNumber ?? 0].name ?? "",
          "userId":
              BlocProvider.of<UserModelBloc>(context).state.userModel?.id ?? "",
        },
      );

      return displaySnackBar(
        text: 'Bin is closed',
        duration: 1,
      );
    } else {
      displaySnackBar(
        text: 'Something went wrong',
        duration: 1,
      );
    }
  }

  // void _updateConnectionStatus(SerialResponse? result) async {
  //   logData = result!.logChannel ?? "Set Log";
  //   receivedData = result.readChannel ?? "Set comm";
  // }

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
          LOCKER_RETURN_COLLECT_SCREEN_ROUTE,
          ModalRoute.withName('/returnCollectScreen'),
        );
      }
    }
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
