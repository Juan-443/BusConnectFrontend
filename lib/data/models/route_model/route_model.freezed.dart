// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'route_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RouteModel _$RouteModelFromJson(Map<String, dynamic> json) {
  return _RouteModel.fromJson(json);
}

/// @nodoc
mixin _$RouteModel {
  int get id => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get origin => throw _privateConstructorUsedError;
  String get destination => throw _privateConstructorUsedError;
  int get distanceKm => throw _privateConstructorUsedError;
  int get durationMin => throw _privateConstructorUsedError;
  List<StopModel>? get stops => throw _privateConstructorUsedError;

  /// Serializes this RouteModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RouteModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RouteModelCopyWith<RouteModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RouteModelCopyWith<$Res> {
  factory $RouteModelCopyWith(
    RouteModel value,
    $Res Function(RouteModel) then,
  ) = _$RouteModelCopyWithImpl<$Res, RouteModel>;
  @useResult
  $Res call({
    int id,
    String code,
    String name,
    String origin,
    String destination,
    int distanceKm,
    int durationMin,
    List<StopModel>? stops,
  });
}

/// @nodoc
class _$RouteModelCopyWithImpl<$Res, $Val extends RouteModel>
    implements $RouteModelCopyWith<$Res> {
  _$RouteModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RouteModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? code = null,
    Object? name = null,
    Object? origin = null,
    Object? destination = null,
    Object? distanceKm = null,
    Object? durationMin = null,
    Object? stops = freezed,
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
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            origin: null == origin
                ? _value.origin
                : origin // ignore: cast_nullable_to_non_nullable
                      as String,
            destination: null == destination
                ? _value.destination
                : destination // ignore: cast_nullable_to_non_nullable
                      as String,
            distanceKm: null == distanceKm
                ? _value.distanceKm
                : distanceKm // ignore: cast_nullable_to_non_nullable
                      as int,
            durationMin: null == durationMin
                ? _value.durationMin
                : durationMin // ignore: cast_nullable_to_non_nullable
                      as int,
            stops: freezed == stops
                ? _value.stops
                : stops // ignore: cast_nullable_to_non_nullable
                      as List<StopModel>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RouteModelImplCopyWith<$Res>
    implements $RouteModelCopyWith<$Res> {
  factory _$$RouteModelImplCopyWith(
    _$RouteModelImpl value,
    $Res Function(_$RouteModelImpl) then,
  ) = __$$RouteModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String code,
    String name,
    String origin,
    String destination,
    int distanceKm,
    int durationMin,
    List<StopModel>? stops,
  });
}

