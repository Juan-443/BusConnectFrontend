// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'baggage_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

BaggageModel _$BaggageModelFromJson(Map<String, dynamic> json) {
  return _BaggageModel.fromJson(json);
}

/// @nodoc
mixin _$BaggageModel {
  int get id => throw _privateConstructorUsedError;
  double get weightKg => throw _privateConstructorUsedError;
  double get fee => throw _privateConstructorUsedError;
  String get tagCode => throw _privateConstructorUsedError;
  int get ticketId => throw _privateConstructorUsedError;
  String? get passengerName => throw _privateConstructorUsedError;
  String? get tripInfo => throw _privateConstructorUsedError;
  bool? get excessWeight => throw _privateConstructorUsedError;

  /// Serializes this BaggageModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BaggageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BaggageModelCopyWith<BaggageModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BaggageModelCopyWith<$Res> {
  factory $BaggageModelCopyWith(
    BaggageModel value,
    $Res Function(BaggageModel) then,
  ) = _$BaggageModelCopyWithImpl<$Res, BaggageModel>;
  @useResult
  $Res call({
    int id,
    double weightKg,
    double fee,
    String tagCode,
    int ticketId,
    String? passengerName,
    String? tripInfo,
    bool? excessWeight,
  });
}

/// @nodoc
class _$BaggageModelCopyWithImpl<$Res, $Val extends BaggageModel>
    implements $BaggageModelCopyWith<$Res> {
  _$BaggageModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BaggageModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? weightKg = null,
    Object? fee = null,
    Object? tagCode = null,
    Object? ticketId = null,
    Object? passengerName = freezed,
    Object? tripInfo = freezed,
    Object? excessWeight = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            weightKg: null == weightKg
                ? _value.weightKg
                : weightKg // ignore: cast_nullable_to_non_nullable
                      as double,
            fee: null == fee
                ? _value.fee
                : fee // ignore: cast_nullable_to_non_nullable
                      as double,
            tagCode: null == tagCode
                ? _value.tagCode
                : tagCode // ignore: cast_nullable_to_non_nullable
                      as String,
            ticketId: null == ticketId
                ? _value.ticketId
                : ticketId // ignore: cast_nullable_to_non_nullable
                      as int,
            passengerName: freezed == passengerName
                ? _value.passengerName
                : passengerName // ignore: cast_nullable_to_non_nullable
                      as String?,
            tripInfo: freezed == tripInfo
                ? _value.tripInfo
                : tripInfo // ignore: cast_nullable_to_non_nullable
                      as String?,
            excessWeight: freezed == excessWeight
                ? _value.excessWeight
                : excessWeight // ignore: cast_nullable_to_non_nullable
                      as bool?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BaggageModelImplCopyWith<$Res>
    implements $BaggageModelCopyWith<$Res> {
  factory _$$BaggageModelImplCopyWith(
    _$BaggageModelImpl value,
    $Res Function(_$BaggageModelImpl) then,
  ) = __$$BaggageModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    double weightKg,
    double fee,
    String tagCode,
    int ticketId,
    String? passengerName,
    String? tripInfo,
    bool? excessWeight,
  });
}

