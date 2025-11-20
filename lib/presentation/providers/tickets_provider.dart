import 'package:bus_connect/core/constants/enums/ticket_status.dart'; // ✅ AGREGAR IMPORT
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/ticket_repository.dart';
import '../../data/models/ticket_model/ticket_model.dart';
import 'package:bus_connect/app.dart';


/// ==================== STATE ====================
class TicketState {
  final List<TicketResponse> tickets;
  final TicketResponse? selectedTicket;
  final bool isLoading;
  final String? error;
  final TicketStatus? filterStatus;

  const TicketState({
    this.tickets = const [],
    this.selectedTicket,
    this.isLoading = false,
    this.error,
    this.filterStatus,
  });

  TicketState copyWith({
    List<TicketResponse>? tickets,
    TicketResponse? selectedTicket,
    bool? isLoading,
    String? error,
    TicketStatus? filterStatus,
  }) {
    return TicketState(
      tickets: tickets ?? this.tickets,
      selectedTicket: selectedTicket ?? this.selectedTicket,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      filterStatus: filterStatus ?? this.filterStatus,
    );
  }

  bool get hasError => error != null && error!.isNotEmpty;
  bool get hasTickets => tickets.isNotEmpty;
}

/// ==================== NOTIFIER ====================
class TicketNotifier extends StateNotifier<TicketState> {
  final TicketRepository _repository;

  TicketNotifier(this._repository) : super(const TicketState());

  Future<void> loadAllTickets() async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _repository.getAllTickets();

    result.fold(
          (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.message,
      ),
          (tickets) => state = state.copyWith(
        tickets: tickets,
        isLoading: false,
        error: null,
      ),
    );
  }

  Future<void> loadMyTickets() async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _repository.getMyTickets();

    result.fold(
          (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.message,
      ),
          (tickets) => state = state.copyWith(
        tickets: tickets,
        isLoading: false,
        error: null,
      ),
    );
  }

  Future<void> loadTicketsByTrip(int tripId) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _repository.getTicketsByTrip(tripId);

    result.fold(
          (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.message,
      ),
          (tickets) => state = state.copyWith(
        tickets: tickets,
        isLoading: false,
        error: null,
      ),
    );
  }

  Future<void> loadTicketById(int id) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _repository.getTicketWithDetails(id);

    result.fold(
          (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.message,
      ),
          (ticket) => state = state.copyWith(
        selectedTicket: ticket,
        isLoading: false,
        error: null,
      ),
    );
  }

  Future<bool> createTicket(TicketCreateRequest request) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _repository.createTicket(request);

    return result.fold(
          (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
      },
          (ticket) {
        final updatedTickets = [...state.tickets, ticket];
        state = state.copyWith(
          tickets: updatedTickets,
          isLoading: false,
          error: null,
        );
        return true;
      },
    );
  }

  Future<bool> updateTicket(int id, TicketUpdateRequest request) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _repository.updateTicket(id, request);

    return result.fold(
          (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
      },
          (updatedTicket) {
        final updatedTickets = state.tickets.map((t) {
          return t.id == id ? updatedTicket : t;
        }).toList();

        state = state.copyWith(
          tickets: updatedTickets,
          selectedTicket: updatedTicket,
          isLoading: false,
          error: null,
        );
        return true;
      },
    );
  }

  Future<bool> cancelTicket(int id) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _repository.cancelTicket(id);

    return result.fold(
          (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
      },
          (updatedTicket) {
        final updatedTickets = state.tickets.map((t) {
          return t.id == id ? updatedTicket : t;
        }).toList();

        state = state.copyWith(
          tickets: updatedTickets,
          isLoading: false,
          error: null,
        );
        return true;
      },
    );
  }

  Future<bool> deleteTicket(int id) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _repository.deleteTicket(id);

    return result.fold(
          (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
      },
          (_) {
        final updatedTickets = state.tickets.where((t) => t.id != id).toList();
        state = state.copyWith(
          tickets: updatedTickets,
          isLoading: false,
          error: null,
        );
        return true;
      },
    );
  }

  void filterByStatus(TicketStatus? status) {
    state = state.copyWith(filterStatus: status);
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  void clearState() {
    state = const TicketState();
  }

  void clearSelectedTicket() {
    state = state.copyWith(selectedTicket: null);
  }
}

/// ==================== PROVIDERS ====================

final ticketProvider =
StateNotifierProvider<TicketNotifier, TicketState>((ref) {
  final repository = ref.watch(ticketRepositoryProvider);
  return TicketNotifier(repository);
});

final ticketDetailProvider =
FutureProvider.family<TicketResponse, int>((ref, id) async {
  final repository = ref.watch(ticketRepositoryProvider);
  final result = await repository.getTicketWithDetails(id);

  return result.fold(
        (failure) => throw Exception(failure.message),
        (ticket) => ticket,
  );
});