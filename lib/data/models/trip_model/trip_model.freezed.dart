// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TripModel _$TripModelFromJson(Map<String, dynamic> json) {
  return _TripModel.fromJson(json);
}

/// @nodoc
mixin _$TripModel {
  int get id => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  DateTime get departureAt => throw _privateConstructorUsedError;
  DateTime get arrivalEta => throw _privateConstructorUsedError;
  TripStatus get status => throw _privateConstructorUsedError;
  int get routeId => throw _privateConstructorUsedError;
  int? get busId => throw _privateConstructorUsedError;
  RouteModel? get route => throw _privateConstructorUsedError;
  BusModel? get bus => throw _privateConstructorUsedError;
  int? get capacity => throw _privateConstructorUsedError;

  /// Serializes this TripModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TripModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TripModelCopyWith<TripModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TripModelCopyWith<$Res> {
  factory $TripModelCopyWith(TripModel value, $Res Function(TripModel) then) =
      _$TripModelCopyWithImpl<$Res, TripModel>;
  @useResult
  $Res call({
    int id,
    DateTime date,
    DateTime departureAt,
    DateTime arrivalEta,
    TripStatus status,
    int routeId,
    int? busId,
    RouteModel? route,
    BusModel? bus,
    int? capacity,
  });

  $RouteModelCopyWith<$Res>? get route;
  $BusModelCopyWith<$Res>? get bus;
}

/// @nodoc
class _$TripModelCopyWithImpl<$Res, $Val extends TripModel>
    implements $TripModelCopyWith<$Res> {
  _$TripModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TripModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? departureAt = null,
    Object? arrivalEta = null,
    Object? status = null,
    Object? routeId = null,
    Object? busId = freezed,
    Object? route = freezed,
    Object? bus = freezed,
    Object? capacity = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            departureAt: null == departureAt
                ? _value.departureAt
                : departureAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            arrivalEta: null == arrivalEta
                ? _value.arrivalEta
                : arrivalEta // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as TripStatus,
            routeId: null == routeId
                ? _value.routeId
                : routeId // ignore: cast_nullable_to_non_nullable
                      as int,
            busId: freezed == busId
                ? _value.busId
                : busId // ignore: cast_nullable_to_non_nullable
                      as int?,
            route: freezed == route
                ? _value.route
                : route // ignore: cast_nullable_to_non_nullable
                      as RouteModel?,
            bus: freezed == bus
                ? _value.bus
                : bus // ignore: cast_nullable_to_non_nullable
                      as BusModel?,
            capacity: freezed == capacity
                ? _value.capacity
                : capacity // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }

  /// Create a copy of TripModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RouteModelCopyWith<$Res>? get route {
    if (_value.route == null) {
      return null;
    }

    return $RouteModelCopyWith<$Res>(_value.route!, (value) {
      return _then(_value.copyWith(route: value) as $Val);
    });
  }

  /// Create a copy of TripModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BusModelCopyWith<$Res>? get bus {
    if (_value.bus == null) {
      return null;
    }

    return $BusModelCopyWith<$Res>(_value.bus!, (value) {
      return _then(_value.copyWith(bus: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TripModelImplCopyWith<$Res>
    implements $TripModelCopyWith<$Res> {
  factory _$$TripModelImplCopyWith(
    _$TripModelImpl value,
    $Res Function(_$TripModelImpl) then,
  ) = __$$TripModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    DateTime date,
    DateTime departureAt,
    DateTime arrivalEta,
    TripStatus status,
    int routeId,
    int? busId,
    RouteModel? route,
    BusModel? bus,
    int? capacity,
  });

  @override
  $RouteModelCopyWith<$Res>? get route;
  @override
  $BusModelCopyWith<$Res>? get bus;
}

/// @nodoc
class __$$TripModelImplCopyWithImpl<$Res>
    extends _$TripModelCopyWithImpl<$Res, _$TripModelImpl>
    implements _$$TripModelImplCopyWith<$Res> {
  __$$TripModelImplCopyWithImpl(
    _$TripModelImpl _value,
    $Res Function(_$TripModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TripModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? departureAt = null,
    Object? arrivalEta = null,
    Object? status = null,
    Object? routeId = null,
    Object? busId = freezed,
    Object? route = freezed,
    Object? bus = freezed,
    Object? capacity = freezed,
  }) {
    return _then(
      _$TripModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        departureAt: null == departureAt
            ? _value.departureAt
            : departureAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        arrivalEta: null == arrivalEta
            ? _value.arrivalEta
            : arrivalEta // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as TripStatus,
        routeId: null == routeId
            ? _value.routeId
            : routeId // ignore: cast_nullable_to_non_nullable
                  as int,
        busId: freezed == busId
            ? _value.busId
            : busId // ignore: cast_nullable_to_non_nullable
                  as int?,
        route: freezed == route
            ? _value.route
            : route // ignore: cast_nullable_to_non_nullable
                  as RouteModel?,
        bus: freezed == bus
            ? _value.bus
            : bus // ignore: cast_nullable_to_non_nullable
                  as BusModel?,
        capacity: freezed == capacity
            ? _value.capacity
            : capacity // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TripModelImpl implements _TripModel {
  const _$TripModelImpl({
    required this.id,
    required this.date,
    required this.departureAt,
    required this.arrivalEta,
    required this.status,
    required this.routeId,
    this.busId,
    this.route,
    this.bus,
    this.capacity,
  });

  factory _$TripModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TripModelImplFromJson(json);

  @override
  final int id;
  @override
  final DateTime date;
  @override
  final DateTime departureAt;
  @override
  final DateTime arrivalEta;
  @override
  final TripStatus status;
  @override
  final int routeId;
  @override
  final int? busId;
  @override
  final RouteModel? route;
  @override
  final BusModel? bus;
  @override
  final int? capacity;

  @override
  String toString() {
    return 'TripModel(id: $id, date: $date, departureAt: $departureAt, arrivalEta: $arrivalEta, status: $status, routeId: $routeId, busId: $busId, route: $route, bus: $bus, capacity: $capacity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TripModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.departureAt, departureAt) ||
                other.departureAt == departureAt) &&
            (identical(other.arrivalEta, arrivalEta) ||
                other.arrivalEta == arrivalEta) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.routeId, routeId) || other.routeId == routeId) &&
            (identical(other.busId, busId) || other.busId == busId) &&
            (identical(other.route, route) || other.route == route) &&
            (identical(other.bus, bus) || other.bus == bus) &&
            (identical(other.capacity, capacity) ||
                other.capacity == capacity));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    date,
    departureAt,
    arrivalEta,
    status,
    routeId,
    busId,
    route,
    bus,
    capacity,
  );

  /// Create a copy of TripModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TripModelImplCopyWith<_$TripModelImpl> get copyWith =>
      __$$TripModelImplCopyWithImpl<_$TripModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TripModelImplToJson(this);
  }
}

