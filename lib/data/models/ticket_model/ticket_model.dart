import 'package:bus_connect/core/constants/enums/cancellation_policy.dart';
import 'package:bus_connect/core/constants/enums/passenger_type.dart';
import 'package:bus_connect/core/constants/enums/payment_method.dart';
import 'package:bus_connect/core/constants/enums/ticket_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../stop_model/stop_model.dart';
import '../trip_model/trip_model.dart';

part 'ticket_model.freezed.dart';
part 'ticket_model.g.dart';

@freezed
class TicketModel with _$TicketModel {
  const factory TicketModel({
    required int id,
    required String seatNumber,
    required double price,
    required PaymentMethod paymentMethod,
    required TicketStatus status,
    required String qrCode,
    required String createdAt,
    PassengerType? passengerType,
    double? discountAmount,
    String? cancelledAt,
    double? refundAmount,
    CancellationPolicy? cancellationPolicy,
    required int fromStopId,
    required int toStopId,
    required int tripId,
    required int passengerId,
    StopModel? fromStop,
    StopModel? toStop,
    TripModel? trip,
  }) = _TicketModel;

  factory TicketModel.fromJson(Map<String, dynamic> json) =>
      _$TicketModelFromJson(json);
}

@freezed
class TicketCreateRequest with _$TicketCreateRequest {
  const factory TicketCreateRequest({
    required int tripId,
    required String seatNumber,
    required int fromStopId,
    required int toStopId,
    required int passengerId,
    required double price,
    required PaymentMethod paymentMethod,
    PassengerType? passengerType,
    double? discountAmount,
  }) = _TicketCreateRequest;

  factory TicketCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$TicketCreateRequestFromJson(json);
}

@freezed
class TicketUpdateRequest with _$TicketUpdateRequest {
  const factory TicketUpdateRequest({
    String? seatNumber,
    double? price,
    PaymentMethod? paymentMethod,
    TicketStatus? status,
  }) = _TicketUpdateRequest;

  factory TicketUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$TicketUpdateRequestFromJson(json);
}

typedef TicketResponse = TicketModel;