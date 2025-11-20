// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'assignment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AssignmentModel _$AssignmentModelFromJson(Map<String, dynamic> json) {
  return _AssignmentModel.fromJson(json);
}

/// @nodoc
mixin _$AssignmentModel {
  int get id => throw _privateConstructorUsedError;
  bool get checklistOk => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _dateFromJson, toJson: _dateToJson)
  DateTime get assignedAt => throw _privateConstructorUsedError;
  int get tripId => throw _privateConstructorUsedError;
  int get driverId => throw _privateConstructorUsedError;
  int get dispatcherId => throw _privateConstructorUsedError;
  TripModel? get trip => throw _privateConstructorUsedError;
  UserModel? get driver => throw _privateConstructorUsedError;
  UserModel? get dispatcher => throw _privateConstructorUsedError;

  /// Serializes this AssignmentModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AssignmentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AssignmentModelCopyWith<AssignmentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AssignmentModelCopyWith<$Res> {
  factory $AssignmentModelCopyWith(
    AssignmentModel value,
    $Res Function(AssignmentModel) then,
  ) = _$AssignmentModelCopyWithImpl<$Res, AssignmentModel>;
  @useResult
  $Res call({
    int id,
    bool checklistOk,
    @JsonKey(fromJson: _dateFromJson, toJson: _dateToJson) DateTime assignedAt,
    int tripId,
    int driverId,
    int dispatcherId,
    TripModel? trip,
    UserModel? driver,
    UserModel? dispatcher,
  });

  $TripModelCopyWith<$Res>? get trip;
  $UserModelCopyWith<$Res>? get driver;
  $UserModelCopyWith<$Res>? get dispatcher;
}

