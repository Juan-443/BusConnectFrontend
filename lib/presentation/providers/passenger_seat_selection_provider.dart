import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/seat_model/seat_model.dart';
import 'package:bus_connect/app.dart';

/// ==================== SELECTION STATE ====================
final selectedTripIdProvider = StateProvider<int?>((ref) => null);
final selectedSeatProvider = StateProvider<String?>((ref) => null);
final selectedFromStopProvider = StateProvider<int?>((ref) => null);
final selectedToStopProvider = StateProvider<int?>((ref) => null);


final tripSeatsProvider = FutureProvider.autoDispose.family<List<SeatResponse>, int>((ref, busId) async {
  final seatRepo = ref.read(seatRepositoryProvider);
  final result = await seatRepo.getSeatsByBus(busId);

  return result.fold(
        (failure) => throw Exception(failure.message),
        (seats) => seats,
  );
});

final occupiedSeatsProvider = FutureProvider.autoDispose.family<List<String>, int>((ref, tripId) async {
  final ticketRepo = ref.read(ticketRepositoryProvider);
  final result = await ticketRepo.getTicketsByTrip(tripId);

  return result.fold(
        (failure) => throw Exception(failure.message),
        (tickets) => tickets.map((t) => t.seatNumber).toList(),
  );
});

final seatAvailabilityProvider = FutureProvider.autoDispose.family<bool, SeatCheckParams>((ref, params) async {
  final ticketRepo = ref.read(ticketRepositoryProvider);
  final result = await ticketRepo.isSeatAvailable(params.tripId, params.seatNumber);

  return result.fold(
        (failure) => throw Exception(failure.message),
        (isAvailable) => isAvailable,
  );
});

final seatInfoProvider = FutureProvider.autoDispose.family<SeatInfo, SeatInfoParams>((ref, params) async {
  // Obtener asientos del bus
  final seatsAsync = await ref.watch(tripSeatsProvider(params.busId).future);

  // Obtener asientos ocupados
  final occupiedAsync = await ref.watch(occupiedSeatsProvider(params.tripId).future);

  // Encontrar el asiento específico
  final seat = seatsAsync.firstWhere(
        (s) => s.number == params.seatNumber,
    orElse: () => throw Exception('Asiento no encontrado'),
  );

  return SeatInfo(
    seat: seat,
    isOccupied: occupiedAsync.contains(params.seatNumber),
  );
});

/// ==================== HELPER CLASSES ====================

class SeatCheckParams {
  final int tripId;
  final String seatNumber;

  SeatCheckParams({
    required this.tripId,
    required this.seatNumber,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is SeatCheckParams &&
              runtimeType == other.runtimeType &&
              tripId == other.tripId &&
              seatNumber == other.seatNumber;

  @override
  int get hashCode => tripId.hashCode ^ seatNumber.hashCode;
}

class SeatInfoParams {
  final int tripId;
  final int busId;
  final String seatNumber;

  SeatInfoParams({
    required this.tripId,
    required this.busId,
    required this.seatNumber,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is SeatInfoParams &&
              runtimeType == other.runtimeType &&
              tripId == other.tripId &&
              busId == other.busId &&
              seatNumber == other.seatNumber;

  @override
  int get hashCode => tripId.hashCode ^ busId.hashCode ^ seatNumber.hashCode;
}

class SeatInfo {
  final SeatResponse seat;
  final bool isOccupied;

  SeatInfo({
    required this.seat,
    required this.isOccupied,
  });

  bool get isAvailable => !isOccupied;
}