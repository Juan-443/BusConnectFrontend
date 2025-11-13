// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ticket_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TicketModel _$TicketModelFromJson(Map<String, dynamic> json) {
  return _TicketModel.fromJson(json);
}

/// @nodoc
mixin _$TicketModel {
  int get id => throw _privateConstructorUsedError;
  String get seatNumber => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  PaymentMethod get paymentMethod => throw _privateConstructorUsedError;
  TicketStatus get status => throw _privateConstructorUsedError;
  String get qrCode => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  PassengerType? get passengerType => throw _privateConstructorUsedError;
  double? get discountAmount => throw _privateConstructorUsedError;
  String? get cancelledAt => throw _privateConstructorUsedError;
  double? get refundAmount => throw _privateConstructorUsedError;
  CancellationPolicy? get cancellationPolicy =>
      throw _privateConstructorUsedError;
  int get fromStopId => throw _privateConstructorUsedError;
  int get toStopId => throw _privateConstructorUsedError;
  int get tripId => throw _privateConstructorUsedError;
  int get passengerId => throw _privateConstructorUsedError;
  StopModel? get fromStop => throw _privateConstructorUsedError;
  StopModel? get toStop => throw _privateConstructorUsedError;
  TripModel? get trip => throw _privateConstructorUsedError;

  /// Serializes this TicketModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TicketModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TicketModelCopyWith<TicketModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TicketModelCopyWith<$Res> {
  factory $TicketModelCopyWith(
    TicketModel value,
    $Res Function(TicketModel) then,
  ) = _$TicketModelCopyWithImpl<$Res, TicketModel>;
  @useResult
  $Res call({
    int id,
    String seatNumber,
    double price,
    PaymentMethod paymentMethod,
    TicketStatus status,
    String qrCode,
    String createdAt,
    PassengerType? passengerType,
    double? discountAmount,
    String? cancelledAt,
    double? refundAmount,
    CancellationPolicy? cancellationPolicy,
    int fromStopId,
    int toStopId,
    int tripId,
    int passengerId,
    StopModel? fromStop,
    StopModel? toStop,
    TripModel? trip,
  });

  $StopModelCopyWith<$Res>? get fromStop;
  $StopModelCopyWith<$Res>? get toStop;
  $TripModelCopyWith<$Res>? get trip;
}

