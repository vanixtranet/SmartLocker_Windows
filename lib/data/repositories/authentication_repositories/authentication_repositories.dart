part of 'abstract_authentication_repositories.dart';

class AuthenticationRepository {
  final Dio _dio = Dio();

  Future<UserModel> authenticateUser({
    Map<String, dynamic>? queryparams,
  }) async {
    try {
      Response response = await _dio.get(
        APIEndpointConstants.AUTHENTICATE_ENDPOINT,
        queryParameters: queryparams ?? {},
      );

      return UserModel.fromJson(
        response.data,
      );
    } catch (err, s) {
      debugPrint(err.toString());
      debugPrint(s.toString());

      return UserModel();
    }
  }

  Future<bool> postSendUnauthorizedAccessAlert({
    Map<String, dynamic>? queryparams,
  }) async {
    try {
      Response response = await _dio.post(
        APIEndpointConstants.SEND_UNAUTHORIZED_ACCESS_ALERT,
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
