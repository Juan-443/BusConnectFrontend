import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../core/errors/failures.dart';
import '../providers/baggage_api_provider.dart';
import '../models/baggage_model/baggage_model.dart';

class BaggageRepository {
  final BaggageApiProvider _apiProvider;

  BaggageRepository(this._apiProvider);

  // ==================== BAGGAGE CRUD ====================

  Future<Either<Failure, BaggageResponse>> createBaggage(
      BaggageCreateRequest request) async {
    try {
      final response = await _apiProvider.createBaggage(request);
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  Future<Either<Failure, BaggageResponse>> updateBaggage(
      int id, BaggageUpdateRequest request) async {
    try {
      final response = await _apiProvider.updateBaggage(id, request);
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  Future<Either<Failure, void>> deleteBaggage(int id) async {
    try {
      await _apiProvider.deleteBaggage(id);
      return const Right(null);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  // ==================== BAGGAGE QUERIES ====================

  Future<Either<Failure, List<BaggageResponse>>> getAllBaggage() async {
    try {
      final response = await _apiProvider.getAllBaggage();
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  Future<Either<Failure, BaggageResponse>> getBaggageById(int id) async {
    try {
      final response = await _apiProvider.getBaggageById(id);
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  Future<Either<Failure, BaggageResponse>> getBaggageByTagCode(
      String tagCode) async {
    try {
      final response = await _apiProvider.getBaggageByTagCode(tagCode);
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  Future<Either<Failure, List<BaggageResponse>>> getBaggageByTicket(
      int ticketId) async {
    try {
      final response = await _apiProvider.getBaggageByTicket(ticketId);
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  Future<Either<Failure, List<BaggageResponse>>> getBaggageByTrip(
      int tripId) async {
    try {
      final response = await _apiProvider.getBaggageByTrip(tripId);
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  // ==================== BAGGAGE CALCULATIONS ====================

  Future<Either<Failure, double>> getTotalWeightByTrip(int tripId) async {
    try {
      final response = await _apiProvider.getTotalWeightByTrip(tripId);
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  Future<Either<Failure, double>> calculateBaggageFee(double weightKg) async {
    try {
      final response = await _apiProvider.calculateBaggageFee(weightKg);
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  // ==================== ERROR HANDLER ====================

  Failure _handleError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return const NetworkFailure();
    }

    final message =
        e.response?.data['message'] ?? 'Error al procesar la solicitud';
    return ServerFailure(message);
  }
}