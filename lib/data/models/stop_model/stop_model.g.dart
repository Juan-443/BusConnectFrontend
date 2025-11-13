// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stop_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StopModelImpl _$$StopModelImplFromJson(Map<String, dynamic> json) =>
    _$StopModelImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      order: (json['order'] as num).toInt(),
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
      routeId: (json['routeId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$StopModelImplToJson(_$StopModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'order': instance.order,
      'lat': instance.lat,
      'lng': instance.lng,
      'routeId': instance.routeId,
    };

_$StopCreateRequestImpl _$$StopCreateRequestImplFromJson(
  Map<String, dynamic> json,
) => _$StopCreateRequestImpl(
  routeId: (json['routeId'] as num).toInt(),
  name: json['name'] as String,
  order: (json['order'] as num).toInt(),
  lat: (json['lat'] as num?)?.toDouble(),
  lng: (json['lng'] as num?)?.toDouble(),
);

Map<String, dynamic> _$$StopCreateRequestImplToJson(
  _$StopCreateRequestImpl instance,
) => <String, dynamic>{
  'routeId': instance.routeId,
  'name': instance.name,
  'order': instance.order,
  'lat': instance.lat,
  'lng': instance.lng,
};

_$StopUpdateRequestImpl _$$StopUpdateRequestImplFromJson(
  Map<String, dynamic> json,
) => _$StopUpdateRequestImpl(
  name: json['name'] as String?,
  order: (json['order'] as num?)?.toInt(),
  lat: (json['lat'] as num?)?.toDouble(),
  lng: (json['lng'] as num?)?.toDouble(),
);

Map<String, dynamic> _$$StopUpdateRequestImplToJson(
  _$StopUpdateRequestImpl instance,
) => <String, dynamic>{
  'name': instance.name,
  'order': instance.order,
  'lat': instance.lat,
  'lng': instance.lng,
};
