import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../models/route_model/route_model.dart';
import '../models/stop_model/stop_model.dart';
import '../providers/route_api_provider.dart';
import 'package:dio/dio.dart';

class RouteRepository {
  final RouteApiProvider _apiProvider;

  RouteRepository(this._apiProvider);

  // ==================== CRUD ====================

  Future<Either<Failure, RouteResponse>> createRoute(RouteCreateRequest request) async {
    try {
      final result = await _apiProvider.createRoute(request);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, RouteResponse>> updateRoute(
      int id,
      RouteUpdateRequest request,
      ) async {
    try {
      final result = await _apiProvider.updateRoute(id, request);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> deleteRoute(int id) async {
    try {
      await _apiProvider.deleteRoute(id);
      return const Right(null);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // ==================== QUERIES ====================

  Future<Either<Failure, List<RouteResponse>>> getAllRoutes() async {
    try {
      final result = await _apiProvider.getAllRoutes();
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, RouteResponse>> getRouteById(int id) async {
    try {
      final result = await _apiProvider.getRouteById(id);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, RouteResponse>> getRouteWithStops(int id) async {
    try {
      final result = await _apiProvider.getRouteWithStops(id);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<StopResponse>>> getRouteStops(int id) async {
    try {
      final result = await _apiProvider.getRouteStops(id);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, RouteResponse>> getRouteByCode(String code) async {
    try {
      final result = await _apiProvider.getRouteByCode(code);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<RouteResponse>>> searchRoutes({
    String? origin,
    String? destination,
  }) async {
    try {
      final result = await _apiProvider.searchRoutes(
        origin: origin,
        destination: destination,
      );
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // ==================== VALIDATION ====================

  Future<Either<Failure, bool>> existsByCode(String code) async {
    try {
      final result = await _apiProvider.existsByCode(code);
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