/// @nodoc
class _$TicketModelCopyWithImpl<$Res, $Val extends TicketModel>
    implements $TicketModelCopyWith<$Res> {
  _$TicketModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TicketModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? seatNumber = null,
    Object? price = null,
    Object? paymentMethod = null,
    Object? status = null,
    Object? qrCode = null,
    Object? createdAt = null,
    Object? passengerType = freezed,
    Object? discountAmount = freezed,
    Object? cancelledAt = freezed,
    Object? refundAmount = freezed,
    Object? cancellationPolicy = freezed,
    Object? fromStopId = null,
    Object? toStopId = null,
    Object? tripId = null,
    Object? passengerId = null,
    Object? fromStop = freezed,
    Object? toStop = freezed,
    Object? trip = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            seatNumber: null == seatNumber
                ? _value.seatNumber
                : seatNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as double,
            paymentMethod: null == paymentMethod
                ? _value.paymentMethod
                : paymentMethod // ignore: cast_nullable_to_non_nullable
                      as PaymentMethod,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as TicketStatus,
            qrCode: null == qrCode
                ? _value.qrCode
                : qrCode // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String,
            passengerType: freezed == passengerType
                ? _value.passengerType
                : passengerType // ignore: cast_nullable_to_non_nullable
                      as PassengerType?,
            discountAmount: freezed == discountAmount
                ? _value.discountAmount
                : discountAmount // ignore: cast_nullable_to_non_nullable
                      as double?,
            cancelledAt: freezed == cancelledAt
                ? _value.cancelledAt
                : cancelledAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            refundAmount: freezed == refundAmount
                ? _value.refundAmount
                : refundAmount // ignore: cast_nullable_to_non_nullable
                      as double?,
            cancellationPolicy: freezed == cancellationPolicy
                ? _value.cancellationPolicy
                : cancellationPolicy // ignore: cast_nullable_to_non_nullable
                      as CancellationPolicy?,
            fromStopId: null == fromStopId
                ? _value.fromStopId
                : fromStopId // ignore: cast_nullable_to_non_nullable
                      as int,
            toStopId: null == toStopId
                ? _value.toStopId
                : toStopId // ignore: cast_nullable_to_non_nullable
                      as int,
            tripId: null == tripId
                ? _value.tripId
                : tripId // ignore: cast_nullable_to_non_nullable
                      as int,
            passengerId: null == passengerId
                ? _value.passengerId
                : passengerId // ignore: cast_nullable_to_non_nullable
                      as int,
            fromStop: freezed == fromStop
                ? _value.fromStop
                : fromStop // ignore: cast_nullable_to_non_nullable
                      as StopModel?,
            toStop: freezed == toStop
                ? _value.toStop
                : toStop // ignore: cast_nullable_to_non_nullable
                      as StopModel?,
            trip: freezed == trip
                ? _value.trip
                : trip // ignore: cast_nullable_to_non_nullable
                      as TripModel?,
          )
          as $Val,
    );
  }

  /// Create a copy of TicketModel
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

  /// Create a copy of TicketModel
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

  /// Create a copy of TicketModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TripModelCopyWith<$Res>? get trip {
    if (_value.trip == null) {
      return null;
    }

    return $TripModelCopyWith<$Res>(_value.trip!, (value) {
      return _then(_value.copyWith(trip: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TicketModelImplCopyWith<$Res>
    implements $TicketModelCopyWith<$Res> {
  factory _$$TicketModelImplCopyWith(
    _$TicketModelImpl value,
    $Res Function(_$TicketModelImpl) then,
  ) = __$$TicketModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String seatNumber,
    double price,
    PaymentMethod paymentMethod,
    TicketStatus status,
    String qrCode,
    String createdAt,
    PassengerType? passengerType,
    double? discountAmount,
    String? cancelledAt,
    double? refundAmount,
    CancellationPolicy? cancellationPolicy,
    int fromStopId,
    int toStopId,
    int tripId,
    int passengerId,
    StopModel? fromStop,
    StopModel? toStop,
    TripModel? trip,
  });

  @override
  $StopModelCopyWith<$Res>? get fromStop;
  @override
  $StopModelCopyWith<$Res>? get toStop;
  @override
  $TripModelCopyWith<$Res>? get trip;
}

/// @nodoc
class __$$TicketModelImplCopyWithImpl<$Res>
    extends _$TicketModelCopyWithImpl<$Res, _$TicketModelImpl>
    implements _$$TicketModelImplCopyWith<$Res> {
  __$$TicketModelImplCopyWithImpl(
    _$TicketModelImpl _value,
    $Res Function(_$TicketModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TicketModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? seatNumber = null,
    Object? price = null,
    Object? paymentMethod = null,
    Object? status = null,
    Object? qrCode = null,
    Object? createdAt = null,
    Object? passengerType = freezed,
    Object? discountAmount = freezed,
    Object? cancelledAt = freezed,
    Object? refundAmount = freezed,
    Object? cancellationPolicy = freezed,
    Object? fromStopId = null,
    Object? toStopId = null,
    Object? tripId = null,
    Object? passengerId = null,
    Object? fromStop = freezed,
    Object? toStop = freezed,
    Object? trip = freezed,
  }) {
    return _then(
      _$TicketModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        seatNumber: null == seatNumber
            ? _value.seatNumber
            : seatNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as double,
        paymentMethod: null == paymentMethod
            ? _value.paymentMethod
            : paymentMethod // ignore: cast_nullable_to_non_nullable
                  as PaymentMethod,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as TicketStatus,
        qrCode: null == qrCode
            ? _value.qrCode
            : qrCode // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String,
        passengerType: freezed == passengerType
            ? _value.passengerType
            : passengerType // ignore: cast_nullable_to_non_nullable
                  as PassengerType?,
        discountAmount: freezed == discountAmount
            ? _value.discountAmount
            : discountAmount // ignore: cast_nullable_to_non_nullable
                  as double?,
        cancelledAt: freezed == cancelledAt
            ? _value.cancelledAt
            : cancelledAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        refundAmount: freezed == refundAmount
            ? _value.refundAmount
            : refundAmount // ignore: cast_nullable_to_non_nullable
                  as double?,
        cancellationPolicy: freezed == cancellationPolicy
            ? _value.cancellationPolicy
            : cancellationPolicy // ignore: cast_nullable_to_non_nullable
                  as CancellationPolicy?,
        fromStopId: null == fromStopId
            ? _value.fromStopId
            : fromStopId // ignore: cast_nullable_to_non_nullable
                  as int,
        toStopId: null == toStopId
            ? _value.toStopId
            : toStopId // ignore: cast_nullable_to_non_nullable
                  as int,
        tripId: null == tripId
            ? _value.tripId
            : tripId // ignore: cast_nullable_to_non_nullable
                  as int,
        passengerId: null == passengerId
            ? _value.passengerId
            : passengerId // ignore: cast_nullable_to_non_nullable
                  as int,
        fromStop: freezed == fromStop
            ? _value.fromStop
            : fromStop // ignore: cast_nullable_to_non_nullable
                  as StopModel?,
        toStop: freezed == toStop
            ? _value.toStop
            : toStop // ignore: cast_nullable_to_non_nullable
                  as StopModel?,
        trip: freezed == trip
            ? _value.trip
            : trip // ignore: cast_nullable_to_non_nullable
                  as TripModel?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TicketModelImpl implements _TicketModel {
  const _$TicketModelImpl({
    required this.id,
    required this.seatNumber,
    required this.price,
    required this.paymentMethod,
    required this.status,
    required this.qrCode,
    required this.createdAt,
    this.passengerType,
    this.discountAmount,
    this.cancelledAt,
    this.refundAmount,
    this.cancellationPolicy,
    required this.fromStopId,
    required this.toStopId,
    required this.tripId,
    required this.passengerId,
    this.fromStop,
    this.toStop,
    this.trip,
  });

  factory _$TicketModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TicketModelImplFromJson(json);

  @override
  final int id;
  @override
  final String seatNumber;
  @override
  final double price;
  @override
  final PaymentMethod paymentMethod;
  @override
  final TicketStatus status;
  @override
  final String qrCode;
  @override
  final String createdAt;
  @override
  final PassengerType? passengerType;
  @override
  final double? discountAmount;
  @override
  final String? cancelledAt;
  @override
  final double? refundAmount;
  @override
  final CancellationPolicy? cancellationPolicy;
  @override
  final int fromStopId;
  @override
  final int toStopId;
  @override
  final int tripId;
  @override
  final int passengerId;
  @override
  final StopModel? fromStop;
  @override
  final StopModel? toStop;
  @override
  final TripModel? trip;

  @override
  String toString() {
    return 'TicketModel(id: $id, seatNumber: $seatNumber, price: $price, paymentMethod: $paymentMethod, status: $status, qrCode: $qrCode, createdAt: $createdAt, passengerType: $passengerType, discountAmount: $discountAmount, cancelledAt: $cancelledAt, refundAmount: $refundAmount, cancellationPolicy: $cancellationPolicy, fromStopId: $fromStopId, toStopId: $toStopId, tripId: $tripId, passengerId: $passengerId, fromStop: $fromStop, toStop: $toStop, trip: $trip)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TicketModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.seatNumber, seatNumber) ||
                other.seatNumber == seatNumber) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.qrCode, qrCode) || other.qrCode == qrCode) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.passengerType, passengerType) ||
                other.passengerType == passengerType) &&
            (identical(other.discountAmount, discountAmount) ||
                other.discountAmount == discountAmount) &&
            (identical(other.cancelledAt, cancelledAt) ||
                other.cancelledAt == cancelledAt) &&
            (identical(other.refundAmount, refundAmount) ||
                other.refundAmount == refundAmount) &&
            (identical(other.cancellationPolicy, cancellationPolicy) ||
                other.cancellationPolicy == cancellationPolicy) &&
            (identical(other.fromStopId, fromStopId) ||
                other.fromStopId == fromStopId) &&
            (identical(other.toStopId, toStopId) ||
                other.toStopId == toStopId) &&
            (identical(other.tripId, tripId) || other.tripId == tripId) &&
            (identical(other.passengerId, passengerId) ||
                other.passengerId == passengerId) &&
            (identical(other.fromStop, fromStop) ||
                other.fromStop == fromStop) &&
            (identical(other.toStop, toStop) || other.toStop == toStop) &&
            (identical(other.trip, trip) || other.trip == trip));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    seatNumber,
    price,
    paymentMethod,
    status,
    qrCode,
    createdAt,
    passengerType,
    discountAmount,
    cancelledAt,
    refundAmount,
    cancellationPolicy,
    fromStopId,
    toStopId,
    tripId,
    passengerId,
    fromStop,
    toStop,
    trip,
  ]);

  /// Create a copy of TicketModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TicketModelImplCopyWith<_$TicketModelImpl> get copyWith =>
      __$$TicketModelImplCopyWithImpl<_$TicketModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TicketModelImplToJson(this);
  }
}

