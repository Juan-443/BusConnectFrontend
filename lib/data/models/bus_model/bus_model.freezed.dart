// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bus_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

BusModel _$BusModelFromJson(Map<String, dynamic> json) {
  return _BusModel.fromJson(json);
}

/// @nodoc
mixin _$BusModel {
  int get id => throw _privateConstructorUsedError;
  String get plate => throw _privateConstructorUsedError;
  int get capacity => throw _privateConstructorUsedError;
  BusStatus get status => throw _privateConstructorUsedError;
  Map<String, dynamic>? get amenities => throw _privateConstructorUsedError;
  List<SeatModel>? get seats => throw _privateConstructorUsedError;

  /// Serializes this BusModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BusModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BusModelCopyWith<BusModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BusModelCopyWith<$Res> {
  factory $BusModelCopyWith(BusModel value, $Res Function(BusModel) then) =
      _$BusModelCopyWithImpl<$Res, BusModel>;
  @useResult
  $Res call({
    int id,
    String plate,
    int capacity,
    BusStatus status,
    Map<String, dynamic>? amenities,
    List<SeatModel>? seats,
  });
}

/// @nodoc
class _$BusModelCopyWithImpl<$Res, $Val extends BusModel>
    implements $BusModelCopyWith<$Res> {
  _$BusModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BusModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? plate = null,
    Object? capacity = null,
    Object? status = null,
    Object? amenities = freezed,
    Object? seats = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            plate: null == plate
                ? _value.plate
                : plate // ignore: cast_nullable_to_non_nullable
                      as String,
            capacity: null == capacity
                ? _value.capacity
                : capacity // ignore: cast_nullable_to_non_nullable
                      as int,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as BusStatus,
            amenities: freezed == amenities
                ? _value.amenities
                : amenities // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            seats: freezed == seats
                ? _value.seats
                : seats // ignore: cast_nullable_to_non_nullable
                      as List<SeatModel>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BusModelImplCopyWith<$Res>
    implements $BusModelCopyWith<$Res> {
  factory _$$BusModelImplCopyWith(
    _$BusModelImpl value,
    $Res Function(_$BusModelImpl) then,
  ) = __$$BusModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String plate,
    int capacity,
    BusStatus status,
    Map<String, dynamic>? amenities,
    List<SeatModel>? seats,
  });
}

