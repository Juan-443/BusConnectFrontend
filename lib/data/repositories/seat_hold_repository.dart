import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../core/errors/failures.dart';
import '../providers/seat_hold_api_provider.dart';
import '../models/seat_hold_model/seat_hold_model.dart';

class SeatHoldRepository {
  final SeatHoldApiProvider _apiProvider;

  SeatHoldRepository(this._apiProvider);

  // ==================== SEAT HOLD CRUD ====================

  Future<Either<Failure, SeatHoldResponse>> createSeatHold(
      SeatHoldCreateRequest request,
      ) async {
    try {
      final response = await _apiProvider.createSeatHold(request);
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  Future<Either<Failure, SeatHoldResponse>> updateSeatHold(
      int id,
      SeatHoldUpdateRequest request,
      ) async {
    try {
      final response = await _apiProvider.updateSeatHold(id, request);
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  Future<Either<Failure, void>> deleteSeatHold(int id) async {
    try {
      await _apiProvider.deleteSeatHold(id);
      return const Right(null);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  Future<Either<Failure, void>> releaseSeatHold(int id) async {
    try {
      await _apiProvider.releaseSeatHold(id);
      return const Right(null);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  // ==================== SEAT HOLD QUERIES ====================

  Future<Either<Failure, List<SeatHoldResponse>>> getMySeatHolds() async {
    try {
      final response = await _apiProvider.getMySeatHolds();
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  Future<Either<Failure, List<SeatHoldResponse>>> getAllSeatHolds() async {
    try {
      final response = await _apiProvider.getAllSeatHolds();
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  Future<Either<Failure, SeatHoldResponse>> getSeatHoldById(int id) async {
    try {
      final response = await _apiProvider.getSeatHoldById(id);
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  Future<Either<Failure, List<SeatHoldResponse>>> getSeatHoldsByTrip(
      int tripId,
      ) async {
    try {
      final response = await _apiProvider.getSeatHoldsByTrip(tripId);
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  Future<Either<Failure, List<SeatHoldResponse>>> getActiveSeatHoldsByTrip(
      int tripId,
      ) async {
    try {
      final response = await _apiProvider.getActiveSeatHoldsByTrip(tripId);
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  Future<Either<Failure, List<SeatHoldResponse>>> getSeatHoldsByUser(
      int userId,
      ) async {
    try {
      final response = await _apiProvider.getSeatHoldsByUser(userId);
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  // ==================== SEAT HOLD ACTIONS ====================

  Future<Either<Failure, void>> convertHoldToTicket(int id) async {
    try {
      await _apiProvider.convertHoldToTicket(id);
      return const Right(null);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  // ==================== SEAT HOLD VALIDATION ====================

  Future<Either<Failure, bool>> isSeatHeld(
      int tripId,
      String seatNumber,
      ) async {
    try {
      final response = await _apiProvider.isSeatHeld(tripId, seatNumber);
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