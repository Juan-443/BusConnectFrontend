import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../core/errors/failures.dart';
import '../providers/parcel_api_provider.dart';
import '../models/parcel_model/parcel_model.dart';

class ParcelRepository {
  final ParcelApiProvider _apiProvider;

  ParcelRepository(this._apiProvider);

  Future<Either<Failure, ParcelResponse>> createParcel(
      ParcelCreateRequest request,
      ) async {
    try {
      final response = await _apiProvider.createParcel(request);
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  Future<Either<Failure, List<ParcelResponse>>> getAllParcels() async {
    try {
      final response = await _apiProvider.getAllParcels();
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  Future<Either<Failure, ParcelResponse>> getParcelById(int id) async {
    try {
      final response = await _apiProvider.getParcelById(id);
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  Future<Either<Failure, ParcelResponse>> getParcelByCode(String code) async {
    try {
      final response = await _apiProvider.getParcelByCode(code);
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  Future<Either<Failure, List<ParcelResponse>>> getParcelsByPhone(
      String phone,
      ) async {
    try {
      final response = await _apiProvider.getParcelsByPhone(phone);
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  Future<Either<Failure, ParcelResponse>> markAsInTransit(
      int id,
      int tripId,
      ) async {
    try {
      final response = await _apiProvider.markAsInTransit(id, tripId);
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  Future<Either<Failure, ParcelResponse>> markAsDelivered(
      int id,
      String otp,
      String? photoUrl,
      ) async {
    try {
      final response = await _apiProvider.markAsDelivered(id, otp, photoUrl);
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  Future<Either<Failure, bool>> validateOtp(int id, String otp) async {
    try {
      final response = await _apiProvider.validateOtp(id, otp);
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  Failure _handleError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return const NetworkFailure();
    }

    final message = e.response?.data['message'] ?? 'Error al procesar la solicitud';
    return ServerFailure(message);
  }
}