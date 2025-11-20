// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seat_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SeatModel _$SeatModelFromJson(Map<String, dynamic> json) {
  return _SeatModel.fromJson(json);
}

/// @nodoc
mixin _$SeatModel {
  int get id => throw _privateConstructorUsedError;
  String get number => throw _privateConstructorUsedError;
  SeatType get type => throw _privateConstructorUsedError;
  int get busId => throw _privateConstructorUsedError;
  String? get busPlate => throw _privateConstructorUsedError;
  int? get busCapacity => throw _privateConstructorUsedError;

  /// Serializes this SeatModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SeatModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SeatModelCopyWith<SeatModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SeatModelCopyWith<$Res> {
  factory $SeatModelCopyWith(SeatModel value, $Res Function(SeatModel) then) =
      _$SeatModelCopyWithImpl<$Res, SeatModel>;
  @useResult
  $Res call({
    int id,
    String number,
    SeatType type,
    int busId,
    String? busPlate,
    int? busCapacity,
  });
}

/// @nodoc
class _$SeatModelCopyWithImpl<$Res, $Val extends SeatModel>
    implements $SeatModelCopyWith<$Res> {
  _$SeatModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SeatModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? number = null,
    Object? type = null,
    Object? busId = null,
    Object? busPlate = freezed,
    Object? busCapacity = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            number: null == number
                ? _value.number
                : number // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as SeatType,
            busId: null == busId
                ? _value.busId
                : busId // ignore: cast_nullable_to_non_nullable
                      as int,
            busPlate: freezed == busPlate
                ? _value.busPlate
                : busPlate // ignore: cast_nullable_to_non_nullable
                      as String?,
            busCapacity: freezed == busCapacity
                ? _value.busCapacity
                : busCapacity // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SeatModelImplCopyWith<$Res>
    implements $SeatModelCopyWith<$Res> {
  factory _$$SeatModelImplCopyWith(
    _$SeatModelImpl value,
    $Res Function(_$SeatModelImpl) then,
  ) = __$$SeatModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String number,
    SeatType type,
    int busId,
    String? busPlate,
    int? busCapacity,
  });
}

/// @nodoc
class __$$SeatModelImplCopyWithImpl<$Res>
    extends _$SeatModelCopyWithImpl<$Res, _$SeatModelImpl>
    implements _$$SeatModelImplCopyWith<$Res> {
  __$$SeatModelImplCopyWithImpl(
    _$SeatModelImpl _value,
    $Res Function(_$SeatModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SeatModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? number = null,
    Object? type = null,
    Object? busId = null,
    Object? busPlate = freezed,
    Object? busCapacity = freezed,
  }) {
    return _then(
      _$SeatModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        number: null == number
            ? _value.number
            : number // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as SeatType,
        busId: null == busId
            ? _value.busId
            : busId // ignore: cast_nullable_to_non_nullable
                  as int,
        busPlate: freezed == busPlate
            ? _value.busPlate
            : busPlate // ignore: cast_nullable_to_non_nullable
                  as String?,
        busCapacity: freezed == busCapacity
            ? _value.busCapacity
            : busCapacity // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SeatModelImpl implements _SeatModel {
  const _$SeatModelImpl({
    required this.id,
    required this.number,
    required this.type,
    required this.busId,
    this.busPlate,
    this.busCapacity,
  });

  factory _$SeatModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SeatModelImplFromJson(json);

  @override
  final int id;
  @override
  final String number;
  @override
  final SeatType type;
  @override
  final int busId;
  @override
  final String? busPlate;
  @override
  final int? busCapacity;

  @override
  String toString() {
    return 'SeatModel(id: $id, number: $number, type: $type, busId: $busId, busPlate: $busPlate, busCapacity: $busCapacity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SeatModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.busId, busId) || other.busId == busId) &&
            (identical(other.busPlate, busPlate) ||
                other.busPlate == busPlate) &&
            (identical(other.busCapacity, busCapacity) ||
                other.busCapacity == busCapacity));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, number, type, busId, busPlate, busCapacity);

  /// Create a copy of SeatModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SeatModelImplCopyWith<_$SeatModelImpl> get copyWith =>
      __$$SeatModelImplCopyWithImpl<_$SeatModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SeatModelImplToJson(this);
  }
}

