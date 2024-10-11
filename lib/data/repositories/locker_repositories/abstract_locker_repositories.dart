import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../constants/api_endpoints.dart';
import '../../models/employee_locker_details_model/employee_locker_details_response.dart';
import '../../models/locker_details_model/locker_details_model.dart';

part 'locker_repositories.dart';

abstract class AbstractLockerRepository {
  AbstractLockerRepository();

  Future<EmployeeLockerDetailResponse> getLockerDetail({
    Map<String, dynamic>? queryparams,
  });

  Future<LockerDetailsModel> getReturnVacantBay({
    Map<String, dynamic>? queryparams,
  });

  Future<bool> postManageLogs({
    Map<String, dynamic>? queryparams,
  });

  Future<LockerDetailsModel> getUpdateCollectedReturnItems({
    Map<String, dynamic>? queryparams,
  });

  Future<bool> postCompleteTransaction({
    Map<String, dynamic>? queryparams,
  });

  Future<bool> postSendLockerNotClosedAlert({
    Map<String, dynamic>? queryparams,
  });
}
