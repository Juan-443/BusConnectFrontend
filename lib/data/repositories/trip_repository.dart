import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../core/errors/failures.dart';
import '../../core/constants/enums/trip_status.dart';
import '../providers/trip_api_provider.dart';
import '../models/trip_model/trip_model.dart';

class TripRepository {
  final TripApiProvider _apiProvider;

  TripRepository(this._apiProvider);

  Future<Either<Failure, List<TripResponse>>> searchTrips({
    int? routeId,
    String? date,
    TripStatus? status,
  }) async {
    try {
      final response = await _apiProvider.searchTrips(
        routeId: routeId,
        date: date,
        status: status,
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  Future<Either<Failure, TripResponse>> getTripById(int id) async {
    try {
      final response = await _apiProvider.getTripById(id);
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  Future<Either<Failure, TripResponse>> getTripWithDetails(int id) async {
    try {
      final response = await _apiProvider.getTripWithDetails(id);
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  Future<Either<Failure, List<TripResponse>>> getTodayTrips() async {
    try {
      final response = await _apiProvider.getTodayTrips();
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  Future<Either<Failure, List<TripResponse>>> getTripsByRouteAndDate(
      int routeId,
      String date,
      ) async {
    try {
      final response = await _apiProvider.getTripsByRouteAndDate(routeId, date);
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  Future<Either<Failure, TripResponse>> createTrip(
      TripCreateRequest request,
      ) async {
    try {
      final response = await _apiProvider.createTrip(request);
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  Future<Either<Failure, TripResponse>> updateTrip(
      int id,
      TripUpdateRequest request,
      ) async {
    try {
      final response = await _apiProvider.updateTrip(id, request);
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  Future<Either<Failure, TripResponse>> changeTripStatus(
      int id,
      TripStatus status,
      ) async {
    try {
      final response = await _apiProvider.changeTripStatus(id, status);
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  Future<Either<Failure, TripResponse>> openBoarding(int id) async {
    try {
      final response = await _apiProvider.openBoarding(id);
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  Future<Either<Failure, TripResponse>> closeBoarding(int id) async {
    try {
      final response = await _apiProvider.closeBoarding(id);
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  Future<Either<Failure, TripResponse>> markAsDeparted(int id) async {
    try {
      final response = await _apiProvider.markAsDeparted(id);
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  Future<Either<Failure, TripResponse>> markAsArrived(int id) async {
    try {
      final response = await _apiProvider.markAsArrived(id);
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  Future<Either<Failure, TripResponse>> cancelTrip(int id) async {
    try {
      final response = await _apiProvider.cancelTrip(id);
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  Future<Either<Failure, void>> deleteTrip(int id) async {
    try {
      await _apiProvider.deleteTrip(id);
      return const Right(null);
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