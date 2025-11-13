// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stop_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

StopModel _$StopModelFromJson(Map<String, dynamic> json) {
  return _StopModel.fromJson(json);
}

/// @nodoc
mixin _$StopModel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get order => throw _privateConstructorUsedError;
  double? get lat => throw _privateConstructorUsedError;
  double? get lng => throw _privateConstructorUsedError;
  int? get routeId => throw _privateConstructorUsedError;

  /// Serializes this StopModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StopModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StopModelCopyWith<StopModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StopModelCopyWith<$Res> {
  factory $StopModelCopyWith(StopModel value, $Res Function(StopModel) then) =
      _$StopModelCopyWithImpl<$Res, StopModel>;
  @useResult
  $Res call({
    int id,
    String name,
    int order,
    double? lat,
    double? lng,
    int? routeId,
  });
}

/// @nodoc
class _$StopModelCopyWithImpl<$Res, $Val extends StopModel>
    implements $StopModelCopyWith<$Res> {
  _$StopModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StopModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? order = null,
    Object? lat = freezed,
    Object? lng = freezed,
    Object? routeId = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            order: null == order
                ? _value.order
                : order // ignore: cast_nullable_to_non_nullable
                      as int,
            lat: freezed == lat
                ? _value.lat
                : lat // ignore: cast_nullable_to_non_nullable
                      as double?,
            lng: freezed == lng
                ? _value.lng
                : lng // ignore: cast_nullable_to_non_nullable
                      as double?,
            routeId: freezed == routeId
                ? _value.routeId
                : routeId // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StopModelImplCopyWith<$Res>
    implements $StopModelCopyWith<$Res> {
  factory _$$StopModelImplCopyWith(
    _$StopModelImpl value,
    $Res Function(_$StopModelImpl) then,
  ) = __$$StopModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String name,
    int order,
    double? lat,
    double? lng,
    int? routeId,
  });
}

