// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AssignmentModelImpl _$$AssignmentModelImplFromJson(
  Map<String, dynamic> json,
) => _$AssignmentModelImpl(
  id: (json['id'] as num).toInt(),
  checklistOk: json['checklistOk'] as bool,
  assignedAt: _dateFromJson(json['assignedAt'] as String),
  tripId: (json['tripId'] as num).toInt(),
  driverId: (json['driverId'] as num).toInt(),
  dispatcherId: (json['dispatcherId'] as num).toInt(),
  trip: json['trip'] == null
      ? null
      : TripModel.fromJson(json['trip'] as Map<String, dynamic>),
  driver: json['driver'] == null
      ? null
      : UserModel.fromJson(json['driver'] as Map<String, dynamic>),
  dispatcher: json['dispatcher'] == null
      ? null
      : UserModel.fromJson(json['dispatcher'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$AssignmentModelImplToJson(
  _$AssignmentModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'checklistOk': instance.checklistOk,
  'assignedAt': _dateToJson(instance.assignedAt),
  'tripId': instance.tripId,
  'driverId': instance.driverId,
  'dispatcherId': instance.dispatcherId,
  'trip': instance.trip,
  'driver': instance.driver,
  'dispatcher': instance.dispatcher,
};

_$AssignmentCreateRequestImpl _$$AssignmentCreateRequestImplFromJson(
  Map<String, dynamic> json,
) => _$AssignmentCreateRequestImpl(
  tripId: (json['tripId'] as num).toInt(),
  driverId: (json['driverId'] as num).toInt(),
  dispatcherId: (json['dispatcherId'] as num).toInt(),
);

Map<String, dynamic> _$$AssignmentCreateRequestImplToJson(
  _$AssignmentCreateRequestImpl instance,
) => <String, dynamic>{
  'tripId': instance.tripId,
  'driverId': instance.driverId,
  'dispatcherId': instance.dispatcherId,
};

_$AssignmentUpdateRequestImpl _$$AssignmentUpdateRequestImplFromJson(
  Map<String, dynamic> json,
) => _$AssignmentUpdateRequestImpl(
  driverId: (json['driverId'] as num?)?.toInt(),
  checklistOk: json['checklistOk'] as bool?,
);

Map<String, dynamic> _$$AssignmentUpdateRequestImplToJson(
  _$AssignmentUpdateRequestImpl instance,
) => <String, dynamic>{
  'driverId': instance.driverId,
  'checklistOk': instance.checklistOk,
};
