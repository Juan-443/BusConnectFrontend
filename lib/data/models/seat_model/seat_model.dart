
import 'package:bus_connect/core/constants/enums/seat_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'seat_model.freezed.dart';
part 'seat_model.g.dart';

@freezed
class SeatModel with _$SeatModel {
  const factory SeatModel({
    required int id,
    required String number,
    required SeatType type,
    required int busId,
    String? busPlate,
    int? busCapacity,
  }) = _SeatModel;

  factory SeatModel.fromJson(Map<String, dynamic> json) =>
      _$SeatModelFromJson(json);
}

@freezed
class SeatCreateRequest with _$SeatCreateRequest {
  const factory SeatCreateRequest({
    required int busId,
    required String number,
    required SeatType type,
  }) = _SeatCreateRequest;

  factory SeatCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$SeatCreateRequestFromJson(json);
}

@freezed
class SeatUpdateRequest with _$SeatUpdateRequest {
  const factory SeatUpdateRequest({
    String? number,
    SeatType? type,
  }) = _SeatUpdateRequest;

  factory SeatUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$SeatUpdateRequestFromJson(json);
}

typedef SeatResponse = SeatModel;