// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'incident_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$IncidentModelImpl _$$IncidentModelImplFromJson(Map<String, dynamic> json) =>
    _$IncidentModelImpl(
      id: (json['id'] as num).toInt(),
      entityType: $enumDecode(_$EntityTypeEnumMap, json['entityType']),
      entityId: (json['entityId'] as num).toInt(),
      type: $enumDecode(_$IncidentTypeEnumMap, json['type']),
      note: json['note'] as String?,
      reportedBy: (json['reportedBy'] as num?)?.toInt(),
      reportedByName: json['reportedByName'] as String?,
      createdAt: _dateFromJson(json['createdAt'] as String),
    );

Map<String, dynamic> _$$IncidentModelImplToJson(_$IncidentModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'entityType': _$EntityTypeEnumMap[instance.entityType]!,
      'entityId': instance.entityId,
      'type': _$IncidentTypeEnumMap[instance.type]!,
      'note': instance.note,
      'reportedBy': instance.reportedBy,
      'reportedByName': instance.reportedByName,
      'createdAt': _dateToJson(instance.createdAt),
    };

const _$EntityTypeEnumMap = {
  EntityType.TRIP: 'TRIP',
  EntityType.TICKET: 'TICKET',
  EntityType.PARCEL: 'PARCEL',
};

const _$IncidentTypeEnumMap = {
  IncidentType.SECURITY: 'SECURITY',
  IncidentType.DELIVERY_FAIL: 'DELIVERY_FAIL',
  IncidentType.OVERBOOK: 'OVERBOOK',
  IncidentType.VEHICLE: 'VEHICLE',
  IncidentType.PASSENGER_COMPLAINT: 'PASSENGER_COMPLAINT',
  IncidentType.OTHER: 'OTHER',
};

_$IncidentCreateRequestImpl _$$IncidentCreateRequestImplFromJson(
  Map<String, dynamic> json,
) => _$IncidentCreateRequestImpl(
  entityType: $enumDecode(_$EntityTypeEnumMap, json['entityType']),
  entityId: (json['entityId'] as num).toInt(),
  type: $enumDecode(_$IncidentTypeEnumMap, json['type']),
  note: json['note'] as String?,
  reportedBy: (json['reportedBy'] as num).toInt(),
);

Map<String, dynamic> _$$IncidentCreateRequestImplToJson(
  _$IncidentCreateRequestImpl instance,
) => <String, dynamic>{
  'entityType': _$EntityTypeEnumMap[instance.entityType]!,
  'entityId': instance.entityId,
  'type': _$IncidentTypeEnumMap[instance.type]!,
  'note': instance.note,
  'reportedBy': instance.reportedBy,
};

_$IncidentUpdateRequestImpl _$$IncidentUpdateRequestImplFromJson(
  Map<String, dynamic> json,
) => _$IncidentUpdateRequestImpl(
  type: $enumDecodeNullable(_$IncidentTypeEnumMap, json['type']),
  note: json['note'] as String?,
);

Map<String, dynamic> _$$IncidentUpdateRequestImplToJson(
  _$IncidentUpdateRequestImpl instance,
) => <String, dynamic>{
  'type': _$IncidentTypeEnumMap[instance.type],
  'note': instance.note,
};
