import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/assignment_model/assignment_model.dart';
import '../../core/constants/api_constants.dart';

part 'assignment_api_provider.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class AssignmentApiProvider {
  factory AssignmentApiProvider(Dio dio, {String baseUrl}) = _AssignmentApiProvider;

  @POST(ApiConstants.assignmentCreate)
  Future<AssignmentResponse> createAssignment(@Body() AssignmentCreateRequest request);

  @PUT('${ApiConstants.assignmentUpdate}/{id}')
  Future<AssignmentResponse> updateAssignment(
      @Path('id') int id,
      @Body() AssignmentUpdateRequest request,
      );

  @DELETE('${ApiConstants.assignmentDelete}/{id}')
  Future<void> deleteAssignment(@Path('id') int id);

  @GET(ApiConstants.assignmentAll)
  Future<List<AssignmentResponse>> getAllAssignments();

  @GET('${ApiConstants.assignmentById}/{id}')
  Future<AssignmentResponse> getAssignmentById(@Path('id') int id);

  @GET('${ApiConstants.assignmentByTrip}/{tripId}')
  Future<AssignmentResponse> getAssignmentByTrip(@Path('tripId') int tripId);

  @GET('${ApiConstants.assignmentWithDetails}/{tripId}/details')
  Future<AssignmentResponse> getAssignmentWithDetails(@Path('tripId') int tripId);

  @GET('${ApiConstants.assignmentsByDriver}/{driverId}')
  Future<List<AssignmentResponse>> getAssignmentsByDriver(@Path('driverId') int driverId);

  @GET('${ApiConstants.assignmentsActiveByDriver}/{driverId}/active')
  Future<List<AssignmentResponse>> getActiveAssignmentsByDriver(
      @Path('driverId') int driverId,
      );

  @GET('${ApiConstants.assignmentsByDriverAndDate}/{driverId}/date')
  Future<List<AssignmentResponse>> getAssignmentsByDriverAndDate(
      @Path('driverId') int driverId,
      @Query('date') String date,
      );

  @GET('${ApiConstants.assignmentsByDispatcher}/{dispatcherId}')
  Future<List<AssignmentResponse>> getAssignmentsByDispatcher(
      @Path('dispatcherId') int dispatcherId,
      );

  @GET(ApiConstants.assignmentsByDateRange)
  Future<List<AssignmentResponse>> getAssignmentsByDateRange(
      @Query('start') String start,
      @Query('end') String end,
      );

  @POST('${ApiConstants.assignmentApproveChecklist}/{id}/approve-checklist')
  Future<AssignmentResponse> approveChecklist(@Path('id') int id);

  @GET('${ApiConstants.assignmentHasActive}/{tripId}/has-assignment')
  Future<bool> hasActiveAssignment(@Path('tripId') int tripId);
}