import 'package:freezed_annotation/freezed_annotation.dart';

part 'baggage_model.freezed.dart';
part 'baggage_model.g.dart';

@freezed
class BaggageModel with _$BaggageModel {
  const factory BaggageModel({
    required int id,
    required double weightKg,
    required double fee,
    required String tagCode,
    required int ticketId,
    String? passengerName,
    String? tripInfo,
    bool? excessWeight,
  }) = _BaggageModel;

  factory BaggageModel.fromJson(Map<String, dynamic> json) =>
      _$BaggageModelFromJson(json);
}

@freezed
class BaggageCreateRequest with _$BaggageCreateRequest {
  const factory BaggageCreateRequest({
    required int ticketId,
    required double weightKg,
    required double fee,
  }) = _BaggageCreateRequest;

  factory BaggageCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$BaggageCreateRequestFromJson(json);
}

@freezed
class BaggageUpdateRequest with _$BaggageUpdateRequest {
  const factory BaggageUpdateRequest({
    double? weightKg,
    double? fee,
  }) = _BaggageUpdateRequest;

  factory BaggageUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$BaggageUpdateRequestFromJson(json);
}

typedef BaggageResponse = BaggageModel;