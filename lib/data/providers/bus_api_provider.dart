import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/bus_model/bus_model.dart';
import '../../core/constants/api_constants.dart';
import '../../core/constants/enums/bus_status.dart';

part 'bus_api_provider.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class BusApiProvider {
  factory BusApiProvider(Dio dio, {String baseUrl}) = _BusApiProvider;

  // ==================== BUS CRUD ====================

  @POST(ApiConstants.busCreate)
  Future<BusResponse> createBus(@Body() BusCreateRequest request);

  @PUT('${ApiConstants.busUpdate}/{id}')
  Future<BusResponse> updateBus(
      @Path('id') int id,
      @Body() BusUpdateRequest request,
      );

  @DELETE('${ApiConstants.busDelete}/{id}')
  Future<void> deleteBus(@Path('id') int id);

  // ==================== BUS QUERIES ====================

  @GET(ApiConstants.busAll)
  Future<List<BusResponse>> getAllBuses();

  @GET('${ApiConstants.busById}/{id}')
  Future<BusResponse> getBusById(@Path('id') int id);

  @GET('${ApiConstants.busWithSeats}/{id}/with-seats')
  Future<BusResponse> getBusWithSeats(@Path('id') int id);

  @GET('${ApiConstants.busByPlate}/{plate}')
  Future<BusResponse> getBusByPlate(@Path('plate') String plate);

  @GET('${ApiConstants.busesByStatus}/{status}')
  Future<List<BusResponse>> getBusesByStatus(@Path('status') BusStatus status);

  @GET(ApiConstants.busesAvailable)
  Future<List<BusResponse>> getAvailableBuses(
      @Query('minCapacity') int minCapacity,
      );

  // ==================== BUS STATUS MANAGEMENT ====================

  @PATCH('${ApiConstants.busChangeStatus}/{id}/status')
  Future<BusResponse> changeBusStatus(
      @Path('id') int id,
      @Query('status') BusStatus status,
      );

  // ==================== BUS VALIDATION ====================

  @GET('${ApiConstants.busPlateExists}/{plate}/exists')
  Future<bool> existsByPlate(@Path('plate') String plate);
}