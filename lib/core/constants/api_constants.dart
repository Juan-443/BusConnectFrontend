class ApiConstants {
  // ==================== BASE CONFIGURATION ====================

  /// Base URL - CAMBIAR POR TU URL REAL
  static const String baseUrl = 'http://localhost:8080';
  static const String apiVersion = '/api';
  static const String apiV1 = '$apiVersion/v1';

  // ==================== AUTH ENDPOINTS ====================

  static const String auth = '$apiVersion/auth';

  // Authentication
  static const String register = '$auth/register';
  static const String login = '$auth/login';
  static const String loginPhone = '$auth/login/phone';
  static const String refresh = '$auth/refresh';
  static const String logout = '$auth/logout';
  static const String validateToken = '$auth/validate';

  // Profile
  static const String me = '$auth/me';

  // Password Management
  static const String changePassword = '$auth/change-password';
  static const String forgotPassword = '$auth/forgot-password';
  static const String resetPassword = '$auth/reset-password';

  // ==================== USER ENDPOINTS ====================

  static const String users = '$apiV1/users';

  // User Profile
  static const String userMe = '$users/me';
  static const String userUpdateMe = '$users/update-me';
  static const String userMeComplete = '$users/me/complete';
  static const String userMePassword = '$users/me/password';

  // User CRUD
  static const String userCreate = '$users/create';
  static const String userUpdate = '$users/update'; // + /{id}
  static const String userDelete = '$users/delete'; // + /{id}
  static const String userById = '$users'; // + /{id}
  static const String userByEmail = '$users/email'; // + /{email}
  static const String userByPhone = '$users/phone'; // + /{phone}
  static const String userChangeStatus = '$users'; // + /{id}/status

  // User Queries
  static const String allUsers = '$users/all-users';
  static const String usersByRole = '$users/role'; // + /{role}
  static const String usersByRoleAndStatus = '$users/role'; // + /{role}/status/{status}
  static const String activeUsersByRole = '$users/role'; // + /{role}/active

  // User Validation
  static const String userExistsByEmail = '$users/exists/email'; // + /{email}
  static const String userExistsByPhone = '$users/exists/phone'; // + /{phone}
  static const String userCheck = '$users/check';

  // ==================== TRIP ENDPOINTS ====================

  static const String trips = '$apiV1/trips';

  // Trip CRUD
  static const String tripCreate = '$trips/create';
  static const String tripUpdate = '$trips/update'; // + /{id}
  static const String tripDelete = '$trips/delete'; // + /{id}
  static const String tripSearch = '$trips/search'; // + /{id} or with params
  static const String tripDetails = '$trips'; // + /{id}/details
  static const String tripAll = '$trips/all';

  // Trip Queries
  static const String tripsByRoute = '$trips/route'; // + /{routeId}
  static const String tripsToday = '$trips/today';
  static const String tripsTodayActive = '$trips/today/active';
  static const String tripsByBus = '$trips/bus'; // + /{busId}
  static const String tripsByStatus = '$trips/status'; // + /{status}

  // Trip Status Management
  static const String tripChangeStatus = '$trips'; // + /{id}/status
  static const String tripBoardingOpen = '$trips'; // + /{id}/boarding/open
  static const String tripBoardingClose = '$trips'; // + /{id}/boarding/close
  static const String tripDepart = '$trips'; // + /{id}/depart
  static const String tripArrive = '$trips'; // + /{id}/arrive
  static const String tripCancel = '$trips'; // + /{id}/cancel
  static const String tripReactivate = '$trips'; // + /{id}/reactivate

  // Driver Trips
  static const String driverMyTrips = '$trips/driver/my-trips';
  static const String driverCurrentTrips = '$trips/driver/current-trips';
  static const String driverActiveTrips = '$trips/driver/active-trips';

  // ==================== TICKET ENDPOINTS ====================

  static const String tickets = '$apiV1/tickets';

  // Ticket CRUD
  static const String ticketCreate = '$tickets/create';
  static const String ticketUpdate = '$tickets/update'; // + /{id}
  static const String ticketDelete = '$tickets/delete'; // + /{id}
  static const String ticketCancel = '$tickets'; // + /{id}/cancel

  // Ticket Queries
  static const String myTickets = '$tickets/my-tickets';
  static const String ticketAll = '$tickets/all';
  static const String ticketById = '$tickets'; // + /{id}
  static const String ticketDetails = '$tickets'; // + /{id}/details
  static const String ticketByQr = '$tickets/qr'; // + /{qrCode}
  static const String ticketsByTrip = '$tickets/trip'; // + /{tripId}
  static const String ticketsByTripAndStatus = '$tickets/trip'; // + /{tripId}/status/{status}
  static const String ticketsByPassenger = '$tickets/passenger'; // + /{passengerId}

  // Ticket Actions
  static const String ticketMarkUsed = '$tickets'; // + /{id}/used
  static const String ticketMarkNoShow = '$tickets'; // + /{id}/no-show

  // Ticket Validation
  static const String ticketCheckAvailability = '$tickets/check-availability';
  static const String ticketCountByTrip = '$tickets/trip'; // + /{tripId}/count

  // ==================== ROUTE ENDPOINTS ====================

  static const String routes = '$apiV1/routes';

  // Route CRUD
  static const String routeCreate = '$routes/create';
  static const String routeUpdate = '$routes/update'; // + /{id}
  static const String routeDelete = '$routes/delete'; // + /{id}

  // Route Queries
  static const String routeAll = '$routes/all';
  static const String routeById = '$routes'; // + /{id}
  static const String routeWithStops = '$routes'; // + /{id}/with-stops
  static const String routeStops = '$routes'; // + /{id}/stops
  static const String routeByCode = '$routes/code'; // + /{code}
  static const String routeSearch = '$routes/search';

  // Route Validation
  static const String routeCodeExists = '$routes/code'; // + /{code}/exists

  // ==================== STOP ENDPOINTS ====================

  static const String stops = '$apiV1/stops';

  // Stop CRUD
  static const String stopCreate = '$stops/create';
  static const String stopUpdate = '$stops/update'; // + /{id}
  static const String stopDelete = '$stops/delete'; // + /{id}

  // Stop Queries
  static const String stopAll = '$stops/all';
  static const String stopById = '$stops'; // + /{id}
  static const String stopsByRoute = '$stops/route'; // + /{routeId}
  static const String stopSearch = '$stops/search';

  // ==================== PARCEL ENDPOINTS ====================

  static const String parcels = '$apiV1/parcels';

  // Parcel CRUD
  static const String parcelCreate = '$parcels/create';
  static const String parcelUpdate = '$parcels/update'; // + /{id}
  static const String parcelDelete = '$parcels/delete'; // + /{id}

  // Parcel Queries
  static const String parcelAll = '$parcels/all';
  static const String parcelById = '$parcels'; // + /{id}
  static const String parcelByCode = '$parcels/code'; // + /{code}
  static const String parcelsByStatus = '$parcels/status'; // + /{status}
  static const String parcelsByTrip = '$parcels/trip'; // + /{tripId}
  static const String parcelsByPhone = '$parcels/phone'; // + /{phone}

  // Parcel Status Management
  static const String parcelMarkInTransit = '$parcels'; // + /{id}/in-transit
  static const String parcelMarkDelivered = '$parcels'; // + /{id}/delivered
  static const String parcelMarkFailed = '$parcels'; // + /{id}/failed

  // Parcel Validation
  static const String parcelValidateOtp = '$parcels'; // + /{id}/validate-otp

  // ==================== BUS ENDPOINTS ====================

  static const String buses = '$apiV1/buses';

  // Bus CRUD
  static const String busCreate = '$buses/create';
  static const String busUpdate = '$buses/update'; // + /{id}
  static const String busDelete = '$buses/delete'; // + /{id}

  // Bus Queries
  static const String busAll = '$buses/all';
  static const String busById = '$buses'; // + /{id}
  static const String busWithSeats = '$buses'; // + /{id}/with-seats
  static const String busByPlate = '$buses/plate'; // + /{plate}
  static const String busesByStatus = '$buses/status'; // + /{status}
  static const String busesAvailable = '$buses/available';

  // Bus Status Management
  static const String busChangeStatus = '$buses'; // + /{id}/status

  // Bus Validation
  static const String busPlateExists = '$buses/plate'; // + /{plate}/exists

  // ==================== SEAT ENDPOINTS ====================

  static const String seats = '$apiV1/seats';

  // Seat CRUD
  static const String seatCreate = '$seats/create';
  static const String seatUpdate = '$seats/update'; // + /{id}
  static const String seatDelete = '$seats/delete'; // + /{id}

  // Seat Queries
  static const String seatAll = '$seats/all';
  static const String seatById = '$seats'; // + /{id}
  static const String seatsByBus = '$seats/bus'; // + /{busId}
  static const String seatByBusAndNumber = '$seats/bus'; // + /{busId}/number/{number}
  static const String seatsByBusAndType = '$seats/bus'; // + /{busId}/type/{type}
  static const String seatsCountByBus = '$seats/bus'; // + /{busId}/count

  // ==================== SEAT HOLD ENDPOINTS ====================

  static const String seatHolds = '$apiV1/seat-holds';

  // SeatHold CRUD
  static const String seatHoldCreate = '$seatHolds/create';
  static const String seatHoldUpdate = '$seatHolds/update'; // + /{id}
  static const String seatHoldDelete = '$seatHolds/delete'; // + /{id}
  static const String seatHoldRelease = '$seatHolds'; // + /{id}/release

  // SeatHold Queries
  static const String mySeatHolds = '$seatHolds/my-holds';
  static const String seatHoldAll = '$seatHolds/all';
  static const String seatHoldById = '$seatHolds'; // + /{id}
  static const String seatHoldsByTrip = '$seatHolds/trip'; // + /{tripId}
  static const String seatHoldsActiveByTrip = '$seatHolds/trip'; // + /{tripId}/active
  static const String seatHoldsByUser = '$seatHolds/user'; // + /{userId}

  // SeatHold Actions
  static const String seatHoldConvert = '$seatHolds'; // + /{id}/convert

  // SeatHold Validation
  static const String seatHoldCheck = '$seatHolds/check';

  // ==================== ASSIGNMENT ENDPOINTS ====================

  static const String assignments = '$apiV1/assignments';

  // Assignment CRUD
  static const String assignmentCreate = '$assignments/create';
  static const String assignmentUpdate = '$assignments/update';
  static const String assignmentDelete = '$assignments/delete';

  // Assignment Queries
  static const String assignmentAll = '$assignments/all';
  static const String assignmentById = '$assignments';
  static const String assignmentByTrip = '$assignments/trip';
  static const String assignmentWithDetails = '$assignments/trip';
  static const String assignmentsByDriver = '$assignments/driver';
  static const String assignmentsActiveByDriver = '$assignments/driver';
  static const String assignmentsByDriverAndDate = '$assignments/driver';
  static const String assignmentsByDispatcher = '$assignments/dispatcher';
  static const String assignmentsByDateRange = '$assignments/date-range';

  // Assignment Actions
  static const String assignmentApproveChecklist = '$assignments';

  // Assignment Validation
  static const String assignmentHasActive = '$assignments/trip';

  // ==================== OVERBOOKING ENDPOINTS ====================

  static const String overbooking = '$apiV1/overbooking';

  // Overbooking CRUD
  static const String overbookingRequest = '$overbooking/request';
  static const String overbookingApprove = '$overbooking';
  static const String overbookingReject = '$overbooking';

  // Overbooking Queries
  static const String overbookingPending = '$overbooking/pending';
  static const String overbookingByTrip = '$overbooking/trip';
  static const String overbookingByStatus = '$overbooking/status';
  static const String overbookingById = '$overbooking';

  // Overbooking Validation
  static const String overbookingCanOverbook = '$overbooking/trip';
  static const String overbookingOccupancy = '$overbooking/trip';

  // Overbooking Actions
  static const String overbookingExpirePending = '$overbooking/expire-pending';

  // ==================== INCIDENT ENDPOINTS ====================

  static const String incidents = '$apiV1/incidents';

  // Incident CRUD
  static const String incidentCreate = '$incidents/create';
  static const String incidentUpdate = '$incidents/update'; // + /{id}
  static const String incidentDelete = '$incidents/delete'; // + /{id}

  // Incident Queries
  static const String incidentAll = '$incidents/all';
  static const String incidentById = '$incidents'; // + /{id}
  static const String incidentsByEntity = '$incidents/incident-entity';
  static const String incidentsByType = '$incidents/type'; // + /{type}
  static const String incidentsByReporter = '$incidents/reported-by'; // + /{reportedById}
  static const String incidentsByDateRange = '$incidents/date-range';
  static const String incidentsCountByType = '$incidents/type'; // + /{type}/count

  // ==================== FARE RULE ENDPOINTS ====================

  static const String fareRules = '$apiV1/fare-rules';

  // FareRule CRUD
  static const String fareRuleCreate = '$fareRules/create';
  static const String fareRuleUpdate = '$fareRules/update'; // + /{id}
  static const String fareRuleDelete = '$fareRules/delete'; // + /{id}

  // FareRule Queries
  static const String fareRuleAll = '$fareRules/all';
  static const String fareRuleById = '$fareRules'; // + /{id}
  static const String fareRulesByRoute = '$fareRules/route'; // + /{routeId}
  static const String fareRuleForSegment = '$fareRules/segment';
  static const String fareRuleDynamicByRoute = '$fareRules/route'; // + /{routeId}/dynamic

  // FareRule Calculations
  static const String fareRuleCalculateDynamic = '$fareRules'; // + /{id}/calculate-dynamic-price

  // ==================== BAGGAGE ENDPOINTS ====================

  static const String baggage = '$apiV1/baggage';

  // Baggage CRUD
  static const String baggageCreate = '$baggage/create';
  static const String baggageUpdate = '$baggage/update'; // + /{id}
  static const String baggageDelete = '$baggage/delete'; // + /{id}

  // Baggage Queries
  static const String baggageAll = '$baggage/all';
  static const String baggageById = '$baggage'; // + /{id}
  static const String baggageByTag = '$baggage/tag'; // + /{tagCode}
  static const String baggageByTicket = '$baggage/ticket'; // + /{ticketId}
  static const String baggageByTrip = '$baggage/trip'; // + /{tripId}

  // Baggage Calculations
  static const String baggageTotalWeight = '$baggage/trip'; // + /{tripId}/total-weight
  static const String baggageCalculateFee = '$baggage/calculate-fee';

  // ==================== CONFIG ENDPOINTS ====================

  static const String configs = '$apiV1/configs';

  // Config CRUD
  static const String configCreate = '$configs/create';
  static const String configUpdate = '$configs/update'; // + /{id}
  static const String configDelete = '$configs/delete'; // + /{id}
  static const String configDeleteByKey = '$configs/delete-key'; // + /{key}

  // Config Queries
  static const String configAll = '$configs/all';
  static const String configById = '$configs'; // + /{id}
  static const String configByKey = '$configs/key'; // + /{key}

  // Config Values
  static const String configValue = '$configs/key'; // + /{key}/value
  static const String configValueInt = '$configs/key'; // + /{key}/value/int
  static const String configValueDouble = '$configs/key'; // + /{key}/value/double

  // ==================== NOTIFICATION ENDPOINTS ====================

  static const String notifications = '$apiV1/notifications';

  // Email Notifications
  static const String notificationEmailSend = '$notifications/email/send';
  static const String notificationEmailWelcome = '$notifications/email/welcome';
  static const String notificationEmailVerification = '$notifications/email/verification';
  static const String notificationEmailTicket = '$notifications/email/ticket-confirmation';

  // SMS Notifications
  static const String notificationSmsSend = '$notifications/sms/send';
  static const String notificationSmsVerification = '$notifications/sms/verification';
  static const String notificationSmsTripReminder = '$notifications/sms/trip-reminder';

  // WhatsApp Notifications
  static const String notificationWhatsAppSend = '$notifications/whatsapp/send';
  static const String notificationWhatsAppVerification = '$notifications/whatsapp/verification';
  static const String notificationWhatsAppTicket = '$notifications/whatsapp/ticket';
  static const String notificationWhatsAppPlatformChange = '$notifications/whatsapp/platform-change';

  // ==================== NETWORK TIMEOUTS ====================

  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);

}