import 'package:bus_connect/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bus_connect/presentation/providers/auth_provider.dart';
import '../../data/models/stop_model/stop_model.dart';
import '../../data/providers/stop_api_provider.dart';
import '../../data/repositories/stop_repository.dart';

/// ==================== API PROVIDER ====================
final stopApiProvider = Provider<StopApiProvider>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return StopApiProvider(apiClient.dio);
});

/// ==================== REPOSITORY PROVIDER ====================
final stopRepositoryProvider = Provider<StopRepository>((ref) {
  final apiProvider = ref.watch(stopApiProvider);
  return StopRepository(apiProvider);
});
/*
final routeStopsProvider = FutureProvider.autoDispose.family<List<StopModel>, int>((ref, routeId) async {
  final routeApi = ref.read(routeApiProvider.notifier);
  return await routeApi.getRouteStops(routeId);
});
*/
/// ==================== STATE ====================
class StopState {
  final List<StopResponse> stops;
  final StopResponse? selectedStop;
  final bool isLoading;
  final String? error;
  final int? filterRouteId;

  const StopState({
    this.stops = const [],
    this.selectedStop,
    this.isLoading = false,
    this.error,
    this.filterRouteId,
  });

  StopState copyWith({
    List<StopResponse>? stops,
    StopResponse? selectedStop,
    bool? isLoading,
    String? error,
    int? filterRouteId,
  }) {
    return StopState(
      stops: stops ?? this.stops,
      selectedStop: selectedStop ?? this.selectedStop,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      filterRouteId: filterRouteId ?? this.filterRouteId,
    );
  }

  List<StopResponse> get filteredStops {
    if (filterRouteId == null) return stops;
    return stops.where((s) => s.routeId == filterRouteId).toList();
  }

  bool get hasError => error != null && error!.isNotEmpty;
  bool get hasStops => stops.isNotEmpty;
}

/// ==================== NOTIFIER ====================
class StopNotifier extends StateNotifier<StopState> {
  final StopRepository _repository;

  StopNotifier(this._repository) : super(const StopState());

  Future<void> fetchAllStops() async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await _repository.getAllStops();

    result.fold(
          (failure) =>
      state = state.copyWith(isLoading: false, error: failure.message),
          (stops) => state = state.copyWith(
        stops: stops,
        isLoading: false,
        error: null,
      ),
    );
  }

  Future<void> fetchStopById(int id) async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await _repository.getStopById(id);

    result.fold(
          (failure) =>
      state = state.copyWith(isLoading: false, error: failure.message),
          (stop) => state = state.copyWith(
        selectedStop: stop,
        isLoading: false,
        error: null,
      ),
    );
  }

  Future<void> fetchStopsByRoute(int routeId) async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await _repository.getStopsByRoute(routeId);

    result.fold(
          (failure) =>
      state = state.copyWith(isLoading: false, error: failure.message),
          (stops) => state = state.copyWith(
        stops: stops,
        isLoading: false,
        error: null,
      ),
    );
  }

  Future<void> searchStopsByName(String name) async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await _repository.searchStopsByName(name);

    result.fold(
          (failure) =>
      state = state.copyWith(isLoading: false, error: failure.message),
          (stops) => state = state.copyWith(
        stops: stops,
        isLoading: false,
        error: null,
      ),
    );
  }

  Future<bool> createStop(StopCreateRequest request) async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await _repository.createStop(request);

    return result.fold(
          (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
      },
          (stop) {
        final updatedStops = [...state.stops, stop]..sort(
              (a, b) => a.order.compareTo(b.order),
        );
        state = state.copyWith(
          stops: updatedStops,
          isLoading: false,
          error: null,
        );
        return true;
      },
    );
  }

  Future<bool> updateStop(int id, StopUpdateRequest request) async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await _repository.updateStop(id, request);

    return result.fold(
          (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
      },
          (stop) {
        final updatedStops = state.stops.map((s) {
          return s.id == id ? stop : s;
        }).toList()
          ..sort((a, b) => a.order.compareTo(b.order));

        state = state.copyWith(
          stops: updatedStops,
          selectedStop:
          state.selectedStop?.id == id ? stop : state.selectedStop,
          isLoading: false,
          error: null,
        );
        return true;
      },
    );
  }

  Future<bool> deleteStop(int id) async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await _repository.deleteStop(id);

    return result.fold(
          (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
      },
          (_) {
        final updatedStops =
        state.stops.where((s) => s.id != id).toList();

        state = state.copyWith(
          stops: updatedStops,
          selectedStop:
          state.selectedStop?.id == id ? null : state.selectedStop,
          isLoading: false,
          error: null,
        );
        return true;
      },
    );
  }

  void setRouteFilter(int? routeId) {
    state = state.copyWith(filterRouteId: routeId);
  }

  void clearFilter() {
    state = state.copyWith(filterRouteId: null);
  }

  void clearSelectedStop() {
    state = state.copyWith(selectedStop: null);
  }

  void selectStop(StopResponse stop) {
    state = state.copyWith(selectedStop: stop);
  }

  void clearState() {
    state = const StopState();
  }
}

/// ==================== PROVIDER ====================
final stopProvider =
StateNotifierProvider<StopNotifier, StopState>((ref) {
  final repository = ref.watch(stopRepositoryProvider);
  return StopNotifier(repository);
});
