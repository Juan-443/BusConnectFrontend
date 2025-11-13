import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/user_model/user_model.dart';
import '../../core/constants/api_constants.dart';

part 'auth_api_provider.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class AuthApiProvider {
  factory AuthApiProvider(Dio dio, {String baseUrl}) = _AuthApiProvider;

  // ==================== AUTHENTICATION ====================

  @POST(ApiConstants.register)
  Future<AuthResponse> register(@Body() RegisterRequest request);

  @POST(ApiConstants.login)
  Future<AuthResponse> login(@Body() LoginRequest request);

  @POST(ApiConstants.loginPhone)
  Future<AuthResponse> loginWithPhone(@Body() PhoneLoginRequest request);

  @POST(ApiConstants.refresh)
  Future<AuthResponse> refreshToken(@Body() Map<String, String> request);

  @POST(ApiConstants.logout)
  Future<MessageResponse> logout(@Body() Map<String, String> request);

  @POST(ApiConstants.validateToken)
  Future<bool> validateToken(@Body() Map<String, String> request);

  // ==================== PROFILE ====================

  @GET(ApiConstants.me)
  Future<UserInfo> getCurrentUser();

  // ==================== PASSWORD MANAGEMENT ====================

  @POST(ApiConstants.changePassword)
  Future<MessageResponse> changePassword(@Body() ChangePasswordRequest request);

  @POST(ApiConstants.forgotPassword)
  Future<MessageResponse> forgotPassword(@Body() Map<String, String> request);

  @POST(ApiConstants.resetPassword)
  Future<MessageResponse> resetPassword(@Body() Map<String, String> request);
}