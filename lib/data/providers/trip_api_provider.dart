import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/trip_model/trip_model.dart';
import '../../core/constants/api_constants.dart';
import '../../core/constants/enums/trip_status.dart';

part 'trip_api_provider.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class TripApiProvider {
  factory TripApiProvider(Dio dio, {String baseUrl}) = _TripApiProvider;

  // ==================== TRIP CRUD ====================

  @POST(ApiConstants.tripCreate)
  Future<TripResponse> createTrip(@Body() TripCreateRequest request);

  @PUT('${ApiConstants.tripUpdate}/{id}')
  Future<TripResponse> updateTrip(
      @Path('id') int id,
      @Body() TripUpdateRequest request,
      );

  @DELETE('${ApiConstants.tripDelete}/{id}')
  Future<void> deleteTrip(@Path('id') int id);

  @GET('${ApiConstants.tripSearch}/{id}')
  Future<TripResponse> getTripById(@Path('id') int id);

  @GET('${ApiConstants.tripDetails}/{id}/details')
  Future<TripResponse> getTripWithDetails(@Path('id') int id);

  @GET(ApiConstants.tripAll)
  Future<List<TripResponse>> getAllTrips();

  @GET(ApiConstants.tripSearch)
  Future<List<TripResponse>> searchTrips({
    @Query('routeId') int? routeId,
    @Query('date') String? date,
    @Query('status') TripStatus? status,
  });

  // ==================== TRIP QUERIES ====================

  @GET('${ApiConstants.tripsByRoute}/{routeId}')
  Future<List<TripResponse>> getTripsByRoute(@Path('routeId') int routeId);

  @GET('${ApiConstants.tripsByRoute}/{routeId}')
  Future<List<TripResponse>> getTripsByRouteAndDate(
      @Path('routeId') int routeId,
      @Query('date') String date,
      );

  @GET(ApiConstants.tripsToday)
  Future<List<TripResponse>> getTodayTrips();

  @GET(ApiConstants.tripsTodayActive)
  Future<List<TripResponse>> getTodayActiveTrips();

  @GET('${ApiConstants.tripsByBus}/{busId}')
  Future<List<TripResponse>> getTripsByBus(@Path('busId') int busId);

  @GET('${ApiConstants.tripsByBus}/{busId}')
  Future<List<TripResponse>> getActiveTripsByBus(
      @Path('busId') int busId,
      @Query('date') String date,
      );

  @GET('${ApiConstants.tripsByStatus}/{status}')
  Future<List<TripResponse>> getTripsByStatus(@Path('status') TripStatus status);

  // ==================== TRIP STATUS MANAGEMENT ====================

  @PATCH('${ApiConstants.tripChangeStatus}/{id}/status')
  Future<TripResponse> changeTripStatus(
      @Path('id') int id,
      @Query('status') TripStatus status,
      );

  @POST('${ApiConstants.tripBoardingOpen}/{id}/boarding/open')
  Future<TripResponse> openBoarding(@Path('id') int id);

  @POST('${ApiConstants.tripBoardingClose}/{id}/boarding/close')
  Future<TripResponse> closeBoarding(@Path('id') int id);

  @POST('${ApiConstants.tripDepart}/{id}/depart')
  Future<TripResponse> markAsDeparted(@Path('id') int id);

  @POST('${ApiConstants.tripArrive}/{id}/arrive')
  Future<TripResponse> markAsArrived(@Path('id') int id);

  @POST('${ApiConstants.tripCancel}/{id}/cancel')
  Future<TripResponse> cancelTrip(@Path('id') int id);

  @POST('${ApiConstants.tripReactivate}/{id}/reactivate')
  Future<TripResponse> reactivateTrip(@Path('id') int id);

  // ==================== DRIVER TRIPS ====================

  @GET(ApiConstants.driverMyTrips)
  Future<List<TripResponse>> getDriverMyTrips();

  @GET(ApiConstants.driverCurrentTrips)
  Future<List<TripResponse>> getDriverCurrentTrips();

  @GET(ApiConstants.driverActiveTrips)
  Future<List<TripResponse>> getDriverActiveTrips();
}