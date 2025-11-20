import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../../core/constants/enums/bus_status.dart';
import '../models/bus_model/bus_model.dart';
import '../providers/bus_api_provider.dart';
import 'package:dio/dio.dart';

class BusRepository {
  final BusApiProvider _apiProvider;

  BusRepository(this._apiProvider);

  // ==================== CRUD ====================

  Future<Either<Failure, BusResponse>> createBus(BusCreateRequest request) async {
    try {
      final result = await _apiProvider.createBus(request);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, BusResponse>> updateBus(
      int id,
      BusUpdateRequest request,
      ) async {
    try {
      final result = await _apiProvider.updateBus(id, request);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> deleteBus(int id) async {
    try {
      await _apiProvider.deleteBus(id);
      return const Right(null);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // ==================== QUERIES ====================

  Future<Either<Failure, List<BusResponse>>> getAllBuses() async {
    try {
      final result = await _apiProvider.getAllBuses();
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, BusResponse>> getBusById(int id) async {
    try {
      final result = await _apiProvider.getBusById(id);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, BusResponse>> getBusWithSeats(int id) async {
    try {
      final result = await _apiProvider.getBusWithSeats(id);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, BusResponse>> getBusByPlate(String plate) async {
    try {
      final result = await _apiProvider.getBusByPlate(plate);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<BusResponse>>> getBusesByStatus(BusStatus status) async {
    try {
      final result = await _apiProvider.getBusesByStatus(status);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<BusResponse>>> getAvailableBuses(int minCapacity) async {
    try {
      final result = await _apiProvider.getAvailableBuses(minCapacity);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // ==================== STATUS MANAGEMENT ====================

  Future<Either<Failure, BusResponse>> changeBusStatus(
      int id,
      BusStatus status,
      ) async {
    try {
      final result = await _apiProvider.changeBusStatus(id, status.toJson());
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // ==================== VALIDATION ====================

  Future<Either<Failure, bool>> existsByPlate(String plate) async {
    try {
      final result = await _apiProvider.existsByPlate(plate);
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