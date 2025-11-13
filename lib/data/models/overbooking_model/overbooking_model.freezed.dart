// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'overbooking_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

OverbookingModel _$OverbookingModelFromJson(Map<String, dynamic> json) {
  return _OverbookingModel.fromJson(json);
}

/// @nodoc
mixin _$OverbookingModel {
  int get id => throw _privateConstructorUsedError;
  int get tripId => throw _privateConstructorUsedError;
  String get tripInfo => throw _privateConstructorUsedError;
  int get ticketId => throw _privateConstructorUsedError;
  String get passengerName => throw _privateConstructorUsedError;
  String get seatNumber => throw _privateConstructorUsedError;
  OverbookingStatus get status => throw _privateConstructorUsedError;
  String get reason => throw _privateConstructorUsedError;
  String? get requestedByName => throw _privateConstructorUsedError;
  String? get approvedByName => throw _privateConstructorUsedError;
  DateTime? get requestedAt => throw _privateConstructorUsedError;
  DateTime? get approvedAt => throw _privateConstructorUsedError;
  DateTime? get expiresAt => throw _privateConstructorUsedError;
  bool get requiresApproval => throw _privateConstructorUsedError;
  double get currentOccupancyRate => throw _privateConstructorUsedError;
  int get minutesUntilDeparture => throw _privateConstructorUsedError;

  /// Serializes this OverbookingModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OverbookingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OverbookingModelCopyWith<OverbookingModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OverbookingModelCopyWith<$Res> {
  factory $OverbookingModelCopyWith(
    OverbookingModel value,
    $Res Function(OverbookingModel) then,
  ) = _$OverbookingModelCopyWithImpl<$Res, OverbookingModel>;
  @useResult
  $Res call({
    int id,
    int tripId,
    String tripInfo,
    int ticketId,
    String passengerName,
    String seatNumber,
    OverbookingStatus status,
    String reason,
    String? requestedByName,
    String? approvedByName,
    DateTime? requestedAt,
    DateTime? approvedAt,
    DateTime? expiresAt,
    bool requiresApproval,
    double currentOccupancyRate,
    int minutesUntilDeparture,
  });
}

/// @nodoc
class _$OverbookingModelCopyWithImpl<$Res, $Val extends OverbookingModel>
    implements $OverbookingModelCopyWith<$Res> {
  _$OverbookingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OverbookingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? tripId = null,
    Object? tripInfo = null,
    Object? ticketId = null,
    Object? passengerName = null,
    Object? seatNumber = null,
    Object? status = null,
    Object? reason = null,
    Object? requestedByName = freezed,
    Object? approvedByName = freezed,
    Object? requestedAt = freezed,
    Object? approvedAt = freezed,
    Object? expiresAt = freezed,
    Object? requiresApproval = null,
    Object? currentOccupancyRate = null,
    Object? minutesUntilDeparture = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            tripId: null == tripId
                ? _value.tripId
                : tripId // ignore: cast_nullable_to_non_nullable
                      as int,
            tripInfo: null == tripInfo
                ? _value.tripInfo
                : tripInfo // ignore: cast_nullable_to_non_nullable
                      as String,
            ticketId: null == ticketId
                ? _value.ticketId
                : ticketId // ignore: cast_nullable_to_non_nullable
                      as int,
            passengerName: null == passengerName
                ? _value.passengerName
                : passengerName // ignore: cast_nullable_to_non_nullable
                      as String,
            seatNumber: null == seatNumber
                ? _value.seatNumber
                : seatNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as OverbookingStatus,
            reason: null == reason
                ? _value.reason
                : reason // ignore: cast_nullable_to_non_nullable
                      as String,
            requestedByName: freezed == requestedByName
                ? _value.requestedByName
                : requestedByName // ignore: cast_nullable_to_non_nullable
                      as String?,
            approvedByName: freezed == approvedByName
                ? _value.approvedByName
                : approvedByName // ignore: cast_nullable_to_non_nullable
                      as String?,
            requestedAt: freezed == requestedAt
                ? _value.requestedAt
                : requestedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            approvedAt: freezed == approvedAt
                ? _value.approvedAt
                : approvedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            expiresAt: freezed == expiresAt
                ? _value.expiresAt
                : expiresAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            requiresApproval: null == requiresApproval
                ? _value.requiresApproval
                : requiresApproval // ignore: cast_nullable_to_non_nullable
                      as bool,
            currentOccupancyRate: null == currentOccupancyRate
                ? _value.currentOccupancyRate
                : currentOccupancyRate // ignore: cast_nullable_to_non_nullable
                      as double,
            minutesUntilDeparture: null == minutesUntilDeparture
                ? _value.minutesUntilDeparture
                : minutesUntilDeparture // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OverbookingModelImplCopyWith<$Res>
    implements $OverbookingModelCopyWith<$Res> {
  factory _$$OverbookingModelImplCopyWith(
    _$OverbookingModelImpl value,
    $Res Function(_$OverbookingModelImpl) then,
  ) = __$$OverbookingModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    int tripId,
    String tripInfo,
    int ticketId,
    String passengerName,
    String seatNumber,
    OverbookingStatus status,
    String reason,
    String? requestedByName,
    String? approvedByName,
    DateTime? requestedAt,
    DateTime? approvedAt,
    DateTime? expiresAt,
    bool requiresApproval,
    double currentOccupancyRate,
    int minutesUntilDeparture,
  });
}

