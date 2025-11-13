// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'incident_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

IncidentModel _$IncidentModelFromJson(Map<String, dynamic> json) {
  return _IncidentModel.fromJson(json);
}

/// @nodoc
mixin _$IncidentModel {
  int get id => throw _privateConstructorUsedError;
  EntityType get entityType => throw _privateConstructorUsedError;
  int get entityId => throw _privateConstructorUsedError;
  IncidentType get type => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;
  int? get reportedBy => throw _privateConstructorUsedError;
  String? get reportedByName => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _dateFromJson, toJson: _dateToJson)
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this IncidentModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of IncidentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IncidentModelCopyWith<IncidentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IncidentModelCopyWith<$Res> {
  factory $IncidentModelCopyWith(
    IncidentModel value,
    $Res Function(IncidentModel) then,
  ) = _$IncidentModelCopyWithImpl<$Res, IncidentModel>;
  @useResult
  $Res call({
    int id,
    EntityType entityType,
    int entityId,
    IncidentType type,
    String? note,
    int? reportedBy,
    String? reportedByName,
    @JsonKey(fromJson: _dateFromJson, toJson: _dateToJson) DateTime createdAt,
  });
}

/// @nodoc
class _$IncidentModelCopyWithImpl<$Res, $Val extends IncidentModel>
    implements $IncidentModelCopyWith<$Res> {
  _$IncidentModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IncidentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? entityType = null,
    Object? entityId = null,
    Object? type = null,
    Object? note = freezed,
    Object? reportedBy = freezed,
    Object? reportedByName = freezed,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            entityType: null == entityType
                ? _value.entityType
                : entityType // ignore: cast_nullable_to_non_nullable
                      as EntityType,
            entityId: null == entityId
                ? _value.entityId
                : entityId // ignore: cast_nullable_to_non_nullable
                      as int,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as IncidentType,
            note: freezed == note
                ? _value.note
                : note // ignore: cast_nullable_to_non_nullable
                      as String?,
            reportedBy: freezed == reportedBy
                ? _value.reportedBy
                : reportedBy // ignore: cast_nullable_to_non_nullable
                      as int?,
            reportedByName: freezed == reportedByName
                ? _value.reportedByName
                : reportedByName // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$IncidentModelImplCopyWith<$Res>
    implements $IncidentModelCopyWith<$Res> {
  factory _$$IncidentModelImplCopyWith(
    _$IncidentModelImpl value,
    $Res Function(_$IncidentModelImpl) then,
  ) = __$$IncidentModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    EntityType entityType,
    int entityId,
    IncidentType type,
    String? note,
    int? reportedBy,
    String? reportedByName,
    @JsonKey(fromJson: _dateFromJson, toJson: _dateToJson) DateTime createdAt,
  });
}