abstract class _TicketModel implements TicketModel {
  const factory _TicketModel({
    required final int id,
    required final String seatNumber,
    required final double price,
    required final PaymentMethod paymentMethod,
    required final TicketStatus status,
    required final String qrCode,
    required final String createdAt,
    final PassengerType? passengerType,
    final double? discountAmount,
    final String? cancelledAt,
    final double? refundAmount,
    final CancellationPolicy? cancellationPolicy,
    required final int fromStopId,
    required final int toStopId,
    required final int tripId,
    required final int passengerId,
    final StopModel? fromStop,
    final StopModel? toStop,
    final TripModel? trip,
  }) = _$TicketModelImpl;

  factory _TicketModel.fromJson(Map<String, dynamic> json) =
      _$TicketModelImpl.fromJson;

  @override
  int get id;
  @override
  String get seatNumber;
  @override
  double get price;
  @override
  PaymentMethod get paymentMethod;
  @override
  TicketStatus get status;
  @override
  String get qrCode;
  @override
  String get createdAt;
  @override
  PassengerType? get passengerType;
  @override
  double? get discountAmount;
  @override
  String? get cancelledAt;
  @override
  double? get refundAmount;
  @override
  CancellationPolicy? get cancellationPolicy;
  @override
  int get fromStopId;
  @override
  int get toStopId;
  @override
  int get tripId;
  @override
  int get passengerId;
  @override
  StopModel? get fromStop;
  @override
  StopModel? get toStop;
  @override
  TripModel? get trip;

