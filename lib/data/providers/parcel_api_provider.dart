import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/parcel_model/parcel_model.dart';
import '../../core/constants/api_constants.dart';
import '../../core/constants/enums/parcel_status.dart';

part 'parcel_api_provider.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ParcelApiProvider {
  factory ParcelApiProvider(Dio dio, {String baseUrl}) = _ParcelApiProvider;

  // ==================== PARCEL CRUD ====================

  @POST(ApiConstants.parcelCreate)
  Future<ParcelResponse> createParcel(@Body() ParcelCreateRequest request);

  @PUT('${ApiConstants.parcelUpdate}/{id}')
  Future<ParcelResponse> updateParcel(
      @Path('id') int id,
      @Body() ParcelUpdateRequest request,
      );

  @DELETE('${ApiConstants.parcelDelete}/{id}')
  Future<void> deleteParcel(@Path('id') int id);

  // ==================== PARCEL QUERIES ====================

  @GET(ApiConstants.parcelAll)
  Future<List<ParcelResponse>> getAllParcels();

  @GET('${ApiConstants.parcelById}/{id}')
  Future<ParcelResponse> getParcelById(@Path('id') int id);

  @GET('${ApiConstants.parcelByCode}/{code}')
  Future<ParcelResponse> getParcelByCode(@Path('code') String code);

  @GET('${ApiConstants.parcelsByStatus}/{status}')
  Future<List<ParcelResponse>> getParcelsByStatus(
      @Path('status') ParcelStatus status,
      );

  @GET('${ApiConstants.parcelsByTrip}/{tripId}')
  Future<List<ParcelResponse>> getParcelsByTrip(@Path('tripId') int tripId);

  @GET('${ApiConstants.parcelsByPhone}/{phone}')
  Future<List<ParcelResponse>> getParcelsByPhone(@Path('phone') String phone);

  // ==================== PARCEL STATUS MANAGEMENT ====================

  @POST('${ApiConstants.parcelMarkInTransit}/{id}/in-transit')
  Future<ParcelResponse> markAsInTransit(
      @Path('id') int id,
      @Query('tripId') int tripId,
      );

  @POST('${ApiConstants.parcelMarkDelivered}/{id}/delivered')
  Future<ParcelResponse> markAsDelivered(
      @Path('id') int id,
      @Query('otp') String otp,
      @Query('photoUrl') String? photoUrl,
      );

  @POST('${ApiConstants.parcelMarkFailed}/{id}/failed')
  Future<ParcelResponse> markAsFailed(
      @Path('id') int id,
      @Query('reason') String reason,
      );

  // ==================== PARCEL VALIDATION ====================

  @POST('${ApiConstants.parcelValidateOtp}/{id}/validate-otp')
  Future<bool> validateOtp(
      @Path('id') int id,
      @Query('otp') String otp,
      );
}