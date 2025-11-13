import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/route_model/route_model.dart';
import '../models/stop_model/stop_model.dart';
import '../../core/constants/api_constants.dart';

part 'route_api_provider.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class RouteApiProvider {
  factory RouteApiProvider(Dio dio, {String baseUrl}) = _RouteApiProvider;

  // ==================== ROUTE CRUD ====================

  @POST(ApiConstants.routeCreate)
  Future<RouteResponse> createRoute(@Body() RouteCreateRequest request);

  @PUT('${ApiConstants.routeUpdate}/{id}')
  Future<RouteResponse> updateRoute(
      @Path('id') int id,
      @Body() RouteUpdateRequest request,
      );

  @DELETE('${ApiConstants.routeDelete}/{id}')
  Future<void> deleteRoute(@Path('id') int id);

  // ==================== ROUTE QUERIES ====================

  @GET(ApiConstants.routeAll)
  Future<List<RouteResponse>> getAllRoutes();

  @GET('${ApiConstants.routeById}/{id}')
  Future<RouteResponse> getRouteById(@Path('id') int id);

  @GET('${ApiConstants.routeWithStops}/{id}/with-stops')
  Future<RouteResponse> getRouteWithStops(@Path('id') int id);

  @GET('${ApiConstants.routeStops}/{id}/stops')
  Future<List<StopResponse>> getRouteStops(@Path('id') int id);

  @GET('${ApiConstants.routeByCode}/{code}')
  Future<RouteResponse> getRouteByCode(@Path('code') String code);

  @GET(ApiConstants.routeSearch)
  Future<List<RouteResponse>> searchRoutes({
    @Query('origin') String? origin,
    @Query('destination') String? destination,
  });

  // ==================== ROUTE VALIDATION ====================

  @GET('${ApiConstants.routeCodeExists}/{code}/exists')
  Future<bool> existsByCode(@Path('code') String code);
}