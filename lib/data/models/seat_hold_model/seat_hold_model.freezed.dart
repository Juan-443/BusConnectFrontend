// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seat_hold_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SeatHoldModel _$SeatHoldModelFromJson(Map<String, dynamic> json) {
  return _SeatHoldModel.fromJson(json);
}

/// @nodoc
mixin _$SeatHoldModel {
  int get id => throw _privateConstructorUsedError;
  String get expiresAt => throw _privateConstructorUsedError;
  String get seatNumber => throw _privateConstructorUsedError;
  HoldStatus get status => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  int get tripId => throw _privateConstructorUsedError;
  int get userId => throw _privateConstructorUsedError;

  /// Serializes this SeatHoldModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SeatHoldModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SeatHoldModelCopyWith<SeatHoldModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SeatHoldModelCopyWith<$Res> {
  factory $SeatHoldModelCopyWith(
    SeatHoldModel value,
    $Res Function(SeatHoldModel) then,
  ) = _$SeatHoldModelCopyWithImpl<$Res, SeatHoldModel>;
  @useResult
  $Res call({
    int id,
    String expiresAt,
    String seatNumber,
    HoldStatus status,
    String createdAt,
    int tripId,
    int userId,
  });
}

/// @nodoc
class _$SeatHoldModelCopyWithImpl<$Res, $Val extends SeatHoldModel>
    implements $SeatHoldModelCopyWith<$Res> {
  _$SeatHoldModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SeatHoldModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? expiresAt = null,
    Object? seatNumber = null,
    Object? status = null,
    Object? createdAt = null,
    Object? tripId = null,
    Object? userId = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            expiresAt: null == expiresAt
                ? _value.expiresAt
                : expiresAt // ignore: cast_nullable_to_non_nullable
                      as String,
            seatNumber: null == seatNumber
                ? _value.seatNumber
                : seatNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as HoldStatus,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String,
            tripId: null == tripId
                ? _value.tripId
                : tripId // ignore: cast_nullable_to_non_nullable
                      as int,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SeatHoldModelImplCopyWith<$Res>
    implements $SeatHoldModelCopyWith<$Res> {
  factory _$$SeatHoldModelImplCopyWith(
    _$SeatHoldModelImpl value,
    $Res Function(_$SeatHoldModelImpl) then,
  ) = __$$SeatHoldModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String expiresAt,
    String seatNumber,
    HoldStatus status,
    String createdAt,
    int tripId,
    int userId,
  });
}

/// @nodoc
class __$$SeatHoldModelImplCopyWithImpl<$Res>
    extends _$SeatHoldModelCopyWithImpl<$Res, _$SeatHoldModelImpl>
    implements _$$SeatHoldModelImplCopyWith<$Res> {
  __$$SeatHoldModelImplCopyWithImpl(
    _$SeatHoldModelImpl _value,
    $Res Function(_$SeatHoldModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SeatHoldModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? expiresAt = null,
    Object? seatNumber = null,
    Object? status = null,
    Object? createdAt = null,
    Object? tripId = null,
    Object? userId = null,
  }) {
    return _then(
      _$SeatHoldModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        expiresAt: null == expiresAt
            ? _value.expiresAt
            : expiresAt // ignore: cast_nullable_to_non_nullable
                  as String,
        seatNumber: null == seatNumber
            ? _value.seatNumber
            : seatNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as HoldStatus,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String,
        tripId: null == tripId
            ? _value.tripId
            : tripId // ignore: cast_nullable_to_non_nullable
                  as int,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SeatHoldModelImpl implements _SeatHoldModel {
  const _$SeatHoldModelImpl({
    required this.id,
    required this.expiresAt,
    required this.seatNumber,
    required this.status,
    required this.createdAt,
    required this.tripId,
    required this.userId,
  });

  factory _$SeatHoldModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SeatHoldModelImplFromJson(json);

  @override
  final int id;
  @override
  final String expiresAt;
  @override
  final String seatNumber;
  @override
  final HoldStatus status;
  @override
  final String createdAt;
  @override
  final int tripId;
  @override
  final int userId;

  @override
  String toString() {
    return 'SeatHoldModel(id: $id, expiresAt: $expiresAt, seatNumber: $seatNumber, status: $status, createdAt: $createdAt, tripId: $tripId, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SeatHoldModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.seatNumber, seatNumber) ||
                other.seatNumber == seatNumber) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.tripId, tripId) || other.tripId == tripId) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    expiresAt,
    seatNumber,
    status,
    createdAt,
    tripId,
    userId,
  );

  /// Create a copy of SeatHoldModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SeatHoldModelImplCopyWith<_$SeatHoldModelImpl> get copyWith =>
      __$$SeatHoldModelImplCopyWithImpl<_$SeatHoldModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SeatHoldModelImplToJson(this);
  }
}

