import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/bus_model/bus_model.dart';
import '../../data/repositories/bus_repository.dart';
import '../../core/constants/enums/bus_status.dart';
import 'package:bus_connect/app.dart';
/// ==================== STATE ====================

class BusState {
  final List<BusResponse> buses;
  final BusResponse? selectedBus;
  final bool isLoading;
  final String? error;
  final BusStatus? filterStatus;

  const BusState({
    this.buses = const [],
    this.selectedBus,
    this.isLoading = false,
    this.error,
    this.filterStatus,
  });

  BusState copyWith({
    List<BusResponse>? buses,
    BusResponse? selectedBus,
    bool? isLoading,
    String? error,
    BusStatus? filterStatus,
    bool clearFilter = false,
    bool clearSelectedBus = false,
  }) {
    return BusState(
      buses: buses ?? this.buses,
      selectedBus: selectedBus ?? this.selectedBus,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      filterStatus: clearFilter ? null : (filterStatus ?? this.filterStatus),
    );
  }

  List<BusResponse> get filteredBuses {
    if (filterStatus == null) return buses;
    return buses.where((b) => b.status == filterStatus).toList();
  }

  List<BusResponse> get availableBuses {
    return buses.where((b) => b.status == BusStatus.ACTIVE).toList();
  }
}

/// ==================== NOTIFIER ====================

class BusNotifier extends StateNotifier<BusState> {
  final BusRepository _repository;

  BusNotifier(this._repository) : super(const BusState());

  /// --- Fetch All
  Future<void> fetchAllBuses() async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _repository.getAllBuses();
    result.fold(
          (failure) =>
      state = state.copyWith(isLoading: false, error: failure.message),
          (buses) => state = state.copyWith(buses: buses, isLoading: false),
    );
  }

  /// --- Fetch by ID
  Future<void> fetchBusById(int id) async {
    state = state.copyWith(isLoading: true);
    final result = await _repository.getBusById(id);
    result.fold(
          (failure) =>
      state = state.copyWith(isLoading: false, error: failure.message),
          (bus) => state = state.copyWith(selectedBus: bus, isLoading: false),
    );
  }

  /// --- Fetch with Seats
  Future<void> fetchBusWithSeats(int id) async {
    state = state.copyWith(isLoading: true);
    final result = await _repository.getBusWithSeats(id);
    result.fold(
          (failure) =>
      state = state.copyWith(isLoading: false, error: failure.message),
          (bus) => state = state.copyWith(selectedBus: bus, isLoading: false),
    );
  }

  /// --- Fetch by Plate
  Future<void> fetchBusByPlate(String plate) async {
    state = state.copyWith(isLoading: true);
    final result = await _repository.getBusByPlate(plate);
    result.fold(
          (failure) =>
      state = state.copyWith(isLoading: false, error: failure.message),
          (bus) => state = state.copyWith(selectedBus: bus, isLoading: false),
    );
  }

  /// --- Fetch by Status
  Future<void> fetchBusesByStatus(BusStatus status) async {
    state = state.copyWith(isLoading: true);
    final result = await _repository.getBusesByStatus(status);
    result.fold(
          (failure) =>
      state = state.copyWith(isLoading: false, error: failure.message),
          (buses) => state = state.copyWith(buses: buses, isLoading: false),
    );
  }

  /// --- Fetch Available
  Future<void> fetchAvailableBuses({int minCapacity = 1}) async {
    state = state.copyWith(isLoading: true);
    final result = await _repository.getAvailableBuses(minCapacity);
    result.fold(
          (failure) =>
      state = state.copyWith(isLoading: false, error: failure.message),
          (buses) => state = state.copyWith(buses: buses, isLoading: false),
    );
  }

  /// --- CRUD: Create
  Future<bool> createBus(BusCreateRequest request) async {
    state = state.copyWith(isLoading: true);
    final result = await _repository.createBus(request);
    return result.fold(
          (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
      },
          (bus) {
        state = state.copyWith(
          isLoading: false,
          buses: [...state.buses, bus],
        );
        return true;
      },
    );
  }

  /// --- CRUD: Update
  Future<bool> updateBus(int id, BusUpdateRequest request) async {
    state = state.copyWith(isLoading: true);
    final result = await _repository.updateBus(id, request);
    return result.fold(
          (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
      },
          (bus) {
        final updated = state.buses.map((b) => b.id == id ? bus : b).toList();
        state =
            state.copyWith(isLoading: false, buses: updated, selectedBus: bus);
        return true;
      },
    );
  }

  /// --- CRUD: Delete
  Future<bool> deleteBus(int id) async {
    state = state.copyWith(isLoading: true);
    final result = await _repository.deleteBus(id);
    return result.fold(
          (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
      },
          (_) {
        final updated = state.buses.where((b) => b.id != id).toList();
        state = state.copyWith(isLoading: false, buses: updated);
        return true;
      },
    );
  }

  /// --- Change Status
  Future<bool> changeBusStatus(int id, BusStatus status) async {
    state = state.copyWith(isLoading: true);
    final result = await _repository.changeBusStatus(id, status);
    return result.fold(
          (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
      },
          (bus) {
        final updated = state.buses.map((b) => b.id == id ? bus : b).toList();
        state =
            state.copyWith(isLoading: false, buses: updated, selectedBus: bus);
        return true;
      },
    );
  }

  /// --- Validation
  Future<bool> checkPlateExists(String plate) async {
    final result = await _repository.existsByPlate(plate);
    return result.fold((_) => false, (exists) => exists);
  }

  /// --- Filters
  void setStatusFilter(BusStatus? status) {
    if (status == null) {
      state = state.copyWith(clearFilter: true);
    } else {
      state = state.copyWith(filterStatus: status);
    }
  }

  void clearFilter() {
    state = state.copyWith(clearFilter: true);
  }

  void clearSelectedBus() {
    state = state.copyWith(clearSelectedBus: true);
  }
}
  /// ==================== PROVIDER ====================

  final busProvider = StateNotifierProvider<BusNotifier, BusState>((ref) {
    final repository = ref.watch(busRepositoryProvider);
    return BusNotifier(repository);
  });

