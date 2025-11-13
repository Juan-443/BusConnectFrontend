import 'package:bus_connect/presentation/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/providers/trip_api_provider.dart';
import '../../data/repositories/trip_repository.dart';
import '../../data/models/trip_model/trip_model.dart';
import '../../core/constants/enums/trip_status.dart';

/// ==================== API PROVIDER ====================
final tripApiProvider = Provider<TripApiProvider>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return TripApiProvider(apiClient.dio);
});

/// ==================== REPOSITORY PROVIDER ====================
final tripRepositoryProvider = Provider<TripRepository>((ref) {
  final apiProvider = ref.watch(tripApiProvider);
  return TripRepository(apiProvider);
});

/// ==================== STATE ====================
class TripSearchState {
  final List<TripResponse> trips;
  final TripResponse? selectedTrip;
  final bool isLoading;
  final String? error;

  const TripSearchState({
    this.trips = const [],
    this.selectedTrip,
    this.isLoading = false,
    this.error,
  });

  TripSearchState copyWith({
    List<TripResponse>? trips,
    TripResponse? selectedTrip,
    bool? isLoading,
    String? error,
  }) {
    return TripSearchState(
      trips: trips ?? this.trips,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  bool get hasTrips => trips.isNotEmpty;
  bool get hasError => error != null && error!.isNotEmpty;
}

/// ==================== NOTIFIER ====================
class TripSearchNotifier extends StateNotifier<TripSearchState> {
  final TripRepository _repository;

  TripSearchNotifier(this._repository) : super(const TripSearchState());

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
          (trip) {
        state = state.copyWith(
          isLoading: false,
          trips: [...state.trips, trip],
          selectedTrip: trip,
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
        final updatedTrips = state.trips.map((t) => t.id == id ? trip : t).toList();
        state = state.copyWith(
          isLoading: false,
          trips: updatedTrips,
          selectedTrip: trip,
        );
        return true;
      },
    );
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
}

/// ==================== PROVIDERS ====================

/// Proveedor principal del buscador de viajes
final tripSearchProvider =
StateNotifierProvider<TripSearchNotifier, TripSearchState>((ref) {
  final repository = ref.watch(tripRepositoryProvider);
  return TripSearchNotifier(repository);
});

/// Proveedor para obtener detalles de un viaje específico
final tripDetailProvider =
FutureProvider.family<TripResponse, int>((ref, id) async {
  final repository = ref.watch(tripRepositoryProvider);
  final result = await repository.getTripWithDetails(id);

  return result.fold(
        (failure) => throw Exception(failure.message),
        (trip) => trip,
  );
});
