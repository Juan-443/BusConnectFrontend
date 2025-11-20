// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fare_rule_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FareRuleModelImpl _$$FareRuleModelImplFromJson(Map<String, dynamic> json) =>
    _$FareRuleModelImpl(
      id: (json['id'] as num).toInt(),
      basePrice: (json['basePrice'] as num).toDouble(),
      discounts: json['discounts'] as Map<String, dynamic>?,
      dynamicPricing: $enumDecode(
        _$DynamicPricingStatusEnumMap,
        json['dynamicPricing'],
      ),
      passengerDiscounts: (json['passengerDiscounts'] as Map<String, dynamic>?)
          ?.map((k, e) => MapEntry(k, (e as num).toDouble())),
      routeId: (json['routeId'] as num).toInt(),
      fromStopId: (json['fromStopId'] as num).toInt(),
      toStopId: (json['toStopId'] as num).toInt(),
      fromStopName: json['fromStopName'] as String?,
      toStopName: json['toStopName'] as String?,
    );

Map<String, dynamic> _$$FareRuleModelImplToJson(_$FareRuleModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'basePrice': instance.basePrice,
      'discounts': instance.discounts,
      'dynamicPricing': _$DynamicPricingStatusEnumMap[instance.dynamicPricing]!,
      'passengerDiscounts': instance.passengerDiscounts,
      'routeId': instance.routeId,
      'fromStopId': instance.fromStopId,
      'toStopId': instance.toStopId,
      'fromStopName': instance.fromStopName,
      'toStopName': instance.toStopName,
    };

const _$DynamicPricingStatusEnumMap = {
  DynamicPricingStatus.ON: 'ON',
  DynamicPricingStatus.OFF: 'OFF',
};

_$FareRuleCreateRequestImpl _$$FareRuleCreateRequestImplFromJson(
  Map<String, dynamic> json,
) => _$FareRuleCreateRequestImpl(
  routeId: (json['routeId'] as num).toInt(),
  fromStopId: (json['fromStopId'] as num).toInt(),
  toStopId: (json['toStopId'] as num).toInt(),
  basePrice: (json['basePrice'] as num).toDouble(),
  discounts: json['discounts'] as Map<String, dynamic>?,
  dynamicPricing: $enumDecodeNullable(
    _$DynamicPricingStatusEnumMap,
    json['dynamicPricing'],
  ),
);

Map<String, dynamic> _$$FareRuleCreateRequestImplToJson(
  _$FareRuleCreateRequestImpl instance,
) => <String, dynamic>{
  'routeId': instance.routeId,
  'fromStopId': instance.fromStopId,
  'toStopId': instance.toStopId,
  'basePrice': instance.basePrice,
  'discounts': instance.discounts,
  'dynamicPricing': _$DynamicPricingStatusEnumMap[instance.dynamicPricing],
};

_$FareRuleUpdateRequestImpl _$$FareRuleUpdateRequestImplFromJson(
  Map<String, dynamic> json,
) => _$FareRuleUpdateRequestImpl(
  basePrice: (json['basePrice'] as num?)?.toDouble(),
  discounts: json['discounts'] as Map<String, dynamic>?,
  dynamicPricing: $enumDecodeNullable(
    _$DynamicPricingStatusEnumMap,
    json['dynamicPricing'],
  ),
);

Map<String, dynamic> _$$FareRuleUpdateRequestImplToJson(
  _$FareRuleUpdateRequestImpl instance,
) => <String, dynamic>{
  'basePrice': instance.basePrice,
  'discounts': instance.discounts,
  'dynamicPricing': _$DynamicPricingStatusEnumMap[instance.dynamicPricing],
};
