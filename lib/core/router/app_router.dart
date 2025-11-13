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
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/trip/search_trips_screen.dart';
import '../../presentation/screens/trip/trip_detail_screen.dart';
import '../../presentation/screens/tickets/select_seats_screen.dart';
import '../../presentation/screens/tickets/passenger_info_screen.dart';
import '../../presentation/screens/tickets/payment_screen.dart';
import '../../presentation/screens/tickets/my_tickets_screen.dart';
import '../../presentation/screens/tickets/ticket_detail_screen.dart';
import '../../presentation/screens/parcel/create_parcel_screen.dart';
import '../../presentation/screens/parcel/track_parcel_screen.dart';
import '../../presentation/screens/profile/profile_screen.dart';
import '../../presentation/screens/profile/edit_profile_screen.dart';

import '../constants/app_routes.dart';
import '../../core/constants/enums/user_role.dart';
import '../../presentation/providers/auth_provider.dart';

// Dispatcher
import '../../presentation/screens/dispatcher/dashboard/dispatcher_dashboard_screen.dart';
import '../../presentation/screens/dispatcher/trips/dispatcher_trip_list_screen.dart';
import '../../presentation/screens/dispatcher/trips/trip_form_screen.dart';
import '../../presentation/screens/dispatcher/assignments/assignment_create_screen.dart';
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
      GoRoute(path: AppRoutes.login, builder: (context, state) => const LoginScreen()),
      GoRoute(path: AppRoutes.register, builder: (context, state) => const RegisterScreen()),
      GoRoute(path: AppRoutes.forgotPassword, builder: (context, state) => const ForgotPasswordScreen()),

      // ==================== ADMIN ====================
      GoRoute(path: AppRoutes.adminDashboard, builder: (context, state) => const AdminDashboardScreen()),
      GoRoute(path: AppRoutes.adminUsers, builder: (context, state) => const UserListScreen()),
      GoRoute(path: AppRoutes.adminUserCreate, builder: (context, state) => const UserFormScreen()),
      GoRoute(path: AppRoutes.adminUserEdit, builder: (context, state) => const UserFormScreen(isEdit: true)),
      GoRoute(path: AppRoutes.adminBuses, builder: (context, state) => const BusListScreen()),
      GoRoute(path: AppRoutes.adminBusCreate, builder: (context, state) => const BusFormScreen()),
      GoRoute(path: AppRoutes.adminBusEdit, builder: (context, state) => const BusFormScreen(isEdit: true)),
      GoRoute(path: AppRoutes.adminRoutes, builder: (context, state) => const RouteListScreen()),
      GoRoute(path: AppRoutes.adminRouteCreate, builder: (context, state) => const RouteFormScreen()),
      GoRoute(path: AppRoutes.adminRouteEdit, builder: (context, state) => const RouteFormScreen(isEdit: true)),
      GoRoute(path: AppRoutes.adminAssignments, builder: (context, state) => const AssignmentListScreen()),
      GoRoute(path: AppRoutes.adminConfig, builder: (context, state) => const ConfigListScreen()),
      GoRoute(path: AppRoutes.adminIncidents, builder: (context, state) => const IncidentListScreen()),

      // ==================== PASSENGER ====================
      GoRoute(path: AppRoutes.home, builder: (context, state) => const HomeScreen()),
      GoRoute(path: AppRoutes.searchTrips, builder: (context, state) => const SearchTripsScreen()),
      //GoRoute(path: AppRoutes.tripDetail, builder: (context, state) => const TripDetailScreen()),
      //GoRoute(path: AppRoutes.selectSeats, builder: (context, state) => const SelectSeatsScreen()),
      //GoRoute(path: AppRoutes.passengerInfo, builder: (context, state) => const PassengerInfoScreen()),
      //GoRoute(path: AppRoutes.payment, builder: (context, state) => const PaymentScreen()),
      GoRoute(path: AppRoutes.myTickets, builder: (context, state) => const MyTicketsScreen()),
      //GoRoute(path: AppRoutes.ticketDetail, builder: (context, state) => const TicketDetailScreen()),
      GoRoute(path: AppRoutes.createParcel, builder: (context, state) => const CreateParcelScreen()),
      GoRoute(path: AppRoutes.trackParcel, builder: (context, state) => const TrackParcelScreen()),
      GoRoute(path: AppRoutes.profile, builder: (context, state) => const ProfileScreen()),
      GoRoute(path: AppRoutes.editProfile, builder: (context, state) => const EditProfileScreen()),

      // ==================== DISPATCHER ====================
      GoRoute(path: AppRoutes.dispatcherDashboard, builder: (context, state) => const DispatcherDashboardScreen()),
      GoRoute(path: AppRoutes.dispatcherTrips, builder: (context, state) => const DispatcherTripListScreen()),
      GoRoute(path: AppRoutes.dispatcherTripCreate, builder: (context, state) => const TripFormScreen()),
      GoRoute(path: AppRoutes.dispatcherTripEdit, builder: (context, state) => const TripFormScreen(isEdit: true)),
      GoRoute(path: AppRoutes.dispatcherAssignments, builder: (context, state) => const AssignmentListScreen()),
      GoRoute(path: AppRoutes.dispatcherAssignmentCreate, builder: (context, state) => const AssignmentCreateScreen()),
      GoRoute(path: AppRoutes.dispatcherOverbooking, builder: (context, state) => const OverbookingListScreen()),
      GoRoute(path: AppRoutes.dispatcherBuses, builder: (context, state) => const BusListScreen()),
      GoRoute(path: AppRoutes.dispatcherIncidents, builder: (context, state) => const IncidentListScreen()),
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
        return AppRoutes.home;
      case UserRole.DRIVER:
        return AppRoutes.home;
      case UserRole.PASSENGER:
        return AppRoutes.home;
    }
  }
}
