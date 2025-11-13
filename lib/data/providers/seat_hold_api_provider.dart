import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/seat_hold_model/seat_hold_model.dart';
import '../../core/constants/api_constants.dart';

part 'seat_hold_api_provider.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class SeatHoldApiProvider {
  factory SeatHoldApiProvider(Dio dio, {String baseUrl}) = _SeatHoldApiProvider;

  // ==================== SEAT HOLD CRUD ====================

  @POST(ApiConstants.seatHoldCreate)
  Future<SeatHoldResponse> createSeatHold(@Body() SeatHoldCreateRequest request);

  @PUT('${ApiConstants.seatHoldUpdate}/{id}')
  Future<SeatHoldResponse> updateSeatHold(
      @Path('id') int id,
      @Body() SeatHoldUpdateRequest request,
      );

  @DELETE('${ApiConstants.seatHoldDelete}/{id}')
  Future<void> deleteSeatHold(@Path('id') int id);

  @DELETE('${ApiConstants.seatHoldRelease}/{id}/release')
  Future<void> releaseSeatHold(@Path('id') int id);

  // ==================== SEAT HOLD QUERIES ====================

  @GET(ApiConstants.mySeatHolds)
  Future<List<SeatHoldResponse>> getMySeatHolds();

  @GET(ApiConstants.seatHoldAll)
  Future<List<SeatHoldResponse>> getAllSeatHolds();

  @GET('${ApiConstants.seatHoldById}/{id}')
  Future<SeatHoldResponse> getSeatHoldById(@Path('id') int id);

  @GET('${ApiConstants.seatHoldsByTrip}/{tripId}')
  Future<List<SeatHoldResponse>> getSeatHoldsByTrip(@Path('tripId') int tripId);

  @GET('${ApiConstants.seatHoldsActiveByTrip}/{tripId}/active')
  Future<List<SeatHoldResponse>> getActiveSeatHoldsByTrip(@Path('tripId') int tripId);

  @GET('${ApiConstants.seatHoldsByUser}/{userId}')
  Future<List<SeatHoldResponse>> getSeatHoldsByUser(@Path('userId') int userId);

  // ==================== SEAT HOLD ACTIONS ====================

  @POST('${ApiConstants.seatHoldConvert}/{id}/convert')
  Future<void> convertHoldToTicket(@Path('id') int id);

  // ==================== SEAT HOLD VALIDATION ====================

  @GET(ApiConstants.seatHoldCheck)
  Future<bool> isSeatHeld(
      @Query('tripId') int tripId,
      @Query('seatNumber') String seatNumber,
      );
}