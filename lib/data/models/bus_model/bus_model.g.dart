// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bus_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BusModelImpl _$$BusModelImplFromJson(Map<String, dynamic> json) =>
    _$BusModelImpl(
      id: (json['id'] as num).toInt(),
      plate: json['plate'] as String,
      capacity: (json['capacity'] as num).toInt(),
      status: $enumDecode(_$BusStatusEnumMap, json['status']),
      amenities: json['amenities'] as Map<String, dynamic>?,
      seats: (json['seats'] as List<dynamic>?)
          ?.map((e) => SeatModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$BusModelImplToJson(_$BusModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'plate': instance.plate,
      'capacity': instance.capacity,
      'status': _$BusStatusEnumMap[instance.status]!,
      'amenities': instance.amenities,
      'seats': instance.seats,
    };

const _$BusStatusEnumMap = {
  BusStatus.ACTIVE: 'ACTIVE',
  BusStatus.MAINTENANCE: 'MAINTENANCE',
  BusStatus.INACTIVE: 'INACTIVE',
};

_$BusCreateRequestImpl _$$BusCreateRequestImplFromJson(
  Map<String, dynamic> json,
) => _$BusCreateRequestImpl(
  plate: json['plate'] as String,
  capacity: (json['capacity'] as num).toInt(),
  amenities: json['amenities'] as Map<String, dynamic>?,
  status: $enumDecode(_$BusStatusEnumMap, json['status']),
);

Map<String, dynamic> _$$BusCreateRequestImplToJson(
  _$BusCreateRequestImpl instance,
) => <String, dynamic>{
  'plate': instance.plate,
  'capacity': instance.capacity,
  'amenities': instance.amenities,
  'status': _$BusStatusEnumMap[instance.status]!,
};

_$BusUpdateRequestImpl _$$BusUpdateRequestImplFromJson(
  Map<String, dynamic> json,
) => _$BusUpdateRequestImpl(
  plate: json['plate'] as String?,
  capacity: (json['capacity'] as num?)?.toInt(),
  status: $enumDecodeNullable(_$BusStatusEnumMap, json['status']),
  amenities: json['amenities'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$$BusUpdateRequestImplToJson(
  _$BusUpdateRequestImpl instance,
) => <String, dynamic>{
  'plate': instance.plate,
  'capacity': instance.capacity,
  'status': _$BusStatusEnumMap[instance.status],
  'amenities': instance.amenities,
};
