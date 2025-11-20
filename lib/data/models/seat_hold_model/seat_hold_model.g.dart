// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seat_hold_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SeatHoldModelImpl _$$SeatHoldModelImplFromJson(Map<String, dynamic> json) =>
    _$SeatHoldModelImpl(
      id: (json['id'] as num).toInt(),
      seatNumber: json['seatNumber'] as String,
      expiresAt: json['expiresAt'] as String,
      status: $enumDecode(_$HoldStatusEnumMap, json['status']),
      createdAt: json['createdAt'] as String,
      tripId: (json['tripId'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      tripDate: json['tripDate'] as String?,
      tripTime: json['tripTime'] as String?,
      routeName: json['routeName'] as String?,
      minutesLeft: (json['minutesLeft'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$SeatHoldModelImplToJson(_$SeatHoldModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'seatNumber': instance.seatNumber,
      'expiresAt': instance.expiresAt,
      'status': _$HoldStatusEnumMap[instance.status]!,
      'createdAt': instance.createdAt,
      'tripId': instance.tripId,
      'userId': instance.userId,
      'tripDate': instance.tripDate,
      'tripTime': instance.tripTime,
      'routeName': instance.routeName,
      'minutesLeft': instance.minutesLeft,
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
  fromStopId: (json['fromStopId'] as num).toInt(),
  toStopId: (json['toStopId'] as num).toInt(),
);

Map<String, dynamic> _$$SeatHoldCreateRequestImplToJson(
  _$SeatHoldCreateRequestImpl instance,
) => <String, dynamic>{
  'tripId': instance.tripId,
  'seatNumber': instance.seatNumber,
  'fromStopId': instance.fromStopId,
  'toStopId': instance.toStopId,
};

_$SeatHoldUpdateRequestImpl _$$SeatHoldUpdateRequestImplFromJson(
  Map<String, dynamic> json,
) => _$SeatHoldUpdateRequestImpl(
  status: $enumDecode(_$HoldStatusEnumMap, json['status']),
);

Map<String, dynamic> _$$SeatHoldUpdateRequestImplToJson(
  _$SeatHoldUpdateRequestImpl instance,
) => <String, dynamic>{'status': _$HoldStatusEnumMap[instance.status]!};
