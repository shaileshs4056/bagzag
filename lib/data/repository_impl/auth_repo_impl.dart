

import '../../core/api/base_response/base_response.dart';
import '../../core/locator/locator.dart';
import '../model/request/login_request_model.dart';
import '../model/response/user_profile_response.dart';
import '../remote/auth_api.dart';
import '../repository/auth_repo.dart';

class AuthRepoImpl extends AuthRepository {
  AuthApi authApi;

  AuthRepoImpl({required this.authApi});

  @override
  Future<BaseResponse<UserData?>> signIn(LoginRequestModel request) async {
    final BaseResponse<UserData?> response = await authApi.signIn(request);
    return response;
  }

  @override
  Future<BaseResponse> logout() async {
    final BaseResponse response = await authApi.logout();
    return response;
  }
}

final authRepo = locator<AuthRepoImpl>();
