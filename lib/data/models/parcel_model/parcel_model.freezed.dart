// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'parcel_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ParcelModel _$ParcelModelFromJson(Map<String, dynamic> json) {
  return _ParcelModel.fromJson(json);
}

/// @nodoc
mixin _$ParcelModel {
  int get id => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  String get senderName => throw _privateConstructorUsedError;
  String get senderPhone => throw _privateConstructorUsedError;
  String get receiverName => throw _privateConstructorUsedError;
  String get receiverPhone => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  ParcelStatus get status => throw _privateConstructorUsedError;
  String? get proofPhotoUrl => throw _privateConstructorUsedError;
  String? get deliveryOtp => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  String? get deliveredAt => throw _privateConstructorUsedError;
  int get fromStopId => throw _privateConstructorUsedError;
  int get toStopId => throw _privateConstructorUsedError;
  int? get tripId => throw _privateConstructorUsedError;
  StopModel? get fromStop => throw _privateConstructorUsedError;
  StopModel? get toStop => throw _privateConstructorUsedError;

  /// Serializes this ParcelModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ParcelModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ParcelModelCopyWith<ParcelModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParcelModelCopyWith<$Res> {
  factory $ParcelModelCopyWith(
    ParcelModel value,
    $Res Function(ParcelModel) then,
  ) = _$ParcelModelCopyWithImpl<$Res, ParcelModel>;
  @useResult
  $Res call({
    int id,
    String code,
    String senderName,
    String senderPhone,
    String receiverName,
    String receiverPhone,
    double price,
    ParcelStatus status,
    String? proofPhotoUrl,
    String? deliveryOtp,
    String createdAt,
    String? deliveredAt,
    int fromStopId,
    int toStopId,
    int? tripId,
    StopModel? fromStop,
    StopModel? toStop,
  });

  $StopModelCopyWith<$Res>? get fromStop;
  $StopModelCopyWith<$Res>? get toStop;
}

