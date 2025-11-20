
import 'package:bus_connect/core/constants/enums/parcel_status.dart';
import 'package:bus_connect/data/models/stop_model/stop_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'parcel_model.freezed.dart';
part 'parcel_model.g.dart';

@freezed
class ParcelModel with _$ParcelModel {
  const factory ParcelModel({
    required int id,
    required String code,
    required String senderName,
    required String senderPhone,
    required String receiverName,
    required String receiverPhone,
    required double price,
    required ParcelStatus status,
    String? proofPhotoUrl,
    String? deliveryOtp,
    DateTime? createdAt,
    String? deliveredAt,
    required int fromStopId,
    required int toStopId,
    int? tripId,
  }) = _ParcelModel;

  factory ParcelModel.fromJson(Map<String, dynamic> json) =>
      _$ParcelModelFromJson(json);
}

@freezed
class ParcelCreateRequest with _$ParcelCreateRequest {
  const factory ParcelCreateRequest({
    required String senderName,
    required String senderPhone,
    required String receiverName,
    required String receiverPhone,
    required double price,
    required int fromStopId,
    required int toStopId,
    int? tripId
  }) = _ParcelCreateRequest;

  factory ParcelCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$ParcelCreateRequestFromJson(json);
}

@freezed
class ParcelUpdateRequest with _$ParcelUpdateRequest {
  const factory ParcelUpdateRequest({
    String? senderName,
    String? senderPhone,
    String? receiverName,
    String? receiverPhone,
    double? price,
    ParcelStatus? status,
  }) = _ParcelUpdateRequest;

  factory ParcelUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$ParcelUpdateRequestFromJson(json);
}
typedef ParcelResponse = ParcelModel;