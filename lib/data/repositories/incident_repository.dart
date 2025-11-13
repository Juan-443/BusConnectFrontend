import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../../core/constants/enums/entity_type.dart';
import '../../core/constants/enums/incident_type.dart';
import '../models/incident_model/incident_model.dart';
import '../providers/incident_api_provider.dart';
import 'package:dio/dio.dart';

class IncidentRepository {
  final IncidentApiProvider _apiProvider;

  IncidentRepository(this._apiProvider);

  // ==================== CRUD ====================

  Future<Either<Failure, IncidentResponse>> createIncident(
      IncidentCreateRequest request,
      ) async {
    try {
      final result = await _apiProvider.createIncident(request);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, IncidentResponse>> updateIncident(
      int id,
      IncidentUpdateRequest request,
      ) async {
    try {
      final result = await _apiProvider.updateIncident(id, request);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> deleteIncident(int id) async {
    try {
      await _apiProvider.deleteIncident(id);
      return const Right(null);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // ==================== QUERIES ====================

  Future<Either<Failure, List<IncidentResponse>>> getAllIncidents() async {
    try {
      final result = await _apiProvider.getAllIncidents();
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, IncidentResponse>> getIncidentById(int id) async {
    try {
      final result = await _apiProvider.getIncidentById(id);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<IncidentResponse>>> getIncidentsByEntity(
      EntityType entityType,
      int entityId,
      ) async {
    try {
      final result = await _apiProvider.getIncidentsByEntity(entityType, entityId);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<IncidentResponse>>> getIncidentsByType(
      IncidentType type,
      ) async {
    try {
      final result = await _apiProvider.getIncidentsByType(type);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<IncidentResponse>>> getIncidentsByReportedBy(
      int reportedById,
      ) async {
    try {
      final result = await _apiProvider.getIncidentsByReportedBy(reportedById);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<IncidentResponse>>> getIncidentsByDateRange(
      String start,
      String end,
      ) async {
    try {
      final result = await _apiProvider.getIncidentsByDateRange(start, end);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, int>> countIncidentsByType(
      IncidentType type,
      String since,
      ) async {
    try {
      final result = await _apiProvider.countIncidentsByType(type, since);
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