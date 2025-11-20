import 'package:bus_connect/core/constants/enums/payment_method.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bus_connect/app.dart';
import '../../../data/models/seat_hold_model/seat_hold_model.dart';
import '../../../data/models/ticket_model/ticket_model.dart';

final passengerBookingProvider = StateNotifierProvider<PassengerBookingNotifier, BookingState>((ref) {
  return PassengerBookingNotifier(ref);
});

class BookingState {
  final SeatHoldModel? currentHold;
  final TicketModel? createdTicket;
  final bool isLoading;
  final String? error;

  BookingState({
    this.currentHold,
    this.createdTicket,
    this.isLoading = false,
    this.error,
  });

  BookingState copyWith({
    SeatHoldModel? currentHold,
    TicketModel? createdTicket,
    bool? isLoading,
    String? error,
    bool clearHold = false,
    bool clearTicket = false,
  }) {
    return BookingState(
      currentHold: clearHold ? null : (currentHold ?? this.currentHold),
      createdTicket: clearTicket ? null : (createdTicket ?? this.createdTicket),
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class PassengerBookingNotifier extends StateNotifier<BookingState> {
  final Ref ref;

  PassengerBookingNotifier(this.ref) : super(BookingState());

  /// Retener un asiento temporalmente
  Future<void> holdSeat({
    required int tripId,
    required String seatNumber,
    required int fromStopId,
    required int toStopId,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final holdRepo = ref.read(seatHoldRepositoryProvider);

      final request = SeatHoldCreateRequest(
        tripId: tripId,
        seatNumber: seatNumber,
        fromStopId: fromStopId,
        toStopId: toStopId,
      );

      final result = await holdRepo.createSeatHold(request);

      result.fold(
            (failure) => state = state.copyWith(
          isLoading: false,
          error: failure.message,
        ),
            (hold) => state = state.copyWith(
          currentHold: hold,
          isLoading: false,
          error: null,
        ),
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Liberar una retención de asiento
  Future<void> releaseHold(int holdId) async {
    try {
      final holdRepo = ref.read(seatHoldRepositoryProvider);
      final result = await holdRepo.releaseSeatHold(holdId);

      result.fold(
            (failure) => state = state.copyWith(error: failure.message),
            (_) => state = state.copyWith(clearHold: true, error: null),
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Crear un ticket
  Future<void> createTicket({
    required int tripId,
    required int passengerId,
    required int fromStopId,
    required int toStopId,
    required String seatNumber,
    required double price,
    required PaymentMethod paymentMethod,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final ticketRepo = ref.read(ticketRepositoryProvider);

      final request = TicketCreateRequest(
        tripId: tripId,
        passengerId: passengerId,
        fromStopId: fromStopId,
        toStopId: toStopId,
        seatNumber: seatNumber,
        price: price,
        paymentMethod: paymentMethod,
      );

      final result = await ticketRepo.createTicket(request);

      await result.fold(
            (failure) async {
          state = state.copyWith(
            isLoading: false,
            error: failure.message,
          );
        },
            (ticket) async {
          if (state.currentHold != null) {
            await releaseHold(state.currentHold!.id);
          }

          state = state.copyWith(
            createdTicket: ticket,
            isLoading: false,
            clearHold: true,
            error: null,
          );
        },
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Convertir hold a ticket directamente
  Future<void> convertHoldToTicket(int holdId) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final holdRepo = ref.read(seatHoldRepositoryProvider);
      final result = await holdRepo.convertHoldToTicket(holdId);

      result.fold(
            (failure) => state = state.copyWith(
          isLoading: false,
          error: failure.message,
        ),
            (_) => state = state.copyWith(
          isLoading: false,
          clearHold: true,
          error: null,
        ),
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }


  void reset() {
    state = BookingState();
  }
}