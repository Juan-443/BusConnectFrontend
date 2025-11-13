import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/user_model/user_model.dart';
import '../../core/constants/api_constants.dart';
import '../../core/constants/enums/user_role.dart';
import '../../core/constants/enums/user_status.dart';

part 'user_api_provider.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class UserApiProvider {
  factory UserApiProvider(Dio dio, {String baseUrl}) = _UserApiProvider;

  // ==================== USER PROFILE ====================

  @GET(ApiConstants.userMe)
  Future<UserModel> getMe();

  @PUT(ApiConstants.userUpdateMe)
  Future<UserModel> updateMe(@Body() UserSelfUpdateRequest request);

  @GET(ApiConstants.userMeComplete)
  Future<UserModel> getMeComplete();

  @PATCH(ApiConstants.userMePassword)
  Future<void> updateMyPassword(@Body() Map<String, dynamic> request);

  // ==================== USER CRUD ====================

  @GET('${ApiConstants.userById}/{id}')
  Future<UserModel> getUserById(@Path('id') int id);

  @GET('${ApiConstants.userByEmail}/{email}')
  Future<UserModel> getUserByEmail(@Path('email') String email);

  @GET('${ApiConstants.userByPhone}/{phone}')
  Future<UserModel> getUserByPhone(@Path('phone') String phone);

  @POST(ApiConstants.userCreate)
  Future<UserModel> createUser(@Body() Map<String, dynamic> request);

  @PUT('${ApiConstants.userUpdate}/{id}')
  Future<UserModel> updateUser(
      @Path('id') int id,
      @Body() Map<String, dynamic> request,
      );

  @DELETE('${ApiConstants.userDelete}/{id}')
  Future<void> deleteUser(@Path('id') int id);

  @PATCH('${ApiConstants.userChangeStatus}/{id}/status')
  Future<UserModel> changeUserStatus(
      @Path('id') int id,
      @Query('status') UserStatus status,
      );

  // ==================== USER QUERIES ====================

  @GET(ApiConstants.allUsers)
  Future<List<UserModel>> getAllUsers();

  @GET('${ApiConstants.usersByRole}/{role}')
  Future<List<UserModel>> getUsersByRole(@Path('role') UserRole role);

  @GET('${ApiConstants.usersByRoleAndStatus}/{role}/status/{status}')
  Future<List<UserModel>> getUsersByRoleAndStatus(
      @Path('role') UserRole role,
      @Path('status') UserStatus status,
      );

  @GET('${ApiConstants.activeUsersByRole}/{role}/active')
  Future<List<UserModel>> getActiveUsersByRole(@Path('role') UserRole role);

  // ==================== USER VALIDATION ====================

  @GET('${ApiConstants.userExistsByEmail}/{email}')
  Future<bool> existsByEmail(@Path('email') String email);

  @GET('${ApiConstants.userExistsByPhone}/{phone}')
  Future<bool> existsByPhone(@Path('phone') String phone);

  @POST(ApiConstants.userCheck)
  Future<dynamic> checkUser(@Body() Map<String, dynamic> request);
}