/// @nodoc
class __$$StopModelImplCopyWithImpl<$Res>
    extends _$StopModelCopyWithImpl<$Res, _$StopModelImpl>
    implements _$$StopModelImplCopyWith<$Res> {
  __$$StopModelImplCopyWithImpl(
    _$StopModelImpl _value,
    $Res Function(_$StopModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StopModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? order = null,
    Object? lat = freezed,
    Object? lng = freezed,
    Object? routeId = freezed,
  }) {
    return _then(
      _$StopModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        order: null == order
            ? _value.order
            : order // ignore: cast_nullable_to_non_nullable
                  as int,
        lat: freezed == lat
            ? _value.lat
            : lat // ignore: cast_nullable_to_non_nullable
                  as double?,
        lng: freezed == lng
            ? _value.lng
            : lng // ignore: cast_nullable_to_non_nullable
                  as double?,
        routeId: freezed == routeId
            ? _value.routeId
            : routeId // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StopModelImpl implements _StopModel {
  const _$StopModelImpl({
    required this.id,
    required this.name,
    required this.order,
    this.lat,
    this.lng,
    this.routeId,
  });

  factory _$StopModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$StopModelImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final int order;
  @override
  final double? lat;
  @override
  final double? lng;
  @override
  final int? routeId;

  @override
  String toString() {
    return 'StopModel(id: $id, name: $name, order: $order, lat: $lat, lng: $lng, routeId: $routeId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StopModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lng, lng) || other.lng == lng) &&
            (identical(other.routeId, routeId) || other.routeId == routeId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, order, lat, lng, routeId);

  /// Create a copy of StopModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StopModelImplCopyWith<_$StopModelImpl> get copyWith =>
      __$$StopModelImplCopyWithImpl<_$StopModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StopModelImplToJson(this);
  }
}

abstract class _StopModel implements StopModel {
  const factory _StopModel({
    required final int id,
    required final String name,
    required final int order,
    final double? lat,
    final double? lng,
    final int? routeId,
  }) = _$StopModelImpl;

  factory _StopModel.fromJson(Map<String, dynamic> json) =
      _$StopModelImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  int get order;
  @override
  double? get lat;
  @override
  double? get lng;
  @override
  int? get routeId;

  /// Create a copy of StopModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StopModelImplCopyWith<_$StopModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StopCreateRequest _$StopCreateRequestFromJson(Map<String, dynamic> json) {
  return _StopCreateRequest.fromJson(json);
}

/// @nodoc
mixin _$StopCreateRequest {
  int get routeId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get order => throw _privateConstructorUsedError;
  double? get lat => throw _privateConstructorUsedError;
  double? get lng => throw _privateConstructorUsedError;

  /// Serializes this StopCreateRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StopCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StopCreateRequestCopyWith<StopCreateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StopCreateRequestCopyWith<$Res> {
  factory $StopCreateRequestCopyWith(
    StopCreateRequest value,
    $Res Function(StopCreateRequest) then,
  ) = _$StopCreateRequestCopyWithImpl<$Res, StopCreateRequest>;
  @useResult
  $Res call({int routeId, String name, int order, double? lat, double? lng});
}

/// @nodoc
class _$StopCreateRequestCopyWithImpl<$Res, $Val extends StopCreateRequest>
    implements $StopCreateRequestCopyWith<$Res> {
  _$StopCreateRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StopCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? routeId = null,
    Object? name = null,
    Object? order = null,
    Object? lat = freezed,
    Object? lng = freezed,
  }) {
    return _then(
      _value.copyWith(
            routeId: null == routeId
                ? _value.routeId
                : routeId // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            order: null == order
                ? _value.order
                : order // ignore: cast_nullable_to_non_nullable
                      as int,
            lat: freezed == lat
                ? _value.lat
                : lat // ignore: cast_nullable_to_non_nullable
                      as double?,
            lng: freezed == lng
                ? _value.lng
                : lng // ignore: cast_nullable_to_non_nullable
                      as double?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StopCreateRequestImplCopyWith<$Res>
    implements $StopCreateRequestCopyWith<$Res> {
  factory _$$StopCreateRequestImplCopyWith(
    _$StopCreateRequestImpl value,
    $Res Function(_$StopCreateRequestImpl) then,
  ) = __$$StopCreateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int routeId, String name, int order, double? lat, double? lng});
}

/// @nodoc
class __$$StopCreateRequestImplCopyWithImpl<$Res>
    extends _$StopCreateRequestCopyWithImpl<$Res, _$StopCreateRequestImpl>
    implements _$$StopCreateRequestImplCopyWith<$Res> {
  __$$StopCreateRequestImplCopyWithImpl(
    _$StopCreateRequestImpl _value,
    $Res Function(_$StopCreateRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StopCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? routeId = null,
    Object? name = null,
    Object? order = null,
    Object? lat = freezed,
    Object? lng = freezed,
  }) {
    return _then(
      _$StopCreateRequestImpl(
        routeId: null == routeId
            ? _value.routeId
            : routeId // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        order: null == order
            ? _value.order
            : order // ignore: cast_nullable_to_non_nullable
                  as int,
        lat: freezed == lat
            ? _value.lat
            : lat // ignore: cast_nullable_to_non_nullable
                  as double?,
        lng: freezed == lng
            ? _value.lng
            : lng // ignore: cast_nullable_to_non_nullable
                  as double?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StopCreateRequestImpl implements _StopCreateRequest {
  const _$StopCreateRequestImpl({
    required this.routeId,
    required this.name,
    required this.order,
    this.lat,
    this.lng,
  });

  factory _$StopCreateRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$StopCreateRequestImplFromJson(json);

  @override
  final int routeId;
  @override
  final String name;
  @override
  final int order;
  @override
  final double? lat;
  @override
  final double? lng;

  @override
  String toString() {
    return 'StopCreateRequest(routeId: $routeId, name: $name, order: $order, lat: $lat, lng: $lng)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StopCreateRequestImpl &&
            (identical(other.routeId, routeId) || other.routeId == routeId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lng, lng) || other.lng == lng));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, routeId, name, order, lat, lng);

  /// Create a copy of StopCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StopCreateRequestImplCopyWith<_$StopCreateRequestImpl> get copyWith =>
      __$$StopCreateRequestImplCopyWithImpl<_$StopCreateRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$StopCreateRequestImplToJson(this);
  }
}

abstract class _StopCreateRequest implements StopCreateRequest {
  const factory _StopCreateRequest({
    required final int routeId,
    required final String name,
    required final int order,
    final double? lat,
    final double? lng,
  }) = _$StopCreateRequestImpl;

  factory _StopCreateRequest.fromJson(Map<String, dynamic> json) =
      _$StopCreateRequestImpl.fromJson;

  @override
  int get routeId;
  @override
  String get name;
  @override
  int get order;
  @override
  double? get lat;
  @override
  double? get lng;

  /// Create a copy of StopCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StopCreateRequestImplCopyWith<_$StopCreateRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StopUpdateRequest _$StopUpdateRequestFromJson(Map<String, dynamic> json) {
  return _StopUpdateRequest.fromJson(json);
}

/// @nodoc
mixin _$StopUpdateRequest {
  String? get name => throw _privateConstructorUsedError;
  int? get order => throw _privateConstructorUsedError;
  double? get lat => throw _privateConstructorUsedError;
  double? get lng => throw _privateConstructorUsedError;

  /// Serializes this StopUpdateRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StopUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StopUpdateRequestCopyWith<StopUpdateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StopUpdateRequestCopyWith<$Res> {
  factory $StopUpdateRequestCopyWith(
    StopUpdateRequest value,
    $Res Function(StopUpdateRequest) then,
  ) = _$StopUpdateRequestCopyWithImpl<$Res, StopUpdateRequest>;
  @useResult
  $Res call({String? name, int? order, double? lat, double? lng});
}

/// @nodoc
class _$StopUpdateRequestCopyWithImpl<$Res, $Val extends StopUpdateRequest>
    implements $StopUpdateRequestCopyWith<$Res> {
  _$StopUpdateRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StopUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? order = freezed,
    Object? lat = freezed,
    Object? lng = freezed,
  }) {
    return _then(
      _value.copyWith(
            name: freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String?,
            order: freezed == order
                ? _value.order
                : order // ignore: cast_nullable_to_non_nullable
                      as int?,
            lat: freezed == lat
                ? _value.lat
                : lat // ignore: cast_nullable_to_non_nullable
                      as double?,
            lng: freezed == lng
                ? _value.lng
                : lng // ignore: cast_nullable_to_non_nullable
                      as double?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StopUpdateRequestImplCopyWith<$Res>
    implements $StopUpdateRequestCopyWith<$Res> {
  factory _$$StopUpdateRequestImplCopyWith(
    _$StopUpdateRequestImpl value,
    $Res Function(_$StopUpdateRequestImpl) then,
  ) = __$$StopUpdateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? name, int? order, double? lat, double? lng});
}

/// @nodoc
class __$$StopUpdateRequestImplCopyWithImpl<$Res>
    extends _$StopUpdateRequestCopyWithImpl<$Res, _$StopUpdateRequestImpl>
    implements _$$StopUpdateRequestImplCopyWith<$Res> {
  __$$StopUpdateRequestImplCopyWithImpl(
    _$StopUpdateRequestImpl _value,
    $Res Function(_$StopUpdateRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StopUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? order = freezed,
    Object? lat = freezed,
    Object? lng = freezed,
  }) {
    return _then(
      _$StopUpdateRequestImpl(
        name: freezed == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String?,
        order: freezed == order
            ? _value.order
            : order // ignore: cast_nullable_to_non_nullable
                  as int?,
        lat: freezed == lat
            ? _value.lat
            : lat // ignore: cast_nullable_to_non_nullable
                  as double?,
        lng: freezed == lng
            ? _value.lng
            : lng // ignore: cast_nullable_to_non_nullable
                  as double?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StopUpdateRequestImpl implements _StopUpdateRequest {
  const _$StopUpdateRequestImpl({this.name, this.order, this.lat, this.lng});

  factory _$StopUpdateRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$StopUpdateRequestImplFromJson(json);

  @override
  final String? name;
  @override
  final int? order;
  @override
  final double? lat;
  @override
  final double? lng;

  @override
  String toString() {
    return 'StopUpdateRequest(name: $name, order: $order, lat: $lat, lng: $lng)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StopUpdateRequestImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lng, lng) || other.lng == lng));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, order, lat, lng);

  /// Create a copy of StopUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StopUpdateRequestImplCopyWith<_$StopUpdateRequestImpl> get copyWith =>
      __$$StopUpdateRequestImplCopyWithImpl<_$StopUpdateRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$StopUpdateRequestImplToJson(this);
  }
}

abstract class _StopUpdateRequest implements StopUpdateRequest {
  const factory _StopUpdateRequest({
    final String? name,
    final int? order,
    final double? lat,
    final double? lng,
  }) = _$StopUpdateRequestImpl;

  factory _StopUpdateRequest.fromJson(Map<String, dynamic> json) =
      _$StopUpdateRequestImpl.fromJson;

  @override
  String? get name;
  @override
  int? get order;
  @override
  double? get lat;
  @override
  double? get lng;

  /// Create a copy of StopUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StopUpdateRequestImplCopyWith<_$StopUpdateRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
