// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationResponseImpl _$$NotificationResponseImplFromJson(
  Map<String, dynamic> json,
) => _$NotificationResponseImpl(
  success: json['success'] as bool,
  message: json['message'] as String,
  error: json['error'] as String?,
);

Map<String, dynamic> _$$NotificationResponseImplToJson(
  _$NotificationResponseImpl instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'error': instance.error,
};

_$EmailNotificationImpl _$$EmailNotificationImplFromJson(
  Map<String, dynamic> json,
) => _$EmailNotificationImpl(
  to: json['to'] as String,
  subject: json['subject'] as String,
  body: json['body'] as String,
  from: json['from'] as String?,
  cc: (json['cc'] as List<dynamic>?)?.map((e) => e as String).toList(),
  bcc: (json['bcc'] as List<dynamic>?)?.map((e) => e as String).toList(),
  attachments: json['attachments'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$$EmailNotificationImplToJson(
  _$EmailNotificationImpl instance,
) => <String, dynamic>{
  'to': instance.to,
  'subject': instance.subject,
  'body': instance.body,
  'from': instance.from,
  'cc': instance.cc,
  'bcc': instance.bcc,
  'attachments': instance.attachments,
};

_$SmsNotificationImpl _$$SmsNotificationImplFromJson(
  Map<String, dynamic> json,
) => _$SmsNotificationImpl(
  phoneNumber: json['phoneNumber'] as String,
  message: json['message'] as String,
  senderId: json['senderId'] as String?,
);

Map<String, dynamic> _$$SmsNotificationImplToJson(
  _$SmsNotificationImpl instance,
) => <String, dynamic>{
  'phoneNumber': instance.phoneNumber,
  'message': instance.message,
  'senderId': instance.senderId,
};

_$WhatsAppNotificationImpl _$$WhatsAppNotificationImplFromJson(
  Map<String, dynamic> json,
) => _$WhatsAppNotificationImpl(
  phoneNumber: json['phoneNumber'] as String,
  message: json['message'] as String,
  templateName: json['templateName'] as String?,
  templateParams: json['templateParams'] as Map<String, dynamic>?,
  mediaUrls: (json['mediaUrls'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$$WhatsAppNotificationImplToJson(
  _$WhatsAppNotificationImpl instance,
) => <String, dynamic>{
  'phoneNumber': instance.phoneNumber,
  'message': instance.message,
  'templateName': instance.templateName,
  'templateParams': instance.templateParams,
  'mediaUrls': instance.mediaUrls,
};
