// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fare_rule_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

FareRuleModel _$FareRuleModelFromJson(Map<String, dynamic> json) {
  return _FareRuleModel.fromJson(json);
}

/// @nodoc
mixin _$FareRuleModel {
  int get id => throw _privateConstructorUsedError;
  double get basePrice => throw _privateConstructorUsedError;
  Map<String, dynamic>? get discounts => throw _privateConstructorUsedError;
  DynamicPricingStatus get dynamicPricing => throw _privateConstructorUsedError;
  Map<String, double>? get passengerDiscounts =>
      throw _privateConstructorUsedError;
  int get routeId => throw _privateConstructorUsedError;
  int get fromStopId => throw _privateConstructorUsedError;
  int get toStopId => throw _privateConstructorUsedError;

  /// Serializes this FareRuleModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FareRuleModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FareRuleModelCopyWith<FareRuleModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FareRuleModelCopyWith<$Res> {
  factory $FareRuleModelCopyWith(
    FareRuleModel value,
    $Res Function(FareRuleModel) then,
  ) = _$FareRuleModelCopyWithImpl<$Res, FareRuleModel>;
  @useResult
  $Res call({
    int id,
    double basePrice,
    Map<String, dynamic>? discounts,
    DynamicPricingStatus dynamicPricing,
    Map<String, double>? passengerDiscounts,
    int routeId,
    int fromStopId,
    int toStopId,
  });
}

/// @nodoc
class _$FareRuleModelCopyWithImpl<$Res, $Val extends FareRuleModel>
    implements $FareRuleModelCopyWith<$Res> {
  _$FareRuleModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FareRuleModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? basePrice = null,
    Object? discounts = freezed,
    Object? dynamicPricing = null,
    Object? passengerDiscounts = freezed,
    Object? routeId = null,
    Object? fromStopId = null,
    Object? toStopId = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            basePrice: null == basePrice
                ? _value.basePrice
                : basePrice // ignore: cast_nullable_to_non_nullable
                      as double,
            discounts: freezed == discounts
                ? _value.discounts
                : discounts // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            dynamicPricing: null == dynamicPricing
                ? _value.dynamicPricing
                : dynamicPricing // ignore: cast_nullable_to_non_nullable
                      as DynamicPricingStatus,
            passengerDiscounts: freezed == passengerDiscounts
                ? _value.passengerDiscounts
                : passengerDiscounts // ignore: cast_nullable_to_non_nullable
                      as Map<String, double>?,
            routeId: null == routeId
                ? _value.routeId
                : routeId // ignore: cast_nullable_to_non_nullable
                      as int,
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
abstract class _$$FareRuleModelImplCopyWith<$Res>
    implements $FareRuleModelCopyWith<$Res> {
  factory _$$FareRuleModelImplCopyWith(
    _$FareRuleModelImpl value,
    $Res Function(_$FareRuleModelImpl) then,
  ) = __$$FareRuleModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    double basePrice,
    Map<String, dynamic>? discounts,
    DynamicPricingStatus dynamicPricing,
    Map<String, double>? passengerDiscounts,
    int routeId,
    int fromStopId,
    int toStopId,
  });
}