/// @nodoc
class __$$IncidentModelImplCopyWithImpl<$Res>
    extends _$IncidentModelCopyWithImpl<$Res, _$IncidentModelImpl>
    implements _$$IncidentModelImplCopyWith<$Res> {
  __$$IncidentModelImplCopyWithImpl(
    _$IncidentModelImpl _value,
    $Res Function(_$IncidentModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of IncidentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? entityType = null,
    Object? entityId = null,
    Object? type = null,
    Object? note = freezed,
    Object? reportedBy = freezed,
    Object? reportedByName = freezed,
    Object? createdAt = null,
  }) {
    return _then(
      _$IncidentModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        entityType: null == entityType
            ? _value.entityType
            : entityType // ignore: cast_nullable_to_non_nullable
                  as EntityType,
        entityId: null == entityId
            ? _value.entityId
            : entityId // ignore: cast_nullable_to_non_nullable
                  as int,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as IncidentType,
        note: freezed == note
            ? _value.note
            : note // ignore: cast_nullable_to_non_nullable
                  as String?,
        reportedBy: freezed == reportedBy
            ? _value.reportedBy
            : reportedBy // ignore: cast_nullable_to_non_nullable
                  as int?,
        reportedByName: freezed == reportedByName
            ? _value.reportedByName
            : reportedByName // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$IncidentModelImpl implements _IncidentModel {
  const _$IncidentModelImpl({
    required this.id,
    required this.entityType,
    required this.entityId,
    required this.type,
    this.note,
    this.reportedBy,
    this.reportedByName,
    @JsonKey(fromJson: _dateFromJson, toJson: _dateToJson)
    required this.createdAt,
  });

  factory _$IncidentModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$IncidentModelImplFromJson(json);

  @override
  final int id;
  @override
  final EntityType entityType;
  @override
  final int entityId;
  @override
  final IncidentType type;
  @override
  final String? note;
  @override
  final int? reportedBy;
  @override
  final String? reportedByName;
  @override
  @JsonKey(fromJson: _dateFromJson, toJson: _dateToJson)
  final DateTime createdAt;

  @override
  String toString() {
    return 'IncidentModel(id: $id, entityType: $entityType, entityId: $entityId, type: $type, note: $note, reportedBy: $reportedBy, reportedByName: $reportedByName, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IncidentModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.entityType, entityType) ||
                other.entityType == entityType) &&
            (identical(other.entityId, entityId) ||
                other.entityId == entityId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.reportedBy, reportedBy) ||
                other.reportedBy == reportedBy) &&
            (identical(other.reportedByName, reportedByName) ||
                other.reportedByName == reportedByName) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    entityType,
    entityId,
    type,
    note,
    reportedBy,
    reportedByName,
    createdAt,
  );

  /// Create a copy of IncidentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IncidentModelImplCopyWith<_$IncidentModelImpl> get copyWith =>
      __$$IncidentModelImplCopyWithImpl<_$IncidentModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IncidentModelImplToJson(this);
  }
}

abstract class _IncidentModel implements IncidentModel {
  const factory _IncidentModel({
    required final int id,
    required final EntityType entityType,
    required final int entityId,
    required final IncidentType type,
    final String? note,
    final int? reportedBy,
    final String? reportedByName,
    @JsonKey(fromJson: _dateFromJson, toJson: _dateToJson)
    required final DateTime createdAt,
  }) = _$IncidentModelImpl;

  factory _IncidentModel.fromJson(Map<String, dynamic> json) =
      _$IncidentModelImpl.fromJson;

  @override
  int get id;
  @override
  EntityType get entityType;
  @override
  int get entityId;
  @override
  IncidentType get type;
  @override
  String? get note;
  @override
  int? get reportedBy;
  @override
  String? get reportedByName;
  @override
  @JsonKey(fromJson: _dateFromJson, toJson: _dateToJson)
  DateTime get createdAt;

