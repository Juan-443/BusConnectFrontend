import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/ticket_model/ticket_model.dart';
import 'package:bus_connect/app.dart';
import 'package:bus_connect/presentation/providers/current_user_provider.dart';


final passengerTicketsProvider = FutureProvider.autoDispose<List<TicketResponse>>((ref) async {
  final currentUser = ref.read(currentUserProvider);

  if (currentUser.isLoading || !currentUser.isAuthenticated) {
    return [];
  }

  try {
    final ticketRepo = ref.read(ticketRepositoryProvider);

    final result = await ticketRepo.getMyTickets();

    return result.fold(
          (failure) => [],
          (tickets) => tickets,
    );
  } catch (e) {
    return [];
  }
});

final ticketDetailProvider = FutureProvider.autoDispose.family<TicketResponse, int>((ref, ticketId) async {
  final ticketRepo = ref.read(ticketRepositoryProvider);
  final result = await ticketRepo.getTicketById(ticketId);

  return result.fold(
        (failure) => throw Exception(failure.message),
        (ticket) => ticket,
  );
});

final cancelTicketProvider = StateNotifierProvider<CancelTicketNotifier, AsyncValue<void>>((ref) {
  return CancelTicketNotifier(ref);
});

class CancelTicketNotifier extends StateNotifier<AsyncValue<void>> {
  final Ref ref;

  CancelTicketNotifier(this.ref) : super(const AsyncValue.data(null));

  Future<void> cancelTicket(int ticketId) async {
    state = const AsyncValue.loading();

    try {
      final ticketRepo = ref.read(ticketRepositoryProvider);
      final result = await ticketRepo.cancelTicket(ticketId);

      result.fold(
            (failure) => throw Exception(failure.message),
            (_) {
          ref.invalidate(passengerTicketsProvider);
          state = const AsyncValue.data(null);
        },
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}