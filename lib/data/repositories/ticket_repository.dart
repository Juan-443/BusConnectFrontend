import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../core/errors/failures.dart';
import '../providers/ticket_api_provider.dart';
import '../models/ticket_model/ticket_model.dart';

class TicketRepository {
  final TicketApiProvider _apiProvider;

  TicketRepository(this._apiProvider);

  // ==================== TICKET CRUD ====================

  Future<Either<Failure, TicketResponse>> createTicket(
      TicketCreateRequest request,
      ) async {
    try {
      final response = await _apiProvider.createTicket(request);
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  Future<Either<Failure, TicketResponse>> updateTicket(
      int id,
      TicketUpdateRequest request,
      ) async {
    try {
      final response = await _apiProvider.updateTicket(id, request);
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  Future<Either<Failure, void>> deleteTicket(int id) async {
    try {
      await _apiProvider.deleteTicket(id);
      return const Right(null);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  Future<Either<Failure, TicketResponse>> cancelTicket(int id) async {
    try {
      final response = await _apiProvider.cancelTicket(id);
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  // ==================== TICKET QUERIES ====================

  Future<Either<Failure, List<TicketResponse>>> getMyTickets() async {
    try {
      final response = await _apiProvider.getMyTickets();
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  Future<Either<Failure, List<TicketResponse>>> getAllTickets() async {
    try {
      final response = await _apiProvider.getAllTickets();
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  Future<Either<Failure, TicketResponse>> getTicketById(int id) async {
    try {
      final response = await _apiProvider.getTicketById(id);
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  Future<Either<Failure, TicketResponse>> getTicketWithDetails(int id) async {
    try {
      final response = await _apiProvider.getTicketWithDetails(id);
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  Future<Either<Failure, TicketResponse>> getTicketByQrCode(
      String qrCode,
      ) async {
    try {
      final response = await _apiProvider.getTicketByQrCode(qrCode);
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  Future<Either<Failure, List<TicketResponse>>> getTicketsByTrip(
      int tripId,
      ) async {
    try {
      final response = await _apiProvider.getTicketsByTrip(tripId);
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  Future<Either<Failure, List<TicketResponse>>> getTicketsByPassenger(
      int passengerId,
      ) async {
    try {
      final response = await _apiProvider.getTicketsByPassenger(passengerId);
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  // ==================== TICKET ACTIONS ====================

  Future<Either<Failure, TicketResponse>> markAsUsed(int id) async {
    try {
      final response = await _apiProvider.markAsUsed(id);
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  Future<Either<Failure, TicketResponse>> markAsNoShow(int id) async {
    try {
      final response = await _apiProvider.markAsNoShow(id);
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  // ==================== TICKET VALIDATION ====================

  Future<Either<Failure, bool>> isSeatAvailable(
      int tripId,
      String seatNumber,
      ) async {
    try {
      final response = await _apiProvider.isSeatAvailable(tripId, seatNumber);
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  Future<Either<Failure, int>> countSoldTicketsByTrip(int tripId) async {
    try {
      final response = await _apiProvider.countSoldTicketsByTrip(tripId);
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