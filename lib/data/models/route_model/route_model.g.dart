// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RouteModelImpl _$$RouteModelImplFromJson(Map<String, dynamic> json) =>
    _$RouteModelImpl(
      id: (json['id'] as num).toInt(),
      code: json['code'] as String,
      name: json['name'] as String,
      origin: json['origin'] as String,
      destination: json['destination'] as String,
      distanceKm: (json['distanceKm'] as num).toInt(),
      durationMin: (json['durationMin'] as num).toInt(),
      stops: (json['stops'] as List<dynamic>?)
          ?.map((e) => StopModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$RouteModelImplToJson(_$RouteModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'origin': instance.origin,
      'destination': instance.destination,
      'distanceKm': instance.distanceKm,
      'durationMin': instance.durationMin,
      'stops': instance.stops,
    };

_$RouteCreateRequestImpl _$$RouteCreateRequestImplFromJson(
  Map<String, dynamic> json,
) => _$RouteCreateRequestImpl(
  code: json['code'] as String,
  name: json['name'] as String,
  origin: json['origin'] as String,
  destination: json['destination'] as String,
  distanceKm: (json['distanceKm'] as num).toInt(),
  durationMin: (json['durationMin'] as num).toInt(),
);

Map<String, dynamic> _$$RouteCreateRequestImplToJson(
  _$RouteCreateRequestImpl instance,
) => <String, dynamic>{
  'code': instance.code,
  'name': instance.name,
  'origin': instance.origin,
  'destination': instance.destination,
  'distanceKm': instance.distanceKm,
  'durationMin': instance.durationMin,
};

_$RouteUpdateRequestImpl _$$RouteUpdateRequestImplFromJson(
  Map<String, dynamic> json,
) => _$RouteUpdateRequestImpl(
  name: json['name'] as String?,
  origin: json['origin'] as String?,
  destination: json['destination'] as String?,
  distanceKm: (json['distanceKm'] as num?)?.toInt(),
  durationMin: (json['durationMin'] as num?)?.toInt(),
);

Map<String, dynamic> _$$RouteUpdateRequestImplToJson(
  _$RouteUpdateRequestImpl instance,
) => <String, dynamic>{
  'name': instance.name,
  'origin': instance.origin,
  'destination': instance.destination,
  'distanceKm': instance.distanceKm,
  'durationMin': instance.durationMin,
};
