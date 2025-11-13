import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/baggage_model/baggage_model.dart';
import '../../core/constants/api_constants.dart';

part 'baggage_api_provider.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class BaggageApiProvider {
  factory BaggageApiProvider(Dio dio, {String baseUrl}) = _BaggageApiProvider;

  // ==================== BAGGAGE CRUD ====================

  @POST(ApiConstants.baggageCreate)
  Future<BaggageResponse> createBaggage(@Body() BaggageCreateRequest request);

  @PUT('${ApiConstants.baggageUpdate}/{id}')
  Future<BaggageResponse> updateBaggage(
      @Path('id') int id,
      @Body() BaggageUpdateRequest request,
      );

  @DELETE('${ApiConstants.baggageDelete}/{id}')
  Future<void> deleteBaggage(@Path('id') int id);

  // ==================== BAGGAGE QUERIES ====================

  @GET(ApiConstants.baggageAll)
  Future<List<BaggageResponse>> getAllBaggage();

  @GET('${ApiConstants.baggageById}/{id}')
  Future<BaggageResponse> getBaggageById(@Path('id') int id);

  @GET('${ApiConstants.baggageByTag}/{tagCode}')
  Future<BaggageResponse> getBaggageByTagCode(@Path('tagCode') String tagCode);

  @GET('${ApiConstants.baggageByTicket}/{ticketId}')
  Future<List<BaggageResponse>> getBaggageByTicket(@Path('ticketId') int ticketId);

  @GET('${ApiConstants.baggageByTrip}/{tripId}')
  Future<List<BaggageResponse>> getBaggageByTrip(@Path('tripId') int tripId);

  // ==================== BAGGAGE CALCULATIONS ====================

  @GET('${ApiConstants.baggageTotalWeight}/{tripId}/total-weight')
  Future<double> getTotalWeightByTrip(@Path('tripId') int tripId);

  @GET(ApiConstants.baggageCalculateFee)
  Future<double> calculateBaggageFee(@Query('weightKg') double weightKg);
}