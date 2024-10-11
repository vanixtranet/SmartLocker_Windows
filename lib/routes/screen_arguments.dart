import '../data/models/employee_locker_details_model/employee_locker_details_response.dart';

class ScreenArguments {
  final String? string1;
  final int? int1;
  final bool? bool1;
  final EmployeeLockerDetailResponse? lockerDetail;

  ScreenArguments({
    this.string1,
    this.int1,
    this.bool1,
    this.lockerDetail,
  });
}
