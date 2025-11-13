import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/ticket_model/ticket_model.dart';
import '../../core/constants/api_constants.dart';
import '../../core/constants/enums/ticket_status.dart';

part 'ticket_api_provider.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class TicketApiProvider {
  factory TicketApiProvider(Dio dio, {String baseUrl}) = _TicketApiProvider;

  // ==================== TICKET CRUD ====================

  @POST(ApiConstants.ticketCreate)
  Future<TicketResponse> createTicket(@Body() TicketCreateRequest request);

  @PUT('${ApiConstants.ticketUpdate}/{id}')
  Future<TicketResponse> updateTicket(
      @Path('id') int id,
      @Body() TicketUpdateRequest request,
      );

  @DELETE('${ApiConstants.ticketDelete}/{id}')
  Future<void> deleteTicket(@Path('id') int id);

  @POST('${ApiConstants.ticketCancel}/{id}/cancel')
  Future<TicketResponse> cancelTicket(@Path('id') int id);

  // ==================== TICKET QUERIES ====================

  @GET(ApiConstants.myTickets)
  Future<List<TicketResponse>> getMyTickets();

  @GET(ApiConstants.ticketAll)
  Future<List<TicketResponse>> getAllTickets();

  @GET('${ApiConstants.ticketById}/{id}')
  Future<TicketResponse> getTicketById(@Path('id') int id);

  @GET('${ApiConstants.ticketDetails}/{id}/details')
  Future<TicketResponse> getTicketWithDetails(@Path('id') int id);

  @GET('${ApiConstants.ticketByQr}/{qrCode}')
  Future<TicketResponse> getTicketByQrCode(@Path('qrCode') String qrCode);

  @GET('${ApiConstants.ticketsByTrip}/{tripId}')
  Future<List<TicketResponse>> getTicketsByTrip(@Path('tripId') int tripId);

  @GET('${ApiConstants.ticketsByTripAndStatus}/{tripId}/status/{status}')
  Future<List<TicketResponse>> getTicketsByTripAndStatus(
      @Path('tripId') int tripId,
      @Path('status') TicketStatus status,
      );

  @GET('${ApiConstants.ticketsByPassenger}/{passengerId}')
  Future<List<TicketResponse>> getTicketsByPassenger(
      @Path('passengerId') int passengerId,
      );

  // ==================== TICKET ACTIONS ====================

  @POST('${ApiConstants.ticketMarkUsed}/{id}/used')
  Future<TicketResponse> markAsUsed(@Path('id') int id);

  @POST('${ApiConstants.ticketMarkNoShow}/{id}/no-show')
  Future<TicketResponse> markAsNoShow(@Path('id') int id);

  // ==================== TICKET VALIDATION ====================

  @GET(ApiConstants.ticketCheckAvailability)
  Future<bool> isSeatAvailable(
      @Query('tripId') int tripId,
      @Query('seatNumber') String seatNumber,
      );

  @GET('${ApiConstants.ticketCountByTrip}/{tripId}/count')
  Future<int> countSoldTicketsByTrip(@Path('tripId') int tripId);
}