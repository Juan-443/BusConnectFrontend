import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../core/constants/enums/overbooking_status.dart';

part 'overbooking_model.freezed.dart';
part 'overbooking_model.g.dart';

@freezed
class OverbookingModel with _$OverbookingModel {
  const factory OverbookingModel({
    required int id,
    required int tripId,
    required String tripInfo,
    required int ticketId,
    required String passengerName,
    required String seatNumber,
    required OverbookingStatus status,
    required String reason,
    String? requestedByName,
    String? approvedByName,
    DateTime? requestedAt,
    DateTime? approvedAt,
    DateTime? expiresAt,
    required bool requiresApproval,
    required double currentOccupancyRate,
    required int minutesUntilDeparture,
  }) = _OverbookingModel;

  factory OverbookingModel.fromJson(Map<String, dynamic> json) =>
      _$OverbookingModelFromJson(json);
}

@freezed
class OverbookingCreateRequest with _$OverbookingCreateRequest {
  const factory OverbookingCreateRequest({
    required int tripId,
    required int ticketId,
    required String reason,
  }) = _OverbookingCreateRequest;

  factory OverbookingCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$OverbookingCreateRequestFromJson(json);
}

@freezed
class OverbookingApproveRequest with _$OverbookingApproveRequest {
  const factory OverbookingApproveRequest({
    String? notes,
  }) = _OverbookingApproveRequest;

  factory OverbookingApproveRequest.fromJson(Map<String, dynamic> json) =>
      _$OverbookingApproveRequestFromJson(json);
}

@freezed
class OverbookingRejectRequest with _$OverbookingRejectRequest {
  const factory OverbookingRejectRequest({
    required String reason,
  }) = _OverbookingRejectRequest;

  factory OverbookingRejectRequest.fromJson(Map<String, dynamic> json) =>
      _$OverbookingRejectRequestFromJson(json);
}

/// Alias opcional para mantener compatibilidad con tu frontend actual
typedef OverbookingResponse = OverbookingModel;
