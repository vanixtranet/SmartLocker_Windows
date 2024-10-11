import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../constants/api_endpoints.dart';
import '../../models/admin_initial_model/admin_initial_model.dart';
import '../../models/bay_details_model/bay_details_response.dart';
import '../../models/employee_locker_details_model/employee_locker_details_response.dart';
import '../../models/vending_stock_model/vending_stock_model.dart';

part 'admin_repositories.dart';

abstract class AbstractAdminRepository {
  AbstractAdminRepository();

  Future<BayDetailsResponse> getAllBayList({
    Map<String, dynamic>? queryparams,
  });

  Future<BayDetailsResponse> getReturnedBayList({
    Map<String, dynamic>? queryparams,
  });

  Future<BayDetailsResponse> getVacantListUser({
    Map<String, dynamic>? queryparams,
  });

  Future<BayDetailsResponse> getBinUser({
    Map<String, dynamic>? queryparams,
  });

  Future<bool> deletevendingUser({
    Map<String, dynamic>? queryparams,
  });

  Future<bool> manageVendingUser({
    Map<String, dynamic>? queryparams,
  });

  Future<VendingStockModel> getVendingStockList({
    Map<String, dynamic>? queryparams,
  });

  Future<EmployeeLockerDetailResponse> getAdminTaskList({
    Map<String, dynamic>? queryparams,
  });
}