/// @nodoc
class __$$FareRuleModelImplCopyWithImpl<$Res>
    extends _$FareRuleModelCopyWithImpl<$Res, _$FareRuleModelImpl>
    implements _$$FareRuleModelImplCopyWith<$Res> {
  __$$FareRuleModelImplCopyWithImpl(
    _$FareRuleModelImpl _value,
    $Res Function(_$FareRuleModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FareRuleModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? basePrice = null,
    Object? discounts = freezed,
    Object? dynamicPricing = null,
    Object? passengerDiscounts = freezed,
    Object? routeId = null,
    Object? fromStopId = null,
    Object? toStopId = null,
  }) {
    return _then(
      _$FareRuleModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        basePrice: null == basePrice
            ? _value.basePrice
            : basePrice // ignore: cast_nullable_to_non_nullable
                  as double,
        discounts: freezed == discounts
            ? _value._discounts
            : discounts // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        dynamicPricing: null == dynamicPricing
            ? _value.dynamicPricing
            : dynamicPricing // ignore: cast_nullable_to_non_nullable
                  as DynamicPricingStatus,
        passengerDiscounts: freezed == passengerDiscounts
            ? _value._passengerDiscounts
            : passengerDiscounts // ignore: cast_nullable_to_non_nullable
                  as Map<String, double>?,
        routeId: null == routeId
            ? _value.routeId
            : routeId // ignore: cast_nullable_to_non_nullable
                  as int,
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
class _$FareRuleModelImpl implements _FareRuleModel {
  const _$FareRuleModelImpl({
    required this.id,
    required this.basePrice,
    final Map<String, dynamic>? discounts,
    required this.dynamicPricing,
    final Map<String, double>? passengerDiscounts,
    required this.routeId,
    required this.fromStopId,
    required this.toStopId,
  }) : _discounts = discounts,
       _passengerDiscounts = passengerDiscounts;

  factory _$FareRuleModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FareRuleModelImplFromJson(json);

  @override
  final int id;
  @override
  final double basePrice;
  final Map<String, dynamic>? _discounts;
  @override
  Map<String, dynamic>? get discounts {
    final value = _discounts;
    if (value == null) return null;
    if (_discounts is EqualUnmodifiableMapView) return _discounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final DynamicPricingStatus dynamicPricing;
  final Map<String, double>? _passengerDiscounts;
  @override
  Map<String, double>? get passengerDiscounts {
    final value = _passengerDiscounts;
    if (value == null) return null;
    if (_passengerDiscounts is EqualUnmodifiableMapView)
      return _passengerDiscounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final int routeId;
  @override
  final int fromStopId;
  @override
  final int toStopId;

  @override
  String toString() {
    return 'FareRuleModel(id: $id, basePrice: $basePrice, discounts: $discounts, dynamicPricing: $dynamicPricing, passengerDiscounts: $passengerDiscounts, routeId: $routeId, fromStopId: $fromStopId, toStopId: $toStopId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FareRuleModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.basePrice, basePrice) ||
                other.basePrice == basePrice) &&
            const DeepCollectionEquality().equals(
              other._discounts,
              _discounts,
            ) &&
            (identical(other.dynamicPricing, dynamicPricing) ||
                other.dynamicPricing == dynamicPricing) &&
            const DeepCollectionEquality().equals(
              other._passengerDiscounts,
              _passengerDiscounts,
            ) &&
            (identical(other.routeId, routeId) || other.routeId == routeId) &&
            (identical(other.fromStopId, fromStopId) ||
                other.fromStopId == fromStopId) &&
            (identical(other.toStopId, toStopId) ||
                other.toStopId == toStopId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    basePrice,
    const DeepCollectionEquality().hash(_discounts),
    dynamicPricing,
    const DeepCollectionEquality().hash(_passengerDiscounts),
    routeId,
    fromStopId,
    toStopId,
  );

  /// Create a copy of FareRuleModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FareRuleModelImplCopyWith<_$FareRuleModelImpl> get copyWith =>
      __$$FareRuleModelImplCopyWithImpl<_$FareRuleModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FareRuleModelImplToJson(this);
  }
}

abstract class _FareRuleModel implements FareRuleModel {
  const factory _FareRuleModel({
    required final int id,
    required final double basePrice,
    final Map<String, dynamic>? discounts,
    required final DynamicPricingStatus dynamicPricing,
    final Map<String, double>? passengerDiscounts,
    required final int routeId,
    required final int fromStopId,
    required final int toStopId,
  }) = _$FareRuleModelImpl;

  factory _FareRuleModel.fromJson(Map<String, dynamic> json) =
      _$FareRuleModelImpl.fromJson;

  @override
  int get id;
  @override
  double get basePrice;
  @override
  Map<String, dynamic>? get discounts;
  @override
  DynamicPricingStatus get dynamicPricing;
  @override
  Map<String, double>? get passengerDiscounts;
  @override
  int get routeId;
  @override
  int get fromStopId;
  @override
  int get toStopId;

  /// Create a copy of FareRuleModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FareRuleModelImplCopyWith<_$FareRuleModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FareRuleCreateRequest _$FareRuleCreateRequestFromJson(
  Map<String, dynamic> json,
) {
  return _FareRuleCreateRequest.fromJson(json);
}

/// @nodoc
mixin _$FareRuleCreateRequest {
  int get routeId => throw _privateConstructorUsedError;
  int get fromStopId => throw _privateConstructorUsedError;
  int get toStopId => throw _privateConstructorUsedError;
  double get basePrice => throw _privateConstructorUsedError;
  Map<String, dynamic>? get discounts => throw _privateConstructorUsedError;
  DynamicPricingStatus? get dynamicPricing =>
      throw _privateConstructorUsedError;

  /// Serializes this FareRuleCreateRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FareRuleCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FareRuleCreateRequestCopyWith<FareRuleCreateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FareRuleCreateRequestCopyWith<$Res> {
  factory $FareRuleCreateRequestCopyWith(
    FareRuleCreateRequest value,
    $Res Function(FareRuleCreateRequest) then,
  ) = _$FareRuleCreateRequestCopyWithImpl<$Res, FareRuleCreateRequest>;
  @useResult
  $Res call({
    int routeId,
    int fromStopId,
    int toStopId,
    double basePrice,
    Map<String, dynamic>? discounts,
    DynamicPricingStatus? dynamicPricing,
  });
}

/// @nodoc
class _$FareRuleCreateRequestCopyWithImpl<
  $Res,
  $Val extends FareRuleCreateRequest
>
    implements $FareRuleCreateRequestCopyWith<$Res> {
  _$FareRuleCreateRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FareRuleCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? routeId = null,
    Object? fromStopId = null,
    Object? toStopId = null,
    Object? basePrice = null,
    Object? discounts = freezed,
    Object? dynamicPricing = freezed,
  }) {
    return _then(
      _value.copyWith(
            routeId: null == routeId
                ? _value.routeId
                : routeId // ignore: cast_nullable_to_non_nullable
                      as int,
            fromStopId: null == fromStopId
                ? _value.fromStopId
                : fromStopId // ignore: cast_nullable_to_non_nullable
                      as int,
            toStopId: null == toStopId
                ? _value.toStopId
                : toStopId // ignore: cast_nullable_to_non_nullable
                      as int,
            basePrice: null == basePrice
                ? _value.basePrice
                : basePrice // ignore: cast_nullable_to_non_nullable
                      as double,
            discounts: freezed == discounts
                ? _value.discounts
                : discounts // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            dynamicPricing: freezed == dynamicPricing
                ? _value.dynamicPricing
                : dynamicPricing // ignore: cast_nullable_to_non_nullable
                      as DynamicPricingStatus?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FareRuleCreateRequestImplCopyWith<$Res>
    implements $FareRuleCreateRequestCopyWith<$Res> {
  factory _$$FareRuleCreateRequestImplCopyWith(
    _$FareRuleCreateRequestImpl value,
    $Res Function(_$FareRuleCreateRequestImpl) then,
  ) = __$$FareRuleCreateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int routeId,
    int fromStopId,
    int toStopId,
    double basePrice,
    Map<String, dynamic>? discounts,
    DynamicPricingStatus? dynamicPricing,
  });
}

/// @nodoc
class __$$FareRuleCreateRequestImplCopyWithImpl<$Res>
    extends
        _$FareRuleCreateRequestCopyWithImpl<$Res, _$FareRuleCreateRequestImpl>
    implements _$$FareRuleCreateRequestImplCopyWith<$Res> {
  __$$FareRuleCreateRequestImplCopyWithImpl(
    _$FareRuleCreateRequestImpl _value,
    $Res Function(_$FareRuleCreateRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FareRuleCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? routeId = null,
    Object? fromStopId = null,
    Object? toStopId = null,
    Object? basePrice = null,
    Object? discounts = freezed,
    Object? dynamicPricing = freezed,
  }) {
    return _then(
      _$FareRuleCreateRequestImpl(
        routeId: null == routeId
            ? _value.routeId
            : routeId // ignore: cast_nullable_to_non_nullable
                  as int,
        fromStopId: null == fromStopId
            ? _value.fromStopId
            : fromStopId // ignore: cast_nullable_to_non_nullable
                  as int,
        toStopId: null == toStopId
            ? _value.toStopId
            : toStopId // ignore: cast_nullable_to_non_nullable
                  as int,
        basePrice: null == basePrice
            ? _value.basePrice
            : basePrice // ignore: cast_nullable_to_non_nullable
                  as double,
        discounts: freezed == discounts
            ? _value._discounts
            : discounts // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        dynamicPricing: freezed == dynamicPricing
            ? _value.dynamicPricing
            : dynamicPricing // ignore: cast_nullable_to_non_nullable
                  as DynamicPricingStatus?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FareRuleCreateRequestImpl implements _FareRuleCreateRequest {
  const _$FareRuleCreateRequestImpl({
    required this.routeId,
    required this.fromStopId,
    required this.toStopId,
    required this.basePrice,
    final Map<String, dynamic>? discounts,
    this.dynamicPricing,
  }) : _discounts = discounts;

  factory _$FareRuleCreateRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$FareRuleCreateRequestImplFromJson(json);

  @override
  final int routeId;
  @override
  final int fromStopId;
  @override
  final int toStopId;
  @override
  final double basePrice;
  final Map<String, dynamic>? _discounts;
  @override
  Map<String, dynamic>? get discounts {
    final value = _discounts;
    if (value == null) return null;
    if (_discounts is EqualUnmodifiableMapView) return _discounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final DynamicPricingStatus? dynamicPricing;

  @override
  String toString() {
    return 'FareRuleCreateRequest(routeId: $routeId, fromStopId: $fromStopId, toStopId: $toStopId, basePrice: $basePrice, discounts: $discounts, dynamicPricing: $dynamicPricing)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FareRuleCreateRequestImpl &&
            (identical(other.routeId, routeId) || other.routeId == routeId) &&
            (identical(other.fromStopId, fromStopId) ||
                other.fromStopId == fromStopId) &&
            (identical(other.toStopId, toStopId) ||
                other.toStopId == toStopId) &&
            (identical(other.basePrice, basePrice) ||
                other.basePrice == basePrice) &&
            const DeepCollectionEquality().equals(
              other._discounts,
              _discounts,
            ) &&
            (identical(other.dynamicPricing, dynamicPricing) ||
                other.dynamicPricing == dynamicPricing));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    routeId,
    fromStopId,
    toStopId,
    basePrice,
    const DeepCollectionEquality().hash(_discounts),
    dynamicPricing,
  );

  /// Create a copy of FareRuleCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FareRuleCreateRequestImplCopyWith<_$FareRuleCreateRequestImpl>
  get copyWith =>
      __$$FareRuleCreateRequestImplCopyWithImpl<_$FareRuleCreateRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$FareRuleCreateRequestImplToJson(this);
  }
}

abstract class _FareRuleCreateRequest implements FareRuleCreateRequest {
  const factory _FareRuleCreateRequest({
    required final int routeId,
    required final int fromStopId,
    required final int toStopId,
    required final double basePrice,
    final Map<String, dynamic>? discounts,
    final DynamicPricingStatus? dynamicPricing,
  }) = _$FareRuleCreateRequestImpl;

  factory _FareRuleCreateRequest.fromJson(Map<String, dynamic> json) =
      _$FareRuleCreateRequestImpl.fromJson;

  @override
  int get routeId;
  @override
  int get fromStopId;
  @override
  int get toStopId;
  @override
  double get basePrice;
  @override
  Map<String, dynamic>? get discounts;
  @override
  DynamicPricingStatus? get dynamicPricing;

  /// Create a copy of FareRuleCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FareRuleCreateRequestImplCopyWith<_$FareRuleCreateRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}

FareRuleUpdateRequest _$FareRuleUpdateRequestFromJson(
  Map<String, dynamic> json,
) {
  return _FareRuleUpdateRequest.fromJson(json);
}

/// @nodoc
mixin _$FareRuleUpdateRequest {
  double? get basePrice => throw _privateConstructorUsedError;
  Map<String, dynamic>? get discounts => throw _privateConstructorUsedError;
  DynamicPricingStatus? get dynamicPricing =>
      throw _privateConstructorUsedError;

  /// Serializes this FareRuleUpdateRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FareRuleUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FareRuleUpdateRequestCopyWith<FareRuleUpdateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FareRuleUpdateRequestCopyWith<$Res> {
  factory $FareRuleUpdateRequestCopyWith(
    FareRuleUpdateRequest value,
    $Res Function(FareRuleUpdateRequest) then,
  ) = _$FareRuleUpdateRequestCopyWithImpl<$Res, FareRuleUpdateRequest>;
  @useResult
  $Res call({
    double? basePrice,
    Map<String, dynamic>? discounts,
    DynamicPricingStatus? dynamicPricing,
  });
}

/// @nodoc
class _$FareRuleUpdateRequestCopyWithImpl<
  $Res,
  $Val extends FareRuleUpdateRequest
>
    implements $FareRuleUpdateRequestCopyWith<$Res> {
  _$FareRuleUpdateRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FareRuleUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? basePrice = freezed,
    Object? discounts = freezed,
    Object? dynamicPricing = freezed,
  }) {
    return _then(
      _value.copyWith(
            basePrice: freezed == basePrice
                ? _value.basePrice
                : basePrice // ignore: cast_nullable_to_non_nullable
                      as double?,
            discounts: freezed == discounts
                ? _value.discounts
                : discounts // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            dynamicPricing: freezed == dynamicPricing
                ? _value.dynamicPricing
                : dynamicPricing // ignore: cast_nullable_to_non_nullable
                      as DynamicPricingStatus?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FareRuleUpdateRequestImplCopyWith<$Res>
    implements $FareRuleUpdateRequestCopyWith<$Res> {
  factory _$$FareRuleUpdateRequestImplCopyWith(
    _$FareRuleUpdateRequestImpl value,
    $Res Function(_$FareRuleUpdateRequestImpl) then,
  ) = __$$FareRuleUpdateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    double? basePrice,
    Map<String, dynamic>? discounts,
    DynamicPricingStatus? dynamicPricing,
  });
}

/// @nodoc
class __$$FareRuleUpdateRequestImplCopyWithImpl<$Res>
    extends
        _$FareRuleUpdateRequestCopyWithImpl<$Res, _$FareRuleUpdateRequestImpl>
    implements _$$FareRuleUpdateRequestImplCopyWith<$Res> {
  __$$FareRuleUpdateRequestImplCopyWithImpl(
    _$FareRuleUpdateRequestImpl _value,
    $Res Function(_$FareRuleUpdateRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FareRuleUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? basePrice = freezed,
    Object? discounts = freezed,
    Object? dynamicPricing = freezed,
  }) {
    return _then(
      _$FareRuleUpdateRequestImpl(
        basePrice: freezed == basePrice
            ? _value.basePrice
            : basePrice // ignore: cast_nullable_to_non_nullable
                  as double?,
        discounts: freezed == discounts
            ? _value._discounts
            : discounts // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        dynamicPricing: freezed == dynamicPricing
            ? _value.dynamicPricing
            : dynamicPricing // ignore: cast_nullable_to_non_nullable
                  as DynamicPricingStatus?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FareRuleUpdateRequestImpl implements _FareRuleUpdateRequest {
  const _$FareRuleUpdateRequestImpl({
    this.basePrice,
    final Map<String, dynamic>? discounts,
    this.dynamicPricing,
  }) : _discounts = discounts;

  factory _$FareRuleUpdateRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$FareRuleUpdateRequestImplFromJson(json);

  @override
  final double? basePrice;
  final Map<String, dynamic>? _discounts;
  @override
  Map<String, dynamic>? get discounts {
    final value = _discounts;
    if (value == null) return null;
    if (_discounts is EqualUnmodifiableMapView) return _discounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final DynamicPricingStatus? dynamicPricing;

  @override
  String toString() {
    return 'FareRuleUpdateRequest(basePrice: $basePrice, discounts: $discounts, dynamicPricing: $dynamicPricing)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FareRuleUpdateRequestImpl &&
            (identical(other.basePrice, basePrice) ||
                other.basePrice == basePrice) &&
            const DeepCollectionEquality().equals(
              other._discounts,
              _discounts,
            ) &&
            (identical(other.dynamicPricing, dynamicPricing) ||
                other.dynamicPricing == dynamicPricing));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    basePrice,
    const DeepCollectionEquality().hash(_discounts),
    dynamicPricing,
  );

  /// Create a copy of FareRuleUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FareRuleUpdateRequestImplCopyWith<_$FareRuleUpdateRequestImpl>
  get copyWith =>
      __$$FareRuleUpdateRequestImplCopyWithImpl<_$FareRuleUpdateRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$FareRuleUpdateRequestImplToJson(this);
  }
}

abstract class _FareRuleUpdateRequest implements FareRuleUpdateRequest {
  const factory _FareRuleUpdateRequest({
    final double? basePrice,
    final Map<String, dynamic>? discounts,
    final DynamicPricingStatus? dynamicPricing,
  }) = _$FareRuleUpdateRequestImpl;

  factory _FareRuleUpdateRequest.fromJson(Map<String, dynamic> json) =
      _$FareRuleUpdateRequestImpl.fromJson;

  @override
  double? get basePrice;
  @override
  Map<String, dynamic>? get discounts;
  @override
  DynamicPricingStatus? get dynamicPricing;

  /// Create a copy of FareRuleUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FareRuleUpdateRequestImplCopyWith<_$FareRuleUpdateRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}
