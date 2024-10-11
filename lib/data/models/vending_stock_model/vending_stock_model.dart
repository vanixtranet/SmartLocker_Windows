import 'dart:convert';

import 'vending_stock_list_model.dart';

VendingStockModel vendingStockModelFromJson(String str) =>
    VendingStockModel.fromJson(json.decode(str));

class VendingStockModel {
  String? smartLockerId;
  String? smartLockerName;
  String? vendingId;
  String? vendingName;
  int? noOfBays;
  int? noOfFilledBays;
  List<VendingStockListModel>? vendingStock;
  String? id;
  DateTime? createdDate;
  String? createdBy;
  DateTime? lastUpdatedDate;
  String? lastUpdatedBy;
  bool? isDeleted;
  String? sequenceOrder;
  String? companyId;
  int? dataAction;
  int? status;
  int? versionNo;
  String? accessoryId;

  VendingStockModel({
    this.smartLockerId,
    this.smartLockerName,
    this.vendingId,
    this.vendingName,
    this.noOfBays,
    this.noOfFilledBays,
    this.vendingStock,
    this.id,
    this.createdDate,
    this.createdBy,
    this.lastUpdatedDate,
    this.lastUpdatedBy,
    this.isDeleted,
    this.sequenceOrder,
    this.companyId,
    this.dataAction,
    this.status,
    this.versionNo,
    this.accessoryId,
  });

  factory VendingStockModel.fromJson(Map<String, dynamic> json) =>
      VendingStockModel(
        smartLockerId: json["SmartLockerId"],
        smartLockerName: json["SmartLockerName"],
        vendingId: json["VendingId"],
        vendingName: json["VendingName"],
        noOfBays: json["NoOfBays"],
        noOfFilledBays: json["NoOfFilledBays"],
        vendingStock: List<VendingStockListModel>.from(
            json["VendingStock"].map((x) => VendingStockListModel.fromJson(x))),
        id: json["Id"],
        createdDate: DateTime.parse(json["CreatedDate"]),
        createdBy: json["CreatedBy"],
        lastUpdatedDate: DateTime.parse(json["LastUpdatedDate"]),
        lastUpdatedBy: json["LastUpdatedBy"],
        isDeleted: json["IsDeleted"],
        sequenceOrder: json["SequenceOrder"],
        companyId: json["CompanyId"],
        dataAction: json["DataAction"],
        status: json["Status"],
        versionNo: json["VersionNo"],
        accessoryId: json["AccessoryId"],
      );
}