  /// Create a copy of TicketModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TicketModelImplCopyWith<_$TicketModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TicketCreateRequest _$TicketCreateRequestFromJson(Map<String, dynamic> json) {
  return _TicketCreateRequest.fromJson(json);
}

/// @nodoc
mixin _$TicketCreateRequest {
  int get tripId => throw _privateConstructorUsedError;
  String get seatNumber => throw _privateConstructorUsedError;
  int get fromStopId => throw _privateConstructorUsedError;
  int get toStopId => throw _privateConstructorUsedError;
  int get passengerId => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  PaymentMethod get paymentMethod => throw _privateConstructorUsedError;
  PassengerType? get passengerType => throw _privateConstructorUsedError;
  double? get discountAmount => throw _privateConstructorUsedError;

  /// Serializes this TicketCreateRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TicketCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TicketCreateRequestCopyWith<TicketCreateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TicketCreateRequestCopyWith<$Res> {
  factory $TicketCreateRequestCopyWith(
    TicketCreateRequest value,
    $Res Function(TicketCreateRequest) then,
  ) = _$TicketCreateRequestCopyWithImpl<$Res, TicketCreateRequest>;
  @useResult
  $Res call({
    int tripId,
    String seatNumber,
    int fromStopId,
    int toStopId,
    int passengerId,
    double price,
    PaymentMethod paymentMethod,
    PassengerType? passengerType,
    double? discountAmount,
  });
}

