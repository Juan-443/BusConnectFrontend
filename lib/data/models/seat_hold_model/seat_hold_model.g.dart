// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seat_hold_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SeatHoldModelImpl _$$SeatHoldModelImplFromJson(Map<String, dynamic> json) =>
    _$SeatHoldModelImpl(
      id: (json['id'] as num).toInt(),
      expiresAt: json['expiresAt'] as String,
      seatNumber: json['seatNumber'] as String,
      status: $enumDecode(_$HoldStatusEnumMap, json['status']),
      createdAt: json['createdAt'] as String,
      tripId: (json['tripId'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
    );

Map<String, dynamic> _$$SeatHoldModelImplToJson(_$SeatHoldModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'expiresAt': instance.expiresAt,
      'seatNumber': instance.seatNumber,
      'status': _$HoldStatusEnumMap[instance.status]!,
      'createdAt': instance.createdAt,
      'tripId': instance.tripId,
      'userId': instance.userId,
    };

const _$HoldStatusEnumMap = {
  HoldStatus.HOLD: 'HOLD',
  HoldStatus.EXPIRED: 'EXPIRED',
  HoldStatus.CONVERTED: 'CONVERTED',
};

_$SeatHoldCreateRequestImpl _$$SeatHoldCreateRequestImplFromJson(
  Map<String, dynamic> json,
) => _$SeatHoldCreateRequestImpl(
  tripId: (json['tripId'] as num).toInt(),
  seatNumber: json['seatNumber'] as String,
);

Map<String, dynamic> _$$SeatHoldCreateRequestImplToJson(
  _$SeatHoldCreateRequestImpl instance,
) => <String, dynamic>{
  'tripId': instance.tripId,
  'seatNumber': instance.seatNumber,
};

_$SeatHoldUpdateRequestImpl _$$SeatHoldUpdateRequestImplFromJson(
  Map<String, dynamic> json,
) => _$SeatHoldUpdateRequestImpl(
  expiresAt: json['expiresAt'] as String?,
  status: $enumDecodeNullable(_$HoldStatusEnumMap, json['status']),
);

Map<String, dynamic> _$$SeatHoldUpdateRequestImplToJson(
  _$SeatHoldUpdateRequestImpl instance,
) => <String, dynamic>{
  'expiresAt': instance.expiresAt,
  'status': _$HoldStatusEnumMap[instance.status],
};