abstract class _TripModel implements TripModel {
  const factory _TripModel({
    required final int id,
    required final DateTime date,
    required final DateTime departureAt,
    required final DateTime arrivalEta,
    required final TripStatus status,
    required final int routeId,
    final int? busId,
    final RouteModel? route,
    final BusModel? bus,
    final int? capacity,
  }) = _$TripModelImpl;

  factory _TripModel.fromJson(Map<String, dynamic> json) =
      _$TripModelImpl.fromJson;

  @override
  int get id;
  @override
  DateTime get date;
  @override
  DateTime get departureAt;
  @override
  DateTime get arrivalEta;
  @override
  TripStatus get status;
  @override
  int get routeId;
  @override
  int? get busId;
  @override
  RouteModel? get route;
  @override
  BusModel? get bus;
  @override
  int? get capacity;

  /// Create a copy of TripModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TripModelImplCopyWith<_$TripModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TripCreateRequest _$TripCreateRequestFromJson(Map<String, dynamic> json) {
  return _TripCreateRequest.fromJson(json);
}

/// @nodoc
mixin _$TripCreateRequest {
  int get routeId => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError; // "YYYY-MM-DD"
  DateTime get departureAt =>
      throw _privateConstructorUsedError; // "YYYY-MM-DDTHH:mm:ss"
  DateTime? get arrivalEta => throw _privateConstructorUsedError;
  int? get busId => throw _privateConstructorUsedError;

  /// Serializes this TripCreateRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TripCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TripCreateRequestCopyWith<TripCreateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TripCreateRequestCopyWith<$Res> {
  factory $TripCreateRequestCopyWith(
    TripCreateRequest value,
    $Res Function(TripCreateRequest) then,
  ) = _$TripCreateRequestCopyWithImpl<$Res, TripCreateRequest>;
  @useResult
  $Res call({
    int routeId,
    DateTime date,
    DateTime departureAt,
    DateTime? arrivalEta,
    int? busId,
  });
}

