// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TripModelImpl _$$TripModelImplFromJson(Map<String, dynamic> json) =>
    _$TripModelImpl(
      id: (json['id'] as num).toInt(),
      date: DateTime.parse(json['date'] as String),
      departureAt: DateTime.parse(json['departureAt'] as String),
      arrivalEta: DateTime.parse(json['arrivalEta'] as String),
      status: $enumDecode(_$TripStatusEnumMap, json['status']),
      routeId: (json['routeId'] as num).toInt(),
      busId: (json['busId'] as num?)?.toInt(),
      route: json['route'] == null
          ? null
          : RouteModel.fromJson(json['route'] as Map<String, dynamic>),
      bus: json['bus'] == null
          ? null
          : BusModel.fromJson(json['bus'] as Map<String, dynamic>),
      capacity: (json['capacity'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$TripModelImplToJson(_$TripModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'departureAt': instance.departureAt.toIso8601String(),
      'arrivalEta': instance.arrivalEta.toIso8601String(),
      'status': _$TripStatusEnumMap[instance.status]!,
      'routeId': instance.routeId,
      'busId': instance.busId,
      'route': instance.route,
      'bus': instance.bus,
      'capacity': instance.capacity,
    };

const _$TripStatusEnumMap = {
  TripStatus.SCHEDULED: 'SCHEDULED',
  TripStatus.BOARDING: 'BOARDING',
  TripStatus.DEPARTED: 'DEPARTED',
  TripStatus.ARRIVED: 'ARRIVED',
  TripStatus.CANCELLED: 'CANCELLED',
};

_$TripCreateRequestImpl _$$TripCreateRequestImplFromJson(
  Map<String, dynamic> json,
) => _$TripCreateRequestImpl(
  routeId: (json['routeId'] as num).toInt(),
  date: DateTime.parse(json['date'] as String),
  departureAt: DateTime.parse(json['departureAt'] as String),
  arrivalEta: json['arrivalEta'] == null
      ? null
      : DateTime.parse(json['arrivalEta'] as String),
  busId: (json['busId'] as num?)?.toInt(),
);

Map<String, dynamic> _$$TripCreateRequestImplToJson(
  _$TripCreateRequestImpl instance,
) => <String, dynamic>{
  'routeId': instance.routeId,
  'date': instance.date.toIso8601String(),
  'departureAt': instance.departureAt.toIso8601String(),
  'arrivalEta': instance.arrivalEta?.toIso8601String(),
  'busId': instance.busId,
};

_$TripUpdateRequestImpl _$$TripUpdateRequestImplFromJson(
  Map<String, dynamic> json,
) => _$TripUpdateRequestImpl(
  date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
  departureAt: json['departureAt'] == null
      ? null
      : DateTime.parse(json['departureAt'] as String),
  arrivalEta: json['arrivalEta'] == null
      ? null
      : DateTime.parse(json['arrivalEta'] as String),
  busId: (json['busId'] as num?)?.toInt(),
  status: $enumDecodeNullable(_$TripStatusEnumMap, json['status']),
);

Map<String, dynamic> _$$TripUpdateRequestImplToJson(
  _$TripUpdateRequestImpl instance,
) => <String, dynamic>{
  'date': instance.date?.toIso8601String(),
  'departureAt': instance.departureAt?.toIso8601String(),
  'arrivalEta': instance.arrivalEta?.toIso8601String(),
  'busId': instance.busId,
  'status': _$TripStatusEnumMap[instance.status],
};
