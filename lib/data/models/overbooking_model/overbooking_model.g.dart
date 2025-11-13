// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'overbooking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OverbookingModelImpl _$$OverbookingModelImplFromJson(
  Map<String, dynamic> json,
) => _$OverbookingModelImpl(
  id: (json['id'] as num).toInt(),
  tripId: (json['tripId'] as num).toInt(),
  tripInfo: json['tripInfo'] as String,
  ticketId: (json['ticketId'] as num).toInt(),
  passengerName: json['passengerName'] as String,
  seatNumber: json['seatNumber'] as String,
  status: $enumDecode(_$OverbookingStatusEnumMap, json['status']),
  reason: json['reason'] as String,
  requestedByName: json['requestedByName'] as String?,
  approvedByName: json['approvedByName'] as String?,
  requestedAt: json['requestedAt'] == null
      ? null
      : DateTime.parse(json['requestedAt'] as String),
  approvedAt: json['approvedAt'] == null
      ? null
      : DateTime.parse(json['approvedAt'] as String),
  expiresAt: json['expiresAt'] == null
      ? null
      : DateTime.parse(json['expiresAt'] as String),
  requiresApproval: json['requiresApproval'] as bool,
  currentOccupancyRate: (json['currentOccupancyRate'] as num).toDouble(),
  minutesUntilDeparture: (json['minutesUntilDeparture'] as num).toInt(),
);

Map<String, dynamic> _$$OverbookingModelImplToJson(
  _$OverbookingModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'tripId': instance.tripId,
  'tripInfo': instance.tripInfo,
  'ticketId': instance.ticketId,
  'passengerName': instance.passengerName,
  'seatNumber': instance.seatNumber,
  'status': _$OverbookingStatusEnumMap[instance.status]!,
  'reason': instance.reason,
  'requestedByName': instance.requestedByName,
  'approvedByName': instance.approvedByName,
  'requestedAt': instance.requestedAt?.toIso8601String(),
  'approvedAt': instance.approvedAt?.toIso8601String(),
  'expiresAt': instance.expiresAt?.toIso8601String(),
  'requiresApproval': instance.requiresApproval,
  'currentOccupancyRate': instance.currentOccupancyRate,
  'minutesUntilDeparture': instance.minutesUntilDeparture,
};

const _$OverbookingStatusEnumMap = {
  OverbookingStatus.PENDING_APPROVAL: 'PENDING_APPROVAL',
  OverbookingStatus.APPROVED: 'APPROVED',
  OverbookingStatus.REJECTED: 'REJECTED',
  OverbookingStatus.EXPIRED: 'EXPIRED',
};

_$OverbookingCreateRequestImpl _$$OverbookingCreateRequestImplFromJson(
  Map<String, dynamic> json,
) => _$OverbookingCreateRequestImpl(
  tripId: (json['tripId'] as num).toInt(),
  ticketId: (json['ticketId'] as num).toInt(),
  reason: json['reason'] as String,
);

Map<String, dynamic> _$$OverbookingCreateRequestImplToJson(
  _$OverbookingCreateRequestImpl instance,
) => <String, dynamic>{
  'tripId': instance.tripId,
  'ticketId': instance.ticketId,
  'reason': instance.reason,
};

_$OverbookingApproveRequestImpl _$$OverbookingApproveRequestImplFromJson(
  Map<String, dynamic> json,
) => _$OverbookingApproveRequestImpl(notes: json['notes'] as String?);

Map<String, dynamic> _$$OverbookingApproveRequestImplToJson(
  _$OverbookingApproveRequestImpl instance,
) => <String, dynamic>{'notes': instance.notes};

_$OverbookingRejectRequestImpl _$$OverbookingRejectRequestImplFromJson(
  Map<String, dynamic> json,
) => _$OverbookingRejectRequestImpl(reason: json['reason'] as String);

Map<String, dynamic> _$$OverbookingRejectRequestImplToJson(
  _$OverbookingRejectRequestImpl instance,
) => <String, dynamic>{'reason': instance.reason};