/// @nodoc
class _$TripCreateRequestCopyWithImpl<$Res, $Val extends TripCreateRequest>
    implements $TripCreateRequestCopyWith<$Res> {
  _$TripCreateRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TripCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? routeId = null,
    Object? date = null,
    Object? departureAt = null,
    Object? arrivalEta = freezed,
    Object? busId = freezed,
  }) {
    return _then(
      _value.copyWith(
            routeId: null == routeId
                ? _value.routeId
                : routeId // ignore: cast_nullable_to_non_nullable
                      as int,
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            departureAt: null == departureAt
                ? _value.departureAt
                : departureAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            arrivalEta: freezed == arrivalEta
                ? _value.arrivalEta
                : arrivalEta // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            busId: freezed == busId
                ? _value.busId
                : busId // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TripCreateRequestImplCopyWith<$Res>
    implements $TripCreateRequestCopyWith<$Res> {
  factory _$$TripCreateRequestImplCopyWith(
    _$TripCreateRequestImpl value,
    $Res Function(_$TripCreateRequestImpl) then,
  ) = __$$TripCreateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int routeId,
    DateTime date,
    DateTime departureAt,
    DateTime? arrivalEta,
    int? busId,
  });
}

/// @nodoc
class __$$TripCreateRequestImplCopyWithImpl<$Res>
    extends _$TripCreateRequestCopyWithImpl<$Res, _$TripCreateRequestImpl>
    implements _$$TripCreateRequestImplCopyWith<$Res> {
  __$$TripCreateRequestImplCopyWithImpl(
    _$TripCreateRequestImpl _value,
    $Res Function(_$TripCreateRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TripCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? routeId = null,
    Object? date = null,
    Object? departureAt = null,
    Object? arrivalEta = freezed,
    Object? busId = freezed,
  }) {
    return _then(
      _$TripCreateRequestImpl(
        routeId: null == routeId
            ? _value.routeId
            : routeId // ignore: cast_nullable_to_non_nullable
                  as int,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        departureAt: null == departureAt
            ? _value.departureAt
            : departureAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        arrivalEta: freezed == arrivalEta
            ? _value.arrivalEta
            : arrivalEta // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        busId: freezed == busId
            ? _value.busId
            : busId // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TripCreateRequestImpl implements _TripCreateRequest {
  const _$TripCreateRequestImpl({
    required this.routeId,
    required this.date,
    required this.departureAt,
    required this.arrivalEta,
    this.busId,
  });

  factory _$TripCreateRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$TripCreateRequestImplFromJson(json);

  @override
  final int routeId;
  @override
  final DateTime date;
  // "YYYY-MM-DD"
  @override
  final DateTime departureAt;
  // "YYYY-MM-DDTHH:mm:ss"
  @override
  final DateTime? arrivalEta;
  @override
  final int? busId;

  @override
  String toString() {
    return 'TripCreateRequest(routeId: $routeId, date: $date, departureAt: $departureAt, arrivalEta: $arrivalEta, busId: $busId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TripCreateRequestImpl &&
            (identical(other.routeId, routeId) || other.routeId == routeId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.departureAt, departureAt) ||
                other.departureAt == departureAt) &&
            (identical(other.arrivalEta, arrivalEta) ||
                other.arrivalEta == arrivalEta) &&
            (identical(other.busId, busId) || other.busId == busId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, routeId, date, departureAt, arrivalEta, busId);

  /// Create a copy of TripCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TripCreateRequestImplCopyWith<_$TripCreateRequestImpl> get copyWith =>
      __$$TripCreateRequestImplCopyWithImpl<_$TripCreateRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TripCreateRequestImplToJson(this);
  }
}

abstract class _TripCreateRequest implements TripCreateRequest {
  const factory _TripCreateRequest({
    required final int routeId,
    required final DateTime date,
    required final DateTime departureAt,
    required final DateTime? arrivalEta,
    final int? busId,
  }) = _$TripCreateRequestImpl;

  factory _TripCreateRequest.fromJson(Map<String, dynamic> json) =
      _$TripCreateRequestImpl.fromJson;

  @override
  int get routeId;
  @override
  DateTime get date; // "YYYY-MM-DD"
  @override
  DateTime get departureAt; // "YYYY-MM-DDTHH:mm:ss"
  @override
  DateTime? get arrivalEta;
  @override
  int? get busId;

  /// Create a copy of TripCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TripCreateRequestImplCopyWith<_$TripCreateRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TripUpdateRequest _$TripUpdateRequestFromJson(Map<String, dynamic> json) {
  return _TripUpdateRequest.fromJson(json);
}

/// @nodoc
mixin _$TripUpdateRequest {
  DateTime? get date => throw _privateConstructorUsedError;
  DateTime? get departureAt => throw _privateConstructorUsedError;
  DateTime? get arrivalEta => throw _privateConstructorUsedError;
  int? get busId => throw _privateConstructorUsedError;
  TripStatus? get status => throw _privateConstructorUsedError;

  /// Serializes this TripUpdateRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TripUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TripUpdateRequestCopyWith<TripUpdateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TripUpdateRequestCopyWith<$Res> {
  factory $TripUpdateRequestCopyWith(
    TripUpdateRequest value,
    $Res Function(TripUpdateRequest) then,
  ) = _$TripUpdateRequestCopyWithImpl<$Res, TripUpdateRequest>;
  @useResult
  $Res call({
    DateTime? date,
    DateTime? departureAt,
    DateTime? arrivalEta,
    int? busId,
    TripStatus? status,
  });
}

/// @nodoc
class _$TripUpdateRequestCopyWithImpl<$Res, $Val extends TripUpdateRequest>
    implements $TripUpdateRequestCopyWith<$Res> {
  _$TripUpdateRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TripUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = freezed,
    Object? departureAt = freezed,
    Object? arrivalEta = freezed,
    Object? busId = freezed,
    Object? status = freezed,
  }) {
    return _then(
      _value.copyWith(
            date: freezed == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            departureAt: freezed == departureAt
                ? _value.departureAt
                : departureAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            arrivalEta: freezed == arrivalEta
                ? _value.arrivalEta
                : arrivalEta // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            busId: freezed == busId
                ? _value.busId
                : busId // ignore: cast_nullable_to_non_nullable
                      as int?,
            status: freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as TripStatus?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TripUpdateRequestImplCopyWith<$Res>
    implements $TripUpdateRequestCopyWith<$Res> {
  factory _$$TripUpdateRequestImplCopyWith(
    _$TripUpdateRequestImpl value,
    $Res Function(_$TripUpdateRequestImpl) then,
  ) = __$$TripUpdateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    DateTime? date,
    DateTime? departureAt,
    DateTime? arrivalEta,
    int? busId,
    TripStatus? status,
  });
}

/// @nodoc
class __$$TripUpdateRequestImplCopyWithImpl<$Res>
    extends _$TripUpdateRequestCopyWithImpl<$Res, _$TripUpdateRequestImpl>
    implements _$$TripUpdateRequestImplCopyWith<$Res> {
  __$$TripUpdateRequestImplCopyWithImpl(
    _$TripUpdateRequestImpl _value,
    $Res Function(_$TripUpdateRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TripUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = freezed,
    Object? departureAt = freezed,
    Object? arrivalEta = freezed,
    Object? busId = freezed,
    Object? status = freezed,
  }) {
    return _then(
      _$TripUpdateRequestImpl(
        date: freezed == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        departureAt: freezed == departureAt
            ? _value.departureAt
            : departureAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        arrivalEta: freezed == arrivalEta
            ? _value.arrivalEta
            : arrivalEta // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        busId: freezed == busId
            ? _value.busId
            : busId // ignore: cast_nullable_to_non_nullable
                  as int?,
        status: freezed == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as TripStatus?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TripUpdateRequestImpl implements _TripUpdateRequest {
  const _$TripUpdateRequestImpl({
    this.date,
    this.departureAt,
    this.arrivalEta,
    this.busId,
    this.status,
  });

  factory _$TripUpdateRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$TripUpdateRequestImplFromJson(json);

  @override
  final DateTime? date;
  @override
  final DateTime? departureAt;
  @override
  final DateTime? arrivalEta;
  @override
  final int? busId;
  @override
  final TripStatus? status;

  @override
  String toString() {
    return 'TripUpdateRequest(date: $date, departureAt: $departureAt, arrivalEta: $arrivalEta, busId: $busId, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TripUpdateRequestImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.departureAt, departureAt) ||
                other.departureAt == departureAt) &&
            (identical(other.arrivalEta, arrivalEta) ||
                other.arrivalEta == arrivalEta) &&
            (identical(other.busId, busId) || other.busId == busId) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, date, departureAt, arrivalEta, busId, status);

  /// Create a copy of TripUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TripUpdateRequestImplCopyWith<_$TripUpdateRequestImpl> get copyWith =>
      __$$TripUpdateRequestImplCopyWithImpl<_$TripUpdateRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TripUpdateRequestImplToJson(this);
  }
}

abstract class _TripUpdateRequest implements TripUpdateRequest {
  const factory _TripUpdateRequest({
    final DateTime? date,
    final DateTime? departureAt,
    final DateTime? arrivalEta,
    final int? busId,
    final TripStatus? status,
  }) = _$TripUpdateRequestImpl;

  factory _TripUpdateRequest.fromJson(Map<String, dynamic> json) =
      _$TripUpdateRequestImpl.fromJson;

  @override
  DateTime? get date;
  @override
  DateTime? get departureAt;
  @override
  DateTime? get arrivalEta;
  @override
  int? get busId;
  @override
  TripStatus? get status;

  /// Create a copy of TripUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TripUpdateRequestImplCopyWith<_$TripUpdateRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
