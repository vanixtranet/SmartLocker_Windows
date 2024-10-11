import 'employee_locker_details_model.dart';

class EmployeeLockerDetailResponse {
  List<EmployeeLockerDetailModel>? list;
  String? error;

  EmployeeLockerDetailResponse({
    this.list,
    this.error,
  });

  EmployeeLockerDetailResponse.fromJson(Map<String, dynamic> response)
      : list = List<EmployeeLockerDetailModel>.from(
            response["list"].map((x) => EmployeeLockerDetailModel.fromJson(x))),
        error = null;

  Map<String, dynamic> toMap() {
    return {
      "list": list,
      "error": error,
    };
  }

  EmployeeLockerDetailResponse.fromJsonApiData(List response)
      : list =
            response.map((e) => EmployeeLockerDetailModel.fromJson(e)).toList(),
        error = null;

  EmployeeLockerDetailResponse.withError(String? errorValue)
      : list = <EmployeeLockerDetailModel>[],
        error = errorValue;
}
