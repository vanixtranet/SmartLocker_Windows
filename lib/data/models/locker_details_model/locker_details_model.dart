import 'dart:convert';

LockerDetailsModel lockerDetailsModelFromJson(String str) =>
    LockerDetailsModel.fromJson(json.decode(str));

String lockerDetailsModelToJson(LockerDetailsModel data) =>
    json.encode(data.toJson());

class LockerDetailsModel {
  bool success;
  String? lockerdetail;
  String? error;

  LockerDetailsModel({
    this.success = false,
    this.lockerdetail,
    this.error,
  });

  factory LockerDetailsModel.fromJson(Map<String, dynamic> json) =>
      LockerDetailsModel(
        success: json["success"],
        lockerdetail: json["lockerdetail"],
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "lockerdetail": lockerdetail,
        "error": error,
      };
}
