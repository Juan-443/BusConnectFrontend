import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/notification_model/notification_model.dart';
import '../../core/constants/api_constants.dart';

part 'notification_api_provider.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class NotificationApiProvider {
  factory NotificationApiProvider(Dio dio, {String baseUrl}) = _NotificationApiProvider;

  // ==================== EMAIL NOTIFICATIONS ====================

  @POST(ApiConstants.notificationEmailSend)
  Future<NotificationResponse> sendEmail(@Body() EmailNotification notification);

  @POST(ApiConstants.notificationEmailWelcome)
  Future<NotificationResponse> sendWelcomeEmail(
      @Query('email') String email,
      @Query('username') String username,
      );

  @POST(ApiConstants.notificationEmailVerification)
  Future<NotificationResponse> sendVerificationEmail(
      @Query('email') String email,
      @Query('username') String username,
      @Query('code') String code,
      );

  @POST(ApiConstants.notificationEmailTicket)
  Future<NotificationResponse> sendTicketConfirmation(
      @Query('email') String email,
      @Query('username') String username,
      @Body() Map<String, dynamic> ticketData,
      );

  // ==================== SMS NOTIFICATIONS ====================

  @POST(ApiConstants.notificationSmsSend)
  Future<NotificationResponse> sendSms(@Body() SmsNotification notification);

  @POST(ApiConstants.notificationSmsVerification)
  Future<NotificationResponse> sendVerificationSms(
      @Query('phoneNumber') String phoneNumber,
      @Query('code') String code,
      );

  @POST(ApiConstants.notificationSmsTripReminder)
  Future<NotificationResponse> sendTripReminderSms(
      @Query('phoneNumber') String phoneNumber,
      @Query('tripInfo') String tripInfo,
      );

  // ==================== WHATSAPP NOTIFICATIONS ====================

  @POST(ApiConstants.notificationWhatsAppSend)
  Future<NotificationResponse> sendWhatsApp(@Body() WhatsAppNotification notification);

  @POST(ApiConstants.notificationWhatsAppVerification)
  Future<NotificationResponse> sendVerificationWhatsApp(
      @Query('phoneNumber') String phoneNumber,
      @Query('code') String code,
      );

  @POST(ApiConstants.notificationWhatsAppTicket)
  Future<NotificationResponse> sendWhatsAppTicket(
      @Query('phoneNumber') String phoneNumber,
      @Query('ticketQR') String ticketQR,
      @Query('tripInfo') String tripInfo,
      );

  @POST(ApiConstants.notificationWhatsAppPlatformChange)
  Future<NotificationResponse> sendPlatformChangeAlert(
      @Query('phoneNumber') String phoneNumber,
      @Query('oldPlatform') String oldPlatform,
      @Query('newPlatform') String newPlatform,
      );
}