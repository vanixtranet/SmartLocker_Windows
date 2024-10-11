part of 'abstract_admin_repositories.dart';

class AdminRepository {
  final Dio _dio = Dio();

  Future<BayDetailsResponse> getAllBayList({
    Map<String, dynamic>? queryparams,
  }) async {
    try {
      Response response = await _dio.get(
        APIEndpointConstants.GET_ALL_BAY_LIST,
        queryParameters: queryparams ?? {},
      );

      return BayDetailsResponse.fromJson(
        response.data,
      );
    } catch (err, s) {
      debugPrint(err.toString());
      debugPrint(s.toString());

      return BayDetailsResponse();
    }
  }

  Future<BayDetailsResponse> getReturnedBayList({
    Map<String, dynamic>? queryparams,
  }) async {
    try {
      Response response = await _dio.get(
        APIEndpointConstants.GET_RETURNED_BAY_LIST,
        queryParameters: queryparams ?? {},
      );

      return BayDetailsResponse.fromJson(
        response.data,
      );
    } catch (err, s) {
      debugPrint(err.toString());
      debugPrint(s.toString());

      return BayDetailsResponse();
    }
  }

  Future<BayDetailsResponse> getVacantListUser({
    Map<String, dynamic>? queryparams,
  }) async {
    try {
      Response response = await _dio.get(
        APIEndpointConstants.GET_ADMIN_VACANT_BAY_LIST_STORE,
        queryParameters: queryparams ?? {},
      );

      return BayDetailsResponse.fromJson(
        response.data,
      );
    } catch (err, s) {
      debugPrint(err.toString());
      debugPrint(s.toString());

      return BayDetailsResponse();
    }
  }

  Future<BayDetailsResponse> getBinUser({
    Map<String, dynamic>? queryparams,
  }) async {
    try {
      Response response = await _dio.get(
        APIEndpointConstants.GET_BIN_LIST,
        queryParameters: queryparams ?? {},
      );

      return BayDetailsResponse.fromJson(
        response.data,
      );
    } catch (err, s) {
      debugPrint(err.toString());
      debugPrint(s.toString());

      return BayDetailsResponse();
    }
  }

  Future<bool> deleteVendingUser({
    Map<String, dynamic>? queryparams,
  }) async {
    try {
      Response response = await _dio.post(
        APIEndpointConstants.DELETE_VENDING_STOCK,
        // data: jsonEncode(queryparams),
        queryParameters: queryparams ?? {},
      );

      return Future.value(
        response.data["success"] ?? false,
      );
    } catch (err, s) {
      debugPrint(err.toString());
      debugPrint(s.toString());

      return Future.error(
        "Something went wrong, please try again later.",
      );
    }
  }

  Future<bool> manageVendingUser({
    Map<String, dynamic>? queryparams,
  }) async {
    try {
      Response response = await _dio.post(
        APIEndpointConstants.MANAGE_VENDING_STOCK,
        data: jsonEncode(queryparams),
      );

      return Future.value(
        response.data["success"] ?? false,
      );
    } catch (err, s) {
      debugPrint(err.toString());
      debugPrint(s.toString());

      return Future.error(
        "Something went wrong, please try again later.",
      );
    }
  }

  Future<VendingStockModel> getVendingStockList({
    Map<String, dynamic>? queryparams,
  }) async {
    try {
      Response response = await _dio.get(
        APIEndpointConstants.GET_VENDING_STOCK_LIST,
        queryParameters: queryparams ?? {},
      );

      return VendingStockModel.fromJson(
        response.data,
      );
    } catch (err, s) {
      debugPrint(err.toString());
      debugPrint(s.toString());

      return VendingStockModel();
    }
  }

  Future<AdminInitalDetailModel> getAdminTaskList({
    Map<String, dynamic>? queryparams,
  }) async {
    try {
      Response response = await _dio.get(
        APIEndpointConstants.GET_ADMIN_TASK_LIST,
        queryParameters: queryparams ?? {},
      );

      return AdminInitalDetailModel.fromJson(
        response.data,
      );
    } catch (err, s) {
      debugPrint(err.toString());
      debugPrint(s.toString());

      return AdminInitalDetailModel();
    }
  }
}