/// @nodoc
class __$$OverbookingModelImplCopyWithImpl<$Res>
    extends _$OverbookingModelCopyWithImpl<$Res, _$OverbookingModelImpl>
    implements _$$OverbookingModelImplCopyWith<$Res> {
  __$$OverbookingModelImplCopyWithImpl(
    _$OverbookingModelImpl _value,
    $Res Function(_$OverbookingModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OverbookingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? tripId = null,
    Object? tripInfo = null,
    Object? ticketId = null,
    Object? passengerName = null,
    Object? seatNumber = null,
    Object? status = null,
    Object? reason = null,
    Object? requestedByName = freezed,
    Object? approvedByName = freezed,
    Object? requestedAt = freezed,
    Object? approvedAt = freezed,
    Object? expiresAt = freezed,
    Object? requiresApproval = null,
    Object? currentOccupancyRate = null,
    Object? minutesUntilDeparture = null,
  }) {
    return _then(
      _$OverbookingModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        tripId: null == tripId
            ? _value.tripId
            : tripId // ignore: cast_nullable_to_non_nullable
                  as int,
        tripInfo: null == tripInfo
            ? _value.tripInfo
            : tripInfo // ignore: cast_nullable_to_non_nullable
                  as String,
        ticketId: null == ticketId
            ? _value.ticketId
            : ticketId // ignore: cast_nullable_to_non_nullable
                  as int,
        passengerName: null == passengerName
            ? _value.passengerName
            : passengerName // ignore: cast_nullable_to_non_nullable
                  as String,
        seatNumber: null == seatNumber
            ? _value.seatNumber
            : seatNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as OverbookingStatus,
        reason: null == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String,
        requestedByName: freezed == requestedByName
            ? _value.requestedByName
            : requestedByName // ignore: cast_nullable_to_non_nullable
                  as String?,
        approvedByName: freezed == approvedByName
            ? _value.approvedByName
            : approvedByName // ignore: cast_nullable_to_non_nullable
                  as String?,
        requestedAt: freezed == requestedAt
            ? _value.requestedAt
            : requestedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        approvedAt: freezed == approvedAt
            ? _value.approvedAt
            : approvedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        expiresAt: freezed == expiresAt
            ? _value.expiresAt
            : expiresAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        requiresApproval: null == requiresApproval
            ? _value.requiresApproval
            : requiresApproval // ignore: cast_nullable_to_non_nullable
                  as bool,
        currentOccupancyRate: null == currentOccupancyRate
            ? _value.currentOccupancyRate
            : currentOccupancyRate // ignore: cast_nullable_to_non_nullable
                  as double,
        minutesUntilDeparture: null == minutesUntilDeparture
            ? _value.minutesUntilDeparture
            : minutesUntilDeparture // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OverbookingModelImpl implements _OverbookingModel {
  const _$OverbookingModelImpl({
    required this.id,
    required this.tripId,
    required this.tripInfo,
    required this.ticketId,
    required this.passengerName,
    required this.seatNumber,
    required this.status,
    required this.reason,
    this.requestedByName,
    this.approvedByName,
    this.requestedAt,
    this.approvedAt,
    this.expiresAt,
    required this.requiresApproval,
    required this.currentOccupancyRate,
    required this.minutesUntilDeparture,
  });

  factory _$OverbookingModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$OverbookingModelImplFromJson(json);

  @override
  final int id;
  @override
  final int tripId;
  @override
  final String tripInfo;
  @override
  final int ticketId;
  @override
  final String passengerName;
  @override
  final String seatNumber;
  @override
  final OverbookingStatus status;
  @override
  final String reason;
  @override
  final String? requestedByName;
  @override
  final String? approvedByName;
  @override
  final DateTime? requestedAt;
  @override
  final DateTime? approvedAt;
  @override
  final DateTime? expiresAt;
  @override
  final bool requiresApproval;
  @override
  final double currentOccupancyRate;
  @override
  final int minutesUntilDeparture;

  @override
  String toString() {
    return 'OverbookingModel(id: $id, tripId: $tripId, tripInfo: $tripInfo, ticketId: $ticketId, passengerName: $passengerName, seatNumber: $seatNumber, status: $status, reason: $reason, requestedByName: $requestedByName, approvedByName: $approvedByName, requestedAt: $requestedAt, approvedAt: $approvedAt, expiresAt: $expiresAt, requiresApproval: $requiresApproval, currentOccupancyRate: $currentOccupancyRate, minutesUntilDeparture: $minutesUntilDeparture)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OverbookingModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.tripId, tripId) || other.tripId == tripId) &&
            (identical(other.tripInfo, tripInfo) ||
                other.tripInfo == tripInfo) &&
            (identical(other.ticketId, ticketId) ||
                other.ticketId == ticketId) &&
            (identical(other.passengerName, passengerName) ||
                other.passengerName == passengerName) &&
            (identical(other.seatNumber, seatNumber) ||
                other.seatNumber == seatNumber) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.requestedByName, requestedByName) ||
                other.requestedByName == requestedByName) &&
            (identical(other.approvedByName, approvedByName) ||
                other.approvedByName == approvedByName) &&
            (identical(other.requestedAt, requestedAt) ||
                other.requestedAt == requestedAt) &&
            (identical(other.approvedAt, approvedAt) ||
                other.approvedAt == approvedAt) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.requiresApproval, requiresApproval) ||
                other.requiresApproval == requiresApproval) &&
            (identical(other.currentOccupancyRate, currentOccupancyRate) ||
                other.currentOccupancyRate == currentOccupancyRate) &&
            (identical(other.minutesUntilDeparture, minutesUntilDeparture) ||
                other.minutesUntilDeparture == minutesUntilDeparture));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    tripId,
    tripInfo,
    ticketId,
    passengerName,
    seatNumber,
    status,
    reason,
    requestedByName,
    approvedByName,
    requestedAt,
    approvedAt,
    expiresAt,
    requiresApproval,
    currentOccupancyRate,
    minutesUntilDeparture,
  );

  /// Create a copy of OverbookingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OverbookingModelImplCopyWith<_$OverbookingModelImpl> get copyWith =>
      __$$OverbookingModelImplCopyWithImpl<_$OverbookingModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$OverbookingModelImplToJson(this);
  }
}

