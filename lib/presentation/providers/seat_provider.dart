import 'package:bus_connect/core/network/api_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/seat_model/seat_model.dart';
import '../../data/providers/seat_api_provider.dart';
import '../../data/repositories/seat_repository.dart';
import 'package:bus_connect/app.dart';

class SeatState {
  final List<SeatResponse> seats;
  final SeatResponse? selectedSeat;
  final bool isLoading;
  final String? error;
  final int? filterBusId;

  const SeatState({
    this.seats = const [],
    this.selectedSeat,
    this.isLoading = false,
    this.error,
    this.filterBusId,
  });

  SeatState copyWith({
    List<SeatResponse>? seats,
    SeatResponse? selectedSeat,
    bool? isLoading,
    String? error,
    int? filterBusId,
  }) {
    return SeatState(
      seats: seats ?? this.seats,
      selectedSeat: selectedSeat ?? this.selectedSeat,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      filterBusId: filterBusId ?? this.filterBusId,
    );
  }

  List<SeatResponse> get filteredSeats {
    if (filterBusId == null) return seats;
    return seats.where((s) => s.busId == filterBusId).toList();
  }
}

class SeatNotifier extends StateNotifier<SeatState> {
  final SeatRepository _repository;

  SeatNotifier(this._repository) : super(const SeatState());

  Future<void> fetchAllSeats() async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await _repository.getAllSeats();
    result.fold(
          (failure) => state = state.copyWith(isLoading: false, error: failure.message),
          (seats) => state = state.copyWith(seats: seats, isLoading: false),
    );
  }

  Future<void> fetchSeatById(int id) async {
    state = state.copyWith(isLoading: true);
    final result = await _repository.getSeatById(id);
    result.fold(
          (failure) => state = state.copyWith(isLoading: false, error: failure.message),
          (seat) => state = state.copyWith(selectedSeat: seat, isLoading: false),
    );
  }

  Future<void> fetchSeatsByBus(int busId) async {
    state = state.copyWith(isLoading: true);
    final result = await _repository.getSeatsByBus(busId);
    result.fold(
          (failure) => state = state.copyWith(isLoading: false, error: failure.message),
          (seats) => state = state.copyWith(seats: seats, isLoading: false),
    );
  }

  Future<bool> createSeat(SeatCreateRequest request) async {
    state = state.copyWith(isLoading: true);
    final result = await _repository.createSeat(request);
    return result.fold(
          (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
      },
          (seat) {
        state = state.copyWith(isLoading: false, seats: [...state.seats, seat]);
        return true;
      },
    );
  }

  Future<bool> updateSeat(int id, SeatUpdateRequest request) async {
    state = state.copyWith(isLoading: true);
    final result = await _repository.updateSeat(id, request);
    return result.fold(
          (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
      },
          (seat) {
        final updated = state.seats.map((s) => s.id == id ? seat : s).toList();
        state = state.copyWith(isLoading: false, seats: updated, selectedSeat: seat);
        return true;
      },
    );
  }

  Future<bool> deleteSeat(int id) async {
    state = state.copyWith(isLoading: true);
    final result = await _repository.deleteSeat(id);
    return result.fold(
          (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
      },
          (_) {
        final updated = state.seats.where((s) => s.id != id).toList();
        state = state.copyWith(isLoading: false, seats: updated);
        return true;
      },
    );
  }

  void setBusFilter(int? busId) {
    state = state.copyWith(filterBusId: busId);
  }

  void clearSelectedSeat() {
    state = state.copyWith(selectedSeat: null);
  }
}

final seatProvider = StateNotifierProvider<SeatNotifier, SeatState>((ref) {
  final repository = ref.watch(seatRepositoryProvider);
  return SeatNotifier(repository);
});