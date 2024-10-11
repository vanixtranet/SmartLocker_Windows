import 'dart:convert';

AdminInitalDetailModel adminInitalDetailModelFromJson(String str) =>
    AdminInitalDetailModel.fromJson(json.decode(str));

String adminInitalDetailModelToJson(AdminInitalDetailModel data) =>
    json.encode(data.toJson());

class AdminInitalDetailModel {
  String? fullName;
  String? applicationTypeId;
  String? locationTypeId;
  String? numberOfTerminals;
  String? sizeVariationId;
  String? businessEmail;
  String? organisation;
  String? contactNumber;
  String? json;
  String? locationName;
  String? locationDetail;
  String? name;
  String? collectionTypeId;
  String? smartLockerId;
  String? bayNumberId;
  String? bayNumber;
  String? transactionType;
  String? assetDetail;
  String? assetId;
  bool? isQRcode;
  bool? isQrCode;
  String? employeeId;
  String? returnAssetId;
  String? collectAssetId;
  String? returnBayNumberId;
  String? collectBayNumberId;
  String? code;
  String? assetType;
  String? asset;
  double? count;
  String? binNumberId;
  String? empName;
  String? collectedDateTime;
  String? lockerNo;
  String? lockerUnit;
  String? employeeName;
  String? collectLockerNo;
  String? collectAssetType;
  String? collectAsset;
  String? collectedDate;
  String? returnLockerNo;
  String? returnAssetType;
  String? returnAsset;
  String? returnedDate;
  String? vendingId;
  String? accessoryId;
  String? currentQuantity;
  String? safetyStock;
  String? collectVendingBayNo;
  String? returnBinNo;
  String? collectAccessory;
  String? returnAccessory;
  String? vendingMachineId;
  String? collectionType;
  String? returnBinNumberId;
  String? returnAccessoryId;
  String? vendingName;
  String? lockerName;
  String? api;
  String? locationId;
  String? unitCode;
  bool? locker;
  bool? vending;
  bool? bin;
  String? adminUserId;
  String? userName;
  String? startTime;
  String? endTime;
  String? totalTime;
  String? id;
  String? createdDate;
  String? createdBy;
  String? lastUpdatedDate;
  String? lastUpdatedBy;
  bool? isDeleted;
  int? sequenceOrder;
  String? companyId;
  int? dataAction;
  int? status;
  int? versionNo;

  AdminInitalDetailModel({
    this.fullName,
    this.applicationTypeId,
    this.locationTypeId,
    this.numberOfTerminals,
    this.sizeVariationId,
    this.businessEmail,
    this.organisation,
    this.contactNumber,
    this.json,
    this.locationName,
    this.locationDetail,
    this.name,
    this.collectionTypeId,
    this.smartLockerId,
    this.bayNumberId,
    this.bayNumber,
    this.transactionType,
    this.assetDetail,
    this.assetId,
    this.isQRcode,
    this.isQrCode,
    this.employeeId,
    this.returnAssetId,
    this.collectAssetId,
    this.returnBayNumberId,
    this.collectBayNumberId,
    this.code,
    this.assetType,
    this.asset,
    this.count,
    this.binNumberId,
    this.empName,
    this.collectedDateTime,
    this.lockerNo,
    this.lockerUnit,
    this.employeeName,
    this.collectLockerNo,
    this.collectAssetType,
    this.collectAsset,
    this.collectedDate,
    this.returnLockerNo,
    this.returnAssetType,
    this.returnAsset,
    this.returnedDate,
    this.vendingId,
    this.accessoryId,
    this.currentQuantity,
    this.safetyStock,
    this.collectVendingBayNo,
    this.returnBinNo,
    this.collectAccessory,
    this.returnAccessory,
    this.vendingMachineId,
    this.collectionType,
    this.returnBinNumberId,
    this.returnAccessoryId,
    this.vendingName,
    this.lockerName,
    this.api,
    this.locationId,
    this.unitCode,
    this.locker,
    this.vending,
    this.bin,
    this.adminUserId,
    this.userName,
    this.startTime,
    this.endTime,
    this.totalTime,
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
  });

