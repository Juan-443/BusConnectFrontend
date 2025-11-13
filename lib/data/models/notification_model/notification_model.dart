// lib/data/models/notification_model/notification_model.dart

import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

// ==================== NOTIFICATION RESPONSE ====================

@freezed
class NotificationResponse with _$NotificationResponse {
  const factory NotificationResponse({
    required bool success,
    required String message,
    String? error,
  }) = _NotificationResponse;

  factory NotificationResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationResponseFromJson(json);
}

// ==================== EMAIL NOTIFICATION ====================

@freezed
class EmailNotification with _$EmailNotification {
  const factory EmailNotification({
    required String to,
    required String subject,
    required String body,
    String? from,
    List<String>? cc,
    List<String>? bcc,
    Map<String, dynamic>? attachments,
  }) = _EmailNotification;

  factory EmailNotification.fromJson(Map<String, dynamic> json) =>
      _$EmailNotificationFromJson(json);
}

// ==================== SMS NOTIFICATION ====================

@freezed
class SmsNotification with _$SmsNotification {
  const factory SmsNotification({
    required String phoneNumber,
    required String message,
    String? senderId,
  }) = _SmsNotification;

  factory SmsNotification.fromJson(Map<String, dynamic> json) =>
      _$SmsNotificationFromJson(json);
}

// ==================== WHATSAPP NOTIFICATION ====================

@freezed
class WhatsAppNotification with _$WhatsAppNotification {
  const factory WhatsAppNotification({
    required String phoneNumber,
    required String message,
    String? templateName,
    Map<String, dynamic>? templateParams,
    List<String>? mediaUrls,
  }) = _WhatsAppNotification;

  factory WhatsAppNotification.fromJson(Map<String, dynamic> json) =>
      _$WhatsAppNotificationFromJson(json);
}