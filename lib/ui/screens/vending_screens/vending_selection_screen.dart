import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_locker_windows/data/bloc/admin_bloc/admin_bloc.dart';
import 'package:smart_locker_windows/routes/route_constants.dart';
import 'package:smart_locker_windows/themes/theme_config.dart';
import 'package:smart_locker_windows/ui/widgets/bottom_row_widget.dart';
import 'package:smart_locker_windows/ui/widgets/title_bar_widget.dart';

import '../../../data/bloc/user_model_bloc/user_model_bloc.dart';
import '../../../data/models/vending_stock_model/vending_stock_list_model.dart';
import '../../../data/models/vending_stock_model/vending_stock_model.dart';
import '../../widgets/empty_list_widget.dart';
import '../../widgets/progress_indicator.dart';

class VendingSelectionScreen extends StatefulWidget {
  const VendingSelectionScreen({Key? key}) : super(key: key);

  @override
  State<VendingSelectionScreen> createState() => _VendingSelectionScreenState();
}

class _VendingSelectionScreenState extends State<VendingSelectionScreen> {
  String? binName;
  List<bool> checkBoxValues = [];

  VendingStockModel? vendingStockModel;

  TextEditingController stockNameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController safetyStockController = TextEditingController();
  TextEditingController selectBayController = TextEditingController();

  TextEditingController editquantityController = TextEditingController();
  TextEditingController editSafetyStockController = TextEditingController();

  bool showCPI = false;
  bool edited = false;
  bool deleted = false;
  bool showButtons = false;

  @override
  void initState() {
    listapiCall();
    super.initState();
  }

  listapiCall() async {
    await adminBloc.getVendingStockList(
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
    return Scaffold(
      backgroundColor: THEME_COLOR,
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 10,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const TitleBarWidget(
                  titleText: "Start Replenishment",
                ),

                //
                const SizedBox(height: 16),

                Visibility(
                  visible: edited || deleted,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 80),
                    child: TextField(
                      decoration: InputDecoration(
                        fillColor: Colors.green[400],
                        filled: true,
                        labelText: edited
                            ? "Saved Successfully"
                            : "Deleted Successfully",
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),

                //
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(child: _streamBuilderWidget()),

                      //
                      const SizedBox(height: 16),

                      //
                      // Visibility(
                      //   visible: showButtons,
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //     children: [
                      //       ElevatedButton(
                      //         onPressed: () =>
                      //             _addStockModalBottomSheet(context),
                      //         style: ElevatedButton.styleFrom(
                      //           backgroundColor: Colors.yellow,
                      //           padding: const EdgeInsets.symmetric(
                      //             horizontal: 80,
                      //             vertical: 20,
                      //           ),
                      //         ),
                      //         child: const Text(
                      //           "Add Stock",
                      //           style: TextStyle(
                      //             fontSize: 21,
                      //             color: Colors.black,
                      //             fontWeight: FontWeight.bold,
                      //           ),
                      //         ),
                      //       ),

                      //       //
                      //       ElevatedButton(
                      //         onPressed: () => _handleSaveOnPressed(),
                      //         style: ElevatedButton.styleFrom(
                      //           backgroundColor: Colors.yellow,
                      //           padding: const EdgeInsets.symmetric(
                      //             horizontal: 80,
                      //             vertical: 20,
                      //           ),
                      //         ),
                      //         child: const Text(
                      //           "Save",
                      //           style: TextStyle(
                      //             fontSize: 21,
                      //             color: Colors.black,
                      //             fontWeight: FontWeight.bold,
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),

                //
                const SizedBox(height: 16),

                //
                const BottomRowWidget(
                  showLockerImage: false,
                  showText: false,
                ),

                //
              ],
            ),
          ),
          Visibility(
            visible: showCPI,
            child: const CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }

