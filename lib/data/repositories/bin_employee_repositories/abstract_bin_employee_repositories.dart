import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../constants/api_endpoints.dart';
import '../../models/employee_locker_details_model/employee_locker_details_response.dart';

part 'bin_employee_repositories.dart';

abstract class AbstractBinEmployeeRepository {
  AbstractBinEmployeeRepository();

  Future<EmployeeLockerDetailResponse> getBinDetails({
    Map<String, dynamic>? queryparams,
  });

  Future<EmployeeLockerDetailResponse> getCompleteCollectedAccessory({
    Map<String, dynamic>? queryparams,
  });
}
