
import 'package:bus_connect/data/models/stop_model/stop_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'route_model.freezed.dart';
part 'route_model.g.dart';

@freezed
class RouteModel with _$RouteModel {
  const factory RouteModel({
    required int id,
    required String code,
    required String name,
    required String origin,
    required String destination,
    required int distanceKm,
    required int durationMin,
    List<StopModel>? stops,
  }) = _RouteModel;

  factory RouteModel.fromJson(Map<String, dynamic> json) =>
      _$RouteModelFromJson(json);
}

@freezed
class RouteCreateRequest with _$RouteCreateRequest {
  const factory RouteCreateRequest({
    required String code,
    required String name,
    required String origin,
    required String destination,
    required int distanceKm,
    required int durationMin,
  }) = _RouteCreateRequest;

  factory RouteCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$RouteCreateRequestFromJson(json);
}

@freezed
class RouteUpdateRequest with _$RouteUpdateRequest {
  const factory RouteUpdateRequest({
    String? name,
    String? origin,
    String? destination,
    int? distanceKm,
    int? durationMin,
  }) = _RouteUpdateRequest;

  factory RouteUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$RouteUpdateRequestFromJson(json);
}

typedef RouteResponse = RouteModel;