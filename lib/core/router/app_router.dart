import 'package:bus_connect/presentation/screens/admin/buses/bus_detail_screen.dart';
import 'package:bus_connect/presentation/screens/admin/fare_rule/fare_rule_form_screen.dart';
import 'package:bus_connect/presentation/screens/admin/fare_rule/fare_rule_list_screen.dart';
import 'package:bus_connect/presentation/screens/admin/routes/route_detail_screen.dart';
import 'package:bus_connect/presentation/screens/admin/routes/route_stops_screen.dart';
import 'package:bus_connect/presentation/screens/admin/seats/bus_seats_screen.dart';
import 'package:bus_connect/presentation/screens/admin/stops/stop_form_screen.dart';
import 'package:bus_connect/presentation/screens/admin/stops/stop_list_screen.dart';
import 'package:bus_connect/presentation/screens/admin/tickets/tickets_list_screen.dart';
import 'package:bus_connect/presentation/screens/admin/trip/from_screen.dart';
import 'package:bus_connect/presentation/screens/admin/trip/trips_list_screen.dart';
import 'package:bus_connect/presentation/screens/passenger/booking/booking_confirmation_screen.dart';
import 'package:bus_connect/presentation/screens/passenger/booking/booking_success_screen.dart';
import 'package:bus_connect/presentation/screens/passenger/dashboard/passenger_dashboard_screen.dart';
import 'package:bus_connect/presentation/screens/passenger/parcel/parcel_tracking_screen.dart';
import 'package:bus_connect/presentation/screens/passenger/profile/profile_screen.dart';
import 'package:bus_connect/presentation/screens/passenger/seat/seat_selection_screen.dart';
import 'package:bus_connect/presentation/screens/passenger/ticket/my_tickets_screen.dart';
import 'package:bus_connect/presentation/screens/passenger/ticket/ticket_detail_screen.dart';
import 'package:bus_connect/presentation/screens/passenger/trip/trip_detail_screen.dart';
import 'package:bus_connect/presentation/screens/passenger/trip/trip_search_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// Auth screens
import '../../presentation/screens/auth/login_screen.dart';
import '../../presentation/screens/auth/register_screen.dart';
import '../../presentation/screens/auth/forgot_password_screen.dart';

// Admin screens
import '../../presentation/screens/admin/dashboard/admin_dashboard_screen.dart';
import '../../presentation/screens/admin/users/user_list_screen.dart';
import '../../presentation/screens/admin/users/user_form_screen.dart';
import '../../presentation/screens/admin/buses/bus_list_screen.dart';
import '../../presentation/screens/admin/buses/bus_form_screen.dart';
import '../../presentation/screens/admin/routes/route_list_screen.dart';
import '../../presentation/screens/admin/routes/route_form_screen.dart';
import '../../presentation/screens/admin/assignments/assignment_list_screen.dart';
import '../../presentation/screens/admin/config/config_list_screen.dart';
import '../../presentation/screens/admin/incidents/incident_list_screen.dart';

// Passenger screens
import '../constants/app_routes.dart';
import '../../core/constants/enums/user_role.dart';
import '../../presentation/providers/auth_provider.dart';

