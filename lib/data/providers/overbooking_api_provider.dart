import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/overbooking_model/overbooking_model.dart';
import '../../core/constants/api_constants.dart';

part 'overbooking_api_provider.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class OverbookingApiProvider {
  factory OverbookingApiProvider(Dio dio, {String baseUrl}) = _OverbookingApiProvider;

  // ==================== OVERBOOKING CRUD ====================

  @POST(ApiConstants.overbookingRequest)
  Future<OverbookingResponse> requestOverbooking(
      @Body() OverbookingCreateRequest request,
      );

  @POST('${ApiConstants.overbookingApprove}/{id}/approve')
  Future<OverbookingResponse> approveOverbooking(
      @Path('id') int id,
      @Body() OverbookingApproveRequest request,
      );

  @POST('${ApiConstants.overbookingReject}/{id}/reject')
  Future<OverbookingResponse> rejectOverbooking(
      @Path('id') int id,
      @Body() OverbookingRejectRequest request,
      );

  // ==================== OVERBOOKING QUERIES ====================

  @GET(ApiConstants.overbookingPending)
  Future<List<OverbookingResponse>> getPendingRequests();

  @GET('${ApiConstants.overbookingByTrip}/{tripId}')
  Future<List<OverbookingResponse>> getOverbookingRequestsByTrip(
      @Path('tripId') int tripId,
      );

  @GET('${ApiConstants.overbookingByStatus}/{status}')
  Future<List<OverbookingResponse>> getOverbookingRequestsByStatus(
      @Path('status') String status,
      );

  @GET('${ApiConstants.overbookingById}/{id}')
  Future<OverbookingResponse> getOverbookingRequestById(@Path('id') int id);

  // ==================== OVERBOOKING VALIDATION ====================

  @GET('${ApiConstants.overbookingCanOverbook}/{tripId}/can-overbook')
  Future<bool> canOverbook(@Path('tripId') int tripId);

  @GET('${ApiConstants.overbookingOccupancy}/{tripId}/occupancy')
  Future<double> getCurrentOccupancyRate(@Path('tripId') int tripId);

  // ==================== OVERBOOKING ACTIONS ====================

  @POST(ApiConstants.overbookingExpirePending)
  Future<void> expirePendingRequests();
}