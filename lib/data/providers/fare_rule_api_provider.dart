import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/fare_rule_model/fare_rule_model.dart';
import '../../core/constants/api_constants.dart';

part 'fare_rule_api_provider.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class FareRuleApiProvider {
  factory FareRuleApiProvider(Dio dio, {String baseUrl}) = _FareRuleApiProvider;

  // ==================== FARE RULE CRUD ====================

  @POST(ApiConstants.fareRuleCreate)
  Future<FareRuleResponse> createFareRule(@Body() FareRuleCreateRequest request);

  @PUT('${ApiConstants.fareRuleUpdate}/{id}')
  Future<FareRuleResponse> updateFareRule(
      @Path('id') int id,
      @Body() FareRuleUpdateRequest request,
      );

  @DELETE('${ApiConstants.fareRuleDelete}/{id}')
  Future<void> deleteFareRule(@Path('id') int id);

  // ==================== FARE RULE QUERIES ====================

  @GET(ApiConstants.fareRuleAll)
  Future<List<FareRuleResponse>> getAllFareRules();

  @GET('${ApiConstants.fareRuleById}/{id}')
  Future<FareRuleResponse> getFareRuleById(@Path('id') int id);

  @GET('${ApiConstants.fareRulesByRoute}/{routeId}')
  Future<List<FareRuleResponse>> getFareRulesByRoute(@Path('routeId') int routeId);

  @GET(ApiConstants.fareRuleForSegment)
  Future<FareRuleResponse> getFareRuleForSegment(
      @Query('routeId') int routeId,
      @Query('fromStopId') int fromStopId,
      @Query('toStopId') int toStopId,
      );

  @GET('${ApiConstants.fareRuleDynamicByRoute}/{routeId}/dynamic')
  Future<List<FareRuleResponse>> getDynamicPricingRules(@Path('routeId') int routeId);

  // ==================== FARE RULE CALCULATIONS ====================

  @GET('${ApiConstants.fareRuleCalculateDynamic}/{id}/calculate-dynamic-price')
  Future<double> calculateDynamicPrice(
      @Path('id') int id,
      @Query('occupancyRate') double occupancyRate,
      );
}