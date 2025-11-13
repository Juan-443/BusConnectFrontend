// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TicketModelImpl _$$TicketModelImplFromJson(Map<String, dynamic> json) =>
    _$TicketModelImpl(
      id: (json['id'] as num).toInt(),
      seatNumber: json['seatNumber'] as String,
      price: (json['price'] as num).toDouble(),
      paymentMethod: $enumDecode(_$PaymentMethodEnumMap, json['paymentMethod']),
      status: $enumDecode(_$TicketStatusEnumMap, json['status']),
      qrCode: json['qrCode'] as String,
      createdAt: json['createdAt'] as String,
      passengerType: $enumDecodeNullable(
        _$PassengerTypeEnumMap,
        json['passengerType'],
      ),
      discountAmount: (json['discountAmount'] as num?)?.toDouble(),
      cancelledAt: json['cancelledAt'] as String?,
      refundAmount: (json['refundAmount'] as num?)?.toDouble(),
      cancellationPolicy: $enumDecodeNullable(
        _$CancellationPolicyEnumMap,
        json['cancellationPolicy'],
      ),
      fromStopId: (json['fromStopId'] as num).toInt(),
      toStopId: (json['toStopId'] as num).toInt(),
      tripId: (json['tripId'] as num).toInt(),
      passengerId: (json['passengerId'] as num).toInt(),
      fromStop: json['fromStop'] == null
          ? null
          : StopModel.fromJson(json['fromStop'] as Map<String, dynamic>),
      toStop: json['toStop'] == null
          ? null
          : StopModel.fromJson(json['toStop'] as Map<String, dynamic>),
      trip: json['trip'] == null
          ? null
          : TripModel.fromJson(json['trip'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$TicketModelImplToJson(_$TicketModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'seatNumber': instance.seatNumber,
      'price': instance.price,
      'paymentMethod': _$PaymentMethodEnumMap[instance.paymentMethod]!,
      'status': _$TicketStatusEnumMap[instance.status]!,
      'qrCode': instance.qrCode,
      'createdAt': instance.createdAt,
      'passengerType': _$PassengerTypeEnumMap[instance.passengerType],
      'discountAmount': instance.discountAmount,
      'cancelledAt': instance.cancelledAt,
      'refundAmount': instance.refundAmount,
      'cancellationPolicy':
          _$CancellationPolicyEnumMap[instance.cancellationPolicy],
      'fromStopId': instance.fromStopId,
      'toStopId': instance.toStopId,
      'tripId': instance.tripId,
      'passengerId': instance.passengerId,
      'fromStop': instance.fromStop,
      'toStop': instance.toStop,
      'trip': instance.trip,
    };

const _$PaymentMethodEnumMap = {
  PaymentMethod.CASH: 'CASH',
  PaymentMethod.TRANSFER: 'TRANSFER',
  PaymentMethod.QR: 'QR',
  PaymentMethod.CARD: 'CARD',
};

const _$TicketStatusEnumMap = {
  TicketStatus.SOLD: 'SOLD',
  TicketStatus.CANCELLED: 'CANCELLED',
  TicketStatus.NO_SHOW: 'NO_SHOW',
  TicketStatus.USED: 'USED',
};

const _$PassengerTypeEnumMap = {
  PassengerType.ADULT: 'ADULT',
  PassengerType.CHILD: 'CHILD',
  PassengerType.STUDENT: 'STUDENT',
  PassengerType.SENIOR: 'SENIOR',
};

const _$CancellationPolicyEnumMap = {
  CancellationPolicy.FULL_REFUND: 'FULL_REFUND',
  CancellationPolicy.PARTIAL_REFUND: 'PARTIAL_REFUND',
  CancellationPolicy.NO_REFUND: 'NO_REFUND',
};

_$TicketCreateRequestImpl _$$TicketCreateRequestImplFromJson(
  Map<String, dynamic> json,
) => _$TicketCreateRequestImpl(
  tripId: (json['tripId'] as num).toInt(),
  seatNumber: json['seatNumber'] as String,
  fromStopId: (json['fromStopId'] as num).toInt(),
  toStopId: (json['toStopId'] as num).toInt(),
  passengerId: (json['passengerId'] as num).toInt(),
  price: (json['price'] as num).toDouble(),
  paymentMethod: $enumDecode(_$PaymentMethodEnumMap, json['paymentMethod']),
  passengerType: $enumDecodeNullable(
    _$PassengerTypeEnumMap,
    json['passengerType'],
  ),
  discountAmount: (json['discountAmount'] as num?)?.toDouble(),
);

Map<String, dynamic> _$$TicketCreateRequestImplToJson(
  _$TicketCreateRequestImpl instance,
) => <String, dynamic>{
  'tripId': instance.tripId,
  'seatNumber': instance.seatNumber,
  'fromStopId': instance.fromStopId,
  'toStopId': instance.toStopId,
  'passengerId': instance.passengerId,
  'price': instance.price,
  'paymentMethod': _$PaymentMethodEnumMap[instance.paymentMethod]!,
  'passengerType': _$PassengerTypeEnumMap[instance.passengerType],
  'discountAmount': instance.discountAmount,
};

_$TicketUpdateRequestImpl _$$TicketUpdateRequestImplFromJson(
  Map<String, dynamic> json,
) => _$TicketUpdateRequestImpl(
  seatNumber: json['seatNumber'] as String?,
  price: (json['price'] as num?)?.toDouble(),
  paymentMethod: $enumDecodeNullable(
    _$PaymentMethodEnumMap,
    json['paymentMethod'],
  ),
  status: $enumDecodeNullable(_$TicketStatusEnumMap, json['status']),
);

Map<String, dynamic> _$$TicketUpdateRequestImplToJson(
  _$TicketUpdateRequestImpl instance,
) => <String, dynamic>{
  'seatNumber': instance.seatNumber,
  'price': instance.price,
  'paymentMethod': _$PaymentMethodEnumMap[instance.paymentMethod],
  'status': _$TicketStatusEnumMap[instance.status],
};
