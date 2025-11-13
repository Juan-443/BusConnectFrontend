import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/config_model/config_model.dart';
import '../../core/constants/api_constants.dart';

part 'config_api_provider.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ConfigApiProvider {
  factory ConfigApiProvider(Dio dio, {String baseUrl}) = _ConfigApiProvider;

  // ==================== CONFIG CRUD ====================

  @POST(ApiConstants.configCreate)
  Future<ConfigResponse> createConfig(@Body() ConfigCreateRequest request);

  @PUT('${ApiConstants.configUpdate}/{id}')
  Future<ConfigResponse> updateConfig(
      @Path('id') int id,
      @Body() ConfigUpdateRequest request,
      );

  @DELETE('${ApiConstants.configDelete}/{id}')
  Future<void> deleteConfig(@Path('id') int id);

  @DELETE('${ApiConstants.configDeleteByKey}/{key}')
  Future<void> deleteConfigByKey(@Path('key') String key);

  // ==================== CONFIG QUERIES ====================

  @GET(ApiConstants.configAll)
  Future<List<ConfigResponse>> getAllConfigs();

  @GET('${ApiConstants.configById}/{id}')
  Future<ConfigResponse> getConfigById(@Path('id') int id);

  @GET('${ApiConstants.configByKey}/{key}')
  Future<ConfigResponse> getConfigByKey(@Path('key') String key);

  // ==================== CONFIG VALUES ====================

  @GET('${ApiConstants.configValue}/{key}/value')
  Future<String> getConfigValue(
      @Path('key') String key,
      @Query('defaultValue') String? defaultValue,
      );

  @GET('${ApiConstants.configValueInt}/{key}/value/int')
  Future<int> getConfigValueAsInt(
      @Path('key') String key,
      @Query('defaultValue') int? defaultValue,
      );

  @GET('${ApiConstants.configValueDouble}/{key}/value/double')
  Future<double> getConfigValueAsDouble(
      @Path('key') String key,
      @Query('defaultValue') double? defaultValue,
      );
}