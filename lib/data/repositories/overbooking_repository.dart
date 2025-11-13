import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../models/overbooking_model/overbooking_model.dart';
import '../providers/overbooking_api_provider.dart';
import 'package:dio/dio.dart';

class OverbookingRepository {
  final OverbookingApiProvider _apiProvider;

  OverbookingRepository(this._apiProvider);

  // ==================== CRUD ====================

  Future<Either<Failure, OverbookingResponse>> requestOverbooking(
      OverbookingCreateRequest request,
      ) async {
    try {
      final result = await _apiProvider.requestOverbooking(request);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, OverbookingResponse>> approveOverbooking(
      int id,
      OverbookingApproveRequest request,
      ) async {
    try {
      final result = await _apiProvider.approveOverbooking(id, request);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, OverbookingResponse>> rejectOverbooking(
      int id,
      OverbookingRejectRequest request,
      ) async {
    try {
      final result = await _apiProvider.rejectOverbooking(id, request);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // ==================== QUERIES ====================

  Future<Either<Failure, List<OverbookingResponse>>> getPendingRequests() async {
    try {
      final result = await _apiProvider.getPendingRequests();
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<OverbookingResponse>>> getOverbookingRequestsByTrip(
      int tripId,
      ) async {
    try {
      final result = await _apiProvider.getOverbookingRequestsByTrip(tripId);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<OverbookingResponse>>> getOverbookingRequestsByStatus(
      String status,
      ) async {
    try {
      final result = await _apiProvider.getOverbookingRequestsByStatus(status);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, OverbookingResponse>> getOverbookingRequestById(
      int id,
      ) async {
    try {
      final result = await _apiProvider.getOverbookingRequestById(id);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // ==================== VALIDATION ====================

  Future<Either<Failure, bool>> canOverbook(int tripId) async {
    try {
      final result = await _apiProvider.canOverbook(tripId);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, double>> getCurrentOccupancyRate(int tripId) async {
    try {
      final result = await _apiProvider.getCurrentOccupancyRate(tripId);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> expirePendingRequests() async {
    try {
      await _apiProvider.expirePendingRequests();
      return const Right(null);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // ==================== HELPER ====================

  String _getErrorMessage(DioException error) {
    if (error.response?.data != null && error.response?.data is Map) {
      return error.response?.data['message'] ?? 'Error desconocido';
    }
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Tiempo de espera agotado';
      case DioExceptionType.badResponse:
        return 'Respuesta inválida del servidor';
      case DioExceptionType.cancel:
        return 'Solicitud cancelada';
      default:
        return 'Error de conexión';
    }
  }
}