abstract class _SeatHoldModel implements SeatHoldModel {
  const factory _SeatHoldModel({
    required final int id,
    required final String expiresAt,
    required final String seatNumber,
    required final HoldStatus status,
    required final String createdAt,
    required final int tripId,
    required final int userId,
  }) = _$SeatHoldModelImpl;

  factory _SeatHoldModel.fromJson(Map<String, dynamic> json) =
      _$SeatHoldModelImpl.fromJson;

  @override
  int get id;
  @override
  String get expiresAt;
  @override
  String get seatNumber;
  @override
  HoldStatus get status;
  @override
  String get createdAt;
  @override
  int get tripId;
  @override
  int get userId;

  /// Create a copy of SeatHoldModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SeatHoldModelImplCopyWith<_$SeatHoldModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SeatHoldCreateRequest _$SeatHoldCreateRequestFromJson(
  Map<String, dynamic> json,
) {
  return _SeatHoldCreateRequest.fromJson(json);
}

/// @nodoc
mixin _$SeatHoldCreateRequest {
  int get tripId => throw _privateConstructorUsedError;
  String get seatNumber => throw _privateConstructorUsedError;

  /// Serializes this SeatHoldCreateRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SeatHoldCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SeatHoldCreateRequestCopyWith<SeatHoldCreateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SeatHoldCreateRequestCopyWith<$Res> {
  factory $SeatHoldCreateRequestCopyWith(
    SeatHoldCreateRequest value,
    $Res Function(SeatHoldCreateRequest) then,
  ) = _$SeatHoldCreateRequestCopyWithImpl<$Res, SeatHoldCreateRequest>;
  @useResult
  $Res call({int tripId, String seatNumber});
}

/// @nodoc
class _$SeatHoldCreateRequestCopyWithImpl<
  $Res,
  $Val extends SeatHoldCreateRequest
