import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
// import 'package:serial_communication/serial_communication.dart';
import 'package:smart_locker_windows/themes/theme_config.dart';
import 'package:smart_locker_windows/ui/widgets/custom_alert_dialog.dart';

import '../../../../data/bloc/admin_bloc/admin_bloc.dart';
import '../../../../data/bloc/locker_bloc/locker_bloc.dart';
import '../../../../data/bloc/user_model_bloc/user_model_bloc.dart';
import '../../../../data/models/bay_details_model/bay_details_model.dart';
import '../../../../data/models/bay_details_model/bay_details_response.dart';
import '../../../../routes/route_constants.dart';
import '../../../widgets/bottom_row_widget.dart';
import '../../../widgets/empty_list_widget.dart';
import '../../../widgets/progress_indicator.dart';
import '../../../widgets/title_bar_widget.dart';

class AnyLockerSelectionScreen extends StatefulWidget {
  const AnyLockerSelectionScreen({Key? key}) : super(key: key);

  @override
  State<AnyLockerSelectionScreen> createState() =>
      _AnyLockerSelectionScreenState();
}

class _AnyLockerSelectionScreenState extends State<AnyLockerSelectionScreen> {
  BayDetailsResponse? binListDetails;
  BayDetailsModel? selectedBin;
  String? binName;
  List<bool> checkBoxValues = [];

  // SerialCommunication serialCommunication = SerialCommunication();
  String logData = "Initialized log";
  String receivedData = "Initialized comm";

  bool showCPI = false;
  bool showButtons = false;
  bool showList = true;
  bool isLockerClosed = false;
  bool canPop = true;

  int lockerOpenAlertCount = 0;
  final String portName = "COM1";
  SerialPort? serialPort;

  SerialPortReader? portReader;

  bool isPortOpen = false;

  @override
  void initState() {
    listapiCall();
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

  // getSerialList() async {
  //   await serialCommunication.getAvailablePorts();
  // }

  // @override
  // void dispose() {
  //   serialCommunication.closePort();
  //   super.dispose();
  // }

  listapiCall() async {
    await adminBloc.getAllBayList(
      queryparams: {
        "methodName": "",
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
          margin: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 10,
          ),
          child: showList ? _lockerSelectionWidget() : _detailsWidget(),
        ),
      ),
    );
  }

  Widget _lockerSelectionWidget() {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const TitleBarWidget(
              titleText: "Select Locker",
            ),

            //
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Please select locker.",
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 20,
                    ),
                  ),

                  //
                  Expanded(child: _streamBuilderWidget()),

                  //
                  const SizedBox(height: 16),

                  //
                  Visibility(
                    visible: !showCPI && showButtons,
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
                        "Open Locker",
                        style: TextStyle(
                          fontSize: 21,
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
              showLockerImage: false,
              showText: false,
              showLogoutWidget: false,
              showBackButton: isLockerClosed ? false : canPop,
              backOnTap: () => handleUserRoleNavigation(),
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
          titleText: "Locker Details",
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
              if (!isLockerClosed)
                const Text(
                  "Please close the locker door when you are done",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              //
              const SizedBox(height: 24),

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
              const SizedBox(height: 12),

              //
              if (isLockerClosed)
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

        // BottomRowWidget(
        //   showLockerImage: false,
        //   showText: false,
        //   showLogoutWidget: false,
        //   showBackButton: isLockerClosed,
        //   backOnTap: () => handleUserRoleNavigation(),
        // ),
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
        title: Column(
          children: [
            Row(
              children: [
                Text(
                  "Locker Name: ",
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

            //
            Row(
              children: [
                Text(
                  "Locker Status: ",
                  style: TextStyle(
                    color: Colors.amber.shade800,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                //
                Text(
                  data.code ?? "-",
                  style: TextStyle(
                    color: Colors.amber.shade900,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        onChanged: (value) {
          selectedBin = (value ?? false) ? data : null;
          binName = (value ?? false) ? data.name : null;

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
        text: 'Please select Locker',
        duration: 1,
      );
    }

    setState(() {
      showCPI = true;
      canPop = false;
    });

    await initializeSerialCommunication();

    // await Future.delayed(const Duration(seconds: 5));

    // serialCommunication.closePort();

    // ScaffoldMessenger.of(context).showSnackBar(
    //   const SnackBar(
    //     duration: Duration(seconds: 1),
    //     content: Text(
    //       'Port Closed',
    //       style: TextStyle(fontSize: 20),
    //     ),
    //   ),
    // );

    // await Future.delayed(const Duration(seconds: 3));

    // serialCommunication.destroy();

    // ScaffoldMessenger.of(context).showSnackBar(
    //   const SnackBar(
    //     duration: Duration(seconds: 1),
    //     content: Text(
    //       'Port Destroyed',
    //       style: TextStyle(fontSize: 20),
    //     ),
    //   ),
    // );

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
      setState(() {
        isLockerClosed = true;
        canPop = true;
      });

      return displaySnackBar(
        text: 'Locker door is closed',
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

  postSendLockerNotClosedAlert() async {
    await lockerBloc.postSendLockerNotClosedAlert(
      queryparams: {
        "smartLockerId": selectedBin?.smartLockerId ?? "",
        "bayNumberId": selectedBin?.name ?? "",
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