// Dispatcher
import '../../presentation/screens/dispatcher/dashboard/dispatcher_dashboard_screen.dart';
import '../../presentation/screens/dispatcher/trips/dispatcher_trip_list_screen.dart';
import '../../presentation/screens/dispatcher/trips/trip_form_screen.dart';
import '../../presentation/screens/dispatcher/assignments/assignment_from_screen.dart';
import '../../presentation/screens/dispatcher/overbooking/overbooking_list_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.login,

    redirect: (context, state) {
      final container = ProviderScope.containerOf(context, listen: false);
      final authState = container.read(authProvider);

      final isAuthenticated = authState.isAuthenticated;
      final userRole = authState.user?.role;

      final isLoginRoute = state.matchedLocation == AppRoutes.login;
      final isRegisterRoute = state.matchedLocation == AppRoutes.register;
      final isForgotPasswordRoute = state.matchedLocation == AppRoutes.forgotPassword;

      if (!isAuthenticated && !isLoginRoute && !isRegisterRoute && !isForgotPasswordRoute) {
        return AppRoutes.login;
      }

      if (isAuthenticated && isLoginRoute) {
        return _getHomeRouteByRole(userRole);
      }

      return null;
    },

    routes: [
      // ==================== AUTH ====================
      GoRoute(
        path: AppRoutes.login,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        name: 'forgotPassword',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),

      // ==================== ADMIN ====================
      GoRoute(
        path: AppRoutes.adminDashboard,
        name: 'adminDashboard',
        builder: (context, state) => const AdminDashboardScreen(),
      ),

      // ----- USERS -----
      GoRoute(
        path: AppRoutes.adminUsers,
        name: 'adminUsers',
        builder: (context, state) => const UserListScreen(),
      ),
      GoRoute(
        path: AppRoutes.adminUserCreate,
        name: 'adminUserCreate',
        builder: (context, state) => const UserFormScreen(),
      ),
      GoRoute(
        path: '${AppRoutes.adminUserEdit}/:userId',
        name: 'adminUserEdit',
        builder: (context, state) {
          final userId = int.parse(state.pathParameters['userId']!);
          return UserFormScreen(
            isEdit: true,
            userId: userId,
            showPasswordField: true,
          );
        },
      ),

      // ----- BUSES -----
      GoRoute(
        path: AppRoutes.adminBuses,
        name: 'adminBuses',
        builder: (context, state) => const BusListScreen(),
      ),
      GoRoute(
        path: AppRoutes.adminBusCreate,
        name: 'adminBusCreate',
        builder: (context, state) => const BusFormScreen(),
      ),
      GoRoute(
        path: '${AppRoutes.adminBusEdit}/:busId',
        name: 'adminBusEdit',
        builder: (context, state) {
          final busId = int.parse(state.pathParameters['busId']!);
          return BusFormScreen(isEdit: true, busId: busId);
        },
      ),
      GoRoute(
        path: '${AppRoutes.adminBusDetail}/:id',
        name: 'adminBusDetail',
        builder: (context, state) {
          final busId = int.parse(state.pathParameters['id']!);
          return BusDetailScreen(busId: busId);
        },
      ),
      GoRoute(
        path: '${AppRoutes.adminBusSeats}/:busId',
        name: 'adminBusSeats',
        builder: (context, state) {
          final busId = int.parse(state.pathParameters['busId']!);
          final extra = state.extra as Map<String, dynamic>?;
          final busPlate = extra?['plate'] as String? ?? 'Bus $busId';
          return BusSeatsScreen(busId: busId, busPlate: busPlate);
        },
      ),

      // ----- ROUTES -----
      GoRoute(
        path: AppRoutes.adminRoutes,
        name: 'adminRoutes',
        builder: (context, state) => const RoutesListScreen(),
        routes: [
          GoRoute(
            path: 'create',
            name: 'adminRouteCreate',
            builder: (context, state) => const RouteFormScreen(),
          ),
          GoRoute(
            path: 'edit/:routeId',
            name: 'adminRouteEdit',
            builder: (context, state) {
              final routeId = int.parse(state.pathParameters['routeId']!);
              return RouteFormScreen(routeId: routeId);
            },
          ),
          GoRoute(
            path: ':id',
            name: 'adminRouteDetail',
            builder: (context, state) {
              final routeId = int.parse(state.pathParameters['id']!);
              return RouteDetailScreen(routeId: routeId);
            },
          ),
          GoRoute(
            path: ':id/stops',
            name: AppRoutes.adminRouteStopsName,
            builder: (context, state) {
              final routeId = int.parse(state.pathParameters['id']!);
              final routeName = state.extra as String?;
              return RouteStopsScreen(
                routeId: routeId,
                routeName: routeName ?? 'Ruta #$routeId',
              );
            },
          ),
        ],
      ),

      // ----- STOPS -----
      GoRoute(
        path: AppRoutes.adminStops,
        name: 'adminStops',
        builder: (context, state) => const StopListScreen(),
      ),
      GoRoute(
        path: AppRoutes.adminStopCreate,
        name: 'adminStopCreate',
        builder: (context, state) => const StopFormScreen(),
      ),

      // ----- FARE RULES -----
      GoRoute(
        path: AppRoutes.adminFareRules,
        name: 'adminFareRules',
        builder: (context, state) => const FareRuleListScreen(),
      ),
      GoRoute(
        path: AppRoutes.adminFareRuleCreate,
        name: 'adminFareRuleCreate',
        builder: (context, state) => const FareRuleFormScreen(),
      ),

      // ----- ASSIGNMENTS -----
      GoRoute(
        path: AppRoutes.adminAssignments,
        name: 'adminAssignments',
        builder: (context, state) => const AssignmentsListScreen(),
      ),
      GoRoute(
        path: AppRoutes.adminAssignmentCreate,
        name: 'adminAssignmentCreate',
        builder: (context, state) => const AssignmentFormScreen(),
      ),
      GoRoute(
        path: AppRoutes.adminAssignmentEdit,
        name: 'adminAssignmentEdit',
        builder: (context, state) => const AssignmentFormScreen(isEdit: true),
      ),

      // ----- CONFIG -----
      GoRoute(
        path: AppRoutes.adminConfig,
        name: 'adminConfig',
        builder: (context, state) => const ConfigsListScreen(),
      ),

      // ----- INCIDENTS -----
      GoRoute(
        path: AppRoutes.adminIncidents,
        name: 'adminIncidents',
        builder: (context, state) => const IncidentsListScreen(),
      ),

      // ----- TICKETS -----
      GoRoute(
        path: AppRoutes.adminTickets,
        name: 'adminTickets',
        builder: (context, state) => const AdminTicketsListScreen(),
      ),

      // ----- TRIPS -----
      GoRoute(
        path: AppRoutes.adminTrips,
        name: 'adminTrips',
        builder: (context, state) => const TripsListScreen(),
      ),
      GoRoute(
        path: AppRoutes.adminTripsCreate,
        name: 'adminTripsCreate',
        builder: (context, state) => const TripFormScreen(),
      ),

      // ==================== PASSENGER ====================
      GoRoute(
        path: AppRoutes.passengerDashboard,
        name: 'passengerDashboard',
        builder: (context, state) => const PassengerDashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.passengerTripSearch,
        name: 'passengerTripSearch',
        builder: (context, state) => const TripSearchScreen(),
      ),
      GoRoute(
        path: '/passenger/trips/:id',
        name: 'passengerTripDetail',
        builder: (context, state) {
          final tripId = int.parse(state.pathParameters['id']!);
          return TripDetailScreen(tripId: tripId);
        },
      ),
      GoRoute(
        path: AppRoutes.passengerProfile,
        name: 'passengerProfile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: AppRoutes.passengerMyTickets,
        name: 'passengerMyTickets',
        builder: (context, state) => const MyTicketsScreen(),
      ),
      GoRoute(
        path: '/passenger/ticket-detail/:id',
        name: 'passengerTicketDetail',
        builder: (context, state) {
          final ticketId = int.parse(state.pathParameters['id']!);
          return TicketDetailScreen(ticketId: ticketId);
        },
      ),
      GoRoute(
        path: '/passenger/seat-selection/:tripId',
        name: 'passengerSeatSelection',
        builder: (context, state) {
          final tripId = int.parse(state.pathParameters['tripId']!);
          return SeatSelectionScreen(tripId: tripId);
        },
      ),
      GoRoute(
        path: AppRoutes.passengerParcelTracking,
        name: 'passengerParcelTracking',
        builder: (context, state) => const ParcelTrackingScreen(),
      ),
      GoRoute(
        path: AppRoutes.passengerBookingSuccess,
        name: 'passengerBookingSuccess',
        builder: (context, state) {
          final ticketId = state.extra as int;
          return BookingSuccessScreen(ticketId: ticketId);
        },
      ),
      GoRoute(
        path: AppRoutes.passengerBookingConfirm,
        name: 'passengerBookingConfirm',
        builder: (context, state) {
          final tripId = state.extra as int;
          return BookingConfirmationScreen(tripId: tripId);
        },
      ),
      GoRoute(
        path: AppRoutes.editProfile,
        name: 'editProfile',
        builder: (context, state) {
          final userId = state.extra as int?;
          return UserFormScreen(
            isEdit: true,
            userId: userId,
            showPasswordField: false,
          );
        },
      ),

      // ==================== DISPATCHER ====================
      GoRoute(
        path: AppRoutes.dispatcherDashboard,
        name: 'dispatcherDashboard',
        builder: (context, state) => const DispatcherDashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.dispatcherTrips,
        name: 'dispatcherTrips',
        builder: (context, state) => const DispatcherTripListScreen(),
      ),
      GoRoute(
        path: AppRoutes.dispatcherTripCreate,
        name: 'dispatcherTripCreate',
        builder: (context, state) => const TripFormScreenss(),
      ),
      GoRoute(
        path: AppRoutes.dispatcherAssignments,
        name: 'dispatcherAssignments',
        builder: (context, state) => const AssignmentsListScreen(),
      ),
      GoRoute(
        path: AppRoutes.dispatcherAssignmentCreate,
        name: 'dispatcherAssignmentCreate',
        builder: (context, state) => const AssignmentFormScreen(),
      ),
      GoRoute(
        path: AppRoutes.dispatcherOverbooking,
        name: 'dispatcherOverbooking',
        builder: (context, state) => const OverbookingListScreen(),
      ),
      GoRoute(
        path: AppRoutes.dispatcherBuses,
        name: 'dispatcherBuses',
        builder: (context, state) => const BusListScreen(),
      ),
      GoRoute(
        path: AppRoutes.dispatcherIncidents,
        name: 'dispatcherIncidents',
        builder: (context, state) => const IncidentsListScreen(),
      ),
    ],
  );

  static String _getHomeRouteByRole(UserRole? role) {
    if (role == null) return AppRoutes.login;

    switch (role) {
      case UserRole.ADMIN:
        return AppRoutes.adminDashboard;
      case UserRole.DISPATCHER:
        return AppRoutes.dispatcherDashboard;
      case UserRole.CLERK:
      case UserRole.DRIVER:
      case UserRole.PASSENGER:
        return AppRoutes.passengerDashboard;
    }
  }
}
