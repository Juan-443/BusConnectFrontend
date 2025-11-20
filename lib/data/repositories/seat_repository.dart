import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../models/seat_model/seat_model.dart';
import '../providers/seat_api_provider.dart';

class SeatRepository {
  final SeatApiProvider _apiProvider;

  SeatRepository(this._apiProvider);

  Future<Either<Failure, List<SeatResponse>>> getAllSeats() async {
    try {
      final seats = await _apiProvider.getAllSeats();
      return Right(seats);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, SeatResponse>> getSeatById(int id) async {
    try {
      final seat = await _apiProvider.getSeatById(id);
      return Right(seat);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<SeatResponse>>> getSeatsByBus(int busId) async {
    try {
      final seats = await _apiProvider.getSeatsByBus(busId);
      return Right(seats);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, SeatResponse>> createSeat(SeatCreateRequest request) async {
    try {
      final seat = await _apiProvider.createSeat(request);
      return Right(seat);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, SeatResponse>> updateSeat(
      int id,
      SeatUpdateRequest request,
      ) async {
    try {
      final seat = await _apiProvider.updateSeat(id, request);
      return Right(seat);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> deleteSeat(int id) async {
    try {
      await _apiProvider.deleteSeat(id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}