/// @nodoc
class _$ParcelModelCopyWithImpl<$Res, $Val extends ParcelModel>
    implements $ParcelModelCopyWith<$Res> {
  _$ParcelModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ParcelModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? code = null,
    Object? senderName = null,
    Object? senderPhone = null,
    Object? receiverName = null,
    Object? receiverPhone = null,
    Object? price = null,
    Object? status = null,
    Object? proofPhotoUrl = freezed,
    Object? deliveryOtp = freezed,
    Object? createdAt = null,
    Object? deliveredAt = freezed,
    Object? fromStopId = null,
    Object? toStopId = null,
    Object? tripId = freezed,
    Object? fromStop = freezed,
    Object? toStop = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            code: null == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                      as String,
            senderName: null == senderName
                ? _value.senderName
                : senderName // ignore: cast_nullable_to_non_nullable
                      as String,
            senderPhone: null == senderPhone
                ? _value.senderPhone
                : senderPhone // ignore: cast_nullable_to_non_nullable
                      as String,
            receiverName: null == receiverName
                ? _value.receiverName
                : receiverName // ignore: cast_nullable_to_non_nullable
                      as String,
            receiverPhone: null == receiverPhone
                ? _value.receiverPhone
                : receiverPhone // ignore: cast_nullable_to_non_nullable
                      as String,
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as double,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as ParcelStatus,
            proofPhotoUrl: freezed == proofPhotoUrl
                ? _value.proofPhotoUrl
                : proofPhotoUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            deliveryOtp: freezed == deliveryOtp
                ? _value.deliveryOtp
                : deliveryOtp // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String,
            deliveredAt: freezed == deliveredAt
                ? _value.deliveredAt
                : deliveredAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            fromStopId: null == fromStopId
                ? _value.fromStopId
                : fromStopId // ignore: cast_nullable_to_non_nullable
                      as int,
            toStopId: null == toStopId
                ? _value.toStopId
                : toStopId // ignore: cast_nullable_to_non_nullable
                      as int,
            tripId: freezed == tripId
                ? _value.tripId
                : tripId // ignore: cast_nullable_to_non_nullable
                      as int?,
            fromStop: freezed == fromStop
                ? _value.fromStop
                : fromStop // ignore: cast_nullable_to_non_nullable
                      as StopModel?,
            toStop: freezed == toStop
                ? _value.toStop
                : toStop // ignore: cast_nullable_to_non_nullable
                      as StopModel?,
          )
          as $Val,
    );
  }

  /// Create a copy of ParcelModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StopModelCopyWith<$Res>? get fromStop {
    if (_value.fromStop == null) {
      return null;
    }

    return $StopModelCopyWith<$Res>(_value.fromStop!, (value) {
      return _then(_value.copyWith(fromStop: value) as $Val);
    });
  }

  /// Create a copy of ParcelModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StopModelCopyWith<$Res>? get toStop {
    if (_value.toStop == null) {
      return null;
    }

    return $StopModelCopyWith<$Res>(_value.toStop!, (value) {
      return _then(_value.copyWith(toStop: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ParcelModelImplCopyWith<$Res>
    implements $ParcelModelCopyWith<$Res> {
  factory _$$ParcelModelImplCopyWith(
    _$ParcelModelImpl value,
    $Res Function(_$ParcelModelImpl) then,
  ) = __$$ParcelModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String code,
    String senderName,
    String senderPhone,
    String receiverName,
    String receiverPhone,
    double price,
    ParcelStatus status,
    String? proofPhotoUrl,
    String? deliveryOtp,
    String createdAt,
    String? deliveredAt,
    int fromStopId,
    int toStopId,
    int? tripId,
    StopModel? fromStop,
    StopModel? toStop,
  });

  @override
  $StopModelCopyWith<$Res>? get fromStop;
  @override
  $StopModelCopyWith<$Res>? get toStop;
}

/// @nodoc
class __$$ParcelModelImplCopyWithImpl<$Res>
    extends _$ParcelModelCopyWithImpl<$Res, _$ParcelModelImpl>
    implements _$$ParcelModelImplCopyWith<$Res> {
  __$$ParcelModelImplCopyWithImpl(
    _$ParcelModelImpl _value,
    $Res Function(_$ParcelModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ParcelModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? code = null,
    Object? senderName = null,
    Object? senderPhone = null,
    Object? receiverName = null,
    Object? receiverPhone = null,
    Object? price = null,
    Object? status = null,
    Object? proofPhotoUrl = freezed,
    Object? deliveryOtp = freezed,
    Object? createdAt = null,
    Object? deliveredAt = freezed,
    Object? fromStopId = null,
    Object? toStopId = null,
    Object? tripId = freezed,
    Object? fromStop = freezed,
    Object? toStop = freezed,
  }) {
    return _then(
      _$ParcelModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        code: null == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String,
        senderName: null == senderName
            ? _value.senderName
            : senderName // ignore: cast_nullable_to_non_nullable
                  as String,
        senderPhone: null == senderPhone
            ? _value.senderPhone
            : senderPhone // ignore: cast_nullable_to_non_nullable
                  as String,
        receiverName: null == receiverName
            ? _value.receiverName
            : receiverName // ignore: cast_nullable_to_non_nullable
                  as String,
        receiverPhone: null == receiverPhone
            ? _value.receiverPhone
            : receiverPhone // ignore: cast_nullable_to_non_nullable
                  as String,
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as double,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as ParcelStatus,
        proofPhotoUrl: freezed == proofPhotoUrl
            ? _value.proofPhotoUrl
            : proofPhotoUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        deliveryOtp: freezed == deliveryOtp
            ? _value.deliveryOtp
            : deliveryOtp // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String,
        deliveredAt: freezed == deliveredAt
            ? _value.deliveredAt
            : deliveredAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        fromStopId: null == fromStopId
            ? _value.fromStopId
            : fromStopId // ignore: cast_nullable_to_non_nullable
                  as int,
        toStopId: null == toStopId
            ? _value.toStopId
            : toStopId // ignore: cast_nullable_to_non_nullable
                  as int,
        tripId: freezed == tripId
            ? _value.tripId
            : tripId // ignore: cast_nullable_to_non_nullable
                  as int?,
        fromStop: freezed == fromStop
            ? _value.fromStop
            : fromStop // ignore: cast_nullable_to_non_nullable
                  as StopModel?,
        toStop: freezed == toStop
            ? _value.toStop
            : toStop // ignore: cast_nullable_to_non_nullable
                  as StopModel?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ParcelModelImpl implements _ParcelModel {
  const _$ParcelModelImpl({
    required this.id,
    required this.code,
    required this.senderName,
    required this.senderPhone,
    required this.receiverName,
    required this.receiverPhone,
    required this.price,
    required this.status,
    this.proofPhotoUrl,
    this.deliveryOtp,
    required this.createdAt,
    this.deliveredAt,
    required this.fromStopId,
    required this.toStopId,
    this.tripId,
    this.fromStop,
    this.toStop,
  });

  factory _$ParcelModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ParcelModelImplFromJson(json);

  @override
  final int id;
  @override
  final String code;
  @override
  final String senderName;
  @override
  final String senderPhone;
  @override
  final String receiverName;
  @override
  final String receiverPhone;
  @override
  final double price;
  @override
  final ParcelStatus status;
  @override
  final String? proofPhotoUrl;
  @override
  final String? deliveryOtp;
  @override
  final String createdAt;
  @override
  final String? deliveredAt;
  @override
  final int fromStopId;
  @override
  final int toStopId;
  @override
  final int? tripId;
  @override
  final StopModel? fromStop;
  @override
  final StopModel? toStop;

  @override
  String toString() {
    return 'ParcelModel(id: $id, code: $code, senderName: $senderName, senderPhone: $senderPhone, receiverName: $receiverName, receiverPhone: $receiverPhone, price: $price, status: $status, proofPhotoUrl: $proofPhotoUrl, deliveryOtp: $deliveryOtp, createdAt: $createdAt, deliveredAt: $deliveredAt, fromStopId: $fromStopId, toStopId: $toStopId, tripId: $tripId, fromStop: $fromStop, toStop: $toStop)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParcelModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.senderName, senderName) ||
                other.senderName == senderName) &&
            (identical(other.senderPhone, senderPhone) ||
                other.senderPhone == senderPhone) &&
            (identical(other.receiverName, receiverName) ||
                other.receiverName == receiverName) &&
            (identical(other.receiverPhone, receiverPhone) ||
                other.receiverPhone == receiverPhone) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.proofPhotoUrl, proofPhotoUrl) ||
                other.proofPhotoUrl == proofPhotoUrl) &&
            (identical(other.deliveryOtp, deliveryOtp) ||
                other.deliveryOtp == deliveryOtp) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.deliveredAt, deliveredAt) ||
                other.deliveredAt == deliveredAt) &&
            (identical(other.fromStopId, fromStopId) ||
                other.fromStopId == fromStopId) &&
            (identical(other.toStopId, toStopId) ||
                other.toStopId == toStopId) &&
            (identical(other.tripId, tripId) || other.tripId == tripId) &&
            (identical(other.fromStop, fromStop) ||
                other.fromStop == fromStop) &&
            (identical(other.toStop, toStop) || other.toStop == toStop));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    code,
    senderName,
    senderPhone,
    receiverName,
    receiverPhone,
    price,
    status,
    proofPhotoUrl,
    deliveryOtp,
    createdAt,
    deliveredAt,
    fromStopId,
    toStopId,
    tripId,
    fromStop,
    toStop,
  );

  /// Create a copy of ParcelModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ParcelModelImplCopyWith<_$ParcelModelImpl> get copyWith =>
      __$$ParcelModelImplCopyWithImpl<_$ParcelModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ParcelModelImplToJson(this);
  }
}

