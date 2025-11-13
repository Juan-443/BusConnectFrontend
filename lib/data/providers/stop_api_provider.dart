import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/stop_model/stop_model.dart';
import '../../core/constants/api_constants.dart';

part 'stop_api_provider.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class StopApiProvider {
  factory StopApiProvider(Dio dio, {String baseUrl}) = _StopApiProvider;

  // ==================== STOP CRUD ====================

  @POST(ApiConstants.stopCreate)
  Future<StopResponse> createStop(@Body() StopCreateRequest request);

  @PUT('${ApiConstants.stopUpdate}/{id}')
  Future<StopResponse> updateStop(
      @Path('id') int id,
      @Body() StopUpdateRequest request,
      );

  @DELETE('${ApiConstants.stopDelete}/{id}')
  Future<void> deleteStop(@Path('id') int id);

  // ==================== STOP QUERIES ====================

  @GET(ApiConstants.stopAll)
  Future<List<StopResponse>> getAllStops();

  @GET('${ApiConstants.stopById}/{id}')
  Future<StopResponse> getStopById(@Path('id') int id);

  @GET('${ApiConstants.stopsByRoute}/{routeId}')
  Future<List<StopResponse>> getStopsByRoute(@Path('routeId') int routeId);

  @GET(ApiConstants.stopSearch)
  Future<List<StopResponse>> searchStopsByName(@Query('name') String name);
}