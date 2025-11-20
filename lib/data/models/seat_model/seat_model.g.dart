// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SeatModelImpl _$$SeatModelImplFromJson(Map<String, dynamic> json) =>
    _$SeatModelImpl(
      id: (json['id'] as num).toInt(),
      number: json['number'] as String,
      type: $enumDecode(_$SeatTypeEnumMap, json['type']),
      busId: (json['busId'] as num).toInt(),
      busPlate: json['busPlate'] as String?,
      busCapacity: (json['busCapacity'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$SeatModelImplToJson(_$SeatModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'number': instance.number,
      'type': _$SeatTypeEnumMap[instance.type]!,
      'busId': instance.busId,
      'busPlate': instance.busPlate,
      'busCapacity': instance.busCapacity,
    };

const _$SeatTypeEnumMap = {
  SeatType.STANDARD: 'STANDARD',
  SeatType.PREFERENTIAL: 'PREFERENTIAL',
};

_$SeatCreateRequestImpl _$$SeatCreateRequestImplFromJson(
  Map<String, dynamic> json,
) => _$SeatCreateRequestImpl(
  busId: (json['busId'] as num).toInt(),
  number: json['number'] as String,
  type: $enumDecode(_$SeatTypeEnumMap, json['type']),
);

Map<String, dynamic> _$$SeatCreateRequestImplToJson(
  _$SeatCreateRequestImpl instance,
) => <String, dynamic>{
  'busId': instance.busId,
  'number': instance.number,
  'type': _$SeatTypeEnumMap[instance.type]!,
};

_$SeatUpdateRequestImpl _$$SeatUpdateRequestImplFromJson(
  Map<String, dynamic> json,
) => _$SeatUpdateRequestImpl(
  number: json['number'] as String?,
  type: $enumDecodeNullable(_$SeatTypeEnumMap, json['type']),
);

Map<String, dynamic> _$$SeatUpdateRequestImplToJson(
  _$SeatUpdateRequestImpl instance,
) => <String, dynamic>{
  'number': instance.number,
  'type': _$SeatTypeEnumMap[instance.type],
};
