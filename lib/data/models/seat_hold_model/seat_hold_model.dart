
import 'package:bus_connect/core/constants/enums/hold_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'seat_hold_model.freezed.dart';
part 'seat_hold_model.g.dart';

@freezed
class SeatHoldModel with _$SeatHoldModel {
  const factory SeatHoldModel({
    required int id,
    required String expiresAt,
    required String seatNumber,
    required HoldStatus status,
    required String createdAt,
    required int tripId,
    required int userId,
  }) = _SeatHoldModel;

  factory SeatHoldModel.fromJson(Map<String, dynamic> json) =>
      _$SeatHoldModelFromJson(json);
}

@freezed
class SeatHoldCreateRequest with _$SeatHoldCreateRequest {
  const factory SeatHoldCreateRequest({
    required int tripId,
    required String seatNumber,
  }) = _SeatHoldCreateRequest;

  factory SeatHoldCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$SeatHoldCreateRequestFromJson(json);
}

@freezed
class SeatHoldUpdateRequest with _$SeatHoldUpdateRequest {
  const factory SeatHoldUpdateRequest({
    String? expiresAt,
    HoldStatus? status,
  }) = _SeatHoldUpdateRequest;

  factory SeatHoldUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$SeatHoldUpdateRequestFromJson(json);
}

typedef SeatHoldResponse = SeatHoldModel;