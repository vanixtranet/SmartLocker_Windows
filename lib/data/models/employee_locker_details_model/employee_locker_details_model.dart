import 'dart:convert';

List<EmployeeLockerDetailModel> employeeLockerDetailModelFromJson(String str) =>
    List<EmployeeLockerDetailModel>.from(
        json.decode(str).map((x) => EmployeeLockerDetailModel.fromJson(x)));

String employeeLockerDetailModelToJson(List<EmployeeLockerDetailModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EmployeeLockerDetailModel {
  String? fullName;
  String? applicationTypeId;
  String? locationTypeId;
  String? numberOfTerminals;
  String? sizeVariationId;
  String? businessEmail;
  String? organisation;
  String? contactNumber;
  int? dataAction;
  String? json;
  String? locationName;
  String? locationDetail;
  String? id;
  String? name;
  String? collectionTypeId;
  String? smartLockerId;
  String? bayNumberId;
  String? bayNumber;

  String? transactionType;
  String? assetDetail;
  String? assetId;
  bool? isQRcode;
  String? employeeId;
  String? returnAssetId;
  String? collectAssetId;
  String? returnBayNumberId;
  String? collectBayNumberId;
  String? code;
  String? assetType;
  String? asset;
  dynamic count;
  String? binNumberId;

  EmployeeLockerDetailModel({
    this.fullName,
    this.applicationTypeId,
    this.locationTypeId,
    this.numberOfTerminals,
    this.sizeVariationId,
    this.businessEmail,
    this.organisation,
    this.contactNumber,
    this.dataAction,
    this.json,
    this.locationName,
    this.locationDetail,
    this.id,
    this.name,
    this.collectionTypeId,
    this.smartLockerId,
    this.bayNumberId,
    this.bayNumber,
    this.transactionType,
    this.assetDetail,
    this.assetId,
    this.isQRcode,
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
  });

  factory EmployeeLockerDetailModel.fromJson(Map<String, dynamic> json) =>
      EmployeeLockerDetailModel(
        fullName: json["FullName"],
        applicationTypeId: json["ApplicationTypeId"],
        locationTypeId: json["LocationTypeId"],
        numberOfTerminals: json["NumberOfTerminals"],
        sizeVariationId: json["SizeVariationId"],
        businessEmail: json["BusinessEmail"],
        organisation: json["Organisation"],
        contactNumber: json["ContactNumber"],
        dataAction: json["DataAction"],
        json: json["Json"],
        locationName: json["LocationName"],
        locationDetail: json["LocationDetail"],
        id: json["Id"],
        name: json["Name"],
        collectionTypeId: json["CollectionTypeId"],
        smartLockerId: json["SmartLockerId"],
        bayNumberId: json["BayNumberId"],
        bayNumber: json["BayNumber"],
        transactionType: json["TransactionType"],
        assetDetail: json["AssetDetail"],
        assetId: json["AssetId"],
        isQRcode: json["IsQRcode"],
        employeeId: json["EmployeeId"],
        returnAssetId: json["ReturnAssetId"],
        collectAssetId: json["CollectAssetId"],
        returnBayNumberId: json["ReturnBayNumberId"],
        collectBayNumberId: json["CollectBayNumberId"],
        code: json["Code"],
        assetType: json["AssetType"],
        asset: json["Asset"],
        count: json["Count"],
        binNumberId: json["BinNumberId"],
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
        "DataAction": dataAction,
        "Json": json,
        "LocationName": locationName,
        "LocationDetail": locationDetail,
        "Id": id,
        "Name": name,
        "CollectionTypeId": collectionTypeId,
        "SmartLockerId": smartLockerId,
        "BayNumberId": bayNumberId,
        "TransactionType": transactionType,
        "AssetDetail": assetDetail,
        "AssetId": assetId,
        "IsQRcode": isQRcode,
        "EmployeeId": employeeId,
        "ReturnAssetId": returnAssetId,
        "CollectAssetId": collectAssetId,
        "ReturnBayNumberId": returnBayNumberId,
        "CollectBayNumberId": collectBayNumberId,
        "BayNumber": bayNumber,
        "Code": code,
        "AssetType": assetType,
        "Asset": asset,
        "Count": count,
        "BinNumberId": binNumberId
      };
}
