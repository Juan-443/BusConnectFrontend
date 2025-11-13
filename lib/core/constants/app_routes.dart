// lib/core/constants/app_routes.dart

class AppRoutes {
  // Auth routes
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';

  // Main routes
  static const String home = '/home';

  // ==================== ADMIN ROUTES ====================
  static const String adminDashboard = '/admin/dashboard';

  // Users
  static const String adminUsers = '/admin/users';
  static const String adminUserCreate = '/admin/users/create';
  static const String adminUserEdit = '/admin/users/edit';
  static const String adminUserDetail = '/admin/users/detail';

  // Buses
  static const String adminBuses = '/admin/buses';
  static const String adminBusCreate = '/admin/buses/create';
  static const String adminBusEdit = '/admin/buses/edit';
  static const String adminBusDetail = '/admin/buses/detail';

  // Routes
  static const String adminRoutes = '/admin/routes';
  static const String adminRouteCreate = '/admin/routes/create';
  static const String adminRouteEdit = '/admin/routes/edit';
  static const String adminRouteDetail = '/admin/routes/detail';

  // Stops
  static const String adminStops = '/admin/stops';
  static const String adminStopCreate = '/admin/stops/create';
  static const String adminStopEdit = '/admin/stops/edit';

  // Fare Rules
  static const String adminFareRules = '/admin/fare-rules';
  static const String adminFareRuleCreate = '/admin/fare-rules/create';
  static const String adminFareRuleEdit = '/admin/fare-rules/edit';

  // Assignments
  static const String adminAssignments = '/admin/assignments';
  static const String adminAssignmentCreate = '/admin/assignments/create';
  static const String adminAssignmentEdit = '/admin/assignments/edit';

  // Incidents
  static const String adminIncidents = '/admin/incidents';
  static const String adminIncidentDetail = '/admin/incidents/detail';

  // Config
  static const String adminConfig = '/admin/config';

  // ==================== PASSENGER ROUTES ====================
  static const String searchTrips = '/trips/search';
  static const String tripDetail = '/trips/detail';
  static const String selectSeats = '/trips/seats';
  static const String passengerInfo = '/trips/passenger-info';
  static const String payment = '/trips/payment';

  // Tickets
  static const String myTickets = '/tickets';
  static const String ticketDetail = '/tickets/detail';

  // Parcels
  static const String createParcel = '/parcels/create';
  static const String trackParcel = '/parcels/track';

  // Profile
  static const String profile = '/profile';
  static const String editProfile = '/profile/edit';

// ==================== DISPATCHER ROUTES ====================
  static const String dispatcherDashboard = '/dispatcher/dashboard';

  // Trips
  static const String dispatcherTrips = '/dispatcher/trips';
  static const String dispatcherTripCreate = '/dispatcher/trips/create';
  static const String dispatcherTripEdit = '/dispatcher/trips/edit';
  static const String dispatcherTripDetail = '/dispatcher/trips/detail';

  // Assignments
  static const String dispatcherAssignments = '/dispatcher/assignments';
  static const String dispatcherAssignmentCreate = '/dispatcher/assignments/create';

  // Overbooking
  static const String dispatcherOverbooking = '/dispatcher/overbooking';

  // Buses
  static const String dispatcherBuses = '/dispatcher/buses';

  // Incidents
  static const String dispatcherIncidents = '/dispatcher/incidents';
  static const String dispatcherIncidentCreate = '/dispatcher/incidents/create';

// ==================== CLERK ROUTES ====================
// (Agregaremos después)

// ==================== DRIVER ROUTES ====================
// (Agregaremos después)

}