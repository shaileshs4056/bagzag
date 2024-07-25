import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../core/api/base_response/base_response.dart';
import '../model/request/login_request_model.dart';
import '../model/response/user_profile_response.dart';

part 'auth_api.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio) = _AuthApi;

  @POST('/user_authentication/signin')
  Future<BaseResponse<UserData?>> signIn(@Body() LoginRequestModel request);

  @POST('/user_authentication/logout')
  Future<BaseResponse> logout();
}
