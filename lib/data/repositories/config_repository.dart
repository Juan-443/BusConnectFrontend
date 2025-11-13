import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../models/config_model/config_model.dart';
import '../providers/config_api_provider.dart';
import 'package:dio/dio.dart';

class ConfigRepository {
  final ConfigApiProvider _apiProvider;

  ConfigRepository(this._apiProvider);

  // ==================== CRUD ====================

  Future<Either<Failure, ConfigResponse>> createConfig(ConfigCreateRequest request) async {
    try {
      final result = await _apiProvider.createConfig(request);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, ConfigResponse>> updateConfig(
      int id,
      ConfigUpdateRequest request,
      ) async {
    try {
      final result = await _apiProvider.updateConfig(id, request);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> deleteConfig(int id) async {
    try {
      await _apiProvider.deleteConfig(id);
      return const Right(null);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> deleteConfigByKey(String key) async {
    try {
      await _apiProvider.deleteConfigByKey(key);
      return const Right(null);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // ==================== QUERIES ====================

  Future<Either<Failure, List<ConfigResponse>>> getAllConfigs() async {
    try {
      final result = await _apiProvider.getAllConfigs();
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, ConfigResponse>> getConfigById(int id) async {
    try {
      final result = await _apiProvider.getConfigById(id);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, ConfigResponse>> getConfigByKey(String key) async {
    try {
      final result = await _apiProvider.getConfigByKey(key);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // ==================== CONFIG VALUES ====================

  Future<Either<Failure, String>> getConfigValue(
      String key, {
        String? defaultValue,
      }) async {
    try {
      final result = await _apiProvider.getConfigValue(key, defaultValue);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, int>> getConfigValueAsInt(
      String key, {
        int? defaultValue,
      }) async {
    try {
      final result = await _apiProvider.getConfigValueAsInt(key, defaultValue);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, double>> getConfigValueAsDouble(
      String key, {
        double? defaultValue,
      }) async {
    try {
      final result = await _apiProvider.getConfigValueAsDouble(key, defaultValue);
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