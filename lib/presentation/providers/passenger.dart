import 'package:bus_connect/data/models/stop_model/stop_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bus_connect/app.dart';
import '../../../data/models/trip_model/trip_model.dart';
import '../../../data/models/route_model/route_model.dart';

// ==================== TRIPS NOTIFIER ====================

class PassengerTripsNotifier extends StateNotifier<AsyncValue<List<TripModel>>> {
  final Ref ref;

  PassengerTripsNotifier(this.ref) : super(const AsyncValue.data([]));

  Future<void> searchByCities({
    required String origin,
    required String destination,
    DateTime? date,
  }) async {
    state = const AsyncValue.loading();

    try {
      final routeRepo = ref.read(routeRepositoryProvider);
      final routesResult = await routeRepo.searchRoutes(
        origin: origin,
        destination: destination,
      );

      final routes = routesResult.fold(
            (failure) => throw Exception(failure.message),
            (routes) => routes,
      );

      if (routes.isEmpty) {
        state = const AsyncValue.data([]);
        return;
      }

      final tripRepo = ref.read(tripRepositoryProvider);
      final allTrips = <TripModel>[];

      for (final route in routes) {
        final tripsResult = await tripRepo.searchTrips(
          routeId: route.id,
          date: date != null ? _formatDate(date) : null,
        );

        tripsResult.fold(
              (failure) {},
              (trips) {
             if (date != null) {
              final filteredTrips = trips.where((trip) {
                return trip.date.year == date.year &&
                    trip.date.month == date.month &&
                    trip.date.day == date.day;
              }).toList();
              allTrips.addAll(filteredTrips);
            } else {
              final now = DateTime.now();
              final futureTrips = trips.where((trip) {
                return trip.departureAt.isAfter(now);
              }).toList();
              allTrips.addAll(futureTrips);
            }
          },
        );
      }

      allTrips.sort((a, b) => a.departureAt.compareTo(b.departureAt));

      state = AsyncValue.data(allTrips);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> searchTrips({
    required int routeId,
    required DateTime date,
  }) async {
    state = const AsyncValue.loading();

    try {
      final tripRepo = ref.read(tripRepositoryProvider);
      final result = await tripRepo.searchTrips(
        routeId: routeId,
        date: _formatDate(date),
      );

      result.fold(
            (failure) => state = AsyncValue.error(failure.message, StackTrace.current),
            (trips) => state = AsyncValue.data(trips),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> getTodayTrips() async {
    state = const AsyncValue.loading();

    try {
      final tripRepo = ref.read(tripRepositoryProvider);
      final result = await tripRepo.getTodayTrips();

      result.fold(
            (failure) => state = AsyncValue.error(failure.message, StackTrace.current),
            (trips) => state = AsyncValue.data(trips),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> searchTripsByFilters({
    int? routeId,
    String? date,
  }) async {
    state = const AsyncValue.loading();

    try {
      final tripRepo = ref.read(tripRepositoryProvider);

       if (routeId == null && date != null) {
        final result = await tripRepo.searchTrips(date: date);

        result.fold(
              (failure) => state = AsyncValue.error(failure.message, StackTrace.current),
              (trips) {

            trips.sort((a, b) => a.departureAt.compareTo(b.departureAt));
            state = AsyncValue.data(trips);
          },
        );
        return;
      }

      final result = await tripRepo.searchTrips(
        routeId: routeId,
        date: date,
      );
      result.fold(
            (failure) => state = AsyncValue.error(failure.message, StackTrace.current),
            (trips) => state = AsyncValue.data(trips),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  void clearTrips() {
    state = const AsyncValue.data([]);
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}

// ==================== PASSENGER TRIPS PROVIDER ====================

final passengerTripsProvider =
StateNotifierProvider<PassengerTripsNotifier, AsyncValue<List<TripModel>>>((ref) {
  return PassengerTripsNotifier(ref);
});

// ==================== TRIP DETAILS PROVIDER ====================

final tripDetailsProvider = FutureProvider.autoDispose.family<TripModel, int>((ref, tripId) async {
  final tripRepo = ref.read(tripRepositoryProvider);
  final result = await tripRepo.getTripWithDetails(tripId);

  return result.fold(
        (failure) => throw Exception(failure.message),
        (trip) => trip,
  );
});

// ==================== ROUTES PROVIDERS ====================

final passengerRoutesProvider = FutureProvider<List<RouteModel>>((ref) async {
  final routeRepo = ref.read(routeRepositoryProvider);
  final result = await routeRepo.getAllRoutes();

  return result.fold(
        (failure) => throw Exception(failure.message),
        (routes) => routes,
  );
});

final routeSearchProvider = StateProvider<String>((ref) => '');

final filteredRoutesProvider = Provider<AsyncValue<List<RouteModel>>>((ref) {
  final routesAsync = ref.watch(passengerRoutesProvider);
  final searchQuery = ref.watch(routeSearchProvider);

  return routesAsync.when(
    data: (routes) {
      if (searchQuery.isEmpty) {
        return AsyncValue.data(routes);
      }
      final filtered = routes.where((route) {
        final query = searchQuery.toLowerCase();
        return route.origin.toLowerCase().contains(query) ||
            route.destination.toLowerCase().contains(query) ||
            route.name.toLowerCase().contains(query) ||
            route.code.toLowerCase().contains(query);
      }).toList();
      return AsyncValue.data(filtered);
    },
    loading: () => const AsyncValue.loading(),
    error: (e, st) => AsyncValue.error(e, st),
  );
});

final citiesProvider = Provider<AsyncValue<Cities>>((ref) {
  final routesAsync = ref.watch(passengerRoutesProvider);

  return routesAsync.when(
    data: (routes) {
      final origins = routes.map((r) => r.origin).toSet().toList()..sort();
      final destinations = routes.map((r) => r.destination).toSet().toList()..sort();

      return AsyncValue.data(Cities(
        origins: origins,
        destinations: destinations,
      ));
    },
    loading: () => const AsyncValue.loading(),
    error: (e, st) => AsyncValue.error(e, st),
  );
});

// ==================== ROUTE DETAILS PROVIDER ====================

final routeDetailsProvider = FutureProvider.autoDispose.family<RouteModel, int>((ref, routeId) async {
  final routeRepo = ref.read(routeRepositoryProvider);
  final result = await routeRepo.getRouteWithStops(routeId);

  return result.fold(
        (failure) => throw Exception(failure.message),
        (route) => route,
  );
});

// ==================== ROUTE STOPS PROVIDER ====================

final routeStopsProvider = FutureProvider.autoDispose.family<List<StopModel>, int>((ref, routeId) async {
  final routeRepo = ref.read(routeRepositoryProvider);
  final result = await routeRepo.getRouteStops(routeId);

  return result.fold(
        (failure) => throw Exception(failure.message),
        (stops) => stops,
  );
});

// ==================== SEARCH ROUTES PROVIDER ====================

final searchRoutesProvider = FutureProvider.autoDispose.family<List<RouteModel>, RouteSearchParams>(
      (ref, params) async {
    final routeRepo = ref.read(routeRepositoryProvider);
    final result = await routeRepo.searchRoutes(
      origin: params.origin,
      destination: params.destination,
    );

    return result.fold(
          (failure) => throw Exception(failure.message),
          (routes) => routes,
    );
  },
);

// ==================== HELPER CLASSES ====================

class RouteSearchParams {
  final String? origin;
  final String? destination;

  RouteSearchParams({this.origin, this.destination});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is RouteSearchParams &&
              runtimeType == other.runtimeType &&
              origin == other.origin &&
              destination == other.destination;

  @override
  int get hashCode => origin.hashCode ^ destination.hashCode;
}

class Cities {
  final List<String> origins;
  final List<String> destinations;

  Cities({required this.origins, required this.destinations});
}