abstract class _OverbookingModel implements OverbookingModel {
  const factory _OverbookingModel({
    required final int id,
    required final int tripId,
    required final String tripInfo,
    required final int ticketId,
    required final String passengerName,
    required final String seatNumber,
    required final OverbookingStatus status,
    required final String reason,
    final String? requestedByName,
    final String? approvedByName,
    final DateTime? requestedAt,
    final DateTime? approvedAt,
    final DateTime? expiresAt,
    required final bool requiresApproval,
    required final double currentOccupancyRate,
    required final int minutesUntilDeparture,
  }) = _$OverbookingModelImpl;

  factory _OverbookingModel.fromJson(Map<String, dynamic> json) =
      _$OverbookingModelImpl.fromJson;

  @override
  int get id;
  @override
  int get tripId;
  @override
  String get tripInfo;
  @override
  int get ticketId;
  @override
  String get passengerName;
  @override
  String get seatNumber;
  @override
  OverbookingStatus get status;
  @override
  String get reason;
  @override
  String? get requestedByName;
  @override
  String? get approvedByName;
  @override
  DateTime? get requestedAt;
  @override
  DateTime? get approvedAt;
  @override
  DateTime? get expiresAt;
  @override
  bool get requiresApproval;
  @override
  double get currentOccupancyRate;
  @override
  int get minutesUntilDeparture;

