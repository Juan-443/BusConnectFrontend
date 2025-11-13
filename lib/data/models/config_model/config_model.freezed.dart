// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'config_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ConfigModel _$ConfigModelFromJson(Map<String, dynamic> json) {
  return _ConfigModel.fromJson(json);
}

/// @nodoc
mixin _$ConfigModel {
  int get id => throw _privateConstructorUsedError;
  String get key => throw _privateConstructorUsedError;
  String get value => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this ConfigModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ConfigModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConfigModelCopyWith<ConfigModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConfigModelCopyWith<$Res> {
  factory $ConfigModelCopyWith(
    ConfigModel value,
    $Res Function(ConfigModel) then,
  ) = _$ConfigModelCopyWithImpl<$Res, ConfigModel>;
  @useResult
  $Res call({
    int id,
    String key,
    String value,
    String? description,
    String? updatedAt,
  });
}

/// @nodoc
class _$ConfigModelCopyWithImpl<$Res, $Val extends ConfigModel>
    implements $ConfigModelCopyWith<$Res> {
  _$ConfigModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConfigModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? key = null,
    Object? value = null,
    Object? description = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            key: null == key
                ? _value.key
                : key // ignore: cast_nullable_to_non_nullable
                      as String,
            value: null == value
                ? _value.value
                : value // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ConfigModelImplCopyWith<$Res>
    implements $ConfigModelCopyWith<$Res> {
  factory _$$ConfigModelImplCopyWith(
    _$ConfigModelImpl value,
    $Res Function(_$ConfigModelImpl) then,
  ) = __$$ConfigModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String key,
    String value,
    String? description,
    String? updatedAt,
  });
}