/// @nodoc
class _$TicketCreateRequestCopyWithImpl<$Res, $Val extends TicketCreateRequest>
    implements $TicketCreateRequestCopyWith<$Res> {
  _$TicketCreateRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TicketCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tripId = null,
    Object? seatNumber = null,
    Object? fromStopId = null,
    Object? toStopId = null,
    Object? passengerId = null,
    Object? price = null,
    Object? paymentMethod = null,
    Object? passengerType = freezed,
    Object? discountAmount = freezed,
  }) {
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
            fromStopId: null == fromStopId
                ? _value.fromStopId
                : fromStopId // ignore: cast_nullable_to_non_nullable
                      as int,
            toStopId: null == toStopId
                ? _value.toStopId
                : toStopId // ignore: cast_nullable_to_non_nullable
                      as int,
            passengerId: null == passengerId
                ? _value.passengerId
                : passengerId // ignore: cast_nullable_to_non_nullable
                      as int,
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as double,
            paymentMethod: null == paymentMethod
                ? _value.paymentMethod
                : paymentMethod // ignore: cast_nullable_to_non_nullable
                      as PaymentMethod,
            passengerType: freezed == passengerType
                ? _value.passengerType
                : passengerType // ignore: cast_nullable_to_non_nullable
                      as PassengerType?,
            discountAmount: freezed == discountAmount
                ? _value.discountAmount
                : discountAmount // ignore: cast_nullable_to_non_nullable
                      as double?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TicketCreateRequestImplCopyWith<$Res>
    implements $TicketCreateRequestCopyWith<$Res> {
  factory _$$TicketCreateRequestImplCopyWith(
    _$TicketCreateRequestImpl value,
    $Res Function(_$TicketCreateRequestImpl) then,
  ) = __$$TicketCreateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int tripId,
    String seatNumber,
    int fromStopId,
    int toStopId,
    int passengerId,
    double price,
    PaymentMethod paymentMethod,
    PassengerType? passengerType,
    double? discountAmount,
  });
}

