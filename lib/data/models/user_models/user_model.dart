class UserModel {
  String? id;
  String? userId;
  String? userName;
  bool? isSystemAdmin;
  String? email;
  String? mobileNumber;
  String? userUniqueId;
  String? companyId;
  String? companyCode;
  String? companyName;
  String? jobTitle;
  String? photoId;
  String? legalEntityId;
  String? legalEntityCode;
  bool? isPasswordChanged;
  String? personId;
  String? userRoleCodes;
  bool? isSuccess;
  String? error;

  UserModel({
    this.id,
    this.userId,
    this.userName,
    this.isSystemAdmin,
    this.email,
    this.mobileNumber,
    this.userUniqueId,
    this.companyId,
    this.companyCode,
    this.companyName,
    this.jobTitle,
    this.photoId,
    this.legalEntityId,
    this.legalEntityCode,
    this.isPasswordChanged,
    this.personId,
    this.userRoleCodes,
    this.isSuccess,
    this.error,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json["Id"],
        userId = json["UserId"],
        userName = json["UserName"],
        isSystemAdmin = json["IsSystemAdmin"],
        email = json["Email"],
        mobileNumber = json["MobileNumber"],
        userUniqueId = json["UserUniqueId"],
        companyId = json["CompanyId"],
        companyCode = json["CompanyCode"],
        companyName = json["CompanyName"],
        jobTitle = json["JobTitle"],
        photoId = json["PhotoId"],
        legalEntityId = json["LegalEntityId"],
        legalEntityCode = json["LegalEntityCode"],
        isPasswordChanged = json["IsPasswordChanged"],
        personId = json["PersonId"],
        isSuccess = json['success'],
        userRoleCodes = json["UserRoleCodes"],
        error = json['error'];

  Map<String, dynamic> toMap() {
    return {
      "Id": id,
      "UserName": userName,
      "IsSystemAdmin": isSystemAdmin,
      "Email": email,
      "MobileNumber": mobileNumber,
      "UserUniqueId": userUniqueId,
      "CompanyId": companyId,
      "CompanyCode": companyCode,
      "CompanyName": companyName,
      "JobTitle": jobTitle,
      "PhotoId": photoId,
      "LegalEntityId": legalEntityId,
      "LegalEntityCode": legalEntityCode,
      "IsPasswordChanged": isPasswordChanged,
      "PersonId": personId,
      "UserRoleCodes": userRoleCodes,
      "success": isSuccess,
      "error": error,
      "UserId": userId,
    };
  }
}
