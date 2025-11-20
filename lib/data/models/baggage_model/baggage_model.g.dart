// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'baggage_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BaggageModelImpl _$$BaggageModelImplFromJson(Map<String, dynamic> json) =>
    _$BaggageModelImpl(
      id: (json['id'] as num).toInt(),
      weightKg: (json['weightKg'] as num).toDouble(),
      fee: (json['fee'] as num).toDouble(),
      tagCode: json['tagCode'] as String,
      ticketId: (json['ticketId'] as num).toInt(),
      passengerName: json['passengerName'] as String?,
      tripInfo: json['tripInfo'] as String?,
      excessWeight: json['excessWeight'] as bool?,
    );

Map<String, dynamic> _$$BaggageModelImplToJson(_$BaggageModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'weightKg': instance.weightKg,
      'fee': instance.fee,
      'tagCode': instance.tagCode,
      'ticketId': instance.ticketId,
      'passengerName': instance.passengerName,
      'tripInfo': instance.tripInfo,
      'excessWeight': instance.excessWeight,
    };

_$BaggageCreateRequestImpl _$$BaggageCreateRequestImplFromJson(
  Map<String, dynamic> json,
) => _$BaggageCreateRequestImpl(
  ticketId: (json['ticketId'] as num).toInt(),
  weightKg: (json['weightKg'] as num).toDouble(),
  fee: (json['fee'] as num).toDouble(),
);

Map<String, dynamic> _$$BaggageCreateRequestImplToJson(
  _$BaggageCreateRequestImpl instance,
) => <String, dynamic>{
  'ticketId': instance.ticketId,
  'weightKg': instance.weightKg,
  'fee': instance.fee,
};

_$BaggageUpdateRequestImpl _$$BaggageUpdateRequestImplFromJson(
  Map<String, dynamic> json,
) => _$BaggageUpdateRequestImpl(
  weightKg: (json['weightKg'] as num?)?.toDouble(),
  fee: (json['fee'] as num?)?.toDouble(),
);

Map<String, dynamic> _$$BaggageUpdateRequestImplToJson(
  _$BaggageUpdateRequestImpl instance,
) => <String, dynamic>{'weightKg': instance.weightKg, 'fee': instance.fee};
