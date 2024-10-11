import 'package:smart_locker_windows/data/repositories/locker_repositories/abstract_locker_repositories.dart';

import '../../models/employee_locker_details_model/employee_locker_details_response.dart';
import '../../models/locker_details_model/locker_details_model.dart';

class LockerBloc {
  final LockerRepository _repository = LockerRepository();

  Future<bool> postManageLogs({
    Map<String, dynamic>? queryparams,
  }) async {
    bool response = await _repository.postManageLogs(
      queryparams: queryparams,
    );

    return response;
  }

  Future<LockerDetailsModel> getReturnVacantBay({
    Map<String, dynamic>? queryparams,
  }) async {
    LockerDetailsModel response = await _repository.getReturnVacantBay(
      queryparams: queryparams,
    );

    return response;
  }

  Future<EmployeeLockerDetailResponse> getLockerDetail({
    Map<String, dynamic>? queryparams,
  }) async {
    EmployeeLockerDetailResponse response = await _repository.getLockerDetail(
      queryparams: queryparams,
    );

    return response;
  }

  Future<bool> postCompleteTransaction({
    Map<String, dynamic>? queryparams,
  }) async {
    bool response = await _repository.postCompleteTransaction(
      queryparams: queryparams,
    );

    return response;
  }

  Future<LockerDetailsModel> getUpdateCollectedReturnItems({
    Map<String, dynamic>? queryparams,
  }) async {
    LockerDetailsModel response =
        await _repository.getUpdateCollectedReturnItems(
      queryparams: queryparams,
    );

    return response;
  }

  Future<bool> postSendLockerNotClosedAlert({
    Map<String, dynamic>? queryparams,
  }) async {
    bool response = await _repository.postSendLockerNotClosedAlert(
      queryparams: queryparams,
    );

    return response;
  }

  Future<bool> postLockerStatus({
    Map<String, dynamic>? queryparams,
  }) async {
    bool response = await _repository.postLockerStatus(
      queryparams: queryparams,
    );

    return response;
  }
}

final lockerBloc = LockerBloc();
