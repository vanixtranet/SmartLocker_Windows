part of 'abstract_bin_employee_repositories.dart';

class BinEmployeeRepository {
  final Dio _dio = Dio();

  Future<EmployeeLockerDetailResponse> getBinDetails({
    Map<String, dynamic>? queryparams,
  }) async {
    try {
      Response response = await _dio.get(
        APIEndpointConstants.GET_BIN_DETAILS_ENDPOINT,
        queryParameters: queryparams ?? {},
      );

      return EmployeeLockerDetailResponse.fromJsonApiData(
        response.data,
      );
    } catch (err, s) {
      debugPrint(err.toString());
      debugPrint(s.toString());

      return EmployeeLockerDetailResponse.withError(
          "Something went wrong, please try again later.");
    }
  }

  Future<EmployeeLockerDetailResponse> getCompleteCollectedAccessory({
    Map<String, dynamic>? queryparams,
  }) async {
    try {
      Response response = await _dio.get(
        APIEndpointConstants.GET_UPDATE_COLLECTED_RETURN_ACCESSORY_ENDPOINT,
        queryParameters: queryparams ?? {},
      );

      return EmployeeLockerDetailResponse.fromJson(
        response.data,
      );
    } catch (err, s) {
      debugPrint(err.toString());
      debugPrint(s.toString());

      return EmployeeLockerDetailResponse.withError(
          "Something went wrong, please try again later.");
    }
  }
}
