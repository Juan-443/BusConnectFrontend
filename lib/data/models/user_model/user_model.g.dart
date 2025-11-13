// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: (json['id'] as num).toInt(),
      username: json['username'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      role: $enumDecode(_$UserRoleEnumMap, json['role']),
      status: $enumDecode(_$UserStatusEnumMap, json['status']),
      dateOfBirth: _dateFromJsonNonNull(json['dateOfBirth'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'phone': instance.phone,
      'role': _$UserRoleEnumMap[instance.role]!,
      'status': _$UserStatusEnumMap[instance.status]!,
      'dateOfBirth': _dateToJsonNonNull(instance.dateOfBirth),
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$UserRoleEnumMap = {
  UserRole.PASSENGER: 'PASSENGER',
  UserRole.CLERK: 'CLERK',
  UserRole.DRIVER: 'DRIVER',
  UserRole.DISPATCHER: 'DISPATCHER',
  UserRole.ADMIN: 'ADMIN',
};

const _$UserStatusEnumMap = {
  UserStatus.ACTIVE: 'ACTIVE',
  UserStatus.INACTIVE: 'INACTIVE',
  UserStatus.BLOCKED: 'BLOCKED',
};

_$RegisterRequestImpl _$$RegisterRequestImplFromJson(
  Map<String, dynamic> json,
) => _$RegisterRequestImpl(
  username: json['username'] as String,
  email: json['email'] as String,
  phone: json['phone'] as String,
  password: json['password'] as String,
  dateOfBirth: _dateFromJsonNonNull(json['dateOfBirth'] as String),
  role: $enumDecode(_$UserRoleEnumMap, json['role']),
);

Map<String, dynamic> _$$RegisterRequestImplToJson(
  _$RegisterRequestImpl instance,
) => <String, dynamic>{
  'username': instance.username,
  'email': instance.email,
  'phone': instance.phone,
  'password': instance.password,
  'dateOfBirth': _dateToJsonNonNull(instance.dateOfBirth),
  'role': _$UserRoleEnumMap[instance.role]!,
};

_$LoginRequestImpl _$$LoginRequestImplFromJson(Map<String, dynamic> json) =>
    _$LoginRequestImpl(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$$LoginRequestImplToJson(_$LoginRequestImpl instance) =>
    <String, dynamic>{'email': instance.email, 'password': instance.password};

_$PhoneLoginRequestImpl _$$PhoneLoginRequestImplFromJson(
  Map<String, dynamic> json,
) => _$PhoneLoginRequestImpl(
  phone: json['phone'] as String,
  password: json['password'] as String,
);

Map<String, dynamic> _$$PhoneLoginRequestImplToJson(
  _$PhoneLoginRequestImpl instance,
) => <String, dynamic>{'phone': instance.phone, 'password': instance.password};

_$AuthResponseImpl _$$AuthResponseImplFromJson(Map<String, dynamic> json) =>
    _$AuthResponseImpl(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      tokenType: json['tokenType'] as String,
      user: UserInfo.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AuthResponseImplToJson(_$AuthResponseImpl instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'tokenType': instance.tokenType,
      'user': instance.user,
    };

_$UserInfoImpl _$$UserInfoImplFromJson(Map<String, dynamic> json) =>
    _$UserInfoImpl(
      id: (json['id'] as num).toInt(),
      username: json['username'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      role: $enumDecode(_$UserRoleEnumMap, json['role']),
      status: $enumDecode(_$UserStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$$UserInfoImplToJson(_$UserInfoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'phone': instance.phone,
      'role': _$UserRoleEnumMap[instance.role]!,
      'status': _$UserStatusEnumMap[instance.status]!,
    };

_$ChangePasswordRequestImpl _$$ChangePasswordRequestImplFromJson(
  Map<String, dynamic> json,
) => _$ChangePasswordRequestImpl(
  currentPassword: json['currentPassword'] as String,
  newPassword: json['newPassword'] as String,
);

Map<String, dynamic> _$$ChangePasswordRequestImplToJson(
  _$ChangePasswordRequestImpl instance,
) => <String, dynamic>{
  'currentPassword': instance.currentPassword,
  'newPassword': instance.newPassword,
};

_$UserSelfUpdateRequestImpl _$$UserSelfUpdateRequestImplFromJson(
  Map<String, dynamic> json,
) => _$UserSelfUpdateRequestImpl(
  username: json['username'] as String?,
  phone: json['phone'] as String?,
  dateOfBirth: json['dateOfBirth'] as String?,
);

Map<String, dynamic> _$$UserSelfUpdateRequestImplToJson(
  _$UserSelfUpdateRequestImpl instance,
) => <String, dynamic>{
  'username': instance.username,
  'phone': instance.phone,
  'dateOfBirth': instance.dateOfBirth,
};

_$UserCreateRequestImpl _$$UserCreateRequestImplFromJson(
  Map<String, dynamic> json,
) => _$UserCreateRequestImpl(
  username: json['username'] as String,
  email: json['email'] as String,
  phone: json['phone'] as String,
  password: json['password'] as String,
  role: $enumDecode(_$UserRoleEnumMap, json['role']),
  status:
      $enumDecodeNullable(_$UserStatusEnumMap, json['status']) ??
      UserStatus.ACTIVE,
  dateOfBirth: _dateFromJsonNonNull(json['dateOfBirth'] as String),
);

Map<String, dynamic> _$$UserCreateRequestImplToJson(
  _$UserCreateRequestImpl instance,
) => <String, dynamic>{
  'username': instance.username,
  'email': instance.email,
  'phone': instance.phone,
  'password': instance.password,
  'role': _$UserRoleEnumMap[instance.role]!,
  'status': _$UserStatusEnumMap[instance.status]!,
  'dateOfBirth': _dateToJsonNonNull(instance.dateOfBirth),
};

_$UserUpdateRequestImpl _$$UserUpdateRequestImplFromJson(
  Map<String, dynamic> json,
) => _$UserUpdateRequestImpl(
  username: json['username'] as String?,
  email: json['email'] as String?,
  phone: json['phone'] as String?,
  password: json['password'] as String?,
  role: $enumDecodeNullable(_$UserRoleEnumMap, json['role']),
  status: $enumDecodeNullable(_$UserStatusEnumMap, json['status']),
  dateOfBirth: _dateFromJsonNullable(json['dateOfBirth'] as String?),
);

Map<String, dynamic> _$$UserUpdateRequestImplToJson(
  _$UserUpdateRequestImpl instance,
) => <String, dynamic>{
  'username': instance.username,
  'email': instance.email,
  'phone': instance.phone,
  'password': instance.password,
  'role': _$UserRoleEnumMap[instance.role],
  'status': _$UserStatusEnumMap[instance.status],
  'dateOfBirth': _dateToJsonNullable(instance.dateOfBirth),
};

_$MessageResponseImpl _$$MessageResponseImplFromJson(
  Map<String, dynamic> json,
) => _$MessageResponseImpl(message: json['message'] as String);

Map<String, dynamic> _$$MessageResponseImplToJson(
  _$MessageResponseImpl instance,
) => <String, dynamic>{'message': instance.message};
