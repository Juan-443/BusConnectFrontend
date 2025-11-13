import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/incident_model/incident_model.dart';
import '../../core/constants/api_constants.dart';
import '../../core/constants/enums/entity_type.dart';
import '../../core/constants/enums/incident_type.dart';

part 'incident_api_provider.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class IncidentApiProvider {
  factory IncidentApiProvider(Dio dio, {String baseUrl}) = _IncidentApiProvider;

  // ==================== INCIDENT CRUD ====================

  @POST(ApiConstants.incidentCreate)
  Future<IncidentResponse> createIncident(@Body() IncidentCreateRequest request);

  @PUT('${ApiConstants.incidentUpdate}/{id}')
  Future<IncidentResponse> updateIncident(
      @Path('id') int id,
      @Body() IncidentUpdateRequest request,
      );

  @DELETE('${ApiConstants.incidentDelete}/{id}')
  Future<void> deleteIncident(@Path('id') int id);

  // ==================== INCIDENT QUERIES ====================

  @GET(ApiConstants.incidentAll)
  Future<List<IncidentResponse>> getAllIncidents();

  @GET('${ApiConstants.incidentById}/{id}')
  Future<IncidentResponse> getIncidentById(@Path('id') int id);

  @GET(ApiConstants.incidentsByEntity)
  Future<List<IncidentResponse>> getIncidentsByEntity(
      @Query('entityType') EntityType entityType,
      @Query('entityId') int entityId,
      );

  @GET('${ApiConstants.incidentsByType}/{type}')
  Future<List<IncidentResponse>> getIncidentsByType(@Path('type') IncidentType type);

  @GET('${ApiConstants.incidentsByReporter}/{reportedById}')
  Future<List<IncidentResponse>> getIncidentsByReportedBy(
      @Path('reportedById') int reportedById,
      );

  @GET(ApiConstants.incidentsByDateRange)
  Future<List<IncidentResponse>> getIncidentsByDateRange(
      @Query('start') String start,
      @Query('end') String end,
      );

  @GET('${ApiConstants.incidentsCountByType}/{type}/count')
  Future<int> countIncidentsByType(
      @Path('type') IncidentType type,
      @Query('since') String since,
      );
}