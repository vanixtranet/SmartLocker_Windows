import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smart_locker_windows/data/models/user_models/user_model.dart';

import '../../../constants/api_endpoints.dart';

part 'authentication_repositories.dart';

abstract class AbstractAuthenticationRepository {
  AbstractAuthenticationRepository();

  Future<UserModel> authenticateUser({
    Map<String, dynamic>? queryparams,
  });

  Future<bool> postSendUnauthorizedAccessAlert({
    Map<String, dynamic>? queryparams,
  });
}
