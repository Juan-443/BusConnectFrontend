import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../models/assignment_model/assignment_model.dart';
import '../providers/assignment_api_provider.dart';
import 'package:dio/dio.dart';

class AssignmentRepository {
  final AssignmentApiProvider _apiProvider;

  AssignmentRepository(this._apiProvider);

  // ==================== CRUD ====================

  Future<Either<Failure, AssignmentResponse>> createAssignment(
      AssignmentCreateRequest request,
      ) async {
    try {
      final result = await _apiProvider.createAssignment(request);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, AssignmentResponse>> updateAssignment(
      int id,
      AssignmentUpdateRequest request,
      ) async {
    try {
      final result = await _apiProvider.updateAssignment(id, request);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> deleteAssignment(int id) async {
    try {
      await _apiProvider.deleteAssignment(id);
      return const Right(null);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // ==================== QUERIES ====================

  Future<Either<Failure, List<AssignmentResponse>>> getAllAssignments() async {
    try {
      final result = await _apiProvider.getAllAssignments();
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, AssignmentResponse>> getAssignmentById(int id) async {
    try {
      final result = await _apiProvider.getAssignmentById(id);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, AssignmentResponse>> getAssignmentByTrip(int tripId) async {
    try {
      final result = await _apiProvider.getAssignmentByTrip(tripId);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, AssignmentModel>> getAssignmentWithDetails(int tripId) async {
    try {
      final result = await _apiProvider.getAssignmentWithDetails(tripId);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<AssignmentResponse>>> getAssignmentsByDriver(
      int driverId,
      ) async {
    try {
      final result = await _apiProvider.getAssignmentsByDriver(driverId);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<AssignmentResponse>>> getActiveAssignmentsByDriver(
      int driverId,
      ) async {
    try {
      final result = await _apiProvider.getActiveAssignmentsByDriver(driverId);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<AssignmentModel>>> getAssignmentsByDriverAndDate(
      int driverId,
      String date,
      ) async {
    try {
      final result = await _apiProvider.getAssignmentsByDriverAndDate(driverId, date);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<AssignmentResponse>>> getAssignmentsByDispatcher(
      int dispatcherId,
      ) async {
    try {
      final result = await _apiProvider.getAssignmentsByDispatcher(dispatcherId);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<AssignmentResponse>>> getAssignmentsByDateRange(
      String start,
      String end,
      ) async {
    try {
      final result = await _apiProvider.getAssignmentsByDateRange(start, end);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // ==================== ACTIONS ====================

  Future<Either<Failure, AssignmentResponse>> approveChecklist(int id) async {
    try {
      final result = await _apiProvider.approveChecklist(id);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // ==================== VALIDATION ====================

  Future<Either<Failure, bool>> hasActiveAssignment(int tripId) async {
    try {
      final result = await _apiProvider.hasActiveAssignment(tripId);
      return Right(result);
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