abstract class _SeatModel implements SeatModel {
  const factory _SeatModel({
    required final int id,
    required final String number,
    required final SeatType type,
    required final int busId,
    final String? busPlate,
    final int? busCapacity,
  }) = _$SeatModelImpl;

  factory _SeatModel.fromJson(Map<String, dynamic> json) =
      _$SeatModelImpl.fromJson;

  @override
  int get id;
  @override
  String get number;
  @override
  SeatType get type;
  @override
  int get busId;
  @override
  String? get busPlate;
  @override
  int? get busCapacity;

  /// Create a copy of SeatModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SeatModelImplCopyWith<_$SeatModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SeatCreateRequest _$SeatCreateRequestFromJson(Map<String, dynamic> json) {
  return _SeatCreateRequest.fromJson(json);
}

/// @nodoc
mixin _$SeatCreateRequest {
  int get busId => throw _privateConstructorUsedError;
  String get number => throw _privateConstructorUsedError;
  SeatType get type => throw _privateConstructorUsedError;

  /// Serializes this SeatCreateRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SeatCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SeatCreateRequestCopyWith<SeatCreateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SeatCreateRequestCopyWith<$Res> {
  factory $SeatCreateRequestCopyWith(
    SeatCreateRequest value,
    $Res Function(SeatCreateRequest) then,
  ) = _$SeatCreateRequestCopyWithImpl<$Res, SeatCreateRequest>;
  @useResult
  $Res call({int busId, String number, SeatType type});
}

