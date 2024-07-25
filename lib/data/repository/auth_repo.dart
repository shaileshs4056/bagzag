import '../../core/api/base_response/base_response.dart';
import '../model/request/login_request_model.dart';
import '../model/response/user_profile_response.dart';

abstract class AuthRepository {
  Future<BaseResponse<UserData?>> signIn(LoginRequestModel request);

  Future<BaseResponse> logout();
}