/// @nodoc
class __$$BaggageModelImplCopyWithImpl<$Res>
    extends _$BaggageModelCopyWithImpl<$Res, _$BaggageModelImpl>
    implements _$$BaggageModelImplCopyWith<$Res> {
  __$$BaggageModelImplCopyWithImpl(
    _$BaggageModelImpl _value,
    $Res Function(_$BaggageModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BaggageModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? weightKg = null,
    Object? fee = null,
    Object? tagCode = null,
    Object? ticketId = null,
    Object? passengerName = freezed,
    Object? tripInfo = freezed,
    Object? excessWeight = freezed,
  }) {
    return _then(
      _$BaggageModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        weightKg: null == weightKg
            ? _value.weightKg
            : weightKg // ignore: cast_nullable_to_non_nullable
                  as double,
        fee: null == fee
            ? _value.fee
            : fee // ignore: cast_nullable_to_non_nullable
                  as double,
        tagCode: null == tagCode
            ? _value.tagCode
            : tagCode // ignore: cast_nullable_to_non_nullable
                  as String,
        ticketId: null == ticketId
            ? _value.ticketId
            : ticketId // ignore: cast_nullable_to_non_nullable
                  as int,
        passengerName: freezed == passengerName
            ? _value.passengerName
            : passengerName // ignore: cast_nullable_to_non_nullable
                  as String?,
        tripInfo: freezed == tripInfo
            ? _value.tripInfo
            : tripInfo // ignore: cast_nullable_to_non_nullable
                  as String?,
        excessWeight: freezed == excessWeight
            ? _value.excessWeight
            : excessWeight // ignore: cast_nullable_to_non_nullable
                  as bool?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BaggageModelImpl implements _BaggageModel {
  const _$BaggageModelImpl({
    required this.id,
    required this.weightKg,
    required this.fee,
    required this.tagCode,
    required this.ticketId,
    this.passengerName,
    this.tripInfo,
    this.excessWeight,
  });

  factory _$BaggageModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BaggageModelImplFromJson(json);

  @override
  final int id;
  @override
  final double weightKg;
  @override
  final double fee;
  @override
  final String tagCode;
  @override
  final int ticketId;
  @override
  final String? passengerName;
  @override
  final String? tripInfo;
  @override
  final bool? excessWeight;

  @override
  String toString() {
    return 'BaggageModel(id: $id, weightKg: $weightKg, fee: $fee, tagCode: $tagCode, ticketId: $ticketId, passengerName: $passengerName, tripInfo: $tripInfo, excessWeight: $excessWeight)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BaggageModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.weightKg, weightKg) ||
                other.weightKg == weightKg) &&
            (identical(other.fee, fee) || other.fee == fee) &&
            (identical(other.tagCode, tagCode) || other.tagCode == tagCode) &&
            (identical(other.ticketId, ticketId) ||
                other.ticketId == ticketId) &&
            (identical(other.passengerName, passengerName) ||
                other.passengerName == passengerName) &&
            (identical(other.tripInfo, tripInfo) ||
                other.tripInfo == tripInfo) &&
            (identical(other.excessWeight, excessWeight) ||
                other.excessWeight == excessWeight));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    weightKg,
    fee,
    tagCode,
    ticketId,
    passengerName,
    tripInfo,
    excessWeight,
  );

  /// Create a copy of BaggageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BaggageModelImplCopyWith<_$BaggageModelImpl> get copyWith =>
      __$$BaggageModelImplCopyWithImpl<_$BaggageModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BaggageModelImplToJson(this);
  }
}

abstract class _BaggageModel implements BaggageModel {
  const factory _BaggageModel({
    required final int id,
    required final double weightKg,
    required final double fee,
    required final String tagCode,
    required final int ticketId,
    final String? passengerName,
    final String? tripInfo,
    final bool? excessWeight,
  }) = _$BaggageModelImpl;

  factory _BaggageModel.fromJson(Map<String, dynamic> json) =
      _$BaggageModelImpl.fromJson;

  @override
  int get id;
  @override
  double get weightKg;
  @override
  double get fee;
  @override
  String get tagCode;
  @override
  int get ticketId;
  @override
  String? get passengerName;
  @override
  String? get tripInfo;
  @override
  bool? get excessWeight;

  /// Create a copy of BaggageModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BaggageModelImplCopyWith<_$BaggageModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BaggageCreateRequest _$BaggageCreateRequestFromJson(Map<String, dynamic> json) {
  return _BaggageCreateRequest.fromJson(json);
}

/// @nodoc
mixin _$BaggageCreateRequest {
  int get ticketId => throw _privateConstructorUsedError;
  double get weightKg => throw _privateConstructorUsedError;
  double get fee => throw _privateConstructorUsedError;

  /// Serializes this BaggageCreateRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BaggageCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BaggageCreateRequestCopyWith<BaggageCreateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BaggageCreateRequestCopyWith<$Res> {
  factory $BaggageCreateRequestCopyWith(
    BaggageCreateRequest value,
    $Res Function(BaggageCreateRequest) then,
  ) = _$BaggageCreateRequestCopyWithImpl<$Res, BaggageCreateRequest>;
  @useResult
  $Res call({int ticketId, double weightKg, double fee});
}

