import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/trip_repository.dart';
import '../../data/models/trip_model/trip_model.dart';
import '../../core/constants/enums/trip_status.dart';
import 'package:bus_connect/app.dart';

/// ==================== STATE ====================
class TripSearchState {
  final List<TripResponse> trips;
  final TripResponse? selectedTrip;
  final bool isLoading;
  final String? error;
  final TripStatus? filterStatus;

  const TripSearchState({
    this.trips = const [],
    this.selectedTrip,
    this.isLoading = false,
    this.error,
    this.filterStatus,
  });

  TripSearchState copyWith({
    List<TripResponse>? trips,
    TripResponse? selectedTrip,
    bool? isLoading,
    String? error,
    TripStatus? filterStatus,
  }) {
    return TripSearchState(
      trips: trips ?? this.trips,
      selectedTrip: selectedTrip ?? this.selectedTrip,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      filterStatus: filterStatus ?? this.filterStatus,
    );
  }

  bool get hasTrips => trips.isNotEmpty;
  bool get hasError => error != null && error!.isNotEmpty;
}

/// ==================== NOTIFIER ====================
class TripSearchNotifier extends StateNotifier<TripSearchState> {
  final TripRepository _repository;
  Timer? _autoUpdateTimer;

  TripSearchNotifier(this._repository) : super(const TripSearchState());

  Future<void> loadAllTrips() async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _repository.searchTrips();

    result.fold(
          (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.message,
      ),
          (trips) => state = state.copyWith(
        trips: trips,
        isLoading: false,
        error: null,
      ),
    );
  }

  Future<void> fetchTripsByDate(String date) async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await _repository.searchTrips(date: date);
    result.fold(
          (failure) => state = state.copyWith(isLoading: false, error: failure.message),
          (trips) => state = state.copyWith(isLoading: false, trips: trips),
    );
  }

  Future<void> searchTrips({
    int? routeId,
    String? date,
    TripStatus? status,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _repository.searchTrips(
      routeId: routeId,
      date: date,
      status: status,
    );

    result.fold(
          (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.message,
      ),
          (trips) => state = state.copyWith(
        trips: trips,
        isLoading: false,
        error: null,
      ),
    );
  }

  void filterByStatus(TripStatus? status) {
    state = state.copyWith(filterStatus: status);
    searchTrips(status: status);
  }

  void selectTrip(TripResponse trip) {
    state = state.copyWith(selectedTrip: trip);
  }

  Future<bool> createTrip(TripCreateRequest request) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _repository.createTrip(request);

    return result.fold(
          (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
      },
          (trip) async {
        final detailResult = await _repository.getTripWithDetails(trip.id);

        final tripWithDetails = detailResult.fold(
              (failure) => trip,
              (detailedTrip) => detailedTrip,
        );

        state = state.copyWith(
          isLoading: false,
          trips: [...state.trips, tripWithDetails],
          selectedTrip: tripWithDetails,
        );
        return true;
      },
    );
  }

  Future<bool> updateTrip(int id, TripUpdateRequest request) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _repository.updateTrip(id, request);

    return result.fold(
          (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
      },
          (trip) {
        final updatedTrips =
        state.trips.map((t) => t.id == id ? trip : t).toList();
        state = state.copyWith(
          isLoading: false,
          trips: updatedTrips,
          selectedTrip: trip,
        );
        return true;
      },
    );
  }

  Future<bool> deleteTrip(int id) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _repository.deleteTrip(id);

    return result.fold(
          (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
      },
          (_) {
        final updatedTrips = state.trips.where((t) => t.id != id).toList();
        state = state.copyWith(
          isLoading: false,
          trips: updatedTrips,
        );
        return true;
      },
    );
  }

  Future<bool> cancelTrip(int id) async {
    return changeTripStatus(id, TripStatus.CANCELLED);
  }

  Future<bool> changeTripStatus(int id, TripStatus status) async {
    final request = TripUpdateRequest(status: status);
    return updateTrip(id, request);
  }

  Future<void> getTodayTrips() async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _repository.getTodayTrips();

    result.fold(
          (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.message,
      ),
          (trips) => state = state.copyWith(
        trips: trips,
        isLoading: false,
        error: null,
      ),
    );
  }

  void clearSearch() {
    state = const TripSearchState();
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
  void startAutoUpdateTimer() {
    _autoUpdateTimer?.cancel();
    _autoUpdateTimer = Timer.periodic(
      const Duration(minutes: 2),
          (_) => _refreshTripsFromBackend(),
    );
    _refreshTripsFromBackend();
  }

  Future<void> _refreshTripsFromBackend() async {
    if (!state.isLoading) {
      await loadAllTrips();
    }
  }

  /// Detiene el timer de auto-actualización
  void stopAutoUpdateTimer() {
    _autoUpdateTimer?.cancel();
    _autoUpdateTimer = null;
  }

  @override
  void dispose() {
    stopAutoUpdateTimer();
    super.dispose();
  }
}

/// ==================== PROVIDERS ====================

final tripSearchProvider =
StateNotifierProvider<TripSearchNotifier, TripSearchState>((ref) {
  final repository = ref.watch(tripRepositoryProvider);
  return TripSearchNotifier(repository);
});

final tripDetailProvider =
FutureProvider.family<TripResponse, int>((ref, id) async {
  final repository = ref.watch(tripRepositoryProvider);
  final result = await repository.getTripWithDetails(id);

  return result.fold(
        (failure) => throw Exception(failure.message),
        (trip) => trip,
  );
});