/// @nodoc
class _$AssignmentModelCopyWithImpl<$Res, $Val extends AssignmentModel>
    implements $AssignmentModelCopyWith<$Res> {
  _$AssignmentModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AssignmentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? checklistOk = null,
    Object? assignedAt = null,
    Object? tripId = null,
    Object? driverId = null,
    Object? dispatcherId = null,
    Object? trip = freezed,
    Object? driver = freezed,
    Object? dispatcher = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            checklistOk: null == checklistOk
                ? _value.checklistOk
                : checklistOk // ignore: cast_nullable_to_non_nullable
                      as bool,
            assignedAt: null == assignedAt
                ? _value.assignedAt
                : assignedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            tripId: null == tripId
                ? _value.tripId
                : tripId // ignore: cast_nullable_to_non_nullable
                      as int,
            driverId: null == driverId
                ? _value.driverId
                : driverId // ignore: cast_nullable_to_non_nullable
                      as int,
            dispatcherId: null == dispatcherId
                ? _value.dispatcherId
                : dispatcherId // ignore: cast_nullable_to_non_nullable
                      as int,
            trip: freezed == trip
                ? _value.trip
                : trip // ignore: cast_nullable_to_non_nullable
                      as TripModel?,
            driver: freezed == driver
                ? _value.driver
                : driver // ignore: cast_nullable_to_non_nullable
                      as UserModel?,
            dispatcher: freezed == dispatcher
                ? _value.dispatcher
                : dispatcher // ignore: cast_nullable_to_non_nullable
                      as UserModel?,
          )
          as $Val,
    );
  }

  /// Create a copy of AssignmentModel
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

  /// Create a copy of AssignmentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res>? get driver {
    if (_value.driver == null) {
      return null;
    }

    return $UserModelCopyWith<$Res>(_value.driver!, (value) {
      return _then(_value.copyWith(driver: value) as $Val);
    });
  }

  /// Create a copy of AssignmentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res>? get dispatcher {
    if (_value.dispatcher == null) {
      return null;
    }

    return $UserModelCopyWith<$Res>(_value.dispatcher!, (value) {
      return _then(_value.copyWith(dispatcher: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AssignmentModelImplCopyWith<$Res>
    implements $AssignmentModelCopyWith<$Res> {
  factory _$$AssignmentModelImplCopyWith(
    _$AssignmentModelImpl value,
    $Res Function(_$AssignmentModelImpl) then,
  ) = __$$AssignmentModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    bool checklistOk,
    @JsonKey(fromJson: _dateFromJson, toJson: _dateToJson) DateTime assignedAt,
    int tripId,
    int driverId,
    int dispatcherId,
    TripModel? trip,
    UserModel? driver,
    UserModel? dispatcher,
  });

  @override
  $TripModelCopyWith<$Res>? get trip;
  @override
  $UserModelCopyWith<$Res>? get driver;
  @override
  $UserModelCopyWith<$Res>? get dispatcher;
}

/// @nodoc
class __$$AssignmentModelImplCopyWithImpl<$Res>
    extends _$AssignmentModelCopyWithImpl<$Res, _$AssignmentModelImpl>
    implements _$$AssignmentModelImplCopyWith<$Res> {
  __$$AssignmentModelImplCopyWithImpl(
    _$AssignmentModelImpl _value,
    $Res Function(_$AssignmentModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AssignmentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? checklistOk = null,
    Object? assignedAt = null,
    Object? tripId = null,
    Object? driverId = null,
    Object? dispatcherId = null,
    Object? trip = freezed,
    Object? driver = freezed,
    Object? dispatcher = freezed,
  }) {
    return _then(
      _$AssignmentModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        checklistOk: null == checklistOk
            ? _value.checklistOk
            : checklistOk // ignore: cast_nullable_to_non_nullable
                  as bool,
        assignedAt: null == assignedAt
            ? _value.assignedAt
            : assignedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        tripId: null == tripId
            ? _value.tripId
            : tripId // ignore: cast_nullable_to_non_nullable
                  as int,
        driverId: null == driverId
            ? _value.driverId
            : driverId // ignore: cast_nullable_to_non_nullable
                  as int,
        dispatcherId: null == dispatcherId
            ? _value.dispatcherId
            : dispatcherId // ignore: cast_nullable_to_non_nullable
                  as int,
        trip: freezed == trip
            ? _value.trip
            : trip // ignore: cast_nullable_to_non_nullable
                  as TripModel?,
        driver: freezed == driver
            ? _value.driver
            : driver // ignore: cast_nullable_to_non_nullable
                  as UserModel?,
        dispatcher: freezed == dispatcher
            ? _value.dispatcher
            : dispatcher // ignore: cast_nullable_to_non_nullable
                  as UserModel?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AssignmentModelImpl implements _AssignmentModel {
  const _$AssignmentModelImpl({
    required this.id,
    required this.checklistOk,
    @JsonKey(fromJson: _dateFromJson, toJson: _dateToJson)
    required this.assignedAt,
    required this.tripId,
    required this.driverId,
    required this.dispatcherId,
    this.trip,
    this.driver,
    this.dispatcher,
  });

  factory _$AssignmentModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AssignmentModelImplFromJson(json);

  @override
  final int id;
  @override
  final bool checklistOk;
  @override
  @JsonKey(fromJson: _dateFromJson, toJson: _dateToJson)
  final DateTime assignedAt;
  @override
  final int tripId;
  @override
  final int driverId;
  @override
  final int dispatcherId;
  @override
  final TripModel? trip;
  @override
  final UserModel? driver;
  @override
  final UserModel? dispatcher;

  @override
  String toString() {
    return 'AssignmentModel(id: $id, checklistOk: $checklistOk, assignedAt: $assignedAt, tripId: $tripId, driverId: $driverId, dispatcherId: $dispatcherId, trip: $trip, driver: $driver, dispatcher: $dispatcher)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AssignmentModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.checklistOk, checklistOk) ||
                other.checklistOk == checklistOk) &&
            (identical(other.assignedAt, assignedAt) ||
                other.assignedAt == assignedAt) &&
            (identical(other.tripId, tripId) || other.tripId == tripId) &&
            (identical(other.driverId, driverId) ||
                other.driverId == driverId) &&
            (identical(other.dispatcherId, dispatcherId) ||
                other.dispatcherId == dispatcherId) &&
            (identical(other.trip, trip) || other.trip == trip) &&
            (identical(other.driver, driver) || other.driver == driver) &&
            (identical(other.dispatcher, dispatcher) ||
                other.dispatcher == dispatcher));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    checklistOk,
    assignedAt,
    tripId,
    driverId,
    dispatcherId,
    trip,
    driver,
    dispatcher,
  );

  /// Create a copy of AssignmentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AssignmentModelImplCopyWith<_$AssignmentModelImpl> get copyWith =>
      __$$AssignmentModelImplCopyWithImpl<_$AssignmentModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AssignmentModelImplToJson(this);
  }
}

abstract class _AssignmentModel implements AssignmentModel {
  const factory _AssignmentModel({
    required final int id,
    required final bool checklistOk,
    @JsonKey(fromJson: _dateFromJson, toJson: _dateToJson)
    required final DateTime assignedAt,
    required final int tripId,
    required final int driverId,
    required final int dispatcherId,
    final TripModel? trip,
    final UserModel? driver,
    final UserModel? dispatcher,
  }) = _$AssignmentModelImpl;

  factory _AssignmentModel.fromJson(Map<String, dynamic> json) =
      _$AssignmentModelImpl.fromJson;

  @override
  int get id;
  @override
  bool get checklistOk;
  @override
  @JsonKey(fromJson: _dateFromJson, toJson: _dateToJson)
  DateTime get assignedAt;
  @override
  int get tripId;
  @override
  int get driverId;
  @override
  int get dispatcherId;
  @override
  TripModel? get trip;
  @override
  UserModel? get driver;
  @override
  UserModel? get dispatcher;

  /// Create a copy of AssignmentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AssignmentModelImplCopyWith<_$AssignmentModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AssignmentCreateRequest _$AssignmentCreateRequestFromJson(
  Map<String, dynamic> json,
) {
  return _AssignmentCreateRequest.fromJson(json);
}

/// @nodoc
mixin _$AssignmentCreateRequest {
  int get tripId => throw _privateConstructorUsedError;
  int get driverId => throw _privateConstructorUsedError;
  int get dispatcherId => throw _privateConstructorUsedError;
  bool? get checklistOk => throw _privateConstructorUsedError;

  /// Serializes this AssignmentCreateRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AssignmentCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AssignmentCreateRequestCopyWith<AssignmentCreateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AssignmentCreateRequestCopyWith<$Res> {
  factory $AssignmentCreateRequestCopyWith(
    AssignmentCreateRequest value,
    $Res Function(AssignmentCreateRequest) then,
  ) = _$AssignmentCreateRequestCopyWithImpl<$Res, AssignmentCreateRequest>;
  @useResult
  $Res call({int tripId, int driverId, int dispatcherId, bool? checklistOk});
}

/// @nodoc
class _$AssignmentCreateRequestCopyWithImpl<
  $Res,
  $Val extends AssignmentCreateRequest
>
    implements $AssignmentCreateRequestCopyWith<$Res> {
  _$AssignmentCreateRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AssignmentCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tripId = null,
    Object? driverId = null,
    Object? dispatcherId = null,
    Object? checklistOk = freezed,
  }) {
    return _then(
      _value.copyWith(
            tripId: null == tripId
                ? _value.tripId
                : tripId // ignore: cast_nullable_to_non_nullable
                      as int,
            driverId: null == driverId
                ? _value.driverId
                : driverId // ignore: cast_nullable_to_non_nullable
                      as int,
            dispatcherId: null == dispatcherId
                ? _value.dispatcherId
                : dispatcherId // ignore: cast_nullable_to_non_nullable
                      as int,
            checklistOk: freezed == checklistOk
                ? _value.checklistOk
                : checklistOk // ignore: cast_nullable_to_non_nullable
                      as bool?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AssignmentCreateRequestImplCopyWith<$Res>
    implements $AssignmentCreateRequestCopyWith<$Res> {
  factory _$$AssignmentCreateRequestImplCopyWith(
    _$AssignmentCreateRequestImpl value,
    $Res Function(_$AssignmentCreateRequestImpl) then,
  ) = __$$AssignmentCreateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int tripId, int driverId, int dispatcherId, bool? checklistOk});
}

/// @nodoc
class __$$AssignmentCreateRequestImplCopyWithImpl<$Res>
    extends
        _$AssignmentCreateRequestCopyWithImpl<
          $Res,
          _$AssignmentCreateRequestImpl
        >
    implements _$$AssignmentCreateRequestImplCopyWith<$Res> {
  __$$AssignmentCreateRequestImplCopyWithImpl(
    _$AssignmentCreateRequestImpl _value,
    $Res Function(_$AssignmentCreateRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AssignmentCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tripId = null,
    Object? driverId = null,
    Object? dispatcherId = null,
    Object? checklistOk = freezed,
  }) {
    return _then(
      _$AssignmentCreateRequestImpl(
        tripId: null == tripId
            ? _value.tripId
            : tripId // ignore: cast_nullable_to_non_nullable
                  as int,
        driverId: null == driverId
            ? _value.driverId
            : driverId // ignore: cast_nullable_to_non_nullable
                  as int,
        dispatcherId: null == dispatcherId
            ? _value.dispatcherId
            : dispatcherId // ignore: cast_nullable_to_non_nullable
                  as int,
        checklistOk: freezed == checklistOk
            ? _value.checklistOk
            : checklistOk // ignore: cast_nullable_to_non_nullable
                  as bool?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AssignmentCreateRequestImpl implements _AssignmentCreateRequest {
  const _$AssignmentCreateRequestImpl({
    required this.tripId,
    required this.driverId,
    required this.dispatcherId,
    this.checklistOk,
  });

  factory _$AssignmentCreateRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$AssignmentCreateRequestImplFromJson(json);

  @override
  final int tripId;
  @override
  final int driverId;
  @override
  final int dispatcherId;
  @override
  final bool? checklistOk;

  @override
  String toString() {
    return 'AssignmentCreateRequest(tripId: $tripId, driverId: $driverId, dispatcherId: $dispatcherId, checklistOk: $checklistOk)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AssignmentCreateRequestImpl &&
            (identical(other.tripId, tripId) || other.tripId == tripId) &&
            (identical(other.driverId, driverId) ||
                other.driverId == driverId) &&
            (identical(other.dispatcherId, dispatcherId) ||
                other.dispatcherId == dispatcherId) &&
            (identical(other.checklistOk, checklistOk) ||
                other.checklistOk == checklistOk));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, tripId, driverId, dispatcherId, checklistOk);

  /// Create a copy of AssignmentCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AssignmentCreateRequestImplCopyWith<_$AssignmentCreateRequestImpl>
  get copyWith =>
      __$$AssignmentCreateRequestImplCopyWithImpl<
        _$AssignmentCreateRequestImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AssignmentCreateRequestImplToJson(this);
  }
}

abstract class _AssignmentCreateRequest implements AssignmentCreateRequest {
  const factory _AssignmentCreateRequest({
    required final int tripId,
    required final int driverId,
    required final int dispatcherId,
    final bool? checklistOk,
  }) = _$AssignmentCreateRequestImpl;

  factory _AssignmentCreateRequest.fromJson(Map<String, dynamic> json) =
      _$AssignmentCreateRequestImpl.fromJson;

  @override
  int get tripId;
  @override
  int get driverId;
  @override
  int get dispatcherId;
  @override
  bool? get checklistOk;

  /// Create a copy of AssignmentCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AssignmentCreateRequestImplCopyWith<_$AssignmentCreateRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}

AssignmentUpdateRequest _$AssignmentUpdateRequestFromJson(
  Map<String, dynamic> json,
) {
  return _AssignmentUpdateRequest.fromJson(json);
}

/// @nodoc
mixin _$AssignmentUpdateRequest {
  int? get driverId => throw _privateConstructorUsedError;
  bool? get checklistOk => throw _privateConstructorUsedError;

  /// Serializes this AssignmentUpdateRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AssignmentUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AssignmentUpdateRequestCopyWith<AssignmentUpdateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AssignmentUpdateRequestCopyWith<$Res> {
  factory $AssignmentUpdateRequestCopyWith(
    AssignmentUpdateRequest value,
    $Res Function(AssignmentUpdateRequest) then,
  ) = _$AssignmentUpdateRequestCopyWithImpl<$Res, AssignmentUpdateRequest>;
  @useResult
  $Res call({int? driverId, bool? checklistOk});
}

/// @nodoc
class _$AssignmentUpdateRequestCopyWithImpl<
  $Res,
  $Val extends AssignmentUpdateRequest
>
    implements $AssignmentUpdateRequestCopyWith<$Res> {
  _$AssignmentUpdateRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AssignmentUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? driverId = freezed, Object? checklistOk = freezed}) {
    return _then(
      _value.copyWith(
            driverId: freezed == driverId
                ? _value.driverId
                : driverId // ignore: cast_nullable_to_non_nullable
                      as int?,
            checklistOk: freezed == checklistOk
                ? _value.checklistOk
                : checklistOk // ignore: cast_nullable_to_non_nullable
                      as bool?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AssignmentUpdateRequestImplCopyWith<$Res>
    implements $AssignmentUpdateRequestCopyWith<$Res> {
  factory _$$AssignmentUpdateRequestImplCopyWith(
    _$AssignmentUpdateRequestImpl value,
    $Res Function(_$AssignmentUpdateRequestImpl) then,
  ) = __$$AssignmentUpdateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? driverId, bool? checklistOk});
}

/// @nodoc
class __$$AssignmentUpdateRequestImplCopyWithImpl<$Res>
    extends
        _$AssignmentUpdateRequestCopyWithImpl<
          $Res,
          _$AssignmentUpdateRequestImpl
        >
    implements _$$AssignmentUpdateRequestImplCopyWith<$Res> {
  __$$AssignmentUpdateRequestImplCopyWithImpl(
    _$AssignmentUpdateRequestImpl _value,
    $Res Function(_$AssignmentUpdateRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AssignmentUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? driverId = freezed, Object? checklistOk = freezed}) {
    return _then(
      _$AssignmentUpdateRequestImpl(
        driverId: freezed == driverId
            ? _value.driverId
            : driverId // ignore: cast_nullable_to_non_nullable
                  as int?,
        checklistOk: freezed == checklistOk
            ? _value.checklistOk
            : checklistOk // ignore: cast_nullable_to_non_nullable
                  as bool?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AssignmentUpdateRequestImpl implements _AssignmentUpdateRequest {
  const _$AssignmentUpdateRequestImpl({this.driverId, this.checklistOk});

  factory _$AssignmentUpdateRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$AssignmentUpdateRequestImplFromJson(json);

  @override
  final int? driverId;
  @override
  final bool? checklistOk;

  @override
  String toString() {
    return 'AssignmentUpdateRequest(driverId: $driverId, checklistOk: $checklistOk)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AssignmentUpdateRequestImpl &&
            (identical(other.driverId, driverId) ||
                other.driverId == driverId) &&
            (identical(other.checklistOk, checklistOk) ||
                other.checklistOk == checklistOk));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, driverId, checklistOk);

  /// Create a copy of AssignmentUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AssignmentUpdateRequestImplCopyWith<_$AssignmentUpdateRequestImpl>
  get copyWith =>
      __$$AssignmentUpdateRequestImplCopyWithImpl<
        _$AssignmentUpdateRequestImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AssignmentUpdateRequestImplToJson(this);
  }
}

abstract class _AssignmentUpdateRequest implements AssignmentUpdateRequest {
  const factory _AssignmentUpdateRequest({
    final int? driverId,
    final bool? checklistOk,
  }) = _$AssignmentUpdateRequestImpl;

  factory _AssignmentUpdateRequest.fromJson(Map<String, dynamic> json) =
      _$AssignmentUpdateRequestImpl.fromJson;

  @override
  int? get driverId;
  @override
  bool? get checklistOk;

  /// Create a copy of AssignmentUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AssignmentUpdateRequestImplCopyWith<_$AssignmentUpdateRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}