>
    implements $SeatHoldCreateRequestCopyWith<$Res> {
  _$SeatHoldCreateRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SeatHoldCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? tripId = null, Object? seatNumber = null}) {
    return _then(
      _value.copyWith(
            tripId: null == tripId
                ? _value.tripId
                : tripId // ignore: cast_nullable_to_non_nullable
                      as int,
            seatNumber: null == seatNumber
                ? _value.seatNumber
                : seatNumber // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SeatHoldCreateRequestImplCopyWith<$Res>
    implements $SeatHoldCreateRequestCopyWith<$Res> {
  factory _$$SeatHoldCreateRequestImplCopyWith(
    _$SeatHoldCreateRequestImpl value,
    $Res Function(_$SeatHoldCreateRequestImpl) then,
  ) = __$$SeatHoldCreateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int tripId, String seatNumber});
}

/// @nodoc
class __$$SeatHoldCreateRequestImplCopyWithImpl<$Res>
    extends
        _$SeatHoldCreateRequestCopyWithImpl<$Res, _$SeatHoldCreateRequestImpl>
    implements _$$SeatHoldCreateRequestImplCopyWith<$Res> {
  __$$SeatHoldCreateRequestImplCopyWithImpl(
    _$SeatHoldCreateRequestImpl _value,
    $Res Function(_$SeatHoldCreateRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SeatHoldCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? tripId = null, Object? seatNumber = null}) {
    return _then(
      _$SeatHoldCreateRequestImpl(
        tripId: null == tripId
            ? _value.tripId
            : tripId // ignore: cast_nullable_to_non_nullable
                  as int,
        seatNumber: null == seatNumber
            ? _value.seatNumber
            : seatNumber // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SeatHoldCreateRequestImpl implements _SeatHoldCreateRequest {
  const _$SeatHoldCreateRequestImpl({
    required this.tripId,
    required this.seatNumber,
  });

  factory _$SeatHoldCreateRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$SeatHoldCreateRequestImplFromJson(json);

  @override
  final int tripId;
  @override
  final String seatNumber;

  @override
  String toString() {
    return 'SeatHoldCreateRequest(tripId: $tripId, seatNumber: $seatNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SeatHoldCreateRequestImpl &&
            (identical(other.tripId, tripId) || other.tripId == tripId) &&
            (identical(other.seatNumber, seatNumber) ||
                other.seatNumber == seatNumber));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, tripId, seatNumber);

  /// Create a copy of SeatHoldCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SeatHoldCreateRequestImplCopyWith<_$SeatHoldCreateRequestImpl>
  get copyWith =>
      __$$SeatHoldCreateRequestImplCopyWithImpl<_$SeatHoldCreateRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SeatHoldCreateRequestImplToJson(this);
  }
}

abstract class _SeatHoldCreateRequest implements SeatHoldCreateRequest {
  const factory _SeatHoldCreateRequest({
    required final int tripId,
    required final String seatNumber,
  }) = _$SeatHoldCreateRequestImpl;

  factory _SeatHoldCreateRequest.fromJson(Map<String, dynamic> json) =
      _$SeatHoldCreateRequestImpl.fromJson;

  @override
  int get tripId;
  @override
  String get seatNumber;

  /// Create a copy of SeatHoldCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SeatHoldCreateRequestImplCopyWith<_$SeatHoldCreateRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}

SeatHoldUpdateRequest _$SeatHoldUpdateRequestFromJson(
  Map<String, dynamic> json,
) {
  return _SeatHoldUpdateRequest.fromJson(json);
}

/// @nodoc
mixin _$SeatHoldUpdateRequest {
  String? get expiresAt => throw _privateConstructorUsedError;
  HoldStatus? get status => throw _privateConstructorUsedError;

  /// Serializes this SeatHoldUpdateRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SeatHoldUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SeatHoldUpdateRequestCopyWith<SeatHoldUpdateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SeatHoldUpdateRequestCopyWith<$Res> {
  factory $SeatHoldUpdateRequestCopyWith(
    SeatHoldUpdateRequest value,
    $Res Function(SeatHoldUpdateRequest) then,
  ) = _$SeatHoldUpdateRequestCopyWithImpl<$Res, SeatHoldUpdateRequest>;
  @useResult
  $Res call({String? expiresAt, HoldStatus? status});
}

/// @nodoc
class _$SeatHoldUpdateRequestCopyWithImpl<
  $Res,
  $Val extends SeatHoldUpdateRequest
>
    implements $SeatHoldUpdateRequestCopyWith<$Res> {
  _$SeatHoldUpdateRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SeatHoldUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? expiresAt = freezed, Object? status = freezed}) {
    return _then(
      _value.copyWith(
            expiresAt: freezed == expiresAt
                ? _value.expiresAt
                : expiresAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as HoldStatus?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SeatHoldUpdateRequestImplCopyWith<$Res>
    implements $SeatHoldUpdateRequestCopyWith<$Res> {
  factory _$$SeatHoldUpdateRequestImplCopyWith(
    _$SeatHoldUpdateRequestImpl value,
    $Res Function(_$SeatHoldUpdateRequestImpl) then,
  ) = __$$SeatHoldUpdateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? expiresAt, HoldStatus? status});
}

/// @nodoc
class __$$SeatHoldUpdateRequestImplCopyWithImpl<$Res>
    extends
        _$SeatHoldUpdateRequestCopyWithImpl<$Res, _$SeatHoldUpdateRequestImpl>
    implements _$$SeatHoldUpdateRequestImplCopyWith<$Res> {
  __$$SeatHoldUpdateRequestImplCopyWithImpl(
    _$SeatHoldUpdateRequestImpl _value,
    $Res Function(_$SeatHoldUpdateRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SeatHoldUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? expiresAt = freezed, Object? status = freezed}) {
    return _then(
      _$SeatHoldUpdateRequestImpl(
        expiresAt: freezed == expiresAt
            ? _value.expiresAt
            : expiresAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: freezed == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as HoldStatus?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SeatHoldUpdateRequestImpl implements _SeatHoldUpdateRequest {
  const _$SeatHoldUpdateRequestImpl({this.expiresAt, this.status});

  factory _$SeatHoldUpdateRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$SeatHoldUpdateRequestImplFromJson(json);

  @override
  final String? expiresAt;
  @override
  final HoldStatus? status;

  @override
  String toString() {
    return 'SeatHoldUpdateRequest(expiresAt: $expiresAt, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SeatHoldUpdateRequestImpl &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, expiresAt, status);

  /// Create a copy of SeatHoldUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SeatHoldUpdateRequestImplCopyWith<_$SeatHoldUpdateRequestImpl>
  get copyWith =>
      __$$SeatHoldUpdateRequestImplCopyWithImpl<_$SeatHoldUpdateRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SeatHoldUpdateRequestImplToJson(this);
  }
}

abstract class _SeatHoldUpdateRequest implements SeatHoldUpdateRequest {
  const factory _SeatHoldUpdateRequest({
    final String? expiresAt,
    final HoldStatus? status,
  }) = _$SeatHoldUpdateRequestImpl;

  factory _SeatHoldUpdateRequest.fromJson(Map<String, dynamic> json) =
      _$SeatHoldUpdateRequestImpl.fromJson;

  @override
  String? get expiresAt;
  @override
  HoldStatus? get status;

  /// Create a copy of SeatHoldUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SeatHoldUpdateRequestImplCopyWith<_$SeatHoldUpdateRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}
