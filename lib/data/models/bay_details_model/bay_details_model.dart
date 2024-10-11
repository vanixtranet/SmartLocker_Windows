import 'dart:convert';

BayDetailsModel bayDetailsModelFromJson(String str) =>
    BayDetailsModel.fromJson(json.decode(str));

String bayDetailsModelToJson(BayDetailsModel data) =>
    json.encode(data.toJson());

class BayDetailsModel {
  String? name;
  String? email;
  String? value;
  String? code;
  String? court;
  double? count;
  String? sequence;
  int? enumId;
  String? dateTest;
  String? dataType;
  String? className;
  String? title;
  String? key;
  bool? lazy;
  bool? selected;
  String? departmentOwnerUserId;
  bool? hasChildren;
  String? userId;
  String? shortCategory;
  String? categoryName;
  String? id;
  String? createdBy;
  String? createdDate;
  String? lastUpdatedDate;
  String? lastUpdatedBy;
  bool? isDeleted;
  String? sequenceOrder;
  String? companyId;
  String? legalEntityId;
  int? dataAction;
  int? status;
  int? versionNo;
  String? portalId;
  String? smartLockerId;
  String? bayNumberId;

  BayDetailsModel({
    this.name,
    this.email,
    this.value,
    this.code,
    this.court,
    this.count,
    this.sequence,
    this.enumId,
    this.dateTest,
    this.dataType,
    this.className,
    this.title,
    this.key,
    this.lazy,
    this.selected,
    this.departmentOwnerUserId,
    this.hasChildren,
    this.userId,
    this.shortCategory,
    this.categoryName,
    this.id,
    this.createdDate,
    this.createdBy,
    this.lastUpdatedDate,
    this.lastUpdatedBy,
    this.isDeleted,
    this.sequenceOrder,
    this.companyId,
    this.legalEntityId,
    this.dataAction,
    this.status,
    this.versionNo,
    this.portalId,
    this.smartLockerId,
    this.bayNumberId,
  });

  factory BayDetailsModel.fromJson(Map<String, dynamic> json) =>
      BayDetailsModel(
        name: json["Name"],
        email: json["Email"],
        value: json["Value"],
        code: json["Code"],
        court: json["Court"],
        count: json["Count"] as double,
        sequence: json["Sequence"],
        enumId: json["EnumId"],
        dateTest: json["DateTest"],
        dataType: json["DataType"],
        className: json["ClassName"],
        title: json["title"],
        key: json["key"],
        lazy: json["lazy"],
        selected: json["selected"],
        departmentOwnerUserId: json["DepartmentOwnerUserId"],
        hasChildren: json["HasChildren"],
        userId: json["UserId"],
        shortCategory: json["ShortCategory"],
        categoryName: json["CategoryName"],
        id: json["Id"],
        createdBy: json["CreatedBy"],
        createdDate: json["CreatedDate"],
        lastUpdatedDate: json["LastUpdatedDate"],
        lastUpdatedBy: json["LastUpdatedBy"],
        isDeleted: json["IsDeleted"],
        sequenceOrder: json["SequenceOrder"],
        companyId: json["CompanyId"],
        legalEntityId: json["LegalEntityId"],
        dataAction: json["DataAction"],
        status: json["Status"],
        versionNo: json["VersionNo"],
        portalId: json["PortalId"],
        smartLockerId: json["SmartLockerId"],
        bayNumberId: json["BayNumberId"],
      );

  Map<String, dynamic> toJson() => {
        "Name": name,
        "Email": email,
        "Value": value,
        "Code": code,
        "Court": court,
        "Count": count,
        "Sequence": sequence,
        "EnumId": enumId,
        "DateTest": dateTest,
        "DataType": dataType,
        "ClassName": className,
        "title": title,
        "key": key,
        "lazy": lazy,
        "selected": selected,
        "DepartmentOwnerUserId": departmentOwnerUserId,
        "HasChildren": hasChildren,
        "UserId": userId,
        "ShortCategory": shortCategory,
        "CategoryName": categoryName,
        "Id": id,
        "CreatedDate": createdDate,
        "CreatedBy": createdBy,
        "LastUpdatedDate": lastUpdatedDate,
        "LastUpdatedBy": lastUpdatedBy,
        "IsDeleted": isDeleted,
        "SequenceOrder": sequenceOrder,
        "CompanyId": companyId,
        "LegalEntityId": legalEntityId,
        "DataAction": dataAction,
        "Status": status,
        "VersionNo": versionNo,
        "PortalId": portalId,
        "SmartLockerId": smartLockerId,
        "BayNumberId": bayNumberId,
      };
}
