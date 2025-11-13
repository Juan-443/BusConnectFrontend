import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../core/errors/failures.dart';
import '../providers/ticket_api_provider.dart';
import '../models/ticket_model/ticket_model.dart';

class TicketRepository {
  final TicketApiProvider _apiProvider;

  TicketRepository(this._apiProvider);

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

  Future<Either<Failure, List<TicketResponse>>> getMyTickets() async {
    try {
      final response = await _apiProvider.getMyTickets();
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

  Future<Either<Failure, TicketResponse>> cancelTicket(int id) async {
    try {
      final response = await _apiProvider.cancelTicket(id);
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  Future<Either<Failure, TicketResponse>> markAsUsed(int id) async {
    try {
      final response = await _apiProvider.markAsUsed(id);
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

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

  Failure _handleError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return const NetworkFailure();
    }

    final message = e.response?.data['message'] ?? 'Error al procesar la solicitud';
    return ServerFailure(message);
  }
}