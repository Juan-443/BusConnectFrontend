import 'package:freezed_annotation/freezed_annotation.dart';

part 'stop_model.freezed.dart';
part 'stop_model.g.dart';

@freezed
class StopModel with _$StopModel {
  const factory StopModel({
    required int id,
    required String name,
    required int order,
    double? lat,
    double? lng,
    int? routeId,
  }) = _StopModel;

  factory StopModel.fromJson(Map<String, dynamic> json) =>
      _$StopModelFromJson(json);
}

@freezed
class StopCreateRequest with _$StopCreateRequest {
  const factory StopCreateRequest({
    required int routeId,
    required String name,
    required int order,
    double? lat,
    double? lng,
  }) = _StopCreateRequest;

  factory StopCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$StopCreateRequestFromJson(json);
}

@freezed
class StopUpdateRequest with _$StopUpdateRequest {
  const factory StopUpdateRequest({
    String? name,
    int? order,
    double? lat,
    double? lng,
  }) = _StopUpdateRequest;

  factory StopUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$StopUpdateRequestFromJson(json);
}

typedef StopResponse = StopModel;