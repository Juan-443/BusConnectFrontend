import 'package:bus_connect/data/providers/baggage_api_provider.dart';
import 'package:bus_connect/data/providers/seat_api_provider.dart';
import 'package:bus_connect/data/providers/seat_hold_api_provider.dart';
import 'package:bus_connect/data/repositories/baggage_repository.dart';
import 'package:bus_connect/data/repositories/seat_hold_repository.dart';
import 'package:bus_connect/data/repositories/seat_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

// Repositories
import 'data/repositories/auth_repository.dart';
import 'data/repositories/user_repository.dart';
import 'data/repositories/bus_repository.dart';
import 'data/repositories/route_repository.dart';
import 'data/repositories/stop_repository.dart';
import 'data/repositories/config_repository.dart';
import 'data/repositories/fare_rule_repository.dart';
import 'data/repositories/assignment_repository.dart';
import 'data/repositories/incident_repository.dart';
import 'data/repositories/trip_repository.dart';
import 'data/repositories/ticket_repository.dart';
import 'data/repositories/parcel_repository.dart';

// API Providers
import 'data/providers/auth_api_provider.dart';
import 'data/providers/user_api_provider.dart';
import 'data/providers/bus_api_provider.dart';
import 'data/providers/route_api_provider.dart';
import 'data/providers/stop_api_provider.dart';
import 'data/providers/config_api_provider.dart';
import 'data/providers/fare_rule_api_provider.dart';
import 'data/providers/assignment_api_provider.dart';
import 'data/providers/incident_api_provider.dart';
import 'data/providers/trip_api_provider.dart';
import 'data/providers/ticket_api_provider.dart';
import 'data/providers/parcel_api_provider.dart';

import 'data/providers/overbooking_api_provider.dart';
import 'data/repositories/overbooking_repository.dart';
import 'presentation/providers/overbooking_provider.dart';

// Network
import 'core/network/api_client.dart';

// ==================== CORE PROVIDERS ====================
final apiClientProvider = Provider((ref) => ApiClient());
final dioProvider = Provider((ref) => ref.watch(apiClientProvider).dio);

// ==================== API PROVIDERS ====================
final authApiProvider = Provider((ref) => AuthApiProvider(ref.watch(dioProvider)));
final userApiProvider = Provider((ref) => UserApiProvider(ref.watch(dioProvider)));
final busApiProvider = Provider((ref) => BusApiProvider(ref.watch(dioProvider)));
final routeApiProvider = Provider((ref) => RouteApiProvider(ref.watch(dioProvider)));
final stopApiProvider = Provider((ref) => StopApiProvider(ref.watch(dioProvider)));
final configApiProvider = Provider((ref) => ConfigApiProvider(ref.watch(dioProvider)));
final fareRuleApiProvider = Provider((ref) => FareRuleApiProvider(ref.watch(dioProvider)));
final assignmentApiProvider = Provider((ref) => AssignmentApiProvider(ref.watch(dioProvider)));
final incidentApiProvider = Provider((ref) => IncidentApiProvider(ref.watch(dioProvider)));
final tripApiProvider = Provider((ref) => TripApiProvider(ref.watch(dioProvider)));
final ticketApiProvider = Provider((ref) => TicketApiProvider(ref.watch(dioProvider)));
final parcelApiProvider = Provider((ref) => ParcelApiProvider(ref.watch(dioProvider)));
final overbookingApiProvider = Provider((ref) => OverbookingApiProvider(ref.watch(dioProvider)));
final baggageApiProvider = Provider((ref) => BaggageApiProvider(ref.watch(dioProvider)));
final seatHoldApiProvider = Provider((ref) => SeatHoldApiProvider(ref.watch(dioProvider))); // ✅ AGREGAR
final seatApiProvider = Provider((ref) => SeatApiProvider(ref.watch(dioProvider))); // ✅ AGREGAR

// ==================== REPOSITORIES ====================
final authRepositoryProvider = Provider((ref) => AuthRepository(ref.watch(authApiProvider)));
final userRepositoryProvider = Provider((ref) => UserRepository(ref.watch(userApiProvider)));
final busRepositoryProvider = Provider((ref) => BusRepository(ref.watch(busApiProvider)));
final routeRepositoryProvider = Provider((ref) => RouteRepository(ref.watch(routeApiProvider)));
final stopRepositoryProvider = Provider((ref) => StopRepository(ref.watch(stopApiProvider)));
final configRepositoryProvider = Provider((ref) => ConfigRepository(ref.watch(configApiProvider)));
final fareRuleRepositoryProvider = Provider((ref) => FareRuleRepository(ref.watch(fareRuleApiProvider)));
final assignmentRepositoryProvider = Provider((ref) => AssignmentRepository(ref.watch(assignmentApiProvider)));
final incidentRepositoryProvider = Provider((ref) => IncidentRepository(ref.watch(incidentApiProvider)));
final tripRepositoryProvider = Provider((ref) => TripRepository(ref.watch(tripApiProvider)));
final ticketRepositoryProvider = Provider((ref) => TicketRepository(ref.watch(ticketApiProvider)));
final parcelRepositoryProvider = Provider((ref) => ParcelRepository(ref.watch(parcelApiProvider)));
final overbookingRepositoryProvider = Provider((ref) => OverbookingRepository(ref.watch(overbookingApiProvider)));
final baggageRepositoryProvider = Provider((ref) => BaggageRepository(ref.watch(baggageApiProvider)));

final seatHoldRepositoryProvider = Provider((ref) => SeatHoldRepository(ref.watch(seatHoldApiProvider)));
final seatRepositoryProvider = Provider((ref) => SeatRepository(ref.watch(seatApiProvider)));

// ==================== STATE NOTIFIERS ====================
final overbookingProvider = StateNotifierProvider<OverbookingNotifier, OverbookingState>(
      (ref) => OverbookingNotifier(ref.watch(overbookingRepositoryProvider)),
);

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Bus Connect',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
    );
  }
}