abstract class _ParcelModel implements ParcelModel {
  const factory _ParcelModel({
    required final int id,
    required final String code,
    required final String senderName,
    required final String senderPhone,
    required final String receiverName,
    required final String receiverPhone,
    required final double price,
    required final ParcelStatus status,
    final String? proofPhotoUrl,
    final String? deliveryOtp,
    required final String createdAt,
    final String? deliveredAt,
    required final int fromStopId,
    required final int toStopId,
    final int? tripId,
    final StopModel? fromStop,
    final StopModel? toStop,
  }) = _$ParcelModelImpl;

  factory _ParcelModel.fromJson(Map<String, dynamic> json) =
      _$ParcelModelImpl.fromJson;

  @override
  int get id;
  @override
  String get code;
  @override
  String get senderName;
  @override
  String get senderPhone;
  @override
  String get receiverName;
  @override
  String get receiverPhone;
  @override
  double get price;
  @override
  ParcelStatus get status;
  @override
  String? get proofPhotoUrl;
  @override
  String? get deliveryOtp;
  @override
  String get createdAt;
  @override
  String? get deliveredAt;
  @override
  int get fromStopId;
  @override
  int get toStopId;
  @override
  int? get tripId;
  @override
  StopModel? get fromStop;
  @override
  StopModel? get toStop;

