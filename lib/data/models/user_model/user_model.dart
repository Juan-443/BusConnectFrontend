import 'package:bus_connect/core/constants/enums/user_role.dart';
import 'package:bus_connect/core/constants/enums/user_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

// Para campos obligatorios
String _dateToJsonNonNull(DateTime date) =>
    DateFormat('yyyy-MM-dd').format(date);
DateTime _dateFromJsonNonNull(String date) =>
    DateTime.parse(date);

// Para campos opcionales
String? _dateToJsonNullable(DateTime? date) =>
    date != null ? DateFormat('yyyy-MM-dd').format(date) : null;
DateTime? _dateFromJsonNullable(String? date) =>
    date != null ? DateTime.parse(date) : null;
@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required int id,
    required String username,
    required String email,
    required String phone,
    required UserRole role,
    required UserStatus status,
    @JsonKey(
      toJson: _dateToJsonNonNull,
      fromJson: _dateFromJsonNonNull,
    )
     required DateTime dateOfBirth,
    required DateTime createdAt,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

// DTO para registro
@freezed
class RegisterRequest with _$RegisterRequest {
  const factory RegisterRequest({
    required String username,
    required String email,
    required String phone,
    required String password,
    @JsonKey(
      name: 'dateOfBirth',
      toJson: _dateToJsonNonNull,
      fromJson: _dateFromJsonNonNull,
    )
    required DateTime dateOfBirth, // "YYYY-MM-DD"
    required UserRole role,
  }) = _RegisterRequest;

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);
}

// DTO para login
@freezed
class LoginRequest with _$LoginRequest {
  const factory LoginRequest({
    required String email,
    required String password,
  }) = _LoginRequest;

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);
}

// DTO para login con teléfono
@freezed
class PhoneLoginRequest with _$PhoneLoginRequest {
  const factory PhoneLoginRequest({
    required String phone,
    required String password,
  }) = _PhoneLoginRequest;

  factory PhoneLoginRequest.fromJson(Map<String, dynamic> json) =>
      _$PhoneLoginRequestFromJson(json);
}

// DTO para respuesta de autenticación
@freezed
class AuthResponse with _$AuthResponse {
  const factory AuthResponse({
    required String accessToken,
    required String refreshToken,
    required String tokenType,
    required UserInfo user,
  }) = _AuthResponse;

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);
}

// DTO para información de usuario
@freezed
class UserInfo with _$UserInfo {
  const factory UserInfo({
    required int id,
    required String username,
    required String email,
    required String phone,
    required UserRole role,
    required UserStatus status,
  }) = _UserInfo;

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);
}

// DTO para cambiar contraseña
@freezed
class ChangePasswordRequest with _$ChangePasswordRequest {
  const factory ChangePasswordRequest({
    required String currentPassword,
    required String newPassword,
  }) = _ChangePasswordRequest;

  factory ChangePasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordRequestFromJson(json);
}

// DTO para actualizar perfil
@freezed
class UserSelfUpdateRequest with _$UserSelfUpdateRequest {
  const factory UserSelfUpdateRequest({
    required String username,
    required String phone,
    required String email,
  }) = _UserSelfUpdateRequest;

  factory UserSelfUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$UserSelfUpdateRequestFromJson(json);
}


// DTO usado por ADMIN para crear usuarios
@freezed
class UserCreateRequest with _$UserCreateRequest {
  const factory UserCreateRequest({
    required String username,
    required String email,
    required String phone,
    required String password,
    required UserRole role,
    @Default(UserStatus.ACTIVE) UserStatus status,
    @JsonKey(
      name: 'dateOfBirth',
      toJson: _dateToJsonNonNull,
      fromJson: _dateFromJsonNonNull,
    )
    required DateTime dateOfBirth,
  }) = _UserCreateRequest;

  factory UserCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$UserCreateRequestFromJson(json);
}

// DTO usado por ADMIN para actualizar usuarios existentes
@freezed
class UserUpdateRequest with _$UserUpdateRequest {
  @JsonSerializable(
    explicitToJson: true,
    includeIfNull: false,
  )
  const factory UserUpdateRequest({
    String? username,
    String? email,
    String? phone,
    String? password,
    UserRole? role,
    UserStatus? status,
    @JsonKey(
      name: 'dateOfBirth',
      toJson: _dateToJsonNullable,
      fromJson: _dateFromJsonNullable,
    )
    DateTime? dateOfBirth,
  }) = _UserUpdateRequest;

  factory UserUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$UserUpdateRequestFromJson(json);
}


// Respuesta genérica
@freezed
class MessageResponse with _$MessageResponse {
  const factory MessageResponse({required String message}) = _MessageResponse;

  factory MessageResponse.fromJson(Map<String, dynamic> json) =>
      _$MessageResponseFromJson(json);
}
typedef UserResponse = UserModel;
