import 'package:bus_connect/core/constants/enums/hold_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'seat_hold_model.freezed.dart';
part 'seat_hold_model.g.dart';

@freezed
class SeatHoldModel with _$SeatHoldModel {
  const factory SeatHoldModel({
    required int id,
    required String seatNumber,
    required String expiresAt,
    required HoldStatus status,
    required String createdAt,
    required int tripId,
    required int userId,
    String? tripDate,
    String? tripTime,
    String? routeName,
    int? minutesLeft,
  }) = _SeatHoldModel;

  factory SeatHoldModel.fromJson(Map<String, dynamic> json) =>
      _$SeatHoldModelFromJson(json);
}

extension SeatHoldModelExtension on SeatHoldModel {
  int get calculateMinutesLeft {
    if (minutesLeft != null) return minutesLeft!;

    try {
      final expiryDate = DateTime.parse(expiresAt);
      final now = DateTime.now();
      final difference = expiryDate.difference(now);
      return difference.inMinutes.clamp(0, 60);
    } catch (e) {
      return 0;
    }
  }

  bool get isExpired {
    return calculateMinutesLeft <= 0;
  }

  bool get isExpiringSoon {
    return calculateMinutesLeft > 0 && calculateMinutesLeft <= 2;
  }
}




@freezed
class SeatHoldCreateRequest with _$SeatHoldCreateRequest {
  const factory SeatHoldCreateRequest({
    required int tripId,
    required String seatNumber,
    required int fromStopId,
    required int toStopId,
  }) = _SeatHoldCreateRequest;

  factory SeatHoldCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$SeatHoldCreateRequestFromJson(json);
}

@freezed
class SeatHoldUpdateRequest with _$SeatHoldUpdateRequest {
  const factory SeatHoldUpdateRequest({
    required HoldStatus status,
  }) = _SeatHoldUpdateRequest;

  factory SeatHoldUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$SeatHoldUpdateRequestFromJson(json);
}

typedef SeatHoldResponse = SeatHoldModel;