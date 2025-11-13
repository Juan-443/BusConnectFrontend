
import 'package:bus_connect/core/constants/enums/bus_status.dart';
import 'package:bus_connect/data/models/seat_model/seat_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bus_model.freezed.dart';
part 'bus_model.g.dart';

@freezed
class BusModel with _$BusModel {
  const factory BusModel({
    required int id,
    required String plate,
    required int capacity,
    required BusStatus status,
    Map<String, dynamic>? amenities,
    List<SeatModel>? seats,
  }) = _BusModel;

  factory BusModel.fromJson(Map<String, dynamic> json) =>
      _$BusModelFromJson(json);
}

@freezed
class BusCreateRequest with _$BusCreateRequest {
  const factory BusCreateRequest({
    required String plate,
    required int capacity,
    Map<String, dynamic>? amenities,
    required BusStatus status
  }) = _BusCreateRequest;

  factory BusCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$BusCreateRequestFromJson(json);
}

@freezed
class BusUpdateRequest with _$BusUpdateRequest {
  const factory BusUpdateRequest({
    String? plate,
    int? capacity,
    BusStatus? status,
    Map<String, dynamic>? amenities,
  }) = _BusUpdateRequest;

  factory BusUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$BusUpdateRequestFromJson(json);
}

typedef BusResponse = BusModel;