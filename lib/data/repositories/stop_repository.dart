import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../models/stop_model/stop_model.dart';
import '../providers/stop_api_provider.dart';
import 'package:dio/dio.dart';

class StopRepository {
  final StopApiProvider _apiProvider;

  StopRepository(this._apiProvider);

  // ==================== CRUD ====================

  Future<Either<Failure, StopResponse>> createStop(StopCreateRequest request) async {
    try {
      final result = await _apiProvider.createStop(request);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, StopResponse>> updateStop(
      int id,
      StopUpdateRequest request,
      ) async {
    try {
      final result = await _apiProvider.updateStop(id, request);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> deleteStop(int id) async {
    try {
      await _apiProvider.deleteStop(id);
      return const Right(null);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // ==================== QUERIES ====================

  Future<Either<Failure, List<StopResponse>>> getAllStops() async {
    try {
      final result = await _apiProvider.getAllStops();
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, StopResponse>> getStopById(int id) async {
    try {
      final result = await _apiProvider.getStopById(id);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<StopResponse>>> getStopsByRoute(int routeId) async {
    try {
      final result = await _apiProvider.getStopsByRoute(routeId);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<StopResponse>>> searchStopsByName(String name) async {
    try {
      final result = await _apiProvider.searchStopsByName(name);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

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