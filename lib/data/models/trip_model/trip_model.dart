import 'package:bus_connect/core/constants/enums/trip_status.dart';
import 'package:bus_connect/data/models/bus_model/bus_model.dart';
import 'package:bus_connect/data/models/route_model/route_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'trip_model.freezed.dart';
part 'trip_model.g.dart';

@freezed
class TripModel with _$TripModel {
  const factory TripModel({
    required int id,
    required DateTime date,
    required DateTime departureAt,
    required DateTime arrivalEta,
    required TripStatus status,
    required int routeId,
    int? busId,
    String? routeName,
    String? origin,
    String? destination,
    String? busPlate,
    int? capacity,
    RouteModel? route,
    BusModel? bus,
  }) = _TripModel;

  factory TripModel.fromJson(Map<String, dynamic> json) =>
      _$TripModelFromJson(json);
}

@freezed
class TripCreateRequest with _$TripCreateRequest {
  const factory TripCreateRequest({
    required int routeId,
    required DateTime date,
    required DateTime departureAt,
    required DateTime? arrivalEta,
    int? busId,
  }) = _TripCreateRequest;

  factory TripCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$TripCreateRequestFromJson(json);
}

@freezed
class TripUpdateRequest with _$TripUpdateRequest {
  const factory TripUpdateRequest({
    DateTime? date,
    DateTime? departureAt,
    DateTime? arrivalEta,
    int? busId,
    TripStatus? status,
  }) = _TripUpdateRequest;

  factory TripUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$TripUpdateRequestFromJson(json);
}

typedef TripResponse = TripModel;