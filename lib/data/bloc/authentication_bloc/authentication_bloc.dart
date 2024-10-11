import '../../models/user_models/user_model.dart';
import '../../repositories/authentication_repositories/abstract_authentication_repositories.dart';

class AuthenticationBloc {
  final AuthenticationRepository _repository = AuthenticationRepository();

  Future<UserModel> authenticateUser({
    Map<String, dynamic>? queryparams,
  }) async {
    UserModel response = await _repository.authenticateUser(
      queryparams: queryparams,
    );

    return response;
  }

  Future<bool> postSendUnauthorizedAccessAlert({
    Map<String, dynamic>? queryparams,
  }) async {
    bool response = await _repository.postSendUnauthorizedAccessAlert(
      queryparams: queryparams,
    );

    return response;
  }
}

final authenticationBloc = AuthenticationBloc();
