part of 'abstract_locker_repositories.dart';

class LockerRepository {
  final Dio _dio = Dio();

  Future<EmployeeLockerDetailResponse> getLockerDetail({
    Map<String, dynamic>? queryparams,
  }) async {
    try {
      Response response = await _dio.get(
        APIEndpointConstants.LOCKER_DETAIL_ENDPOINT,
        queryParameters: queryparams ?? {},
      );

      return EmployeeLockerDetailResponse.fromJsonApiData(
        response.data,
      );
    } catch (err, s) {
      debugPrint(err.toString());
      debugPrint(s.toString());

      return EmployeeLockerDetailResponse(
          error: "Something went wrong. Please try again");
    }
  }

  Future<LockerDetailsModel> getReturnVacantBay({
    Map<String, dynamic>? queryparams,
  }) async {
    try {
      Response response = await _dio.get(
        APIEndpointConstants.GET_RETURN_VACANT_BAY_ENDPOINT,
        queryParameters: queryparams ?? {},
      );

      return LockerDetailsModel.fromJson(
        response.data,
      );
    } catch (err, s) {
      debugPrint(err.toString());
      debugPrint(s.toString());

      return LockerDetailsModel(success: false);
    }
  }

  Future<bool> postManageLogs({
    Map<String, dynamic>? queryparams,
  }) async {
    try {
      Response response = await _dio.post(
        APIEndpointConstants.MANAGE_LOGS_ENDPOINT,
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

  Future<bool> postCompleteTransaction({
    Map<String, dynamic>? queryparams,
  }) async {
    try {
      Response response = await _dio.post(
        APIEndpointConstants.COMPLETE_TRANSACTION,
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

  Future<LockerDetailsModel> getUpdateCollectedReturnItems({
    Map<String, dynamic>? queryparams,
  }) async {
    try {
      Response response = await _dio.get(
        APIEndpointConstants.UPDATE_COLLECTED_RETURN_ITEMS,
        queryParameters: queryparams ?? {},
      );

      return LockerDetailsModel.fromJson(
        response.data,
      );
    } catch (err, s) {
      debugPrint(err.toString());
      debugPrint(s.toString());

      return LockerDetailsModel(success: false);
    }
  }

  Future<bool> postSendLockerNotClosedAlert({
    Map<String, dynamic>? queryparams,
  }) async {
    try {
      Response response = await _dio.post(
        APIEndpointConstants.SEND_LOCKER_NOT_CLOSED_ALERT,
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

  Future<bool> postLockerStatus({
    Map<String, dynamic>? queryparams,
  }) async {
    try {
      Response response = await _dio.post(
        APIEndpointConstants.POST_LOCKER_STATUS,
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
}