  // List
  Widget _streamBuilderWidget() {
    return StreamBuilder<VendingStockModel?>(
      stream: adminBloc.subjectVendingStockDetails.stream,
      builder: (context, AsyncSnapshot<VendingStockModel?> snapshot) {
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
          vendingStockModel = snapshot.data;
          if (snapshot.data?.vendingStock == null ||
              snapshot.data!.vendingStock!.isEmpty) {
            showButtons = false;
            return const Center(
              child: EmptyListWidget(),
            );
          }

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
    if (vendingStockModel!.vendingStock != null &&
        vendingStockModel!.vendingStock!.isNotEmpty &&
        checkBoxValues.isEmpty) {
      for (var element in vendingStockModel!.vendingStock!) {
        element;
        checkBoxValues.add(false);
      }
    }
    return ListView.builder(
      itemCount: vendingStockModel!.vendingStock?.length,
      itemBuilder: (BuildContext context, int index) {
        return _elementCardListWidget(
          data: vendingStockModel!.vendingStock![index],
          index: index,
        );
      },
    );
  }

  Widget _elementCardListWidget({
    required VendingStockListModel data,
    required int index,
  }) {
    return Card(
      elevation: 20,
      margin: const EdgeInsets.all(12.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Item Name: ",
                        style: TextStyle(
                          color: Colors.amber.shade800,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      //
                      Expanded(
                        child: Text(
                          data.itemName ?? "-",
                          style: TextStyle(
                            color: Colors.amber.shade900,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),

                  //
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Current Quantity : ",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 20,
                        ),
                      ),

                      //
                      Text(
                        data.currentQuantity?.toString() ?? "-",
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Safety Stock : ",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 20,
                        ),
                      ),

                      //
                      Text(
                        data.safetyStock?.toString() ?? "-",
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Bay Number : ",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 20,
                        ),
                      ),

                      //
                      Text(
                        data.bayNumber?.toString() ?? "-",
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            //
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () =>
                      _editQuantityModalBottomSheet(context, data: data),
                  icon: const Icon(
                    Icons.edit,
                    size: 32,
                  ),
                ),

                //
                // IconButton(
                //   onPressed: () => _handleDeleteStock(data),
                //   icon: const Icon(
                //     Icons.delete,
                //     size: 32,
                //   ),
                // )
              ],
            ),
          ],
        ),
      ),
    );
  }

  _editQuantityModalBottomSheet(context, {VendingStockListModel? data}) {
    editquantityController.text = data?.currentQuantity.toString() ?? "";
    editSafetyStockController.text = data?.safetyStock.toString() ?? "";

    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const TextField(
                decoration: InputDecoration(
                  fillColor: Colors.yellow,
                  filled: true,
                  labelText: 'Edit Quantity',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.black,
                  ),
                ),
                keyboardType: TextInputType.number,
              ),

              //
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  data?.itemName ?? "-",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.amber.shade900,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),
              ),

              //
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextField(
                  controller: editquantityController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide:
                          const BorderSide(width: 3, color: Colors.black),
                    ),
                    labelText: 'Quantity:',
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),

              //
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextField(
                  controller: editSafetyStockController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide:
                          const BorderSide(width: 3, color: Colors.black),
                    ),
                    labelText: 'Safety Stock:',
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),

              //
              ElevatedButton(
                onPressed: () => _handleUpdate(data),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 100,
                    vertical: 15,
                  ),
                ),
                child: const Text(
                  "Update",
                  style: TextStyle(
                    fontSize: 21,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _addStockModalBottomSheet(context) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const TextField(
                decoration: InputDecoration(
                  fillColor: Colors.yellow,
                  filled: true,
                  labelText: 'Add Stock',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.black,
                  ),
                ),
              ),

              //
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextField(
                  controller: stockNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide:
                          const BorderSide(width: 3, color: Colors.black),
                    ),
                    labelText: 'Stock Name:',
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),

              //
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextField(
                  controller: quantityController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide:
                          const BorderSide(width: 3, color: Colors.black),
                    ),
                    labelText: 'Quantity:',
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),

              //
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextField(
                  controller: safetyStockController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide:
                          const BorderSide(width: 3, color: Colors.black),
                    ),
                    labelText: 'Safety Stock:',
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),

              //
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextField(
                  controller: selectBayController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide:
                          const BorderSide(width: 3, color: Colors.black),
                    ),
                    labelText: 'Select Bay:',
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),

              //
              ElevatedButton(
                onPressed: () => _handleAddStock(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 100,
                    vertical: 15,
                  ),
                ),
                child: const Text(
                  "Add",
                  style: TextStyle(
                    fontSize: 21,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _handleUpdate(VendingStockListModel? data) async {
    FocusScope.of(context).requestFocus(FocusNode());

    Navigator.pop(context);

    setState(() {
      showCPI = true;
      showButtons = false;
    });

    int safetyStock = (editSafetyStockController.text.isNotEmpty)
        ? int.parse(editSafetyStockController.text)
        : (data?.safetyStock ?? 0);

    int quantity = (editquantityController.text.isNotEmpty)
        ? int.parse(editquantityController.text)
        : (data?.currentQuantity ?? 0);

    bool response = await adminBloc.manageVendingUser(
      queryparams: {
        "ItemName": data!.itemName ?? "",
        "SafetyStock": safetyStock,
        "CurrentQuantity": quantity,
        "BayNumber": data.bayNumber ?? 0,
        "VendingId": data.vendingId ?? "",
        "Id": data.id ?? "",
        "DataAction": "Edit",
        "AccessoryId": data.accessoryId ?? "",
      },
    );

    if (response) {
      listapiCall();
    }

    setState(() {
      showCPI = false;
      edited = true;
    });

    await Future.delayed(const Duration(seconds: 5));

    setState(() {
      edited = false;
    });
  }

  _handleAddStock() async {
    FocusScope.of(context).requestFocus(FocusNode());

    Navigator.pop(context);

    setState(() {
      showCPI = true;
      showButtons = false;
    });

    bool response = await adminBloc.manageVendingUser(
      queryparams: {
        "ItemName": stockNameController.text,
        "SafetyStock": int.parse(safetyStockController.text),
        "CurrentQuantity": int.parse(quantityController.text),
        "BayNumber": selectBayController.text,
        "VendingId": vendingStockModel?.vendingId ?? "",
        "DataAction": "Create",
      },
    );

    if (response) {
      listapiCall();
    }

    setState(() {
      showCPI = false;
      edited = true;
    });

    await Future.delayed(const Duration(seconds: 5));

    setState(() {
      edited = false;
    });
  }

  _handleDeleteStock(VendingStockListModel? data) async {
    setState(() {
      showCPI = true;
      showButtons = false;
    });

    bool response = await adminBloc.deleteVendingUser(
      queryparams: {
        "stockId": data?.id ?? "",
      },
    );

    if (response) {
      listapiCall();
    }

    setState(() {
      showCPI = false;
      deleted = true;
    });

    await Future.delayed(const Duration(seconds: 5));

    setState(() {
      deleted = false;
    });
  }

  _handleSaveOnPressed() async {
    Navigator.pushNamed(
      context,
      CLOSE_VENDING_DOOR_ROUTE,
    );

    await Future.delayed(const Duration(seconds: 3));

    Navigator.pushNamed(
      context,
      ALERT_ROUTE,
    );

    await Future.delayed(const Duration(seconds: 3));

    Navigator.pushNamed(
      context,
      THANK_YOU_SCREEN_ROUTE,
    );
  }
}
