import '../../models/employee_locker_details_model/employee_locker_details_response.dart';
import '../../repositories/bin_employee_repositories/abstract_bin_employee_repositories.dart';

class BinEmployeeBloc {
  final BinEmployeeRepository _repository = BinEmployeeRepository();

  Future<EmployeeLockerDetailResponse> getBinDetails({
    Map<String, dynamic>? queryparams,
  }) async {
    EmployeeLockerDetailResponse response = await _repository.getBinDetails(
      queryparams: queryparams,
    );

    return response;
  }

  Future<EmployeeLockerDetailResponse> getCompleteCollectedAccessory({
    Map<String, dynamic>? queryparams,
  }) async {
    EmployeeLockerDetailResponse response =
        await _repository.getCompleteCollectedAccessory(
      queryparams: queryparams,
    );

    return response;
  }
}

final binEmployeeBloc = BinEmployeeBloc();