/// @nodoc
class __$$RouteModelImplCopyWithImpl<$Res>
    extends _$RouteModelCopyWithImpl<$Res, _$RouteModelImpl>
    implements _$$RouteModelImplCopyWith<$Res> {
  __$$RouteModelImplCopyWithImpl(
    _$RouteModelImpl _value,
    $Res Function(_$RouteModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RouteModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? code = null,
    Object? name = null,
    Object? origin = null,
    Object? destination = null,
    Object? distanceKm = null,
    Object? durationMin = null,
    Object? stops = freezed,
  }) {
    return _then(
      _$RouteModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        code: null == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        origin: null == origin
            ? _value.origin
            : origin // ignore: cast_nullable_to_non_nullable
                  as String,
        destination: null == destination
            ? _value.destination
            : destination // ignore: cast_nullable_to_non_nullable
                  as String,
        distanceKm: null == distanceKm
            ? _value.distanceKm
            : distanceKm // ignore: cast_nullable_to_non_nullable
                  as int,
        durationMin: null == durationMin
            ? _value.durationMin
            : durationMin // ignore: cast_nullable_to_non_nullable
                  as int,
        stops: freezed == stops
            ? _value._stops
            : stops // ignore: cast_nullable_to_non_nullable
                  as List<StopModel>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RouteModelImpl implements _RouteModel {
  const _$RouteModelImpl({
    required this.id,
    required this.code,
    required this.name,
    required this.origin,
    required this.destination,
    required this.distanceKm,
    required this.durationMin,
    final List<StopModel>? stops,
  }) : _stops = stops;

  factory _$RouteModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RouteModelImplFromJson(json);

  @override
  final int id;
  @override
  final String code;
  @override
  final String name;
  @override
  final String origin;
  @override
  final String destination;
  @override
  final int distanceKm;
  @override
  final int durationMin;
  final List<StopModel>? _stops;
  @override
  List<StopModel>? get stops {
    final value = _stops;
    if (value == null) return null;
    if (_stops is EqualUnmodifiableListView) return _stops;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'RouteModel(id: $id, code: $code, name: $name, origin: $origin, destination: $destination, distanceKm: $distanceKm, durationMin: $durationMin, stops: $stops)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RouteModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.origin, origin) || other.origin == origin) &&
            (identical(other.destination, destination) ||
                other.destination == destination) &&
            (identical(other.distanceKm, distanceKm) ||
                other.distanceKm == distanceKm) &&
            (identical(other.durationMin, durationMin) ||
                other.durationMin == durationMin) &&
            const DeepCollectionEquality().equals(other._stops, _stops));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    code,
    name,
    origin,
    destination,
    distanceKm,
    durationMin,
    const DeepCollectionEquality().hash(_stops),
  );

  /// Create a copy of RouteModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RouteModelImplCopyWith<_$RouteModelImpl> get copyWith =>
      __$$RouteModelImplCopyWithImpl<_$RouteModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RouteModelImplToJson(this);
  }
}

abstract class _RouteModel implements RouteModel {
  const factory _RouteModel({
    required final int id,
    required final String code,
    required final String name,
    required final String origin,
    required final String destination,
    required final int distanceKm,
    required final int durationMin,
    final List<StopModel>? stops,
  }) = _$RouteModelImpl;

  factory _RouteModel.fromJson(Map<String, dynamic> json) =
      _$RouteModelImpl.fromJson;

  @override
  int get id;
  @override
  String get code;
  @override
  String get name;
  @override
  String get origin;
  @override
  String get destination;
  @override
  int get distanceKm;
  @override
  int get durationMin;
  @override
  List<StopModel>? get stops;

  /// Create a copy of RouteModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RouteModelImplCopyWith<_$RouteModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RouteCreateRequest _$RouteCreateRequestFromJson(Map<String, dynamic> json) {
  return _RouteCreateRequest.fromJson(json);
}

/// @nodoc
mixin _$RouteCreateRequest {
  String get code => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get origin => throw _privateConstructorUsedError;
  String get destination => throw _privateConstructorUsedError;
  int get distanceKm => throw _privateConstructorUsedError;
  int get durationMin => throw _privateConstructorUsedError;

  /// Serializes this RouteCreateRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RouteCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RouteCreateRequestCopyWith<RouteCreateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RouteCreateRequestCopyWith<$Res> {
  factory $RouteCreateRequestCopyWith(
    RouteCreateRequest value,
    $Res Function(RouteCreateRequest) then,
  ) = _$RouteCreateRequestCopyWithImpl<$Res, RouteCreateRequest>;
  @useResult
  $Res call({
    String code,
    String name,
    String origin,
    String destination,
    int distanceKm,
    int durationMin,
  });
}

/// @nodoc
class _$RouteCreateRequestCopyWithImpl<$Res, $Val extends RouteCreateRequest>
    implements $RouteCreateRequestCopyWith<$Res> {
  _$RouteCreateRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RouteCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? name = null,
    Object? origin = null,
    Object? destination = null,
    Object? distanceKm = null,
    Object? durationMin = null,
  }) {
    return _then(
      _value.copyWith(
            code: null == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            origin: null == origin
                ? _value.origin
                : origin // ignore: cast_nullable_to_non_nullable
                      as String,
            destination: null == destination
                ? _value.destination
                : destination // ignore: cast_nullable_to_non_nullable
                      as String,
            distanceKm: null == distanceKm
                ? _value.distanceKm
                : distanceKm // ignore: cast_nullable_to_non_nullable
                      as int,
            durationMin: null == durationMin
                ? _value.durationMin
                : durationMin // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RouteCreateRequestImplCopyWith<$Res>
    implements $RouteCreateRequestCopyWith<$Res> {
  factory _$$RouteCreateRequestImplCopyWith(
    _$RouteCreateRequestImpl value,
    $Res Function(_$RouteCreateRequestImpl) then,
  ) = __$$RouteCreateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String code,
    String name,
    String origin,
    String destination,
    int distanceKm,
    int durationMin,
  });
}

/// @nodoc
class __$$RouteCreateRequestImplCopyWithImpl<$Res>
    extends _$RouteCreateRequestCopyWithImpl<$Res, _$RouteCreateRequestImpl>
    implements _$$RouteCreateRequestImplCopyWith<$Res> {
  __$$RouteCreateRequestImplCopyWithImpl(
    _$RouteCreateRequestImpl _value,
    $Res Function(_$RouteCreateRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RouteCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? name = null,
    Object? origin = null,
    Object? destination = null,
    Object? distanceKm = null,
    Object? durationMin = null,
  }) {
    return _then(
      _$RouteCreateRequestImpl(
        code: null == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        origin: null == origin
            ? _value.origin
            : origin // ignore: cast_nullable_to_non_nullable
                  as String,
        destination: null == destination
            ? _value.destination
            : destination // ignore: cast_nullable_to_non_nullable
                  as String,
        distanceKm: null == distanceKm
            ? _value.distanceKm
            : distanceKm // ignore: cast_nullable_to_non_nullable
                  as int,
        durationMin: null == durationMin
            ? _value.durationMin
            : durationMin // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RouteCreateRequestImpl implements _RouteCreateRequest {
  const _$RouteCreateRequestImpl({
    required this.code,
    required this.name,
    required this.origin,
    required this.destination,
    required this.distanceKm,
    required this.durationMin,
  });

  factory _$RouteCreateRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$RouteCreateRequestImplFromJson(json);

  @override
  final String code;
  @override
  final String name;
  @override
  final String origin;
  @override
  final String destination;
  @override
  final int distanceKm;
  @override
  final int durationMin;

  @override
  String toString() {
    return 'RouteCreateRequest(code: $code, name: $name, origin: $origin, destination: $destination, distanceKm: $distanceKm, durationMin: $durationMin)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RouteCreateRequestImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.origin, origin) || other.origin == origin) &&
            (identical(other.destination, destination) ||
                other.destination == destination) &&
            (identical(other.distanceKm, distanceKm) ||
                other.distanceKm == distanceKm) &&
            (identical(other.durationMin, durationMin) ||
                other.durationMin == durationMin));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    code,
    name,
    origin,
    destination,
    distanceKm,
    durationMin,
  );

  /// Create a copy of RouteCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RouteCreateRequestImplCopyWith<_$RouteCreateRequestImpl> get copyWith =>
      __$$RouteCreateRequestImplCopyWithImpl<_$RouteCreateRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RouteCreateRequestImplToJson(this);
  }
}

abstract class _RouteCreateRequest implements RouteCreateRequest {
  const factory _RouteCreateRequest({
    required final String code,
    required final String name,
    required final String origin,
    required final String destination,
    required final int distanceKm,
    required final int durationMin,
  }) = _$RouteCreateRequestImpl;

  factory _RouteCreateRequest.fromJson(Map<String, dynamic> json) =
      _$RouteCreateRequestImpl.fromJson;

  @override
  String get code;
  @override
  String get name;
  @override
  String get origin;
  @override
  String get destination;
  @override
  int get distanceKm;
  @override
  int get durationMin;

  /// Create a copy of RouteCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RouteCreateRequestImplCopyWith<_$RouteCreateRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RouteUpdateRequest _$RouteUpdateRequestFromJson(Map<String, dynamic> json) {
  return _RouteUpdateRequest.fromJson(json);
}

/// @nodoc
mixin _$RouteUpdateRequest {
  String? get name => throw _privateConstructorUsedError;
  String? get origin => throw _privateConstructorUsedError;
  String? get destination => throw _privateConstructorUsedError;
  int? get distanceKm => throw _privateConstructorUsedError;
  int? get durationMin => throw _privateConstructorUsedError;

  /// Serializes this RouteUpdateRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RouteUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RouteUpdateRequestCopyWith<RouteUpdateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RouteUpdateRequestCopyWith<$Res> {
  factory $RouteUpdateRequestCopyWith(
    RouteUpdateRequest value,
    $Res Function(RouteUpdateRequest) then,
  ) = _$RouteUpdateRequestCopyWithImpl<$Res, RouteUpdateRequest>;
  @useResult
  $Res call({
    String? name,
    String? origin,
    String? destination,
    int? distanceKm,
    int? durationMin,
  });
}

/// @nodoc
class _$RouteUpdateRequestCopyWithImpl<$Res, $Val extends RouteUpdateRequest>
    implements $RouteUpdateRequestCopyWith<$Res> {
  _$RouteUpdateRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RouteUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? origin = freezed,
    Object? destination = freezed,
    Object? distanceKm = freezed,
    Object? durationMin = freezed,
  }) {
    return _then(
      _value.copyWith(
            name: freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String?,
            origin: freezed == origin
                ? _value.origin
                : origin // ignore: cast_nullable_to_non_nullable
                      as String?,
            destination: freezed == destination
                ? _value.destination
                : destination // ignore: cast_nullable_to_non_nullable
                      as String?,
            distanceKm: freezed == distanceKm
                ? _value.distanceKm
                : distanceKm // ignore: cast_nullable_to_non_nullable
                      as int?,
            durationMin: freezed == durationMin
                ? _value.durationMin
                : durationMin // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RouteUpdateRequestImplCopyWith<$Res>
    implements $RouteUpdateRequestCopyWith<$Res> {
  factory _$$RouteUpdateRequestImplCopyWith(
    _$RouteUpdateRequestImpl value,
    $Res Function(_$RouteUpdateRequestImpl) then,
  ) = __$$RouteUpdateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? name,
    String? origin,
    String? destination,
    int? distanceKm,
    int? durationMin,
  });
}

/// @nodoc
class __$$RouteUpdateRequestImplCopyWithImpl<$Res>
    extends _$RouteUpdateRequestCopyWithImpl<$Res, _$RouteUpdateRequestImpl>
    implements _$$RouteUpdateRequestImplCopyWith<$Res> {
  __$$RouteUpdateRequestImplCopyWithImpl(
    _$RouteUpdateRequestImpl _value,
    $Res Function(_$RouteUpdateRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RouteUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? origin = freezed,
    Object? destination = freezed,
    Object? distanceKm = freezed,
    Object? durationMin = freezed,
  }) {
    return _then(
      _$RouteUpdateRequestImpl(
        name: freezed == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String?,
        origin: freezed == origin
            ? _value.origin
            : origin // ignore: cast_nullable_to_non_nullable
                  as String?,
        destination: freezed == destination
            ? _value.destination
            : destination // ignore: cast_nullable_to_non_nullable
                  as String?,
        distanceKm: freezed == distanceKm
            ? _value.distanceKm
            : distanceKm // ignore: cast_nullable_to_non_nullable
                  as int?,
        durationMin: freezed == durationMin
            ? _value.durationMin
            : durationMin // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RouteUpdateRequestImpl implements _RouteUpdateRequest {
  const _$RouteUpdateRequestImpl({
    this.name,
    this.origin,
    this.destination,
    this.distanceKm,
    this.durationMin,
  });

  factory _$RouteUpdateRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$RouteUpdateRequestImplFromJson(json);

  @override
  final String? name;
  @override
  final String? origin;
  @override
  final String? destination;
  @override
  final int? distanceKm;
  @override
  final int? durationMin;

  @override
  String toString() {
    return 'RouteUpdateRequest(name: $name, origin: $origin, destination: $destination, distanceKm: $distanceKm, durationMin: $durationMin)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RouteUpdateRequestImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.origin, origin) || other.origin == origin) &&
            (identical(other.destination, destination) ||
                other.destination == destination) &&
            (identical(other.distanceKm, distanceKm) ||
                other.distanceKm == distanceKm) &&
            (identical(other.durationMin, durationMin) ||
                other.durationMin == durationMin));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    name,
    origin,
    destination,
    distanceKm,
    durationMin,
  );

  /// Create a copy of RouteUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RouteUpdateRequestImplCopyWith<_$RouteUpdateRequestImpl> get copyWith =>
      __$$RouteUpdateRequestImplCopyWithImpl<_$RouteUpdateRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RouteUpdateRequestImplToJson(this);
  }
}

abstract class _RouteUpdateRequest implements RouteUpdateRequest {
  const factory _RouteUpdateRequest({
    final String? name,
    final String? origin,
    final String? destination,
    final int? distanceKm,
    final int? durationMin,
  }) = _$RouteUpdateRequestImpl;

  factory _RouteUpdateRequest.fromJson(Map<String, dynamic> json) =
      _$RouteUpdateRequestImpl.fromJson;

  @override
  String? get name;
  @override
  String? get origin;
  @override
  String? get destination;
  @override
  int? get distanceKm;
  @override
  int? get durationMin;

  /// Create a copy of RouteUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RouteUpdateRequestImplCopyWith<_$RouteUpdateRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