  /// Create a copy of OverbookingModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OverbookingModelImplCopyWith<_$OverbookingModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OverbookingCreateRequest _$OverbookingCreateRequestFromJson(
  Map<String, dynamic> json,
) {
  return _OverbookingCreateRequest.fromJson(json);
}

/// @nodoc
mixin _$OverbookingCreateRequest {
  int get tripId => throw _privateConstructorUsedError;
  int get ticketId => throw _privateConstructorUsedError;
  String get reason => throw _privateConstructorUsedError;

  /// Serializes this OverbookingCreateRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OverbookingCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OverbookingCreateRequestCopyWith<OverbookingCreateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OverbookingCreateRequestCopyWith<$Res> {
  factory $OverbookingCreateRequestCopyWith(
    OverbookingCreateRequest value,
    $Res Function(OverbookingCreateRequest) then,
  ) = _$OverbookingCreateRequestCopyWithImpl<$Res, OverbookingCreateRequest>;
  @useResult
  $Res call({int tripId, int ticketId, String reason});
}

/// @nodoc
class _$OverbookingCreateRequestCopyWithImpl<
  $Res,
  $Val extends OverbookingCreateRequest
>
    implements $OverbookingCreateRequestCopyWith<$Res> {
  _$OverbookingCreateRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OverbookingCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tripId = null,
    Object? ticketId = null,
    Object? reason = null,
  }) {
    return _then(
      _value.copyWith(
            tripId: null == tripId
                ? _value.tripId
                : tripId // ignore: cast_nullable_to_non_nullable
                      as int,
            ticketId: null == ticketId
                ? _value.ticketId
                : ticketId // ignore: cast_nullable_to_non_nullable
                      as int,
            reason: null == reason
                ? _value.reason
                : reason // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OverbookingCreateRequestImplCopyWith<$Res>
    implements $OverbookingCreateRequestCopyWith<$Res> {
  factory _$$OverbookingCreateRequestImplCopyWith(
    _$OverbookingCreateRequestImpl value,
    $Res Function(_$OverbookingCreateRequestImpl) then,
  ) = __$$OverbookingCreateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int tripId, int ticketId, String reason});
}

/// @nodoc
class __$$OverbookingCreateRequestImplCopyWithImpl<$Res>
    extends
        _$OverbookingCreateRequestCopyWithImpl<
          $Res,
          _$OverbookingCreateRequestImpl
        >
    implements _$$OverbookingCreateRequestImplCopyWith<$Res> {
  __$$OverbookingCreateRequestImplCopyWithImpl(
    _$OverbookingCreateRequestImpl _value,
    $Res Function(_$OverbookingCreateRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OverbookingCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tripId = null,
    Object? ticketId = null,
    Object? reason = null,
  }) {
    return _then(
      _$OverbookingCreateRequestImpl(
        tripId: null == tripId
            ? _value.tripId
            : tripId // ignore: cast_nullable_to_non_nullable
                  as int,
        ticketId: null == ticketId
            ? _value.ticketId
            : ticketId // ignore: cast_nullable_to_non_nullable
                  as int,
        reason: null == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OverbookingCreateRequestImpl implements _OverbookingCreateRequest {
  const _$OverbookingCreateRequestImpl({
    required this.tripId,
    required this.ticketId,
    required this.reason,
  });

  factory _$OverbookingCreateRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$OverbookingCreateRequestImplFromJson(json);

  @override
  final int tripId;
  @override
  final int ticketId;
  @override
  final String reason;

  @override
  String toString() {
    return 'OverbookingCreateRequest(tripId: $tripId, ticketId: $ticketId, reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OverbookingCreateRequestImpl &&
            (identical(other.tripId, tripId) || other.tripId == tripId) &&
            (identical(other.ticketId, ticketId) ||
                other.ticketId == ticketId) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, tripId, ticketId, reason);

  /// Create a copy of OverbookingCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OverbookingCreateRequestImplCopyWith<_$OverbookingCreateRequestImpl>
  get copyWith =>
      __$$OverbookingCreateRequestImplCopyWithImpl<
        _$OverbookingCreateRequestImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OverbookingCreateRequestImplToJson(this);
  }
}

abstract class _OverbookingCreateRequest implements OverbookingCreateRequest {
  const factory _OverbookingCreateRequest({
    required final int tripId,
    required final int ticketId,
    required final String reason,
  }) = _$OverbookingCreateRequestImpl;

  factory _OverbookingCreateRequest.fromJson(Map<String, dynamic> json) =
      _$OverbookingCreateRequestImpl.fromJson;

  @override
  int get tripId;
  @override
  int get ticketId;
  @override
  String get reason;

  /// Create a copy of OverbookingCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OverbookingCreateRequestImplCopyWith<_$OverbookingCreateRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}

OverbookingApproveRequest _$OverbookingApproveRequestFromJson(
  Map<String, dynamic> json,
) {
  return _OverbookingApproveRequest.fromJson(json);
}

/// @nodoc
mixin _$OverbookingApproveRequest {
  String? get notes => throw _privateConstructorUsedError;

  /// Serializes this OverbookingApproveRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OverbookingApproveRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OverbookingApproveRequestCopyWith<OverbookingApproveRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OverbookingApproveRequestCopyWith<$Res> {
  factory $OverbookingApproveRequestCopyWith(
    OverbookingApproveRequest value,
    $Res Function(OverbookingApproveRequest) then,
  ) = _$OverbookingApproveRequestCopyWithImpl<$Res, OverbookingApproveRequest>;
  @useResult
  $Res call({String? notes});
}

/// @nodoc
class _$OverbookingApproveRequestCopyWithImpl<
  $Res,
  $Val extends OverbookingApproveRequest
>
    implements $OverbookingApproveRequestCopyWith<$Res> {
  _$OverbookingApproveRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OverbookingApproveRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? notes = freezed}) {
    return _then(
      _value.copyWith(
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OverbookingApproveRequestImplCopyWith<$Res>
    implements $OverbookingApproveRequestCopyWith<$Res> {
  factory _$$OverbookingApproveRequestImplCopyWith(
    _$OverbookingApproveRequestImpl value,
    $Res Function(_$OverbookingApproveRequestImpl) then,
  ) = __$$OverbookingApproveRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? notes});
}

/// @nodoc
class __$$OverbookingApproveRequestImplCopyWithImpl<$Res>
    extends
        _$OverbookingApproveRequestCopyWithImpl<
          $Res,
          _$OverbookingApproveRequestImpl
        >
    implements _$$OverbookingApproveRequestImplCopyWith<$Res> {
  __$$OverbookingApproveRequestImplCopyWithImpl(
    _$OverbookingApproveRequestImpl _value,
    $Res Function(_$OverbookingApproveRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OverbookingApproveRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? notes = freezed}) {
    return _then(
      _$OverbookingApproveRequestImpl(
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OverbookingApproveRequestImpl implements _OverbookingApproveRequest {
  const _$OverbookingApproveRequestImpl({this.notes});

  factory _$OverbookingApproveRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$OverbookingApproveRequestImplFromJson(json);

  @override
  final String? notes;

  @override
  String toString() {
    return 'OverbookingApproveRequest(notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OverbookingApproveRequestImpl &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, notes);

  /// Create a copy of OverbookingApproveRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OverbookingApproveRequestImplCopyWith<_$OverbookingApproveRequestImpl>
  get copyWith =>
      __$$OverbookingApproveRequestImplCopyWithImpl<
        _$OverbookingApproveRequestImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OverbookingApproveRequestImplToJson(this);
  }
}

abstract class _OverbookingApproveRequest implements OverbookingApproveRequest {
  const factory _OverbookingApproveRequest({final String? notes}) =
      _$OverbookingApproveRequestImpl;

  factory _OverbookingApproveRequest.fromJson(Map<String, dynamic> json) =
      _$OverbookingApproveRequestImpl.fromJson;

  @override
  String? get notes;

  /// Create a copy of OverbookingApproveRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OverbookingApproveRequestImplCopyWith<_$OverbookingApproveRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}

OverbookingRejectRequest _$OverbookingRejectRequestFromJson(
  Map<String, dynamic> json,
) {
  return _OverbookingRejectRequest.fromJson(json);
}

/// @nodoc
mixin _$OverbookingRejectRequest {
  String get reason => throw _privateConstructorUsedError;

  /// Serializes this OverbookingRejectRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OverbookingRejectRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OverbookingRejectRequestCopyWith<OverbookingRejectRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OverbookingRejectRequestCopyWith<$Res> {
  factory $OverbookingRejectRequestCopyWith(
    OverbookingRejectRequest value,
    $Res Function(OverbookingRejectRequest) then,
  ) = _$OverbookingRejectRequestCopyWithImpl<$Res, OverbookingRejectRequest>;
  @useResult
  $Res call({String reason});
}

/// @nodoc
class _$OverbookingRejectRequestCopyWithImpl<
  $Res,
  $Val extends OverbookingRejectRequest
>
    implements $OverbookingRejectRequestCopyWith<$Res> {
  _$OverbookingRejectRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OverbookingRejectRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? reason = null}) {
    return _then(
      _value.copyWith(
            reason: null == reason
                ? _value.reason
                : reason // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OverbookingRejectRequestImplCopyWith<$Res>
    implements $OverbookingRejectRequestCopyWith<$Res> {
  factory _$$OverbookingRejectRequestImplCopyWith(
    _$OverbookingRejectRequestImpl value,
    $Res Function(_$OverbookingRejectRequestImpl) then,
  ) = __$$OverbookingRejectRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String reason});
}

/// @nodoc
class __$$OverbookingRejectRequestImplCopyWithImpl<$Res>
    extends
        _$OverbookingRejectRequestCopyWithImpl<
          $Res,
          _$OverbookingRejectRequestImpl
        >
    implements _$$OverbookingRejectRequestImplCopyWith<$Res> {
  __$$OverbookingRejectRequestImplCopyWithImpl(
    _$OverbookingRejectRequestImpl _value,
    $Res Function(_$OverbookingRejectRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OverbookingRejectRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? reason = null}) {
    return _then(
      _$OverbookingRejectRequestImpl(
        reason: null == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OverbookingRejectRequestImpl implements _OverbookingRejectRequest {
  const _$OverbookingRejectRequestImpl({required this.reason});

  factory _$OverbookingRejectRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$OverbookingRejectRequestImplFromJson(json);

  @override
  final String reason;

  @override
  String toString() {
    return 'OverbookingRejectRequest(reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OverbookingRejectRequestImpl &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, reason);

  /// Create a copy of OverbookingRejectRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OverbookingRejectRequestImplCopyWith<_$OverbookingRejectRequestImpl>
  get copyWith =>
      __$$OverbookingRejectRequestImplCopyWithImpl<
        _$OverbookingRejectRequestImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OverbookingRejectRequestImplToJson(this);
  }
}

abstract class _OverbookingRejectRequest implements OverbookingRejectRequest {
  const factory _OverbookingRejectRequest({required final String reason}) =
      _$OverbookingRejectRequestImpl;

  factory _OverbookingRejectRequest.fromJson(Map<String, dynamic> json) =
      _$OverbookingRejectRequestImpl.fromJson;

  @override
  String get reason;

  /// Create a copy of OverbookingRejectRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OverbookingRejectRequestImplCopyWith<_$OverbookingRejectRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}
