// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

NotificationResponse _$NotificationResponseFromJson(Map<String, dynamic> json) {
  return _NotificationResponse.fromJson(json);
}

/// @nodoc
mixin _$NotificationResponse {
  bool get success => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Serializes this NotificationResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NotificationResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationResponseCopyWith<NotificationResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationResponseCopyWith<$Res> {
  factory $NotificationResponseCopyWith(
    NotificationResponse value,
    $Res Function(NotificationResponse) then,
  ) = _$NotificationResponseCopyWithImpl<$Res, NotificationResponse>;
  @useResult
  $Res call({bool success, String message, String? error});
}

/// @nodoc
class _$NotificationResponseCopyWithImpl<
  $Res,
  $Val extends NotificationResponse
>
    implements $NotificationResponseCopyWith<$Res> {
  _$NotificationResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? error = freezed,
  }) {
    return _then(
      _value.copyWith(
            success: null == success
                ? _value.success
                : success // ignore: cast_nullable_to_non_nullable
                      as bool,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NotificationResponseImplCopyWith<$Res>
    implements $NotificationResponseCopyWith<$Res> {
  factory _$$NotificationResponseImplCopyWith(
    _$NotificationResponseImpl value,
    $Res Function(_$NotificationResponseImpl) then,
  ) = __$$NotificationResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool success, String message, String? error});
}

/// @nodoc
class __$$NotificationResponseImplCopyWithImpl<$Res>
    extends _$NotificationResponseCopyWithImpl<$Res, _$NotificationResponseImpl>
    implements _$$NotificationResponseImplCopyWith<$Res> {
  __$$NotificationResponseImplCopyWithImpl(
    _$NotificationResponseImpl _value,
    $Res Function(_$NotificationResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NotificationResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? error = freezed,
  }) {
    return _then(
      _$NotificationResponseImpl(
        success: null == success
            ? _value.success
            : success // ignore: cast_nullable_to_non_nullable
                  as bool,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationResponseImpl implements _NotificationResponse {
  const _$NotificationResponseImpl({
    required this.success,
    required this.message,
    this.error,
  });

  factory _$NotificationResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationResponseImplFromJson(json);

  @override
  final bool success;
  @override
  final String message;
  @override
  final String? error;

  @override
  String toString() {
    return 'NotificationResponse(success: $success, message: $message, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, message, error);

  /// Create a copy of NotificationResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationResponseImplCopyWith<_$NotificationResponseImpl>
  get copyWith =>
      __$$NotificationResponseImplCopyWithImpl<_$NotificationResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationResponseImplToJson(this);
  }
}

abstract class _NotificationResponse implements NotificationResponse {
  const factory _NotificationResponse({
    required final bool success,
    required final String message,
    final String? error,
  }) = _$NotificationResponseImpl;

  factory _NotificationResponse.fromJson(Map<String, dynamic> json) =
      _$NotificationResponseImpl.fromJson;

  @override
  bool get success;
  @override
  String get message;
  @override
  String? get error;

  /// Create a copy of NotificationResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationResponseImplCopyWith<_$NotificationResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

EmailNotification _$EmailNotificationFromJson(Map<String, dynamic> json) {
  return _EmailNotification.fromJson(json);
}

/// @nodoc
mixin _$EmailNotification {
  String get to => throw _privateConstructorUsedError;
  String get subject => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;
  String? get from => throw _privateConstructorUsedError;
  List<String>? get cc => throw _privateConstructorUsedError;
  List<String>? get bcc => throw _privateConstructorUsedError;
  Map<String, dynamic>? get attachments => throw _privateConstructorUsedError;

  /// Serializes this EmailNotification to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EmailNotification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EmailNotificationCopyWith<EmailNotification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmailNotificationCopyWith<$Res> {
  factory $EmailNotificationCopyWith(
    EmailNotification value,
    $Res Function(EmailNotification) then,
  ) = _$EmailNotificationCopyWithImpl<$Res, EmailNotification>;
  @useResult
  $Res call({
    String to,
    String subject,
    String body,
    String? from,
    List<String>? cc,
    List<String>? bcc,
    Map<String, dynamic>? attachments,
  });
}

/// @nodoc
class _$EmailNotificationCopyWithImpl<$Res, $Val extends EmailNotification>
    implements $EmailNotificationCopyWith<$Res> {
  _$EmailNotificationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EmailNotification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? to = null,
    Object? subject = null,
    Object? body = null,
    Object? from = freezed,
    Object? cc = freezed,
    Object? bcc = freezed,
    Object? attachments = freezed,
  }) {
    return _then(
      _value.copyWith(
            to: null == to
                ? _value.to
                : to // ignore: cast_nullable_to_non_nullable
                      as String,
            subject: null == subject
                ? _value.subject
                : subject // ignore: cast_nullable_to_non_nullable
                      as String,
            body: null == body
                ? _value.body
                : body // ignore: cast_nullable_to_non_nullable
                      as String,
            from: freezed == from
                ? _value.from
                : from // ignore: cast_nullable_to_non_nullable
                      as String?,
            cc: freezed == cc
                ? _value.cc
                : cc // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            bcc: freezed == bcc
                ? _value.bcc
                : bcc // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            attachments: freezed == attachments
                ? _value.attachments
                : attachments // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EmailNotificationImplCopyWith<$Res>
    implements $EmailNotificationCopyWith<$Res> {
  factory _$$EmailNotificationImplCopyWith(
    _$EmailNotificationImpl value,
    $Res Function(_$EmailNotificationImpl) then,
  ) = __$$EmailNotificationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String to,
    String subject,
    String body,
    String? from,
    List<String>? cc,
    List<String>? bcc,
    Map<String, dynamic>? attachments,
  });
}

/// @nodoc
class __$$EmailNotificationImplCopyWithImpl<$Res>
    extends _$EmailNotificationCopyWithImpl<$Res, _$EmailNotificationImpl>
    implements _$$EmailNotificationImplCopyWith<$Res> {
  __$$EmailNotificationImplCopyWithImpl(
    _$EmailNotificationImpl _value,
    $Res Function(_$EmailNotificationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EmailNotification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? to = null,
    Object? subject = null,
    Object? body = null,
    Object? from = freezed,
    Object? cc = freezed,
    Object? bcc = freezed,
    Object? attachments = freezed,
  }) {
    return _then(
      _$EmailNotificationImpl(
        to: null == to
            ? _value.to
            : to // ignore: cast_nullable_to_non_nullable
                  as String,
        subject: null == subject
            ? _value.subject
            : subject // ignore: cast_nullable_to_non_nullable
                  as String,
        body: null == body
            ? _value.body
            : body // ignore: cast_nullable_to_non_nullable
                  as String,
        from: freezed == from
            ? _value.from
            : from // ignore: cast_nullable_to_non_nullable
                  as String?,
        cc: freezed == cc
            ? _value._cc
            : cc // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        bcc: freezed == bcc
            ? _value._bcc
            : bcc // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        attachments: freezed == attachments
            ? _value._attachments
            : attachments // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$EmailNotificationImpl implements _EmailNotification {
  const _$EmailNotificationImpl({
    required this.to,
    required this.subject,
    required this.body,
    this.from,
    final List<String>? cc,
    final List<String>? bcc,
    final Map<String, dynamic>? attachments,
  }) : _cc = cc,
       _bcc = bcc,
       _attachments = attachments;

  factory _$EmailNotificationImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmailNotificationImplFromJson(json);

  @override
  final String to;
  @override
  final String subject;
  @override
  final String body;
  @override
  final String? from;
  final List<String>? _cc;
  @override
  List<String>? get cc {
    final value = _cc;
    if (value == null) return null;
    if (_cc is EqualUnmodifiableListView) return _cc;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _bcc;
  @override
  List<String>? get bcc {
    final value = _bcc;
    if (value == null) return null;
    if (_bcc is EqualUnmodifiableListView) return _bcc;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final Map<String, dynamic>? _attachments;
  @override
  Map<String, dynamic>? get attachments {
    final value = _attachments;
    if (value == null) return null;
    if (_attachments is EqualUnmodifiableMapView) return _attachments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'EmailNotification(to: $to, subject: $subject, body: $body, from: $from, cc: $cc, bcc: $bcc, attachments: $attachments)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmailNotificationImpl &&
            (identical(other.to, to) || other.to == to) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.from, from) || other.from == from) &&
            const DeepCollectionEquality().equals(other._cc, _cc) &&
            const DeepCollectionEquality().equals(other._bcc, _bcc) &&
            const DeepCollectionEquality().equals(
              other._attachments,
              _attachments,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    to,
    subject,
    body,
    from,
    const DeepCollectionEquality().hash(_cc),
    const DeepCollectionEquality().hash(_bcc),
    const DeepCollectionEquality().hash(_attachments),
  );

  /// Create a copy of EmailNotification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmailNotificationImplCopyWith<_$EmailNotificationImpl> get copyWith =>
      __$$EmailNotificationImplCopyWithImpl<_$EmailNotificationImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$EmailNotificationImplToJson(this);
  }
}

abstract class _EmailNotification implements EmailNotification {
  const factory _EmailNotification({
    required final String to,
    required final String subject,
    required final String body,
    final String? from,
    final List<String>? cc,
    final List<String>? bcc,
    final Map<String, dynamic>? attachments,
  }) = _$EmailNotificationImpl;

  factory _EmailNotification.fromJson(Map<String, dynamic> json) =
      _$EmailNotificationImpl.fromJson;

  @override
  String get to;
  @override
  String get subject;
  @override
  String get body;
  @override
  String? get from;
  @override
  List<String>? get cc;
  @override
  List<String>? get bcc;
  @override
  Map<String, dynamic>? get attachments;

  /// Create a copy of EmailNotification
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmailNotificationImplCopyWith<_$EmailNotificationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SmsNotification _$SmsNotificationFromJson(Map<String, dynamic> json) {
  return _SmsNotification.fromJson(json);
}

/// @nodoc
mixin _$SmsNotification {
  String get phoneNumber => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String? get senderId => throw _privateConstructorUsedError;

  /// Serializes this SmsNotification to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SmsNotification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SmsNotificationCopyWith<SmsNotification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SmsNotificationCopyWith<$Res> {
  factory $SmsNotificationCopyWith(
    SmsNotification value,
    $Res Function(SmsNotification) then,
  ) = _$SmsNotificationCopyWithImpl<$Res, SmsNotification>;
  @useResult
  $Res call({String phoneNumber, String message, String? senderId});
}

/// @nodoc
class _$SmsNotificationCopyWithImpl<$Res, $Val extends SmsNotification>
    implements $SmsNotificationCopyWith<$Res> {
  _$SmsNotificationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SmsNotification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phoneNumber = null,
    Object? message = null,
    Object? senderId = freezed,
  }) {
    return _then(
      _value.copyWith(
            phoneNumber: null == phoneNumber
                ? _value.phoneNumber
                : phoneNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            senderId: freezed == senderId
                ? _value.senderId
                : senderId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SmsNotificationImplCopyWith<$Res>
    implements $SmsNotificationCopyWith<$Res> {
  factory _$$SmsNotificationImplCopyWith(
    _$SmsNotificationImpl value,
    $Res Function(_$SmsNotificationImpl) then,
  ) = __$$SmsNotificationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String phoneNumber, String message, String? senderId});
}

/// @nodoc
class __$$SmsNotificationImplCopyWithImpl<$Res>
    extends _$SmsNotificationCopyWithImpl<$Res, _$SmsNotificationImpl>
    implements _$$SmsNotificationImplCopyWith<$Res> {
  __$$SmsNotificationImplCopyWithImpl(
    _$SmsNotificationImpl _value,
    $Res Function(_$SmsNotificationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SmsNotification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phoneNumber = null,
    Object? message = null,
    Object? senderId = freezed,
  }) {
    return _then(
      _$SmsNotificationImpl(
        phoneNumber: null == phoneNumber
            ? _value.phoneNumber
            : phoneNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        senderId: freezed == senderId
            ? _value.senderId
            : senderId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SmsNotificationImpl implements _SmsNotification {
  const _$SmsNotificationImpl({
    required this.phoneNumber,
    required this.message,
    this.senderId,
  });

  factory _$SmsNotificationImpl.fromJson(Map<String, dynamic> json) =>
      _$$SmsNotificationImplFromJson(json);

  @override
  final String phoneNumber;
  @override
  final String message;
  @override
  final String? senderId;

  @override
  String toString() {
    return 'SmsNotification(phoneNumber: $phoneNumber, message: $message, senderId: $senderId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SmsNotificationImpl &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, phoneNumber, message, senderId);

  /// Create a copy of SmsNotification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SmsNotificationImplCopyWith<_$SmsNotificationImpl> get copyWith =>
      __$$SmsNotificationImplCopyWithImpl<_$SmsNotificationImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SmsNotificationImplToJson(this);
  }
}

abstract class _SmsNotification implements SmsNotification {
  const factory _SmsNotification({
    required final String phoneNumber,
    required final String message,
    final String? senderId,
  }) = _$SmsNotificationImpl;

  factory _SmsNotification.fromJson(Map<String, dynamic> json) =
      _$SmsNotificationImpl.fromJson;

  @override
  String get phoneNumber;
  @override
  String get message;
  @override
  String? get senderId;

  /// Create a copy of SmsNotification
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SmsNotificationImplCopyWith<_$SmsNotificationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WhatsAppNotification _$WhatsAppNotificationFromJson(Map<String, dynamic> json) {
  return _WhatsAppNotification.fromJson(json);
}

/// @nodoc
mixin _$WhatsAppNotification {
  String get phoneNumber => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String? get templateName => throw _privateConstructorUsedError;
  Map<String, dynamic>? get templateParams =>
      throw _privateConstructorUsedError;
  List<String>? get mediaUrls => throw _privateConstructorUsedError;

  /// Serializes this WhatsAppNotification to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WhatsAppNotification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WhatsAppNotificationCopyWith<WhatsAppNotification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WhatsAppNotificationCopyWith<$Res> {
  factory $WhatsAppNotificationCopyWith(
    WhatsAppNotification value,
    $Res Function(WhatsAppNotification) then,
  ) = _$WhatsAppNotificationCopyWithImpl<$Res, WhatsAppNotification>;
  @useResult
  $Res call({
    String phoneNumber,
    String message,
    String? templateName,
    Map<String, dynamic>? templateParams,
    List<String>? mediaUrls,
  });
}

/// @nodoc
class _$WhatsAppNotificationCopyWithImpl<
  $Res,
  $Val extends WhatsAppNotification
>
    implements $WhatsAppNotificationCopyWith<$Res> {
  _$WhatsAppNotificationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WhatsAppNotification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phoneNumber = null,
    Object? message = null,
    Object? templateName = freezed,
    Object? templateParams = freezed,
    Object? mediaUrls = freezed,
  }) {
    return _then(
      _value.copyWith(
            phoneNumber: null == phoneNumber
                ? _value.phoneNumber
                : phoneNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            templateName: freezed == templateName
                ? _value.templateName
                : templateName // ignore: cast_nullable_to_non_nullable
                      as String?,
            templateParams: freezed == templateParams
                ? _value.templateParams
                : templateParams // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            mediaUrls: freezed == mediaUrls
                ? _value.mediaUrls
                : mediaUrls // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WhatsAppNotificationImplCopyWith<$Res>
    implements $WhatsAppNotificationCopyWith<$Res> {
  factory _$$WhatsAppNotificationImplCopyWith(
    _$WhatsAppNotificationImpl value,
    $Res Function(_$WhatsAppNotificationImpl) then,
  ) = __$$WhatsAppNotificationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String phoneNumber,
    String message,
    String? templateName,
    Map<String, dynamic>? templateParams,
    List<String>? mediaUrls,
  });
}

/// @nodoc
class __$$WhatsAppNotificationImplCopyWithImpl<$Res>
    extends _$WhatsAppNotificationCopyWithImpl<$Res, _$WhatsAppNotificationImpl>
    implements _$$WhatsAppNotificationImplCopyWith<$Res> {
  __$$WhatsAppNotificationImplCopyWithImpl(
    _$WhatsAppNotificationImpl _value,
    $Res Function(_$WhatsAppNotificationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WhatsAppNotification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phoneNumber = null,
    Object? message = null,
    Object? templateName = freezed,
    Object? templateParams = freezed,
    Object? mediaUrls = freezed,
  }) {
    return _then(
      _$WhatsAppNotificationImpl(
        phoneNumber: null == phoneNumber
            ? _value.phoneNumber
            : phoneNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        templateName: freezed == templateName
            ? _value.templateName
            : templateName // ignore: cast_nullable_to_non_nullable
                  as String?,
        templateParams: freezed == templateParams
            ? _value._templateParams
            : templateParams // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        mediaUrls: freezed == mediaUrls
            ? _value._mediaUrls
            : mediaUrls // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WhatsAppNotificationImpl implements _WhatsAppNotification {
  const _$WhatsAppNotificationImpl({
    required this.phoneNumber,
    required this.message,
    this.templateName,
    final Map<String, dynamic>? templateParams,
    final List<String>? mediaUrls,
  }) : _templateParams = templateParams,
       _mediaUrls = mediaUrls;

  factory _$WhatsAppNotificationImpl.fromJson(Map<String, dynamic> json) =>
      _$$WhatsAppNotificationImplFromJson(json);

  @override
  final String phoneNumber;
  @override
  final String message;
  @override
  final String? templateName;
  final Map<String, dynamic>? _templateParams;
  @override
  Map<String, dynamic>? get templateParams {
    final value = _templateParams;
    if (value == null) return null;
    if (_templateParams is EqualUnmodifiableMapView) return _templateParams;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final List<String>? _mediaUrls;
  @override
  List<String>? get mediaUrls {
    final value = _mediaUrls;
    if (value == null) return null;
    if (_mediaUrls is EqualUnmodifiableListView) return _mediaUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'WhatsAppNotification(phoneNumber: $phoneNumber, message: $message, templateName: $templateName, templateParams: $templateParams, mediaUrls: $mediaUrls)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WhatsAppNotificationImpl &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.templateName, templateName) ||
                other.templateName == templateName) &&
            const DeepCollectionEquality().equals(
              other._templateParams,
              _templateParams,
            ) &&
            const DeepCollectionEquality().equals(
              other._mediaUrls,
              _mediaUrls,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    phoneNumber,
    message,
    templateName,
    const DeepCollectionEquality().hash(_templateParams),
    const DeepCollectionEquality().hash(_mediaUrls),
  );

  /// Create a copy of WhatsAppNotification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WhatsAppNotificationImplCopyWith<_$WhatsAppNotificationImpl>
  get copyWith =>
      __$$WhatsAppNotificationImplCopyWithImpl<_$WhatsAppNotificationImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$WhatsAppNotificationImplToJson(this);
  }
}

abstract class _WhatsAppNotification implements WhatsAppNotification {
  const factory _WhatsAppNotification({
    required final String phoneNumber,
    required final String message,
    final String? templateName,
    final Map<String, dynamic>? templateParams,
    final List<String>? mediaUrls,
  }) = _$WhatsAppNotificationImpl;

  factory _WhatsAppNotification.fromJson(Map<String, dynamic> json) =
      _$WhatsAppNotificationImpl.fromJson;

  @override
  String get phoneNumber;
  @override
  String get message;
  @override
  String? get templateName;
  @override
  Map<String, dynamic>? get templateParams;
  @override
  List<String>? get mediaUrls;

  /// Create a copy of WhatsAppNotification
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WhatsAppNotificationImplCopyWith<_$WhatsAppNotificationImpl>
  get copyWith => throw _privateConstructorUsedError;
}
