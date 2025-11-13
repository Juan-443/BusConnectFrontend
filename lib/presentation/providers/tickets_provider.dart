import 'package:bus_connect/presentation/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/providers/ticket_api_provider.dart';
import '../../data/repositories/ticket_repository.dart';
import '../../data/models/ticket_model/ticket_model.dart';

/// ==================== API PROVIDER ====================
final ticketApiProvider = Provider<TicketApiProvider>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return TicketApiProvider(apiClient.dio);
});

/// ==================== REPOSITORY PROVIDER ====================
final ticketRepositoryProvider = Provider<TicketRepository>((ref) {
  final apiProvider = ref.watch(ticketApiProvider);
  return TicketRepository(apiProvider);
});

/// ==================== STATE ====================
class TicketState {
  final List<TicketResponse> tickets;
  final bool isLoading;
  final String? error;

  const TicketState({
    this.tickets = const [],
    this.isLoading = false,
    this.error,
  });

  TicketState copyWith({
    List<TicketResponse>? tickets,
    bool? isLoading,
    String? error,
  }) {
    return TicketState(
      tickets: tickets ?? this.tickets,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  bool get hasError => error != null && error!.isNotEmpty;
  bool get hasTickets => tickets.isNotEmpty;
}

/// ==================== NOTIFIER ====================
class TicketNotifier extends StateNotifier<TicketState> {
  final TicketRepository _repository;

  TicketNotifier(this._repository) : super(const TicketState());

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

  void clearError() {
    state = state.copyWith(error: null);
  }

  void clearState() {
    state = const TicketState();
  }
}

/// ==================== PROVIDERS ====================

/// Proveedor principal para gestionar todos los tickets
final ticketProvider =
StateNotifierProvider<TicketNotifier, TicketState>((ref) {
  final repository = ref.watch(ticketRepositoryProvider);
  return TicketNotifier(repository);
});

/// Proveedor para obtener un ticket con sus detalles (FutureProvider)
final ticketDetailProvider =
FutureProvider.family<TicketResponse, int>((ref, id) async {
  final repository = ref.watch(ticketRepositoryProvider);
  final result = await repository.getTicketWithDetails(id);

  return result.fold(
        (failure) => throw Exception(failure.message),
        (ticket) => ticket,
  );
});
