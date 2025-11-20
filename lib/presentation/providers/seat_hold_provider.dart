import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/seat_hold_repository.dart';
import '../../data/models/seat_hold_model/seat_hold_model.dart';
import '../../core/constants/enums/hold_status.dart';
import 'package:bus_connect/app.dart';

/// ==================== STATE ====================
class SeatHoldState {
  final List<SeatHoldResponse> holds;
  final SeatHoldResponse? selectedHold;
  final bool isLoading;
  final String? error;
  final HoldStatus? filterStatus;

  const SeatHoldState({
    this.holds = const [],
    this.selectedHold,
    this.isLoading = false,
    this.error,
    this.filterStatus,
  });

  SeatHoldState copyWith({
    List<SeatHoldResponse>? holds,
    SeatHoldResponse? selectedHold,
    bool? isLoading,
    String? error,
    HoldStatus? filterStatus,
  }) {
    return SeatHoldState(
      holds: holds ?? this.holds,
      selectedHold: selectedHold ?? this.selectedHold,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      filterStatus: filterStatus ?? this.filterStatus,
    );
  }

  bool get hasError => error != null && error!.isNotEmpty;
  bool get hasHolds => holds.isNotEmpty;
}

/// ==================== NOTIFIER ====================
class SeatHoldNotifier extends StateNotifier<SeatHoldState> {
  final SeatHoldRepository _repository;

  SeatHoldNotifier(this._repository) : super(const SeatHoldState());

  Future<void> loadMyHolds() async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _repository.getMySeatHolds();

    result.fold(
          (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.message,
      ),
          (holds) => state = state.copyWith(
        holds: holds,
        isLoading: false,
        error: null,
      ),
    );
  }

  Future<void> loadAllHolds() async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _repository.getAllSeatHolds();

    result.fold(
          (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.message,
      ),
          (holds) => state = state.copyWith(
        holds: holds,
        isLoading: false,
        error: null,
      ),
    );
  }

  Future<void> loadHoldsByTrip(int tripId) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _repository.getSeatHoldsByTrip(tripId);

    result.fold(
          (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.message,
      ),
          (holds) => state = state.copyWith(
        holds: holds,
        isLoading: false,
        error: null,
      ),
    );
  }

  Future<void> loadActiveHoldsByTrip(int tripId) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _repository.getActiveSeatHoldsByTrip(tripId);

    result.fold(
          (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.message,
      ),
          (holds) => state = state.copyWith(
        holds: holds,
        isLoading: false,
        error: null,
      ),
    );
  }

  Future<void> loadHoldById(int id) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _repository.getSeatHoldById(id);

    result.fold(
          (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.message,
      ),
          (hold) => state = state.copyWith(
        selectedHold: hold,
        isLoading: false,
        error: null,
      ),
    );
  }

  Future<bool> createSeatHold(SeatHoldCreateRequest request) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _repository.createSeatHold(request);

    return result.fold(
          (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
      },
          (hold) {
        final updatedHolds = [...state.holds, hold];
        state = state.copyWith(
          holds: updatedHolds,
          isLoading: false,
          error: null,
        );
        return true;
      },
    );
  }

  Future<bool> updateSeatHold(int id, SeatHoldUpdateRequest request) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _repository.updateSeatHold(id, request);

    return result.fold(
          (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
      },
          (updatedHold) {
        final updatedHolds = state.holds.map((h) {
          return h.id == id ? updatedHold : h;
        }).toList();

        state = state.copyWith(
          holds: updatedHolds,
          selectedHold: updatedHold,
          isLoading: false,
          error: null,
        );
        return true;
      },
    );
  }

  Future<bool> releaseSeatHold(int id) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _repository.releaseSeatHold(id);

    return result.fold(
          (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
      },
          (_) {
        final updatedHolds = state.holds.where((h) => h.id != id).toList();
        state = state.copyWith(
          holds: updatedHolds,
          isLoading: false,
          error: null,
        );
        return true;
      },
    );
  }

  Future<bool> deleteSeatHold(int id) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _repository.deleteSeatHold(id);

    return result.fold(
          (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
      },
          (_) {
        final updatedHolds = state.holds.where((h) => h.id != id).toList();
        state = state.copyWith(
          holds: updatedHolds,
          isLoading: false,
          error: null,
        );
        return true;
      },
    );
  }

  Future<bool> convertHoldToTicket(int id) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _repository.convertHoldToTicket(id);

    return result.fold(
          (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
      },
          (_) {
        final updatedHolds = state.holds.where((h) => h.id != id).toList();
        state = state.copyWith(
          holds: updatedHolds,
          isLoading: false,
          error: null,
        );
        return true;
      },
    );
  }

  Future<bool> checkIfSeatHeld(int tripId, String seatNumber) async {
    final result = await _repository.isSeatHeld(tripId, seatNumber);

    return result.fold(
          (failure) {
        state = state.copyWith(error: failure.message);
        return false;
      },
          (isHeld) => isHeld,
    );
  }

  void filterByStatus(HoldStatus? status) {
    state = state.copyWith(filterStatus: status);
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  void clearState() {
    state = const SeatHoldState();
  }

  void clearSelectedHold() {
    state = state.copyWith(selectedHold: null);
  }
}

/// ==================== PROVIDERS ====================

final seatHoldProvider =
StateNotifierProvider<SeatHoldNotifier, SeatHoldState>((ref) {
  final repository = ref.watch(seatHoldRepositoryProvider);
  return SeatHoldNotifier(repository);
});

final seatHoldDetailProvider =
FutureProvider.family<SeatHoldResponse, int>((ref, id) async {
  final repository = ref.watch(seatHoldRepositoryProvider);
  final result = await repository.getSeatHoldById(id);

  return result.fold(
        (failure) => throw Exception(failure.message),
        (hold) => hold,
  );
});