/// @nodoc
class __$$BusModelImplCopyWithImpl<$Res>
    extends _$BusModelCopyWithImpl<$Res, _$BusModelImpl>
    implements _$$BusModelImplCopyWith<$Res> {
  __$$BusModelImplCopyWithImpl(
    _$BusModelImpl _value,
    $Res Function(_$BusModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BusModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? plate = null,
    Object? capacity = null,
    Object? status = null,
    Object? amenities = freezed,
    Object? seats = freezed,
  }) {
    return _then(
      _$BusModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        plate: null == plate
            ? _value.plate
            : plate // ignore: cast_nullable_to_non_nullable
                  as String,
        capacity: null == capacity
            ? _value.capacity
            : capacity // ignore: cast_nullable_to_non_nullable
                  as int,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as BusStatus,
        amenities: freezed == amenities
            ? _value._amenities
            : amenities // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        seats: freezed == seats
            ? _value._seats
            : seats // ignore: cast_nullable_to_non_nullable
                  as List<SeatModel>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BusModelImpl implements _BusModel {
  const _$BusModelImpl({
    required this.id,
    required this.plate,
    required this.capacity,
    required this.status,
    final Map<String, dynamic>? amenities,
    final List<SeatModel>? seats,
  }) : _amenities = amenities,
       _seats = seats;

  factory _$BusModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BusModelImplFromJson(json);

  @override
  final int id;
  @override
  final String plate;
  @override
  final int capacity;
  @override
  final BusStatus status;
  final Map<String, dynamic>? _amenities;
  @override
  Map<String, dynamic>? get amenities {
    final value = _amenities;
    if (value == null) return null;
    if (_amenities is EqualUnmodifiableMapView) return _amenities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final List<SeatModel>? _seats;
  @override
  List<SeatModel>? get seats {
    final value = _seats;
    if (value == null) return null;
    if (_seats is EqualUnmodifiableListView) return _seats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'BusModel(id: $id, plate: $plate, capacity: $capacity, status: $status, amenities: $amenities, seats: $seats)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BusModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.plate, plate) || other.plate == plate) &&
            (identical(other.capacity, capacity) ||
                other.capacity == capacity) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(
              other._amenities,
              _amenities,
            ) &&
            const DeepCollectionEquality().equals(other._seats, _seats));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    plate,
    capacity,
    status,
    const DeepCollectionEquality().hash(_amenities),
    const DeepCollectionEquality().hash(_seats),
  );

  /// Create a copy of BusModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BusModelImplCopyWith<_$BusModelImpl> get copyWith =>
      __$$BusModelImplCopyWithImpl<_$BusModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BusModelImplToJson(this);
  }
}

abstract class _BusModel implements BusModel {
  const factory _BusModel({
    required final int id,
    required final String plate,
    required final int capacity,
    required final BusStatus status,
    final Map<String, dynamic>? amenities,
    final List<SeatModel>? seats,
  }) = _$BusModelImpl;

  factory _BusModel.fromJson(Map<String, dynamic> json) =
      _$BusModelImpl.fromJson;

  @override
  int get id;
  @override
  String get plate;
  @override
  int get capacity;
  @override
  BusStatus get status;
  @override
  Map<String, dynamic>? get amenities;
  @override
  List<SeatModel>? get seats;

  /// Create a copy of BusModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BusModelImplCopyWith<_$BusModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BusCreateRequest _$BusCreateRequestFromJson(Map<String, dynamic> json) {
  return _BusCreateRequest.fromJson(json);
}

/// @nodoc
mixin _$BusCreateRequest {
  String get plate => throw _privateConstructorUsedError;
  int get capacity => throw _privateConstructorUsedError;
  Map<String, dynamic>? get amenities => throw _privateConstructorUsedError;
  BusStatus get status => throw _privateConstructorUsedError;

  /// Serializes this BusCreateRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BusCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BusCreateRequestCopyWith<BusCreateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BusCreateRequestCopyWith<$Res> {
  factory $BusCreateRequestCopyWith(
    BusCreateRequest value,
    $Res Function(BusCreateRequest) then,
  ) = _$BusCreateRequestCopyWithImpl<$Res, BusCreateRequest>;
  @useResult
  $Res call({
    String plate,
    int capacity,
    Map<String, dynamic>? amenities,
    BusStatus status,
  });
}

/// @nodoc
class _$BusCreateRequestCopyWithImpl<$Res, $Val extends BusCreateRequest>
    implements $BusCreateRequestCopyWith<$Res> {
  _$BusCreateRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BusCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? plate = null,
    Object? capacity = null,
    Object? amenities = freezed,
    Object? status = null,
  }) {
    return _then(
      _value.copyWith(
            plate: null == plate
                ? _value.plate
                : plate // ignore: cast_nullable_to_non_nullable
                      as String,
            capacity: null == capacity
                ? _value.capacity
                : capacity // ignore: cast_nullable_to_non_nullable
                      as int,
            amenities: freezed == amenities
                ? _value.amenities
                : amenities // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as BusStatus,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BusCreateRequestImplCopyWith<$Res>
    implements $BusCreateRequestCopyWith<$Res> {
  factory _$$BusCreateRequestImplCopyWith(
    _$BusCreateRequestImpl value,
    $Res Function(_$BusCreateRequestImpl) then,
  ) = __$$BusCreateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String plate,
    int capacity,
    Map<String, dynamic>? amenities,
    BusStatus status,
  });
}

/// @nodoc
class __$$BusCreateRequestImplCopyWithImpl<$Res>
    extends _$BusCreateRequestCopyWithImpl<$Res, _$BusCreateRequestImpl>
    implements _$$BusCreateRequestImplCopyWith<$Res> {
  __$$BusCreateRequestImplCopyWithImpl(
    _$BusCreateRequestImpl _value,
    $Res Function(_$BusCreateRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BusCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? plate = null,
    Object? capacity = null,
    Object? amenities = freezed,
    Object? status = null,
  }) {
    return _then(
      _$BusCreateRequestImpl(
        plate: null == plate
            ? _value.plate
            : plate // ignore: cast_nullable_to_non_nullable
                  as String,
        capacity: null == capacity
            ? _value.capacity
            : capacity // ignore: cast_nullable_to_non_nullable
                  as int,
        amenities: freezed == amenities
            ? _value._amenities
            : amenities // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as BusStatus,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$BusCreateRequestImpl implements _BusCreateRequest {
  const _$BusCreateRequestImpl({
    required this.plate,
    required this.capacity,
    final Map<String, dynamic>? amenities,
    required this.status,
  }) : _amenities = amenities;

  factory _$BusCreateRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$BusCreateRequestImplFromJson(json);

  @override
  final String plate;
  @override
  final int capacity;
  final Map<String, dynamic>? _amenities;
  @override
  Map<String, dynamic>? get amenities {
    final value = _amenities;
    if (value == null) return null;
    if (_amenities is EqualUnmodifiableMapView) return _amenities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final BusStatus status;

  @override
  String toString() {
    return 'BusCreateRequest(plate: $plate, capacity: $capacity, amenities: $amenities, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BusCreateRequestImpl &&
            (identical(other.plate, plate) || other.plate == plate) &&
            (identical(other.capacity, capacity) ||
                other.capacity == capacity) &&
            const DeepCollectionEquality().equals(
              other._amenities,
              _amenities,
            ) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    plate,
    capacity,
    const DeepCollectionEquality().hash(_amenities),
    status,
  );

  /// Create a copy of BusCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BusCreateRequestImplCopyWith<_$BusCreateRequestImpl> get copyWith =>
      __$$BusCreateRequestImplCopyWithImpl<_$BusCreateRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$BusCreateRequestImplToJson(this);
  }
}

abstract class _BusCreateRequest implements BusCreateRequest {
  const factory _BusCreateRequest({
    required final String plate,
    required final int capacity,
    final Map<String, dynamic>? amenities,
    required final BusStatus status,
  }) = _$BusCreateRequestImpl;

  factory _BusCreateRequest.fromJson(Map<String, dynamic> json) =
      _$BusCreateRequestImpl.fromJson;

  @override
  String get plate;
  @override
  int get capacity;
  @override
  Map<String, dynamic>? get amenities;
  @override
  BusStatus get status;

  /// Create a copy of BusCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BusCreateRequestImplCopyWith<_$BusCreateRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BusUpdateRequest _$BusUpdateRequestFromJson(Map<String, dynamic> json) {
  return _BusUpdateRequest.fromJson(json);
}

/// @nodoc
mixin _$BusUpdateRequest {
  String? get plate => throw _privateConstructorUsedError;
  int? get capacity => throw _privateConstructorUsedError;
  BusStatus? get status => throw _privateConstructorUsedError;
  Map<String, dynamic>? get amenities => throw _privateConstructorUsedError;

  /// Serializes this BusUpdateRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BusUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BusUpdateRequestCopyWith<BusUpdateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BusUpdateRequestCopyWith<$Res> {
  factory $BusUpdateRequestCopyWith(
    BusUpdateRequest value,
    $Res Function(BusUpdateRequest) then,
  ) = _$BusUpdateRequestCopyWithImpl<$Res, BusUpdateRequest>;
  @useResult
  $Res call({
    String? plate,
    int? capacity,
    BusStatus? status,
    Map<String, dynamic>? amenities,
  });
}

/// @nodoc
class _$BusUpdateRequestCopyWithImpl<$Res, $Val extends BusUpdateRequest>
    implements $BusUpdateRequestCopyWith<$Res> {
  _$BusUpdateRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BusUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? plate = freezed,
    Object? capacity = freezed,
    Object? status = freezed,
    Object? amenities = freezed,
  }) {
    return _then(
      _value.copyWith(
            plate: freezed == plate
                ? _value.plate
                : plate // ignore: cast_nullable_to_non_nullable
                      as String?,
            capacity: freezed == capacity
                ? _value.capacity
                : capacity // ignore: cast_nullable_to_non_nullable
                      as int?,
            status: freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as BusStatus?,
            amenities: freezed == amenities
                ? _value.amenities
                : amenities // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BusUpdateRequestImplCopyWith<$Res>
    implements $BusUpdateRequestCopyWith<$Res> {
  factory _$$BusUpdateRequestImplCopyWith(
    _$BusUpdateRequestImpl value,
    $Res Function(_$BusUpdateRequestImpl) then,
  ) = __$$BusUpdateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? plate,
    int? capacity,
    BusStatus? status,
    Map<String, dynamic>? amenities,
  });
}

/// @nodoc
class __$$BusUpdateRequestImplCopyWithImpl<$Res>
    extends _$BusUpdateRequestCopyWithImpl<$Res, _$BusUpdateRequestImpl>
    implements _$$BusUpdateRequestImplCopyWith<$Res> {
  __$$BusUpdateRequestImplCopyWithImpl(
    _$BusUpdateRequestImpl _value,
    $Res Function(_$BusUpdateRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BusUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? plate = freezed,
    Object? capacity = freezed,
    Object? status = freezed,
    Object? amenities = freezed,
  }) {
    return _then(
      _$BusUpdateRequestImpl(
        plate: freezed == plate
            ? _value.plate
            : plate // ignore: cast_nullable_to_non_nullable
                  as String?,
        capacity: freezed == capacity
            ? _value.capacity
            : capacity // ignore: cast_nullable_to_non_nullable
                  as int?,
        status: freezed == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as BusStatus?,
        amenities: freezed == amenities
            ? _value._amenities
            : amenities // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$BusUpdateRequestImpl implements _BusUpdateRequest {
  const _$BusUpdateRequestImpl({
    this.plate,
    this.capacity,
    this.status,
    final Map<String, dynamic>? amenities,
  }) : _amenities = amenities;

  factory _$BusUpdateRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$BusUpdateRequestImplFromJson(json);

  @override
  final String? plate;
  @override
  final int? capacity;
  @override
  final BusStatus? status;
  final Map<String, dynamic>? _amenities;
  @override
  Map<String, dynamic>? get amenities {
    final value = _amenities;
    if (value == null) return null;
    if (_amenities is EqualUnmodifiableMapView) return _amenities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'BusUpdateRequest(plate: $plate, capacity: $capacity, status: $status, amenities: $amenities)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BusUpdateRequestImpl &&
            (identical(other.plate, plate) || other.plate == plate) &&
            (identical(other.capacity, capacity) ||
                other.capacity == capacity) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(
              other._amenities,
              _amenities,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    plate,
    capacity,
    status,
    const DeepCollectionEquality().hash(_amenities),
  );

  /// Create a copy of BusUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BusUpdateRequestImplCopyWith<_$BusUpdateRequestImpl> get copyWith =>
      __$$BusUpdateRequestImplCopyWithImpl<_$BusUpdateRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$BusUpdateRequestImplToJson(this);
  }
}

abstract class _BusUpdateRequest implements BusUpdateRequest {
  const factory _BusUpdateRequest({
    final String? plate,
    final int? capacity,
    final BusStatus? status,
    final Map<String, dynamic>? amenities,
  }) = _$BusUpdateRequestImpl;

  factory _BusUpdateRequest.fromJson(Map<String, dynamic> json) =
      _$BusUpdateRequestImpl.fromJson;

  @override
  String? get plate;
  @override
  int? get capacity;
  @override
  BusStatus? get status;
  @override
  Map<String, dynamic>? get amenities;

  /// Create a copy of BusUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BusUpdateRequestImplCopyWith<_$BusUpdateRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
