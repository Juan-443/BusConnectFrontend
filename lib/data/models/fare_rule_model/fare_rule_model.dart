
import 'package:bus_connect/core/constants/enums/dynamic_pricing_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'fare_rule_model.freezed.dart';
part 'fare_rule_model.g.dart';

@freezed
class FareRuleModel with _$FareRuleModel {
  const factory FareRuleModel({
    required int id,
    required double basePrice,
    Map<String, dynamic>? discounts,
    required DynamicPricingStatus dynamicPricing,
    Map<String, double>? passengerDiscounts,
    required int routeId,
    required int fromStopId,
    required int toStopId,
    String? fromStopName,
    String? toStopName,
  }) = _FareRuleModel;

  factory FareRuleModel.fromJson(Map<String, dynamic> json) =>
      _$FareRuleModelFromJson(json);
}

@freezed
class FareRuleCreateRequest with _$FareRuleCreateRequest {
  const factory FareRuleCreateRequest({
    required int routeId,
    required int fromStopId,
    required int toStopId,
    required double basePrice,
    Map<String, dynamic>? discounts,
    DynamicPricingStatus? dynamicPricing,
  }) = _FareRuleCreateRequest;

  factory FareRuleCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$FareRuleCreateRequestFromJson(json);
}

@freezed
class FareRuleUpdateRequest with _$FareRuleUpdateRequest {
  const factory FareRuleUpdateRequest({
    double? basePrice,
    Map<String, dynamic>? discounts,
    DynamicPricingStatus? dynamicPricing,
  }) = _FareRuleUpdateRequest;

  factory FareRuleUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$FareRuleUpdateRequestFromJson(json);
}
typedef FareRuleResponse = FareRuleModel;