  factory AdminInitalDetailModel.fromJson(Map<String, dynamic> json) =>
      AdminInitalDetailModel(
        fullName: json["FullName"],
        applicationTypeId: json["ApplicationTypeId"],
        locationTypeId: json["LocationTypeId"],
        numberOfTerminals: json["NumberOfTerminals"],
        sizeVariationId: json["SizeVariationId"],
        businessEmail: json["BusinessEmail"],
        organisation: json["Organisation"],
        contactNumber: json["ContactNumber"],
        json: json["Json"],
        locationName: json["LocationName"],
        locationDetail: json["LocationDetail"],
        name: json["Name"],
        collectionTypeId: json["CollectionTypeId"],
        smartLockerId: json["SmartLockerId"],
        bayNumberId: json["BayNumberId"],
        bayNumber: json["BayNumber"],
        transactionType: json["TransactionType"],
        assetDetail: json["AssetDetail"],
        assetId: json["AssetId"],
        isQRcode: json["IsQRcode"],
        isQrCode: json["IsQRCode"],
        employeeId: json["EmployeeId"],
        returnAssetId: json["ReturnAssetId"],
        collectAssetId: json["CollectAssetId"],
        returnBayNumberId: json["ReturnBayNumberId"],
        collectBayNumberId: json["CollectBayNumberId"],
        code: json["Code"],
        assetType: json["AssetType"],
        asset: json["Asset"],
        count: json["Count"] != null ? json["Count"] as double : null,
        binNumberId: json["BinNumberId"],
        empName: json["EmpName"],
        collectedDateTime: json["CollectedDateTime"],
        lockerNo: json["LockerNo"],
        lockerUnit: json["LockerUnit"],
        employeeName: json["EmployeeName"],
        collectLockerNo: json["CollectLockerNo"],
        collectAssetType: json["CollectAssetType"],
        collectAsset: json["CollectAsset"],
        collectedDate: json["CollectedDate"],
        returnLockerNo: json["ReturnLockerNo"],
        returnAssetType: json["ReturnAssetType"],
        returnAsset: json["ReturnAsset"],
        returnedDate: json["ReturnedDate"],
        vendingId: json["VendingId"],
        accessoryId: json["AccessoryId"],
        currentQuantity: json["CurrentQuantity"],
        safetyStock: json["SafetyStock"],
        collectVendingBayNo: json["CollectVendingBayNo"],
        returnBinNo: json["ReturnBinNo"],
        collectAccessory: json["CollectAccessory"],
        returnAccessory: json["ReturnAccessory"],
        vendingMachineId: json["VendingMachineId"],
        collectionType: json["CollectionType"],
        returnBinNumberId: json["ReturnBinNumberId"],
        returnAccessoryId: json["ReturnAccessoryId"],
        vendingName: json["VendingName"],
        lockerName: json["LockerName"],
        api: json["API"],
        locationId: json["LocationId"],
        unitCode: json["UnitCode"],
        locker: json["Locker"],
        vending: json["Vending"],
        bin: json["Bin"],
        adminUserId: json["AdminUserId"],
        userName: json["UserName"],
        startTime: json["StartTime"],
        endTime: json["EndTime"],
        totalTime: json["TotalTime"],
        id: json["Id"],
        createdDate: json["CreatedDate"],
        createdBy: json["CreatedBy"],
        lastUpdatedDate: json["LastUpdatedDate"],
        lastUpdatedBy: json["LastUpdatedBy"],
        isDeleted: json["IsDeleted"],
        sequenceOrder: json["SequenceOrder"],
        companyId: json["CompanyId"],
        dataAction: json["DataAction"],
        status: json["Status"],
        versionNo: json["VersionNo"],
      );

  Map<String, dynamic> toJson() => {
        "FullName": fullName,
        "ApplicationTypeId": applicationTypeId,
        "LocationTypeId": locationTypeId,
        "NumberOfTerminals": numberOfTerminals,
        "SizeVariationId": sizeVariationId,
        "BusinessEmail": businessEmail,
        "Organisation": organisation,
        "ContactNumber": contactNumber,
        "Json": json,
        "LocationName": locationName,
        "LocationDetail": locationDetail,
        "Name": name,
        "CollectionTypeId": collectionTypeId,
        "SmartLockerId": smartLockerId,
        "BayNumberId": bayNumberId,
        "BayNumber": bayNumber,
        "TransactionType": transactionType,
        "AssetDetail": assetDetail,
        "AssetId": assetId,
        "IsQRcode": isQRcode,
        "IsQRCode": isQrCode,
        "EmployeeId": employeeId,
        "ReturnAssetId": returnAssetId,
        "CollectAssetId": collectAssetId,
        "ReturnBayNumberId": returnBayNumberId,
        "CollectBayNumberId": collectBayNumberId,
        "Code": code,
        "AssetType": assetType,
        "Asset": asset,
        "Count": count,
        "BinNumberId": binNumberId,
        "EmpName": empName,
        "CollectedDateTime": collectedDateTime,
        "LockerNo": lockerNo,
        "LockerUnit": lockerUnit,
        "EmployeeName": employeeName,
        "CollectLockerNo": collectLockerNo,
        "CollectAssetType": collectAssetType,
        "CollectAsset": collectAsset,
        "CollectedDate": collectedDate,
        "ReturnLockerNo": returnLockerNo,
        "ReturnAssetType": returnAssetType,
        "ReturnAsset": returnAsset,
        "ReturnedDate": returnedDate,
        "VendingId": vendingId,
        "AccessoryId": accessoryId,
        "CurrentQuantity": currentQuantity,
        "SafetyStock": safetyStock,
        "CollectVendingBayNo": collectVendingBayNo,
        "ReturnBinNo": returnBinNo,
        "CollectAccessory": collectAccessory,
        "ReturnAccessory": returnAccessory,
        "VendingMachineId": vendingMachineId,
        "CollectionType": collectionType,
        "ReturnBinNumberId": returnBinNumberId,
        "ReturnAccessoryId": returnAccessoryId,
        "VendingName": vendingName,
        "LockerName": lockerName,
        "API": api,
        "LocationId": locationId,
        "UnitCode": unitCode,
        "Locker": locker,
        "Vending": vending,
        "Bin": bin,
        "AdminUserId": adminUserId,
        "UserName": userName,
        "StartTime": startTime,
        "EndTime": endTime,
        "TotalTime": totalTime,
        "Id": id,
        "CreatedDate": createdDate.toString(),
        "CreatedBy": createdBy,
        "LastUpdatedDate": lastUpdatedDate.toString(),
        "LastUpdatedBy": lastUpdatedBy,
        "IsDeleted": isDeleted,
        "SequenceOrder": sequenceOrder,
        "CompanyId": companyId,
        "DataAction": dataAction,
        "Status": status,
        "VersionNo": versionNo,
      };
}
