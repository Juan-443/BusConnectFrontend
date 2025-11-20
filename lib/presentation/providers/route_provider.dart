import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/route_model/route_model.dart';
import '../../data/models/stop_model/stop_model.dart';
import '../../data/repositories/route_repository.dart';
import 'package:bus_connect/app.dart';

/// ==================== STATE ====================
class RouteState {
  final List<RouteResponse> routes;
  final RouteResponse? selectedRoute;
  final List<StopResponse> routeStops;
  final bool isLoading;
  final String? error;
  final String? searchOrigin;
  final String? searchDestination;

  const RouteState({
    this.routes = const [],
    this.selectedRoute,
    this.routeStops = const [],
    this.isLoading = false,
    this.error,
    this.searchOrigin,
    this.searchDestination,
  });

  RouteState copyWith({
    List<RouteResponse>? routes,
    RouteResponse? selectedRoute,
    List<StopResponse>? routeStops,
    bool? isLoading,
    String? error,
    String? searchOrigin,
    String? searchDestination,
  }) {
    return RouteState(
      routes: routes ?? this.routes,
      selectedRoute: selectedRoute ?? this.selectedRoute,
      routeStops: routeStops ?? this.routeStops,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      searchOrigin: searchOrigin ?? this.searchOrigin,
      searchDestination: searchDestination ?? this.searchDestination,
    );
  }

  bool get hasError => error != null && error!.isNotEmpty;
  bool get hasRoutes => routes.isNotEmpty;
}

/// ==================== NOTIFIER ====================
class RouteNotifier extends StateNotifier<RouteState> {
  final RouteRepository _repository;

  RouteNotifier(this._repository) : super(const RouteState());

  Future<void> fetchAllRoutes() async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await _repository.getAllRoutes();

    result.fold(
          (failure) =>
      state = state.copyWith(isLoading: false, error: failure.message),
          (routes) => state = state.copyWith(
        routes: routes,
        isLoading: false,
        error: null,
      ),
    );
  }

  Future<void> fetchRouteById(int id) async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await _repository.getRouteById(id);

    result.fold(
          (failure) =>
      state = state.copyWith(isLoading: false, error: failure.message),
          (route) => state = state.copyWith(
        selectedRoute: route,
        isLoading: false,
        error: null,
      ),
    );
  }

  Future<void> fetchRouteWithStops(int id) async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await _repository.getRouteWithStops(id);

    result.fold(
          (failure) =>
      state = state.copyWith(isLoading: false, error: failure.message),
          (route) => state = state.copyWith(
        selectedRoute: route,
        isLoading: false,
        error: null,
      ),
    );
  }

  Future<void> fetchRouteStops(int id) async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await _repository.getRouteStops(id);

    result.fold(
          (failure) =>
      state = state.copyWith(isLoading: false, error: failure.message),
          (stops) => state = state.copyWith(
        routeStops: stops,
        isLoading: false,
        error: null,
      ),
    );
  }

  Future<void> fetchRouteByCode(String code) async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await _repository.getRouteByCode(code);

    result.fold(
          (failure) =>
      state = state.copyWith(isLoading: false, error: failure.message),
          (route) => state = state.copyWith(
        selectedRoute: route,
        isLoading: false,
        error: null,
      ),
    );
  }

  Future<void> searchRoutes({String? origin, String? destination}) async {
    state = state.copyWith(
      isLoading: true,
      error: null,
      searchOrigin: origin,
      searchDestination: destination,
    );

    final result = await _repository.searchRoutes(
      origin: origin,
      destination: destination,
    );

    result.fold(
          (failure) =>
      state = state.copyWith(isLoading: false, error: failure.message),
          (routes) => state = state.copyWith(
        routes: routes,
        isLoading: false,
        error: null,
      ),
    );
  }

  Future<bool> createRoute(RouteCreateRequest request) async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await _repository.createRoute(request);

    return result.fold(
          (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
      },
          (route) {
        state = state.copyWith(
          routes: [...state.routes, route],
          isLoading: false,
          error: null,
        );
        return true;
      },
    );
  }

  Future<bool> updateRoute(int id, RouteUpdateRequest request) async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await _repository.updateRoute(id, request);

    return result.fold(
          (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
      },
          (route) {
        final updatedRoutes = state.routes.map((r) {
          return r.id == id ? route : r;
        }).toList();

        state = state.copyWith(
          routes: updatedRoutes,
          selectedRoute:
          state.selectedRoute?.id == id ? route : state.selectedRoute,
          isLoading: false,
          error: null,
        );
        return true;
      },
    );
  }

  Future<bool> deleteRoute(int id) async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await _repository.deleteRoute(id);

    return result.fold(
          (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
      },
          (_) {
        final updatedRoutes =
        state.routes.where((r) => r.id != id).toList();

        state = state.copyWith(
          routes: updatedRoutes,
          selectedRoute:
          state.selectedRoute?.id == id ? null : state.selectedRoute,
          isLoading: false,
          error: null,
        );
        return true;
      },
    );
  }

  Future<bool> checkCodeExists(String code) async {
    final result = await _repository.existsByCode(code);
    return result.fold((_) => false, (exists) => exists);
  }

  void clearSelectedRoute() {
    state = state.copyWith(selectedRoute: null, routeStops: []);
  }

  void clearSearch() {
    state = state.copyWith(searchOrigin: null, searchDestination: null);
  }

  void clearState() {
    state = const RouteState();
  }
}

final allRoutesProvider = FutureProvider<List<RouteResponse>>((ref) async {
  final repository = ref.watch(routeRepositoryProvider);
  final result = await repository.getAllRoutes();
  return result.fold(
        (failure) => throw Exception(failure.message),
        (routes) => routes,
  );
});
/// ==================== PROVIDER ====================
final routeProvider =
StateNotifierProvider<RouteNotifier, RouteState>((ref) {
  final repository = ref.watch(routeRepositoryProvider);
  return RouteNotifier(repository);
});
