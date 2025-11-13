
import 'package:bus_connect/core/constants/enums/entity_type.dart';
import 'package:bus_connect/core/constants/enums/incident_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'incident_model.freezed.dart';
part 'incident_model.g.dart';

 DateTime _dateFromJson(String date) => DateTime.parse(date);
 String _dateToJson(DateTime date) => date.toIso8601String();


@freezed
class IncidentModel with _$IncidentModel {
  const factory IncidentModel({
    required int id,
    required EntityType entityType,
    required int entityId,
    required IncidentType type,
    String? note,
    int? reportedBy,
    String? reportedByName,
    @JsonKey(fromJson: _dateFromJson, toJson: _dateToJson)
    required DateTime createdAt,
  }) = _IncidentModel;

  factory IncidentModel.fromJson(Map<String, dynamic> json) =>
      _$IncidentModelFromJson(json);
}

@freezed
class IncidentCreateRequest with _$IncidentCreateRequest {
  const factory IncidentCreateRequest({
    required EntityType entityType,
    required int entityId,
    required IncidentType type,
    String? note,
    required int reportedBy,
  }) = _IncidentCreateRequest;

  factory IncidentCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$IncidentCreateRequestFromJson(json);
}

@freezed
class IncidentUpdateRequest with _$IncidentUpdateRequest {
  const factory IncidentUpdateRequest({
    IncidentType? type,
    String? note,
  }) = _IncidentUpdateRequest;

  factory IncidentUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$IncidentUpdateRequestFromJson(json);
}

typedef IncidentResponse = IncidentModel;