  /// Create a copy of ParcelModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ParcelModelImplCopyWith<_$ParcelModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ParcelCreateRequest _$ParcelCreateRequestFromJson(Map<String, dynamic> json) {
  return _ParcelCreateRequest.fromJson(json);
}

/// @nodoc
mixin _$ParcelCreateRequest {
  String get senderName => throw _privateConstructorUsedError;
  String get senderPhone => throw _privateConstructorUsedError;
  String get receiverName => throw _privateConstructorUsedError;
  String get receiverPhone => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  int get fromStopId => throw _privateConstructorUsedError;
  int get toStopId => throw _privateConstructorUsedError;

  /// Serializes this ParcelCreateRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ParcelCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ParcelCreateRequestCopyWith<ParcelCreateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParcelCreateRequestCopyWith<$Res> {
  factory $ParcelCreateRequestCopyWith(
    ParcelCreateRequest value,
    $Res Function(ParcelCreateRequest) then,
  ) = _$ParcelCreateRequestCopyWithImpl<$Res, ParcelCreateRequest>;
  @useResult
  $Res call({
    String senderName,
    String senderPhone,
    String receiverName,
    String receiverPhone,
    double price,
    int fromStopId,
    int toStopId,
  });
}

/// @nodoc
class _$ParcelCreateRequestCopyWithImpl<$Res, $Val extends ParcelCreateRequest>
    implements $ParcelCreateRequestCopyWith<$Res> {
  _$ParcelCreateRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ParcelCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? senderName = null,
    Object? senderPhone = null,
    Object? receiverName = null,
    Object? receiverPhone = null,
    Object? price = null,
    Object? fromStopId = null,
    Object? toStopId = null,
  }) {
    return _then(
      _value.copyWith(
            senderName: null == senderName
                ? _value.senderName
                : senderName // ignore: cast_nullable_to_non_nullable
                      as String,
            senderPhone: null == senderPhone
                ? _value.senderPhone
                : senderPhone // ignore: cast_nullable_to_non_nullable
                      as String,
            receiverName: null == receiverName
                ? _value.receiverName
                : receiverName // ignore: cast_nullable_to_non_nullable
                      as String,
            receiverPhone: null == receiverPhone
                ? _value.receiverPhone
                : receiverPhone // ignore: cast_nullable_to_non_nullable
                      as String,
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as double,
            fromStopId: null == fromStopId
                ? _value.fromStopId
                : fromStopId // ignore: cast_nullable_to_non_nullable
                      as int,
            toStopId: null == toStopId
                ? _value.toStopId
                : toStopId // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ParcelCreateRequestImplCopyWith<$Res>
    implements $ParcelCreateRequestCopyWith<$Res> {
  factory _$$ParcelCreateRequestImplCopyWith(
    _$ParcelCreateRequestImpl value,
    $Res Function(_$ParcelCreateRequestImpl) then,
  ) = __$$ParcelCreateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String senderName,
    String senderPhone,
    String receiverName,
    String receiverPhone,
    double price,
    int fromStopId,
    int toStopId,
  });
}

/// @nodoc
class __$$ParcelCreateRequestImplCopyWithImpl<$Res>
    extends _$ParcelCreateRequestCopyWithImpl<$Res, _$ParcelCreateRequestImpl>
    implements _$$ParcelCreateRequestImplCopyWith<$Res> {
  __$$ParcelCreateRequestImplCopyWithImpl(
    _$ParcelCreateRequestImpl _value,
    $Res Function(_$ParcelCreateRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ParcelCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? senderName = null,
    Object? senderPhone = null,
    Object? receiverName = null,
    Object? receiverPhone = null,
    Object? price = null,
    Object? fromStopId = null,
    Object? toStopId = null,
  }) {
    return _then(
      _$ParcelCreateRequestImpl(
        senderName: null == senderName
            ? _value.senderName
            : senderName // ignore: cast_nullable_to_non_nullable
                  as String,
        senderPhone: null == senderPhone
            ? _value.senderPhone
            : senderPhone // ignore: cast_nullable_to_non_nullable
                  as String,
        receiverName: null == receiverName
            ? _value.receiverName
            : receiverName // ignore: cast_nullable_to_non_nullable
                  as String,
        receiverPhone: null == receiverPhone
            ? _value.receiverPhone
            : receiverPhone // ignore: cast_nullable_to_non_nullable
                  as String,
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as double,
        fromStopId: null == fromStopId
            ? _value.fromStopId
            : fromStopId // ignore: cast_nullable_to_non_nullable
                  as int,
        toStopId: null == toStopId
            ? _value.toStopId
            : toStopId // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ParcelCreateRequestImpl implements _ParcelCreateRequest {
  const _$ParcelCreateRequestImpl({
    required this.senderName,
    required this.senderPhone,
    required this.receiverName,
    required this.receiverPhone,
    required this.price,
    required this.fromStopId,
    required this.toStopId,
  });

  factory _$ParcelCreateRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$ParcelCreateRequestImplFromJson(json);

  @override
  final String senderName;
  @override
  final String senderPhone;
  @override
  final String receiverName;
  @override
  final String receiverPhone;
  @override
  final double price;
  @override
  final int fromStopId;
  @override
  final int toStopId;

  @override
  String toString() {
    return 'ParcelCreateRequest(senderName: $senderName, senderPhone: $senderPhone, receiverName: $receiverName, receiverPhone: $receiverPhone, price: $price, fromStopId: $fromStopId, toStopId: $toStopId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParcelCreateRequestImpl &&
            (identical(other.senderName, senderName) ||
                other.senderName == senderName) &&
            (identical(other.senderPhone, senderPhone) ||
                other.senderPhone == senderPhone) &&
            (identical(other.receiverName, receiverName) ||
                other.receiverName == receiverName) &&
            (identical(other.receiverPhone, receiverPhone) ||
                other.receiverPhone == receiverPhone) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.fromStopId, fromStopId) ||
                other.fromStopId == fromStopId) &&
            (identical(other.toStopId, toStopId) ||
                other.toStopId == toStopId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    senderName,
    senderPhone,
    receiverName,
    receiverPhone,
    price,
    fromStopId,
    toStopId,
  );

  /// Create a copy of ParcelCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ParcelCreateRequestImplCopyWith<_$ParcelCreateRequestImpl> get copyWith =>
      __$$ParcelCreateRequestImplCopyWithImpl<_$ParcelCreateRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ParcelCreateRequestImplToJson(this);
  }
}

abstract class _ParcelCreateRequest implements ParcelCreateRequest {
  const factory _ParcelCreateRequest({
    required final String senderName,
    required final String senderPhone,
    required final String receiverName,
    required final String receiverPhone,
    required final double price,
    required final int fromStopId,
    required final int toStopId,
  }) = _$ParcelCreateRequestImpl;

  factory _ParcelCreateRequest.fromJson(Map<String, dynamic> json) =
      _$ParcelCreateRequestImpl.fromJson;

  @override
  String get senderName;
  @override
  String get senderPhone;
  @override
  String get receiverName;
  @override
  String get receiverPhone;
  @override
  double get price;
  @override
  int get fromStopId;
  @override
  int get toStopId;

  /// Create a copy of ParcelCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ParcelCreateRequestImplCopyWith<_$ParcelCreateRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ParcelUpdateRequest _$ParcelUpdateRequestFromJson(Map<String, dynamic> json) {
  return _ParcelUpdateRequest.fromJson(json);
}

/// @nodoc
mixin _$ParcelUpdateRequest {
  String? get senderName => throw _privateConstructorUsedError;
  String? get senderPhone => throw _privateConstructorUsedError;
  String? get receiverName => throw _privateConstructorUsedError;
  String? get receiverPhone => throw _privateConstructorUsedError;
  double? get price => throw _privateConstructorUsedError;
  ParcelStatus? get status => throw _privateConstructorUsedError;

  /// Serializes this ParcelUpdateRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ParcelUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ParcelUpdateRequestCopyWith<ParcelUpdateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParcelUpdateRequestCopyWith<$Res> {
  factory $ParcelUpdateRequestCopyWith(
    ParcelUpdateRequest value,
    $Res Function(ParcelUpdateRequest) then,
  ) = _$ParcelUpdateRequestCopyWithImpl<$Res, ParcelUpdateRequest>;
  @useResult
  $Res call({
    String? senderName,
    String? senderPhone,
    String? receiverName,
    String? receiverPhone,
    double? price,
    ParcelStatus? status,
  });
}

/// @nodoc
class _$ParcelUpdateRequestCopyWithImpl<$Res, $Val extends ParcelUpdateRequest>
    implements $ParcelUpdateRequestCopyWith<$Res> {
  _$ParcelUpdateRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ParcelUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? senderName = freezed,
    Object? senderPhone = freezed,
    Object? receiverName = freezed,
    Object? receiverPhone = freezed,
    Object? price = freezed,
    Object? status = freezed,
  }) {
    return _then(
      _value.copyWith(
            senderName: freezed == senderName
                ? _value.senderName
                : senderName // ignore: cast_nullable_to_non_nullable
                      as String?,
            senderPhone: freezed == senderPhone
                ? _value.senderPhone
                : senderPhone // ignore: cast_nullable_to_non_nullable
                      as String?,
            receiverName: freezed == receiverName
                ? _value.receiverName
                : receiverName // ignore: cast_nullable_to_non_nullable
                      as String?,
            receiverPhone: freezed == receiverPhone
                ? _value.receiverPhone
                : receiverPhone // ignore: cast_nullable_to_non_nullable
                      as String?,
            price: freezed == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as double?,
            status: freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as ParcelStatus?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ParcelUpdateRequestImplCopyWith<$Res>
    implements $ParcelUpdateRequestCopyWith<$Res> {
  factory _$$ParcelUpdateRequestImplCopyWith(
    _$ParcelUpdateRequestImpl value,
    $Res Function(_$ParcelUpdateRequestImpl) then,
  ) = __$$ParcelUpdateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? senderName,
    String? senderPhone,
    String? receiverName,
    String? receiverPhone,
    double? price,
    ParcelStatus? status,
  });
}

/// @nodoc
class __$$ParcelUpdateRequestImplCopyWithImpl<$Res>
    extends _$ParcelUpdateRequestCopyWithImpl<$Res, _$ParcelUpdateRequestImpl>
    implements _$$ParcelUpdateRequestImplCopyWith<$Res> {
  __$$ParcelUpdateRequestImplCopyWithImpl(
    _$ParcelUpdateRequestImpl _value,
    $Res Function(_$ParcelUpdateRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ParcelUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? senderName = freezed,
    Object? senderPhone = freezed,
    Object? receiverName = freezed,
    Object? receiverPhone = freezed,
    Object? price = freezed,
    Object? status = freezed,
  }) {
    return _then(
      _$ParcelUpdateRequestImpl(
        senderName: freezed == senderName
            ? _value.senderName
            : senderName // ignore: cast_nullable_to_non_nullable
                  as String?,
        senderPhone: freezed == senderPhone
            ? _value.senderPhone
            : senderPhone // ignore: cast_nullable_to_non_nullable
                  as String?,
        receiverName: freezed == receiverName
            ? _value.receiverName
            : receiverName // ignore: cast_nullable_to_non_nullable
                  as String?,
        receiverPhone: freezed == receiverPhone
            ? _value.receiverPhone
            : receiverPhone // ignore: cast_nullable_to_non_nullable
                  as String?,
        price: freezed == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as double?,
        status: freezed == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as ParcelStatus?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ParcelUpdateRequestImpl implements _ParcelUpdateRequest {
  const _$ParcelUpdateRequestImpl({
    this.senderName,
    this.senderPhone,
    this.receiverName,
    this.receiverPhone,
    this.price,
    this.status,
  });

  factory _$ParcelUpdateRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$ParcelUpdateRequestImplFromJson(json);

  @override
  final String? senderName;
  @override
  final String? senderPhone;
  @override
  final String? receiverName;
  @override
  final String? receiverPhone;
  @override
  final double? price;
  @override
  final ParcelStatus? status;

  @override
  String toString() {
    return 'ParcelUpdateRequest(senderName: $senderName, senderPhone: $senderPhone, receiverName: $receiverName, receiverPhone: $receiverPhone, price: $price, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParcelUpdateRequestImpl &&
            (identical(other.senderName, senderName) ||
                other.senderName == senderName) &&
            (identical(other.senderPhone, senderPhone) ||
                other.senderPhone == senderPhone) &&
            (identical(other.receiverName, receiverName) ||
                other.receiverName == receiverName) &&
            (identical(other.receiverPhone, receiverPhone) ||
                other.receiverPhone == receiverPhone) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    senderName,
    senderPhone,
    receiverName,
    receiverPhone,
    price,
    status,
  );

  /// Create a copy of ParcelUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ParcelUpdateRequestImplCopyWith<_$ParcelUpdateRequestImpl> get copyWith =>
      __$$ParcelUpdateRequestImplCopyWithImpl<_$ParcelUpdateRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ParcelUpdateRequestImplToJson(this);
  }
}

abstract class _ParcelUpdateRequest implements ParcelUpdateRequest {
  const factory _ParcelUpdateRequest({
    final String? senderName,
    final String? senderPhone,
    final String? receiverName,
    final String? receiverPhone,
    final double? price,
    final ParcelStatus? status,
  }) = _$ParcelUpdateRequestImpl;

  factory _ParcelUpdateRequest.fromJson(Map<String, dynamic> json) =
      _$ParcelUpdateRequestImpl.fromJson;

  @override
  String? get senderName;
  @override
  String? get senderPhone;
  @override
  String? get receiverName;
  @override
  String? get receiverPhone;
  @override
  double? get price;
  @override
  ParcelStatus? get status;

  /// Create a copy of ParcelUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ParcelUpdateRequestImplCopyWith<_$ParcelUpdateRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
