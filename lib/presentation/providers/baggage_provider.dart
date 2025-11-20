import 'package:bus_connect/data/repositories/baggage_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bus_connect/app.dart';
import '../../data/models/baggage_model/baggage_model.dart';

// ==================== STATE ====================

class BaggageState {
  final List<BaggageResponse> baggageList;
  final BaggageResponse? selectedBaggage;
  final bool isLoading;
  final String? error;
  final double? calculatedFee;
  final double? totalWeight;

  const BaggageState({
    this.baggageList = const [],
    this.selectedBaggage,
    this.isLoading = false,
    this.error,
    this.calculatedFee,
    this.totalWeight,
  });

  BaggageState copyWith({
    List<BaggageResponse>? baggageList,
    BaggageResponse? selectedBaggage,
    bool? isLoading,
    String? error,
    double? calculatedFee,
    double? totalWeight,
  }) {
    return BaggageState(
      baggageList: baggageList ?? this.baggageList,
      selectedBaggage: selectedBaggage ?? this.selectedBaggage,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      calculatedFee: calculatedFee ?? this.calculatedFee,
      totalWeight: totalWeight ?? this.totalWeight,
    );
  }
}

// ==================== NOTIFIER ====================

class BaggageNotifier extends StateNotifier<BaggageState> {
  final BaggageRepository _repository;

  BaggageNotifier(this._repository) : super(const BaggageState());

  // ==================== QUERIES ====================

  Future<void> fetchAllBaggage() async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await _repository.getAllBaggage();
    result.fold(
          (failure) =>
      state = state.copyWith(isLoading: false, error: failure.message),
          (baggage) =>
      state = state.copyWith(baggageList: baggage, isLoading: false),
    );
  }

  Future<void> fetchBaggageById(int id) async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await _repository.getBaggageById(id);
    result.fold(
          (failure) =>
      state = state.copyWith(isLoading: false, error: failure.message),
          (baggage) =>
      state = state.copyWith(selectedBaggage: baggage, isLoading: false),
    );
  }

  Future<void> fetchBaggageByTagCode(String tagCode) async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await _repository.getBaggageByTagCode(tagCode);
    result.fold(
          (failure) =>
      state = state.copyWith(isLoading: false, error: failure.message),
          (baggage) =>
      state = state.copyWith(selectedBaggage: baggage, isLoading: false),
    );
  }

  Future<void> fetchBaggageByTrip(int tripId) async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await _repository.getBaggageByTrip(tripId);
    result.fold(
          (failure) =>
      state = state.copyWith(isLoading: false, error: failure.message),
          (baggage) =>
      state = state.copyWith(baggageList: baggage, isLoading: false),
    );
  }

  Future<void> fetchBaggageByTicket(int ticketId) async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await _repository.getBaggageByTicket(ticketId);
    result.fold(
          (failure) =>
      state = state.copyWith(isLoading: false, error: failure.message),
          (baggage) =>
      state = state.copyWith(baggageList: baggage, isLoading: false),
    );
  }

  // ==================== MUTATIONS ====================

  Future<bool> createBaggage(BaggageCreateRequest request) async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await _repository.createBaggage(request);
    return result.fold(
          (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
      },
          (baggage) {
        state = state.copyWith(
          isLoading: false,
          baggageList: [...state.baggageList, baggage],
          selectedBaggage: baggage,
        );
        return true;
      },
    );
  }

  Future<bool> updateBaggage(int id, BaggageUpdateRequest request) async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await _repository.updateBaggage(id, request);
    return result.fold(
          (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
      },
          (baggage) {
        final updated = state.baggageList
            .map((b) => b.id == id ? baggage : b)
            .toList();
        state = state.copyWith(
          isLoading: false,
          baggageList: updated,
          selectedBaggage: baggage,
        );
        return true;
      },
    );
  }

  Future<bool> deleteBaggage(int id) async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await _repository.deleteBaggage(id);
    return result.fold(
          (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
      },
          (_) {
        final updated = state.baggageList.where((b) => b.id != id).toList();
        state = state.copyWith(isLoading: false, baggageList: updated);
        return true;
      },
    );
  }

  // ==================== CALCULATIONS ====================

  Future<void> calculateFee(double weightKg) async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await _repository.calculateBaggageFee(weightKg);
    result.fold(
          (failure) =>
      state = state.copyWith(isLoading: false, error: failure.message),
          (fee) => state = state.copyWith(
        isLoading: false,
        calculatedFee: fee,
      ),
    );
  }

  Future<void> getTotalWeightByTrip(int tripId) async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await _repository.getTotalWeightByTrip(tripId);
    result.fold(
          (failure) =>
      state = state.copyWith(isLoading: false, error: failure.message),
          (weight) => state = state.copyWith(
        isLoading: false,
        totalWeight: weight,
      ),
    );
  }

  // ==================== UTILITIES ====================

  void clearError() {
    state = state.copyWith(error: null);
  }

  void clearSelectedBaggage() {
    state = state.copyWith(selectedBaggage: null);
  }

  void clearCalculations() {
    state = state.copyWith(calculatedFee: null, totalWeight: null);
  }
}

// ==================== PROVIDER ====================

final baggageProvider =
StateNotifierProvider<BaggageNotifier, BaggageState>((ref) {
  final repository = ref.watch(baggageRepositoryProvider); // ← Viene de app.dart
  return BaggageNotifier(repository);
});

// ==================== DETAIL PROVIDER ====================

final baggageDetailProvider =
FutureProvider.family<BaggageResponse, int>((ref, id) async {
  final repository = ref.watch(baggageRepositoryProvider); // ← Viene de app.dart
  final result = await repository.getBaggageById(id);

  return result.fold(
        (failure) => throw Exception(failure.message),
        (baggage) => baggage,
  );
});