  /// Create a copy of IncidentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IncidentModelImplCopyWith<_$IncidentModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

IncidentCreateRequest _$IncidentCreateRequestFromJson(
  Map<String, dynamic> json,
) {
  return _IncidentCreateRequest.fromJson(json);
}

/// @nodoc
mixin _$IncidentCreateRequest {
  EntityType get entityType => throw _privateConstructorUsedError;
  int get entityId => throw _privateConstructorUsedError;
  IncidentType get type => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;
  int get reportedBy => throw _privateConstructorUsedError;

  /// Serializes this IncidentCreateRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of IncidentCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IncidentCreateRequestCopyWith<IncidentCreateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IncidentCreateRequestCopyWith<$Res> {
  factory $IncidentCreateRequestCopyWith(
    IncidentCreateRequest value,
    $Res Function(IncidentCreateRequest) then,
  ) = _$IncidentCreateRequestCopyWithImpl<$Res, IncidentCreateRequest>;
  @useResult
  $Res call({
    EntityType entityType,
    int entityId,
    IncidentType type,
    String? note,
    int reportedBy,
  });
}

/// @nodoc
class _$IncidentCreateRequestCopyWithImpl<
  $Res,
  $Val extends IncidentCreateRequest
>
    implements $IncidentCreateRequestCopyWith<$Res> {
  _$IncidentCreateRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IncidentCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? entityType = null,
    Object? entityId = null,
    Object? type = null,
    Object? note = freezed,
    Object? reportedBy = null,
  }) {
    return _then(
      _value.copyWith(
            entityType: null == entityType
                ? _value.entityType
                : entityType // ignore: cast_nullable_to_non_nullable
                      as EntityType,
            entityId: null == entityId
                ? _value.entityId
                : entityId // ignore: cast_nullable_to_non_nullable
                      as int,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as IncidentType,
            note: freezed == note
                ? _value.note
                : note // ignore: cast_nullable_to_non_nullable
                      as String?,
            reportedBy: null == reportedBy
                ? _value.reportedBy
                : reportedBy // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$IncidentCreateRequestImplCopyWith<$Res>
    implements $IncidentCreateRequestCopyWith<$Res> {
  factory _$$IncidentCreateRequestImplCopyWith(
    _$IncidentCreateRequestImpl value,
    $Res Function(_$IncidentCreateRequestImpl) then,
  ) = __$$IncidentCreateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    EntityType entityType,
    int entityId,
    IncidentType type,
    String? note,
    int reportedBy,
  });
}

/// @nodoc
class __$$IncidentCreateRequestImplCopyWithImpl<$Res>
    extends
        _$IncidentCreateRequestCopyWithImpl<$Res, _$IncidentCreateRequestImpl>
    implements _$$IncidentCreateRequestImplCopyWith<$Res> {
  __$$IncidentCreateRequestImplCopyWithImpl(
    _$IncidentCreateRequestImpl _value,
    $Res Function(_$IncidentCreateRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of IncidentCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? entityType = null,
    Object? entityId = null,
    Object? type = null,
    Object? note = freezed,
    Object? reportedBy = null,
  }) {
    return _then(
      _$IncidentCreateRequestImpl(
        entityType: null == entityType
            ? _value.entityType
            : entityType // ignore: cast_nullable_to_non_nullable
                  as EntityType,
        entityId: null == entityId
            ? _value.entityId
            : entityId // ignore: cast_nullable_to_non_nullable
                  as int,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as IncidentType,
        note: freezed == note
            ? _value.note
            : note // ignore: cast_nullable_to_non_nullable
                  as String?,
        reportedBy: null == reportedBy
            ? _value.reportedBy
            : reportedBy // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$IncidentCreateRequestImpl implements _IncidentCreateRequest {
  const _$IncidentCreateRequestImpl({
    required this.entityType,
    required this.entityId,
    required this.type,
    this.note,
    required this.reportedBy,
  });

  factory _$IncidentCreateRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$IncidentCreateRequestImplFromJson(json);

  @override
  final EntityType entityType;
  @override
  final int entityId;
  @override
  final IncidentType type;
  @override
  final String? note;
  @override
  final int reportedBy;

  @override
  String toString() {
    return 'IncidentCreateRequest(entityType: $entityType, entityId: $entityId, type: $type, note: $note, reportedBy: $reportedBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IncidentCreateRequestImpl &&
            (identical(other.entityType, entityType) ||
                other.entityType == entityType) &&
            (identical(other.entityId, entityId) ||
                other.entityId == entityId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.reportedBy, reportedBy) ||
                other.reportedBy == reportedBy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, entityType, entityId, type, note, reportedBy);

  /// Create a copy of IncidentCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IncidentCreateRequestImplCopyWith<_$IncidentCreateRequestImpl>
  get copyWith =>
      __$$IncidentCreateRequestImplCopyWithImpl<_$IncidentCreateRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$IncidentCreateRequestImplToJson(this);
  }
}

abstract class _IncidentCreateRequest implements IncidentCreateRequest {
  const factory _IncidentCreateRequest({
    required final EntityType entityType,
    required final int entityId,
    required final IncidentType type,
    final String? note,
    required final int reportedBy,
  }) = _$IncidentCreateRequestImpl;

  factory _IncidentCreateRequest.fromJson(Map<String, dynamic> json) =
      _$IncidentCreateRequestImpl.fromJson;

  @override
  EntityType get entityType;
  @override
  int get entityId;
  @override
  IncidentType get type;
  @override
  String? get note;
  @override
  int get reportedBy;

  /// Create a copy of IncidentCreateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IncidentCreateRequestImplCopyWith<_$IncidentCreateRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}

IncidentUpdateRequest _$IncidentUpdateRequestFromJson(
  Map<String, dynamic> json,
) {
  return _IncidentUpdateRequest.fromJson(json);
}

/// @nodoc
mixin _$IncidentUpdateRequest {
  IncidentType? get type => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;

  /// Serializes this IncidentUpdateRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of IncidentUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IncidentUpdateRequestCopyWith<IncidentUpdateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IncidentUpdateRequestCopyWith<$Res> {
  factory $IncidentUpdateRequestCopyWith(
    IncidentUpdateRequest value,
    $Res Function(IncidentUpdateRequest) then,
  ) = _$IncidentUpdateRequestCopyWithImpl<$Res, IncidentUpdateRequest>;
  @useResult
  $Res call({IncidentType? type, String? note});
}

/// @nodoc
class _$IncidentUpdateRequestCopyWithImpl<
  $Res,
  $Val extends IncidentUpdateRequest
>
    implements $IncidentUpdateRequestCopyWith<$Res> {
  _$IncidentUpdateRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IncidentUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? type = freezed, Object? note = freezed}) {
    return _then(
      _value.copyWith(
            type: freezed == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as IncidentType?,
            note: freezed == note
                ? _value.note
                : note // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$IncidentUpdateRequestImplCopyWith<$Res>
    implements $IncidentUpdateRequestCopyWith<$Res> {
  factory _$$IncidentUpdateRequestImplCopyWith(
    _$IncidentUpdateRequestImpl value,
    $Res Function(_$IncidentUpdateRequestImpl) then,
  ) = __$$IncidentUpdateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({IncidentType? type, String? note});
}

/// @nodoc
class __$$IncidentUpdateRequestImplCopyWithImpl<$Res>
    extends
        _$IncidentUpdateRequestCopyWithImpl<$Res, _$IncidentUpdateRequestImpl>
    implements _$$IncidentUpdateRequestImplCopyWith<$Res> {
  __$$IncidentUpdateRequestImplCopyWithImpl(
    _$IncidentUpdateRequestImpl _value,
    $Res Function(_$IncidentUpdateRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of IncidentUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? type = freezed, Object? note = freezed}) {
    return _then(
      _$IncidentUpdateRequestImpl(
        type: freezed == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as IncidentType?,
        note: freezed == note
            ? _value.note
            : note // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$IncidentUpdateRequestImpl implements _IncidentUpdateRequest {
  const _$IncidentUpdateRequestImpl({this.type, this.note});

  factory _$IncidentUpdateRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$IncidentUpdateRequestImplFromJson(json);

  @override
  final IncidentType? type;
  @override
  final String? note;

  @override
  String toString() {
    return 'IncidentUpdateRequest(type: $type, note: $note)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IncidentUpdateRequestImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.note, note) || other.note == note));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type, note);

  /// Create a copy of IncidentUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IncidentUpdateRequestImplCopyWith<_$IncidentUpdateRequestImpl>
  get copyWith =>
      __$$IncidentUpdateRequestImplCopyWithImpl<_$IncidentUpdateRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$IncidentUpdateRequestImplToJson(this);
  }
}

abstract class _IncidentUpdateRequest implements IncidentUpdateRequest {
  const factory _IncidentUpdateRequest({
    final IncidentType? type,
    final String? note,
  }) = _$IncidentUpdateRequestImpl;

  factory _IncidentUpdateRequest.fromJson(Map<String, dynamic> json) =
      _$IncidentUpdateRequestImpl.fromJson;

  @override
  IncidentType? get type;
  @override
  String? get note;

  /// Create a copy of IncidentUpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IncidentUpdateRequestImplCopyWith<_$IncidentUpdateRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}
