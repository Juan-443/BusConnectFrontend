class AppRoutes {
  // ================= AUTH =================
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';

  // Home
  static const String home = '/home';

  // Profile
  static const String profile = '/profile';
  static const String editProfile = '/profile/edit';

  // ================= ADMIN =================
  static const String adminMain = '/admin';
  static const String adminDashboard = '/admin/dashboard';
  // ----- USERS -----
  static const String adminUsers = '/admin/users';
  static const String adminUserCreate = '/admin/users/create';
  static const String adminUserEdit = '/admin/users/edit';
  static const String adminUserDetail = '/admin/users/detail';
  // ----- BUSES -----
  static const String adminBuses = '/admin/buses';
  static const String adminBusCreate = '/admin/buses/create';
  static const String adminBusEdit = '/admin/buses/edit';
  static const String adminBusDetail = '/admin/buses/detail';

  // ----- SEATS -----
  static const String adminBusSeats = '/admin/buses/seats';

  // ----- ROUTES -----
  static const String adminRoutes = '/admin/routes';
  static const String adminRouteCreate = '/admin/routes/create';
  static const String adminRouteEdit = '/admin/routes/edit';
  static const String adminRouteDetail = '/admin/routes/detail';
  static const String adminRouteStops = '/admin/routes/stops';
  static const String adminRouteStopsName = 'adminRouteStops';

  // ----- STOPS -----
  static const String adminStops = '/admin/stops';
  static const String adminStopCreate = '/admin/stops/create';
  static const String adminStopEdit = '/admin/stops/edit';

  // ----- FARE RULES -----
  static const String adminFareRules = '/admin/fare-rules';
  static const String adminFareRuleCreate = '/admin/fare-rules/create';
  static const String adminFareRuleEdit = '/admin/fare-rules/edit';

  // ----- ASSIGNMENTS -----
  static const String adminAssignments = '/admin/assignments';
  static const String adminAssignmentCreate = '/admin/assignments/create';
  static const String adminAssignmentEdit = '/admin/assignments/edit';

  // ----- INCIDENTS -----
  static const String adminIncidents = '/admin/incidents';
  static const String adminIncidentDetail = '/admin/incidents/detail';
  static const String adminIncidentcreate = '/admin/incident/create';
  // ----- TICKETS -----
  static const String adminTickets = '/admin/tickets';

  // ----- CONFIG -----
  static const String adminConfig = '/admin/config';
  static const String adminConfigCreate = '/admin/config/create';
  static const String adminConfigEdit = '/admin/config/edit';

  // ----- PARCEL -----
  static const String adminParcels = '/admin/parcels';
  static const String adminTripsCreate = '/admin/trips/create';
  static const String adminTrips = '/admin/trips/search';

  // ================= PASSENGER =================
  static const String passengerDashboard = '/passenger/dashboard';
  static const String passengerTripSearch = '/passenger/trips-search';
  static const String passengerTripDetail = '/passenger/trips';
  static const String passengerSeatSelection = '/passenger/seat-selection';
  static const String passengerBookingConfirm = '/passenger/booking/confirm';
  static const String passengerBookingSuccess = '/passenger/booking/success';
  static const String passengerMyTickets = '/passenger/tickets';
  static const String passengerTicketDetail = '/passenger/ticket-detail';
  static const String passengerProfile = '/passenger/profile';
  static const String passengerParcelTracking = '/passenger/parcels/tracking';
  static const String passengerIncidentReport = '/passenger/incidents/report';

  // ================= DISPATCHER =================
  static const String dispatcherMain = '/dispatcher';
  static const String dispatcherDashboard = '/dispatcher/dashboard';

  // Trips
  static const String dispatcherTrips = '/dispatcher/trips';
  static const String dispatcherTripCreate = '/dispatcher/trips/create';
  static const String dispatcherTripEdit = '/dispatcher/trips/edit';
  static const String dispatcherTripDetail = '/dispatcher/trips/detail';

  // Assignments
  static const String dispatcherAssignments = '/dispatcher/assignments';
  static const String dispatcherAssignmentCreate = '/dispatcher/assignments/create';
  static const String dispatcherAssignmentEdit = '/dispatcher/assignments/edit';

  // Overbooking
  static const String dispatcherOverbooking = '/dispatcher/overbooking';

  // Buses
  static const String dispatcherBuses = '/dispatcher/buses';

  // Incidents
  static const String dispatcherIncidents = '/dispatcher/incidents';
  static const String dispatcherIncidentCreate = '/dispatcher/incidents/create';

// ================= CLERK (PRÓXIMO) =================
// TODO

// ================= DRIVER (PRÓXIMO) =================
// TODO
}