/// @nodoc
class _$BaggageCreateRequestCopyWithImpl<
  $Res,
  $Val extends BaggageCreateRequest
>
    implements $BaggageCreateRequestCopyWith<$Res> {
  _$BaggageCreateRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BaggageCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ticketId = null,
    Object? weightKg = null,
    Object? fee = null,
  }) {
    return _then(
      _value.copyWith(
            ticketId: null == ticketId
                ? _value.ticketId
                : ticketId // ignore: cast_nullable_to_non_nullable
                      as int,
            weightKg: null == weightKg
                ? _value.weightKg
                : weightKg // ignore: cast_nullable_to_non_nullable
                      as double,
            fee: null == fee
                ? _value.fee
                : fee // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BaggageCreateRequestImplCopyWith<$Res>
    implements $BaggageCreateRequestCopyWith<$Res> {
  factory _$$BaggageCreateRequestImplCopyWith(
    _$BaggageCreateRequestImpl value,
    $Res Function(_$BaggageCreateRequestImpl) then,
  ) = __$$BaggageCreateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int ticketId, double weightKg, double fee});
}

/// @nodoc
class __$$BaggageCreateRequestImplCopyWithImpl<$Res>
    extends _$BaggageCreateRequestCopyWithImpl<$Res, _$BaggageCreateRequestImpl>
    implements _$$BaggageCreateRequestImplCopyWith<$Res> {
  __$$BaggageCreateRequestImplCopyWithImpl(
    _$BaggageCreateRequestImpl _value,
    $Res Function(_$BaggageCreateRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BaggageCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ticketId = null,
    Object? weightKg = null,
    Object? fee = null,
  }) {
    return _then(
      _$BaggageCreateRequestImpl(
        ticketId: null == ticketId
            ? _value.ticketId
            : ticketId // ignore: cast_nullable_to_non_nullable
                  as int,
        weightKg: null == weightKg
            ? _value.weightKg
            : weightKg // ignore: cast_nullable_to_non_nullable
                  as double,
        fee: null == fee
            ? _value.fee
            : fee // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BaggageCreateRequestImpl implements _BaggageCreateRequest {
  const _$BaggageCreateRequestImpl({
    required this.ticketId,
    required this.weightKg,
    required this.fee,
  });

  factory _$BaggageCreateRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$BaggageCreateRequestImplFromJson(json);

  @override
  final int ticketId;
  @override
  final double weightKg;
  @override
  final double fee;

  @override
  String toString() {
    return 'BaggageCreateRequest(ticketId: $ticketId, weightKg: $weightKg, fee: $fee)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BaggageCreateRequestImpl &&
            (identical(other.ticketId, ticketId) ||
                other.ticketId == ticketId) &&
            (identical(other.weightKg, weightKg) ||
                other.weightKg == weightKg) &&
            (identical(other.fee, fee) || other.fee == fee));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, ticketId, weightKg, fee);

  /// Create a copy of BaggageCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BaggageCreateRequestImplCopyWith<_$BaggageCreateRequestImpl>
  get copyWith =>
      __$$BaggageCreateRequestImplCopyWithImpl<_$BaggageCreateRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$BaggageCreateRequestImplToJson(this);
  }
}

abstract class _BaggageCreateRequest implements BaggageCreateRequest {
  const factory _BaggageCreateRequest({
    required final int ticketId,
    required final double weightKg,
    required final double fee,
  }) = _$BaggageCreateRequestImpl;

  factory _BaggageCreateRequest.fromJson(Map<String, dynamic> json) =
      _$BaggageCreateRequestImpl.fromJson;

  @override
  int get ticketId;
  @override
  double get weightKg;
  @override
  double get fee;

  /// Create a copy of BaggageCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BaggageCreateRequestImplCopyWith<_$BaggageCreateRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}

BaggageUpdateRequest _$BaggageUpdateRequestFromJson(Map<String, dynamic> json) {
  return _BaggageUpdateRequest.fromJson(json);
}

/// @nodoc
mixin _$BaggageUpdateRequest {
  double? get weightKg => throw _privateConstructorUsedError;
  double? get fee => throw _privateConstructorUsedError;

  /// Serializes this BaggageUpdateRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BaggageUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BaggageUpdateRequestCopyWith<BaggageUpdateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BaggageUpdateRequestCopyWith<$Res> {
  factory $BaggageUpdateRequestCopyWith(
    BaggageUpdateRequest value,
    $Res Function(BaggageUpdateRequest) then,
  ) = _$BaggageUpdateRequestCopyWithImpl<$Res, BaggageUpdateRequest>;
  @useResult
  $Res call({double? weightKg, double? fee});
}

/// @nodoc
class _$BaggageUpdateRequestCopyWithImpl<
  $Res,
  $Val extends BaggageUpdateRequest
>
    implements $BaggageUpdateRequestCopyWith<$Res> {
  _$BaggageUpdateRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BaggageUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? weightKg = freezed, Object? fee = freezed}) {
    return _then(
      _value.copyWith(
            weightKg: freezed == weightKg
                ? _value.weightKg
                : weightKg // ignore: cast_nullable_to_non_nullable
                      as double?,
            fee: freezed == fee
                ? _value.fee
                : fee // ignore: cast_nullable_to_non_nullable
                      as double?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BaggageUpdateRequestImplCopyWith<$Res>
    implements $BaggageUpdateRequestCopyWith<$Res> {
  factory _$$BaggageUpdateRequestImplCopyWith(
    _$BaggageUpdateRequestImpl value,
    $Res Function(_$BaggageUpdateRequestImpl) then,
  ) = __$$BaggageUpdateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double? weightKg, double? fee});
}

/// @nodoc
class __$$BaggageUpdateRequestImplCopyWithImpl<$Res>
    extends _$BaggageUpdateRequestCopyWithImpl<$Res, _$BaggageUpdateRequestImpl>
    implements _$$BaggageUpdateRequestImplCopyWith<$Res> {
  __$$BaggageUpdateRequestImplCopyWithImpl(
    _$BaggageUpdateRequestImpl _value,
    $Res Function(_$BaggageUpdateRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BaggageUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? weightKg = freezed, Object? fee = freezed}) {
    return _then(
      _$BaggageUpdateRequestImpl(
        weightKg: freezed == weightKg
            ? _value.weightKg
            : weightKg // ignore: cast_nullable_to_non_nullable
                  as double?,
        fee: freezed == fee
            ? _value.fee
            : fee // ignore: cast_nullable_to_non_nullable
                  as double?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BaggageUpdateRequestImpl implements _BaggageUpdateRequest {
  const _$BaggageUpdateRequestImpl({this.weightKg, this.fee});

  factory _$BaggageUpdateRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$BaggageUpdateRequestImplFromJson(json);

  @override
  final double? weightKg;
  @override
  final double? fee;

  @override
  String toString() {
    return 'BaggageUpdateRequest(weightKg: $weightKg, fee: $fee)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BaggageUpdateRequestImpl &&
            (identical(other.weightKg, weightKg) ||
                other.weightKg == weightKg) &&
            (identical(other.fee, fee) || other.fee == fee));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, weightKg, fee);

  /// Create a copy of BaggageUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BaggageUpdateRequestImplCopyWith<_$BaggageUpdateRequestImpl>
  get copyWith =>
      __$$BaggageUpdateRequestImplCopyWithImpl<_$BaggageUpdateRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$BaggageUpdateRequestImplToJson(this);
  }
}

abstract class _BaggageUpdateRequest implements BaggageUpdateRequest {
  const factory _BaggageUpdateRequest({
    final double? weightKg,
    final double? fee,
  }) = _$BaggageUpdateRequestImpl;

  factory _BaggageUpdateRequest.fromJson(Map<String, dynamic> json) =
      _$BaggageUpdateRequestImpl.fromJson;

  @override
  double? get weightKg;
  @override
  double? get fee;

  /// Create a copy of BaggageUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BaggageUpdateRequestImplCopyWith<_$BaggageUpdateRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}