/// @nodoc
class _$SeatCreateRequestCopyWithImpl<$Res, $Val extends SeatCreateRequest>
    implements $SeatCreateRequestCopyWith<$Res> {
  _$SeatCreateRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SeatCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? busId = null,
    Object? number = null,
    Object? type = null,
  }) {
    return _then(
      _value.copyWith(
            busId: null == busId
                ? _value.busId
                : busId // ignore: cast_nullable_to_non_nullable
                      as int,
            number: null == number
                ? _value.number
                : number // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as SeatType,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SeatCreateRequestImplCopyWith<$Res>
    implements $SeatCreateRequestCopyWith<$Res> {
  factory _$$SeatCreateRequestImplCopyWith(
    _$SeatCreateRequestImpl value,
    $Res Function(_$SeatCreateRequestImpl) then,
  ) = __$$SeatCreateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int busId, String number, SeatType type});
}

/// @nodoc
class __$$SeatCreateRequestImplCopyWithImpl<$Res>
    extends _$SeatCreateRequestCopyWithImpl<$Res, _$SeatCreateRequestImpl>
    implements _$$SeatCreateRequestImplCopyWith<$Res> {
  __$$SeatCreateRequestImplCopyWithImpl(
    _$SeatCreateRequestImpl _value,
    $Res Function(_$SeatCreateRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SeatCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? busId = null,
    Object? number = null,
    Object? type = null,
  }) {
    return _then(
      _$SeatCreateRequestImpl(
        busId: null == busId
            ? _value.busId
            : busId // ignore: cast_nullable_to_non_nullable
                  as int,
        number: null == number
            ? _value.number
            : number // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as SeatType,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SeatCreateRequestImpl implements _SeatCreateRequest {
  const _$SeatCreateRequestImpl({
    required this.busId,
    required this.number,
    required this.type,
  });

  factory _$SeatCreateRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$SeatCreateRequestImplFromJson(json);

  @override
  final int busId;
  @override
  final String number;
  @override
  final SeatType type;

  @override
  String toString() {
    return 'SeatCreateRequest(busId: $busId, number: $number, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SeatCreateRequestImpl &&
            (identical(other.busId, busId) || other.busId == busId) &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, busId, number, type);

  /// Create a copy of SeatCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SeatCreateRequestImplCopyWith<_$SeatCreateRequestImpl> get copyWith =>
      __$$SeatCreateRequestImplCopyWithImpl<_$SeatCreateRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SeatCreateRequestImplToJson(this);
  }
}

abstract class _SeatCreateRequest implements SeatCreateRequest {
  const factory _SeatCreateRequest({
    required final int busId,
    required final String number,
    required final SeatType type,
  }) = _$SeatCreateRequestImpl;

  factory _SeatCreateRequest.fromJson(Map<String, dynamic> json) =
      _$SeatCreateRequestImpl.fromJson;

  @override
  int get busId;
  @override
  String get number;
  @override
  SeatType get type;

  /// Create a copy of SeatCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SeatCreateRequestImplCopyWith<_$SeatCreateRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SeatUpdateRequest _$SeatUpdateRequestFromJson(Map<String, dynamic> json) {
  return _SeatUpdateRequest.fromJson(json);
}

/// @nodoc
mixin _$SeatUpdateRequest {
  String? get number => throw _privateConstructorUsedError;
  SeatType? get type => throw _privateConstructorUsedError;

  /// Serializes this SeatUpdateRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SeatUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SeatUpdateRequestCopyWith<SeatUpdateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SeatUpdateRequestCopyWith<$Res> {
  factory $SeatUpdateRequestCopyWith(
    SeatUpdateRequest value,
    $Res Function(SeatUpdateRequest) then,
  ) = _$SeatUpdateRequestCopyWithImpl<$Res, SeatUpdateRequest>;
  @useResult
  $Res call({String? number, SeatType? type});
}

/// @nodoc
class _$SeatUpdateRequestCopyWithImpl<$Res, $Val extends SeatUpdateRequest>
    implements $SeatUpdateRequestCopyWith<$Res> {
  _$SeatUpdateRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SeatUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? number = freezed, Object? type = freezed}) {
    return _then(
      _value.copyWith(
            number: freezed == number
                ? _value.number
                : number // ignore: cast_nullable_to_non_nullable
                      as String?,
            type: freezed == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as SeatType?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SeatUpdateRequestImplCopyWith<$Res>
    implements $SeatUpdateRequestCopyWith<$Res> {
  factory _$$SeatUpdateRequestImplCopyWith(
    _$SeatUpdateRequestImpl value,
    $Res Function(_$SeatUpdateRequestImpl) then,
  ) = __$$SeatUpdateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? number, SeatType? type});
}

/// @nodoc
class __$$SeatUpdateRequestImplCopyWithImpl<$Res>
    extends _$SeatUpdateRequestCopyWithImpl<$Res, _$SeatUpdateRequestImpl>
    implements _$$SeatUpdateRequestImplCopyWith<$Res> {
  __$$SeatUpdateRequestImplCopyWithImpl(
    _$SeatUpdateRequestImpl _value,
    $Res Function(_$SeatUpdateRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SeatUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? number = freezed, Object? type = freezed}) {
    return _then(
      _$SeatUpdateRequestImpl(
        number: freezed == number
            ? _value.number
            : number // ignore: cast_nullable_to_non_nullable
                  as String?,
        type: freezed == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as SeatType?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SeatUpdateRequestImpl implements _SeatUpdateRequest {
  const _$SeatUpdateRequestImpl({this.number, this.type});

  factory _$SeatUpdateRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$SeatUpdateRequestImplFromJson(json);

  @override
  final String? number;
  @override
  final SeatType? type;

  @override
  String toString() {
    return 'SeatUpdateRequest(number: $number, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SeatUpdateRequestImpl &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, number, type);

  /// Create a copy of SeatUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SeatUpdateRequestImplCopyWith<_$SeatUpdateRequestImpl> get copyWith =>
      __$$SeatUpdateRequestImplCopyWithImpl<_$SeatUpdateRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SeatUpdateRequestImplToJson(this);
  }
}

abstract class _SeatUpdateRequest implements SeatUpdateRequest {
  const factory _SeatUpdateRequest({
    final String? number,
    final SeatType? type,
  }) = _$SeatUpdateRequestImpl;

  factory _SeatUpdateRequest.fromJson(Map<String, dynamic> json) =
      _$SeatUpdateRequestImpl.fromJson;

  @override
  String? get number;
  @override
  SeatType? get type;

  /// Create a copy of SeatUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SeatUpdateRequestImplCopyWith<_$SeatUpdateRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
