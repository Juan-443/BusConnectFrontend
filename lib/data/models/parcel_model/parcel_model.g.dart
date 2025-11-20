// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parcel_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ParcelModelImpl _$$ParcelModelImplFromJson(Map<String, dynamic> json) =>
    _$ParcelModelImpl(
      id: (json['id'] as num).toInt(),
      code: json['code'] as String,
      senderName: json['senderName'] as String,
      senderPhone: json['senderPhone'] as String,
      receiverName: json['receiverName'] as String,
      receiverPhone: json['receiverPhone'] as String,
      price: (json['price'] as num).toDouble(),
      status: $enumDecode(_$ParcelStatusEnumMap, json['status']),
      proofPhotoUrl: json['proofPhotoUrl'] as String?,
      deliveryOtp: json['deliveryOtp'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      deliveredAt: json['deliveredAt'] as String?,
      fromStopId: (json['fromStopId'] as num).toInt(),
      toStopId: (json['toStopId'] as num).toInt(),
      tripId: (json['tripId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ParcelModelImplToJson(_$ParcelModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'senderName': instance.senderName,
      'senderPhone': instance.senderPhone,
      'receiverName': instance.receiverName,
      'receiverPhone': instance.receiverPhone,
      'price': instance.price,
      'status': _$ParcelStatusEnumMap[instance.status]!,
      'proofPhotoUrl': instance.proofPhotoUrl,
      'deliveryOtp': instance.deliveryOtp,
      'createdAt': instance.createdAt?.toIso8601String(),
      'deliveredAt': instance.deliveredAt,
      'fromStopId': instance.fromStopId,
      'toStopId': instance.toStopId,
      'tripId': instance.tripId,
    };

const _$ParcelStatusEnumMap = {
  ParcelStatus.CREATED: 'CREATED',
  ParcelStatus.IN_TRANSIT: 'IN_TRANSIT',
  ParcelStatus.DELIVERED: 'DELIVERED',
  ParcelStatus.FAILED: 'FAILED',
};

_$ParcelCreateRequestImpl _$$ParcelCreateRequestImplFromJson(
  Map<String, dynamic> json,
) => _$ParcelCreateRequestImpl(
  senderName: json['senderName'] as String,
  senderPhone: json['senderPhone'] as String,
  receiverName: json['receiverName'] as String,
  receiverPhone: json['receiverPhone'] as String,
  price: (json['price'] as num).toDouble(),
  fromStopId: (json['fromStopId'] as num).toInt(),
  toStopId: (json['toStopId'] as num).toInt(),
  tripId: (json['tripId'] as num?)?.toInt(),
);

Map<String, dynamic> _$$ParcelCreateRequestImplToJson(
  _$ParcelCreateRequestImpl instance,
) => <String, dynamic>{
  'senderName': instance.senderName,
  'senderPhone': instance.senderPhone,
  'receiverName': instance.receiverName,
  'receiverPhone': instance.receiverPhone,
  'price': instance.price,
  'fromStopId': instance.fromStopId,
  'toStopId': instance.toStopId,
  'tripId': instance.tripId,
};

_$ParcelUpdateRequestImpl _$$ParcelUpdateRequestImplFromJson(
  Map<String, dynamic> json,
) => _$ParcelUpdateRequestImpl(
  senderName: json['senderName'] as String?,
  senderPhone: json['senderPhone'] as String?,
  receiverName: json['receiverName'] as String?,
  receiverPhone: json['receiverPhone'] as String?,
  price: (json['price'] as num?)?.toDouble(),
  status: $enumDecodeNullable(_$ParcelStatusEnumMap, json['status']),
);

Map<String, dynamic> _$$ParcelUpdateRequestImplToJson(
  _$ParcelUpdateRequestImpl instance,
) => <String, dynamic>{
  'senderName': instance.senderName,
  'senderPhone': instance.senderPhone,
  'receiverName': instance.receiverName,
  'receiverPhone': instance.receiverPhone,
  'price': instance.price,
  'status': _$ParcelStatusEnumMap[instance.status],
};
