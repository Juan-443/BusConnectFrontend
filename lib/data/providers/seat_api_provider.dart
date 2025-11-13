import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/seat_model/seat_model.dart';
import '../../core/constants/api_constants.dart';
import '../../core/constants/enums/seat_type.dart';

part 'seat_api_provider.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class SeatApiProvider {
  factory SeatApiProvider(Dio dio, {String baseUrl}) = _SeatApiProvider;

  // ==================== SEAT CRUD ====================

  @POST(ApiConstants.seatCreate)
  Future<SeatResponse> createSeat(@Body() SeatCreateRequest request);

  @PUT('${ApiConstants.seatUpdate}/{id}')
  Future<SeatResponse> updateSeat(
      @Path('id') int id,
      @Body() SeatUpdateRequest request,
      );

  @DELETE('${ApiConstants.seatDelete}/{id}')
  Future<void> deleteSeat(@Path('id') int id);

  // ==================== SEAT QUERIES ====================

  @GET(ApiConstants.seatAll)
  Future<List<SeatResponse>> getAllSeats();

  @GET('${ApiConstants.seatById}/{id}')
  Future<SeatResponse> getSeatById(@Path('id') int id);

  @GET('${ApiConstants.seatsByBus}/{busId}')
  Future<List<SeatResponse>> getSeatsByBus(@Path('busId') int busId);

  @GET('${ApiConstants.seatByBusAndNumber}/{busId}/number/{number}')
  Future<SeatResponse> getSeatByBusAndNumber(
      @Path('busId') int busId,
      @Path('number') String number,
      );

  @GET('${ApiConstants.seatsByBusAndType}/{busId}/type/{type}')
  Future<List<SeatResponse>> getSeatsByBusAndType(
      @Path('busId') int busId,
      @Path('type') SeatType type,
      );

  @GET('${ApiConstants.seatsCountByBus}/{busId}/count')
  Future<int> countSeatsByBus(@Path('busId') int busId);
}