/// @nodoc
class __$$ConfigModelImplCopyWithImpl<$Res>
    extends _$ConfigModelCopyWithImpl<$Res, _$ConfigModelImpl>
    implements _$$ConfigModelImplCopyWith<$Res> {
  __$$ConfigModelImplCopyWithImpl(
    _$ConfigModelImpl _value,
    $Res Function(_$ConfigModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConfigModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? key = null,
    Object? value = null,
    Object? description = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$ConfigModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        key: null == key
            ? _value.key
            : key // ignore: cast_nullable_to_non_nullable
                  as String,
        value: null == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ConfigModelImpl implements _ConfigModel {
  const _$ConfigModelImpl({
    required this.id,
    required this.key,
    required this.value,
    this.description,
    this.updatedAt,
  });

  factory _$ConfigModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConfigModelImplFromJson(json);

  @override
  final int id;
  @override
  final String key;
  @override
  final String value;
  @override
  final String? description;
  @override
  final String? updatedAt;

  @override
  String toString() {
    return 'ConfigModel(id: $id, key: $key, value: $value, description: $description, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfigModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, key, value, description, updatedAt);

  /// Create a copy of ConfigModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConfigModelImplCopyWith<_$ConfigModelImpl> get copyWith =>
      __$$ConfigModelImplCopyWithImpl<_$ConfigModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConfigModelImplToJson(this);
  }
}

abstract class _ConfigModel implements ConfigModel {
  const factory _ConfigModel({
    required final int id,
    required final String key,
    required final String value,
    final String? description,
    final String? updatedAt,
  }) = _$ConfigModelImpl;

  factory _ConfigModel.fromJson(Map<String, dynamic> json) =
      _$ConfigModelImpl.fromJson;

  @override
  int get id;
  @override
  String get key;
  @override
  String get value;
  @override
  String? get description;
  @override
  String? get updatedAt;

  /// Create a copy of ConfigModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConfigModelImplCopyWith<_$ConfigModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ConfigCreateRequest _$ConfigCreateRequestFromJson(Map<String, dynamic> json) {
  return _ConfigCreateRequest.fromJson(json);
}

/// @nodoc
mixin _$ConfigCreateRequest {
  String get key => throw _privateConstructorUsedError;
  String get value => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  /// Serializes this ConfigCreateRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ConfigCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConfigCreateRequestCopyWith<ConfigCreateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConfigCreateRequestCopyWith<$Res> {
  factory $ConfigCreateRequestCopyWith(
    ConfigCreateRequest value,
    $Res Function(ConfigCreateRequest) then,
  ) = _$ConfigCreateRequestCopyWithImpl<$Res, ConfigCreateRequest>;
  @useResult
  $Res call({String key, String value, String? description});
}

/// @nodoc
class _$ConfigCreateRequestCopyWithImpl<$Res, $Val extends ConfigCreateRequest>
    implements $ConfigCreateRequestCopyWith<$Res> {
  _$ConfigCreateRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConfigCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? value = null,
    Object? description = freezed,
  }) {
    return _then(
      _value.copyWith(
            key: null == key
                ? _value.key
                : key // ignore: cast_nullable_to_non_nullable
                      as String,
            value: null == value
                ? _value.value
                : value // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ConfigCreateRequestImplCopyWith<$Res>
    implements $ConfigCreateRequestCopyWith<$Res> {
  factory _$$ConfigCreateRequestImplCopyWith(
    _$ConfigCreateRequestImpl value,
    $Res Function(_$ConfigCreateRequestImpl) then,
  ) = __$$ConfigCreateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String key, String value, String? description});
}

/// @nodoc
class __$$ConfigCreateRequestImplCopyWithImpl<$Res>
    extends _$ConfigCreateRequestCopyWithImpl<$Res, _$ConfigCreateRequestImpl>
    implements _$$ConfigCreateRequestImplCopyWith<$Res> {
  __$$ConfigCreateRequestImplCopyWithImpl(
    _$ConfigCreateRequestImpl _value,
    $Res Function(_$ConfigCreateRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConfigCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? value = null,
    Object? description = freezed,
  }) {
    return _then(
      _$ConfigCreateRequestImpl(
        key: null == key
            ? _value.key
            : key // ignore: cast_nullable_to_non_nullable
                  as String,
        value: null == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ConfigCreateRequestImpl implements _ConfigCreateRequest {
  const _$ConfigCreateRequestImpl({
    required this.key,
    required this.value,
    this.description,
  });

  factory _$ConfigCreateRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConfigCreateRequestImplFromJson(json);

  @override
  final String key;
  @override
  final String value;
  @override
  final String? description;

  @override
  String toString() {
    return 'ConfigCreateRequest(key: $key, value: $value, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfigCreateRequestImpl &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, key, value, description);

  /// Create a copy of ConfigCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConfigCreateRequestImplCopyWith<_$ConfigCreateRequestImpl> get copyWith =>
      __$$ConfigCreateRequestImplCopyWithImpl<_$ConfigCreateRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ConfigCreateRequestImplToJson(this);
  }
}

abstract class _ConfigCreateRequest implements ConfigCreateRequest {
  const factory _ConfigCreateRequest({
    required final String key,
    required final String value,
    final String? description,
  }) = _$ConfigCreateRequestImpl;

  factory _ConfigCreateRequest.fromJson(Map<String, dynamic> json) =
      _$ConfigCreateRequestImpl.fromJson;

  @override
  String get key;
  @override
  String get value;
  @override
  String? get description;

  /// Create a copy of ConfigCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConfigCreateRequestImplCopyWith<_$ConfigCreateRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ConfigUpdateRequest _$ConfigUpdateRequestFromJson(Map<String, dynamic> json) {
  return _ConfigUpdateRequest.fromJson(json);
}

/// @nodoc
mixin _$ConfigUpdateRequest {
  String? get value => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  /// Serializes this ConfigUpdateRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ConfigUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConfigUpdateRequestCopyWith<ConfigUpdateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConfigUpdateRequestCopyWith<$Res> {
  factory $ConfigUpdateRequestCopyWith(
    ConfigUpdateRequest value,
    $Res Function(ConfigUpdateRequest) then,
  ) = _$ConfigUpdateRequestCopyWithImpl<$Res, ConfigUpdateRequest>;
  @useResult
  $Res call({String? value, String? description});
}

/// @nodoc
class _$ConfigUpdateRequestCopyWithImpl<$Res, $Val extends ConfigUpdateRequest>
    implements $ConfigUpdateRequestCopyWith<$Res> {
  _$ConfigUpdateRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConfigUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? value = freezed, Object? description = freezed}) {
    return _then(
      _value.copyWith(
            value: freezed == value
                ? _value.value
                : value // ignore: cast_nullable_to_non_nullable
                      as String?,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ConfigUpdateRequestImplCopyWith<$Res>
    implements $ConfigUpdateRequestCopyWith<$Res> {
  factory _$$ConfigUpdateRequestImplCopyWith(
    _$ConfigUpdateRequestImpl value,
    $Res Function(_$ConfigUpdateRequestImpl) then,
  ) = __$$ConfigUpdateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? value, String? description});
}

/// @nodoc
class __$$ConfigUpdateRequestImplCopyWithImpl<$Res>
    extends _$ConfigUpdateRequestCopyWithImpl<$Res, _$ConfigUpdateRequestImpl>
    implements _$$ConfigUpdateRequestImplCopyWith<$Res> {
  __$$ConfigUpdateRequestImplCopyWithImpl(
    _$ConfigUpdateRequestImpl _value,
    $Res Function(_$ConfigUpdateRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConfigUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? value = freezed, Object? description = freezed}) {
    return _then(
      _$ConfigUpdateRequestImpl(
        value: freezed == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as String?,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ConfigUpdateRequestImpl implements _ConfigUpdateRequest {
  const _$ConfigUpdateRequestImpl({this.value, this.description});

  factory _$ConfigUpdateRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConfigUpdateRequestImplFromJson(json);

  @override
  final String? value;
  @override
  final String? description;

  @override
  String toString() {
    return 'ConfigUpdateRequest(value: $value, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfigUpdateRequestImpl &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, value, description);

  /// Create a copy of ConfigUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConfigUpdateRequestImplCopyWith<_$ConfigUpdateRequestImpl> get copyWith =>
      __$$ConfigUpdateRequestImplCopyWithImpl<_$ConfigUpdateRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ConfigUpdateRequestImplToJson(this);
  }
}

abstract class _ConfigUpdateRequest implements ConfigUpdateRequest {
  const factory _ConfigUpdateRequest({
    final String? value,
    final String? description,
  }) = _$ConfigUpdateRequestImpl;

  factory _ConfigUpdateRequest.fromJson(Map<String, dynamic> json) =
      _$ConfigUpdateRequestImpl.fromJson;

  @override
  String? get value;
  @override
  String? get description;

  /// Create a copy of ConfigUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConfigUpdateRequestImplCopyWith<_$ConfigUpdateRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