/// @nodoc
class __$$TicketCreateRequestImplCopyWithImpl<$Res>
    extends _$TicketCreateRequestCopyWithImpl<$Res, _$TicketCreateRequestImpl>
    implements _$$TicketCreateRequestImplCopyWith<$Res> {
  __$$TicketCreateRequestImplCopyWithImpl(
    _$TicketCreateRequestImpl _value,
    $Res Function(_$TicketCreateRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TicketCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tripId = null,
    Object? seatNumber = null,
    Object? fromStopId = null,
    Object? toStopId = null,
    Object? passengerId = null,
    Object? price = null,
    Object? paymentMethod = null,
    Object? passengerType = freezed,
    Object? discountAmount = freezed,
  }) {
    return _then(
      _$TicketCreateRequestImpl(
        tripId: null == tripId
            ? _value.tripId
            : tripId // ignore: cast_nullable_to_non_nullable
                  as int,
        seatNumber: null == seatNumber
            ? _value.seatNumber
            : seatNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        fromStopId: null == fromStopId
            ? _value.fromStopId
            : fromStopId // ignore: cast_nullable_to_non_nullable
                  as int,
        toStopId: null == toStopId
            ? _value.toStopId
            : toStopId // ignore: cast_nullable_to_non_nullable
                  as int,
        passengerId: null == passengerId
            ? _value.passengerId
            : passengerId // ignore: cast_nullable_to_non_nullable
                  as int,
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as double,
        paymentMethod: null == paymentMethod
            ? _value.paymentMethod
            : paymentMethod // ignore: cast_nullable_to_non_nullable
                  as PaymentMethod,
        passengerType: freezed == passengerType
            ? _value.passengerType
            : passengerType // ignore: cast_nullable_to_non_nullable
                  as PassengerType?,
        discountAmount: freezed == discountAmount
            ? _value.discountAmount
            : discountAmount // ignore: cast_nullable_to_non_nullable
                  as double?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TicketCreateRequestImpl implements _TicketCreateRequest {
  const _$TicketCreateRequestImpl({
    required this.tripId,
    required this.seatNumber,
    required this.fromStopId,
    required this.toStopId,
    required this.passengerId,
    required this.price,
    required this.paymentMethod,
    this.passengerType,
    this.discountAmount,
  });

  factory _$TicketCreateRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$TicketCreateRequestImplFromJson(json);

  @override
  final int tripId;
  @override
  final String seatNumber;
  @override
  final int fromStopId;
  @override
  final int toStopId;
  @override
  final int passengerId;
  @override
  final double price;
  @override
  final PaymentMethod paymentMethod;
  @override
  final PassengerType? passengerType;
  @override
  final double? discountAmount;

  @override
  String toString() {
    return 'TicketCreateRequest(tripId: $tripId, seatNumber: $seatNumber, fromStopId: $fromStopId, toStopId: $toStopId, passengerId: $passengerId, price: $price, paymentMethod: $paymentMethod, passengerType: $passengerType, discountAmount: $discountAmount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TicketCreateRequestImpl &&
            (identical(other.tripId, tripId) || other.tripId == tripId) &&
            (identical(other.seatNumber, seatNumber) ||
                other.seatNumber == seatNumber) &&
            (identical(other.fromStopId, fromStopId) ||
                other.fromStopId == fromStopId) &&
            (identical(other.toStopId, toStopId) ||
                other.toStopId == toStopId) &&
            (identical(other.passengerId, passengerId) ||
                other.passengerId == passengerId) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.passengerType, passengerType) ||
                other.passengerType == passengerType) &&
            (identical(other.discountAmount, discountAmount) ||
                other.discountAmount == discountAmount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    tripId,
    seatNumber,
    fromStopId,
    toStopId,
    passengerId,
    price,
    paymentMethod,
    passengerType,
    discountAmount,
  );

  /// Create a copy of TicketCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TicketCreateRequestImplCopyWith<_$TicketCreateRequestImpl> get copyWith =>
      __$$TicketCreateRequestImplCopyWithImpl<_$TicketCreateRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TicketCreateRequestImplToJson(this);
  }
}

abstract class _TicketCreateRequest implements TicketCreateRequest {
  const factory _TicketCreateRequest({
    required final int tripId,
    required final String seatNumber,
    required final int fromStopId,
    required final int toStopId,
    required final int passengerId,
    required final double price,
    required final PaymentMethod paymentMethod,
    final PassengerType? passengerType,
    final double? discountAmount,
  }) = _$TicketCreateRequestImpl;

  factory _TicketCreateRequest.fromJson(Map<String, dynamic> json) =
      _$TicketCreateRequestImpl.fromJson;

  @override
  int get tripId;
  @override
  String get seatNumber;
  @override
  int get fromStopId;
  @override
  int get toStopId;
  @override
  int get passengerId;
  @override
  double get price;
  @override
  PaymentMethod get paymentMethod;
  @override
  PassengerType? get passengerType;
  @override
  double? get discountAmount;

  /// Create a copy of TicketCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TicketCreateRequestImplCopyWith<_$TicketCreateRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TicketUpdateRequest _$TicketUpdateRequestFromJson(Map<String, dynamic> json) {
  return _TicketUpdateRequest.fromJson(json);
}

/// @nodoc
mixin _$TicketUpdateRequest {
  String? get seatNumber => throw _privateConstructorUsedError;
  double? get price => throw _privateConstructorUsedError;
  PaymentMethod? get paymentMethod => throw _privateConstructorUsedError;
  TicketStatus? get status => throw _privateConstructorUsedError;

  /// Serializes this TicketUpdateRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TicketUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TicketUpdateRequestCopyWith<TicketUpdateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TicketUpdateRequestCopyWith<$Res> {
  factory $TicketUpdateRequestCopyWith(
    TicketUpdateRequest value,
    $Res Function(TicketUpdateRequest) then,
  ) = _$TicketUpdateRequestCopyWithImpl<$Res, TicketUpdateRequest>;
  @useResult
  $Res call({
    String? seatNumber,
    double? price,
    PaymentMethod? paymentMethod,
    TicketStatus? status,
  });
}

/// @nodoc
class _$TicketUpdateRequestCopyWithImpl<$Res, $Val extends TicketUpdateRequest>
    implements $TicketUpdateRequestCopyWith<$Res> {
  _$TicketUpdateRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TicketUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? seatNumber = freezed,
    Object? price = freezed,
    Object? paymentMethod = freezed,
    Object? status = freezed,
  }) {
    return _then(
      _value.copyWith(
            seatNumber: freezed == seatNumber
                ? _value.seatNumber
                : seatNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            price: freezed == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as double?,
            paymentMethod: freezed == paymentMethod
                ? _value.paymentMethod
                : paymentMethod // ignore: cast_nullable_to_non_nullable
                      as PaymentMethod?,
            status: freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as TicketStatus?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TicketUpdateRequestImplCopyWith<$Res>
    implements $TicketUpdateRequestCopyWith<$Res> {
  factory _$$TicketUpdateRequestImplCopyWith(
    _$TicketUpdateRequestImpl value,
    $Res Function(_$TicketUpdateRequestImpl) then,
  ) = __$$TicketUpdateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? seatNumber,
    double? price,
    PaymentMethod? paymentMethod,
    TicketStatus? status,
  });
}

/// @nodoc
class __$$TicketUpdateRequestImplCopyWithImpl<$Res>
    extends _$TicketUpdateRequestCopyWithImpl<$Res, _$TicketUpdateRequestImpl>
    implements _$$TicketUpdateRequestImplCopyWith<$Res> {
  __$$TicketUpdateRequestImplCopyWithImpl(
    _$TicketUpdateRequestImpl _value,
    $Res Function(_$TicketUpdateRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TicketUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? seatNumber = freezed,
    Object? price = freezed,
    Object? paymentMethod = freezed,
    Object? status = freezed,
  }) {
    return _then(
      _$TicketUpdateRequestImpl(
        seatNumber: freezed == seatNumber
            ? _value.seatNumber
            : seatNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        price: freezed == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as double?,
        paymentMethod: freezed == paymentMethod
            ? _value.paymentMethod
            : paymentMethod // ignore: cast_nullable_to_non_nullable
                  as PaymentMethod?,
        status: freezed == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as TicketStatus?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TicketUpdateRequestImpl implements _TicketUpdateRequest {
  const _$TicketUpdateRequestImpl({
    this.seatNumber,
    this.price,
    this.paymentMethod,
    this.status,
  });

  factory _$TicketUpdateRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$TicketUpdateRequestImplFromJson(json);

  @override
  final String? seatNumber;
  @override
  final double? price;
  @override
  final PaymentMethod? paymentMethod;
  @override
  final TicketStatus? status;

  @override
  String toString() {
    return 'TicketUpdateRequest(seatNumber: $seatNumber, price: $price, paymentMethod: $paymentMethod, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TicketUpdateRequestImpl &&
            (identical(other.seatNumber, seatNumber) ||
                other.seatNumber == seatNumber) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, seatNumber, price, paymentMethod, status);

  /// Create a copy of TicketUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TicketUpdateRequestImplCopyWith<_$TicketUpdateRequestImpl> get copyWith =>
      __$$TicketUpdateRequestImplCopyWithImpl<_$TicketUpdateRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TicketUpdateRequestImplToJson(this);
  }
}

abstract class _TicketUpdateRequest implements TicketUpdateRequest {
  const factory _TicketUpdateRequest({
    final String? seatNumber,
    final double? price,
    final PaymentMethod? paymentMethod,
    final TicketStatus? status,
  }) = _$TicketUpdateRequestImpl;

  factory _TicketUpdateRequest.fromJson(Map<String, dynamic> json) =
      _$TicketUpdateRequestImpl.fromJson;

  @override
  String? get seatNumber;
  @override
  double? get price;
  @override
  PaymentMethod? get paymentMethod;
  @override
  TicketStatus? get status;

  /// Create a copy of TicketUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TicketUpdateRequestImplCopyWith<_$TicketUpdateRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
