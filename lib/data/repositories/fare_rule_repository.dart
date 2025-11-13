import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../models/fare_rule_model/fare_rule_model.dart';
import '../providers/fare_rule_api_provider.dart';
import 'package:dio/dio.dart';

class FareRuleRepository {
  final FareRuleApiProvider _apiProvider;

  FareRuleRepository(this._apiProvider);

  // ==================== CRUD ====================

  Future<Either<Failure, FareRuleResponse>> createFareRule(
      FareRuleCreateRequest request,
      ) async {
    try {
      final result = await _apiProvider.createFareRule(request);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, FareRuleResponse>> updateFareRule(
      int id,
      FareRuleUpdateRequest request,
      ) async {
    try {
      final result = await _apiProvider.updateFareRule(id, request);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> deleteFareRule(int id) async {
    try {
      await _apiProvider.deleteFareRule(id);
      return const Right(null);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // ==================== QUERIES ====================

  Future<Either<Failure, List<FareRuleResponse>>> getAllFareRules() async {
    try {
      final result = await _apiProvider.getAllFareRules();
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, FareRuleResponse>> getFareRuleById(int id) async {
    try {
      final result = await _apiProvider.getFareRuleById(id);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<FareRuleResponse>>> getFareRulesByRoute(
      int routeId,
      ) async {
    try {
      final result = await _apiProvider.getFareRulesByRoute(routeId);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, FareRuleResponse>> getFareRuleForSegment({
    required int routeId,
    required int fromStopId,
    required int toStopId,
  }) async {
    try {
      final result = await _apiProvider.getFareRuleForSegment(
        routeId,
        fromStopId,
        toStopId,
      );
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<FareRuleResponse>>> getDynamicPricingRules(
      int routeId,
      ) async {
    try {
      final result = await _apiProvider.getDynamicPricingRules(routeId);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // ==================== CALCULATIONS ====================

  Future<Either<Failure, double>> calculateDynamicPrice(
      int id,
      double occupancyRate,
      ) async {
    try {
      final result = await _apiProvider.calculateDynamicPrice(id, occupancyRate);
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