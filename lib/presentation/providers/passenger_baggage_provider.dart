import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bus_connect/app.dart';
import '../../../data/models/baggage_model/baggage_model.dart';

/// ==================== TICKET BAGGAGE ====================
/// Obtiene todo el equipaje asociado a un ticket
final ticketBaggageProvider = FutureProvider.autoDispose.family<List<BaggageModel>, int>((ref, ticketId) async {
  final baggageRepo = ref.read(baggageRepositoryProvider);
  final result = await baggageRepo.getBaggageByTicket(ticketId);

  return result.fold(
        (failure) => throw Exception(failure.message),
        (baggageList) => baggageList,
  );
});

/// ==================== TRIP BAGGAGE ====================
/// Obtiene todo el equipaje de un viaje
final tripBaggageProvider = FutureProvider.autoDispose.family<List<BaggageModel>, int>((ref, tripId) async {
  final baggageRepo = ref.read(baggageRepositoryProvider);
  final result = await baggageRepo.getBaggageByTrip(tripId);

  return result.fold(
        (failure) => throw Exception(failure.message),
        (baggageList) => baggageList,
  );
});

/// ==================== BAGGAGE DETAILS ====================
/// Obtiene detalles de un equipaje específico
final baggageDetailsProvider = FutureProvider.autoDispose.family<BaggageModel, int>((ref, baggageId) async {
  final baggageRepo = ref.read(baggageRepositoryProvider);
  final result = await baggageRepo.getBaggageById(baggageId);

  return result.fold(
        (failure) => throw Exception(failure.message),
        (baggage) => baggage,
  );
});

/// ==================== BAGGAGE BY TAG CODE ====================
/// Busca equipaje por código de etiqueta
final baggageByTagProvider = FutureProvider.autoDispose.family<BaggageModel, String>((ref, tagCode) async {
  final baggageRepo = ref.read(baggageRepositoryProvider);
  final result = await baggageRepo.getBaggageByTagCode(tagCode);

  return result.fold(
        (failure) => throw Exception(failure.message),
        (baggage) => baggage,
  );
});

/// ==================== BAGGAGE FEE CALCULATOR ====================
/// Calcula la tarifa del equipaje según el peso
final baggageFeeCalculatorProvider = FutureProvider.autoDispose.family<double, double>((ref, weightKg) async {
  final baggageRepo = ref.read(baggageRepositoryProvider);
  final result = await baggageRepo.calculateBaggageFee(weightKg);

  return result.fold(
        (failure) => throw Exception(failure.message),
        (fee) => fee,
  );
});

/// ==================== TRIP TOTAL WEIGHT ====================
/// Obtiene el peso total del equipaje en un viaje
final tripTotalWeightProvider = FutureProvider.autoDispose.family<double, int>((ref, tripId) async {
  final baggageRepo = ref.read(baggageRepositoryProvider);
  final result = await baggageRepo.getTotalWeightByTrip(tripId);

  return result.fold(
        (failure) => throw Exception(failure.message),
        (totalWeight) => totalWeight,
  );
});

/// ==================== ADD BAGGAGE NOTIFIER ====================
final addBaggageProvider = StateNotifierProvider<AddBaggageNotifier, AsyncValue<BaggageModel?>>((ref) {
  return AddBaggageNotifier(ref);
});

class AddBaggageNotifier extends StateNotifier<AsyncValue<BaggageModel?>> {
  final Ref ref;

  AddBaggageNotifier(this.ref) : super(const AsyncValue.data(null));

  Future<void> addBaggage({
    required int ticketId,
    required double weightKg,
    required double fee,
  }) async {
    state = const AsyncValue.loading();

    try {
      final baggageRepo = ref.read(baggageRepositoryProvider);
      final request = BaggageCreateRequest(
        ticketId: ticketId,
        weightKg: weightKg,
        fee: fee,
      );

      final result = await baggageRepo.createBaggage(request);

      result.fold(
            (failure) => state = AsyncValue.error(failure.message, StackTrace.current),
            (baggage) {
          state = AsyncValue.data(baggage);
          // Invalidar lista para refrescar
          ref.invalidate(ticketBaggageProvider(ticketId));
        },
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  void clearBaggage() {
    state = const AsyncValue.data(null);
  }
}

/// ==================== UPDATE BAGGAGE NOTIFIER ====================
final updateBaggageProvider = StateNotifierProvider<UpdateBaggageNotifier, AsyncValue<BaggageModel?>>((ref) {
  return UpdateBaggageNotifier(ref);
});

class UpdateBaggageNotifier extends StateNotifier<AsyncValue<BaggageModel?>> {
  final Ref ref;

  UpdateBaggageNotifier(this.ref) : super(const AsyncValue.data(null));

  Future<void> updateBaggage({
    required int baggageId,
    required int ticketId,
    double? weightKg,
    double? fee,
  }) async {
    state = const AsyncValue.loading();

    try {
      final baggageRepo = ref.read(baggageRepositoryProvider);

      final request = BaggageUpdateRequest(
        weightKg: weightKg,
        fee: fee,
      );

      final result = await baggageRepo.updateBaggage(baggageId, request);

      result.fold(
            (failure) => state = AsyncValue.error(failure.message, StackTrace.current),
            (baggage) {
          state = AsyncValue.data(baggage);
          ref.invalidate(ticketBaggageProvider(ticketId));
          ref.invalidate(baggageDetailsProvider(baggageId));
        },
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

/// ==================== DELETE BAGGAGE NOTIFIER ====================
final deleteBaggageProvider = StateNotifierProvider<DeleteBaggageNotifier, AsyncValue<void>>((ref) {
  return DeleteBaggageNotifier(ref);
});

class DeleteBaggageNotifier extends StateNotifier<AsyncValue<void>> {
  final Ref ref;

  DeleteBaggageNotifier(this.ref) : super(const AsyncValue.data(null));

  Future<void> deleteBaggage(int baggageId, int ticketId) async {
    state = const AsyncValue.loading();

    try {
      final baggageRepo = ref.read(baggageRepositoryProvider);
      final result = await baggageRepo.deleteBaggage(baggageId);

      result.fold(
            (failure) => state = AsyncValue.error(failure.message, StackTrace.current),
            (_) {
          state = const AsyncValue.data(null);
          // Invalidar lista para refrescar
          ref.invalidate(ticketBaggageProvider(ticketId));
        },
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}