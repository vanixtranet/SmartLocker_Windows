import 'dart:convert';

VendingStockListModel vendingStockListModelFromJson(String str) =>
    VendingStockListModel.fromJson(json.decode(str));

String vendingStockListModelToJson(VendingStockListModel data) =>
    json.encode(data.toJson());

class VendingStockListModel {
  String? itemName;
  int? safetyStock;
  int? currentQuantity;
  String? bayNumber;
  String? smartLockerId;
  String? vendingId;
  String? vendingName;
  int? noOfBays;
  String? id;
  DateTime? createdDate;
  String? createdBy;
  DateTime? lastUpdatedDate;
  String? lastUpdatedBy;
  bool? isDeleted;
  int? sequenceOrder;
  String? companyId;
  int? dataAction;
  int? status;
  int? versionNo;
  String? accessoryId;

  VendingStockListModel({
    this.itemName,
    this.safetyStock,
    this.currentQuantity,
    this.bayNumber,
    this.smartLockerId,
    this.vendingId,
    this.vendingName,
    this.noOfBays,
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

  factory VendingStockListModel.fromJson(Map<String, dynamic> json) =>
      VendingStockListModel(
        itemName: json["ItemName"],
        safetyStock: json["SafetyStock"],
        currentQuantity: json["CurrentQuantity"],
        bayNumber: json["BayNumber"],
        smartLockerId: json["SmartLockerId"],
        vendingId: json["VendingId"],
        vendingName: json["VendingName"],
        noOfBays: json["NoOfBays"],
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

  Map<String, dynamic> toJson() => {
        "ItemName": itemName,
        "SafetyStock": safetyStock,
        "CurrentQuantity": currentQuantity,
        "BayNumber": bayNumber,
        "SmartLockerId": smartLockerId,
        "VendingId": vendingId,
        "VendingName": vendingName,
        "NoOfBays": noOfBays,
        "Id": id,
        "CreatedDate": createdDate,
        "CreatedBy": createdBy,
        "LastUpdatedDate": lastUpdatedDate,
        "LastUpdatedBy": lastUpdatedBy,
        "IsDeleted": isDeleted,
        "SequenceOrder": sequenceOrder,
        "CompanyId": companyId,
        "DataAction": dataAction,
        "Status": status,
        "VersionNo": versionNo,
        "AccessoryId": accessoryId,
      };
}
