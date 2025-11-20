import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/fare_rule_model/fare_rule_model.dart';
import '../../data/repositories/fare_rule_repository.dart';
import 'package:bus_connect/app.dart';


/// ==================== STATE ====================
class FareRuleState {
  final List<FareRuleResponse> fareRules;
  final FareRuleResponse? selectedFareRule;
  final bool isLoading;
  final String? error;
  final int? filterRouteId;

  const FareRuleState({
    this.fareRules = const [],
    this.selectedFareRule,
    this.isLoading = false,
    this.error,
    this.filterRouteId,
  });

  FareRuleState copyWith({
    List<FareRuleResponse>? fareRules,
    FareRuleResponse? selectedFareRule,
    bool? isLoading,
    String? error,
    int? filterRouteId,
    bool clearFilter = false,
  }) {
    return FareRuleState(
      fareRules: fareRules ?? this.fareRules,
      selectedFareRule: selectedFareRule ?? this.selectedFareRule,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      filterRouteId: clearFilter ? null : (filterRouteId ?? this.filterRouteId),
    );
  }

  List<FareRuleResponse> get filteredFareRules {
    if (filterRouteId == null) return fareRules;
    return fareRules.where((f) => f.routeId == filterRouteId).toList();
  }

  List<FareRuleResponse> get dynamicPricingRules {
    return fareRules.where((f) => f.dynamicPricing.name == 'ON').toList();
  }
}

/// ==================== NOTIFIER ====================
class FareRuleNotifier extends StateNotifier<FareRuleState> {
  final FareRuleRepository _repository;

  FareRuleNotifier(this._repository) : super(const FareRuleState());

  // ==================== FETCH ====================

  Future<void> fetchAllFareRules() async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await _repository.getAllFareRules();

    result.fold(
          (failure) => state = state.copyWith(isLoading: false, error: failure.message),
          (fareRules) => state = state.copyWith(
        fareRules: fareRules,
        isLoading: false,
      ),
    );
  }

  Future<void> fetchFareRuleById(int id) async {
    state = state.copyWith(isLoading: true);
    final result = await _repository.getFareRuleById(id);

    result.fold(
          (failure) => state = state.copyWith(isLoading: false, error: failure.message),
          (fareRule) => state = state.copyWith(
        selectedFareRule: fareRule,
        isLoading: false,
      ),
    );
  }

  Future<void> fetchFareRulesByRoute(int routeId) async {
    state = state.copyWith(isLoading: true);
    final result = await _repository.getFareRulesByRoute(routeId);

    result.fold(
          (failure) => state = state.copyWith(isLoading: false, error: failure.message),
          (fareRules) => state = state.copyWith(
        fareRules: fareRules,
        isLoading: false,
      ),
    );
  }

  Future<void> fetchFareRuleForSegment({
    required int routeId,
    required int fromStopId,
    required int toStopId,
  }) async {
    state = state.copyWith(isLoading: true);
    final result = await _repository.getFareRuleForSegment(
      routeId: routeId,
      fromStopId: fromStopId,
      toStopId: toStopId,
    );

    result.fold(
          (failure) => state = state.copyWith(isLoading: false, error: failure.message),
          (fareRule) => state = state.copyWith(
        selectedFareRule: fareRule,
        isLoading: false,
      ),
    );
  }

  Future<void> fetchDynamicPricingRules(int routeId) async {
    state = state.copyWith(isLoading: true);
    final result = await _repository.getDynamicPricingRules(routeId);

    result.fold(
          (failure) => state = state.copyWith(isLoading: false, error: failure.message),
          (fareRules) => state = state.copyWith(
        fareRules: fareRules,
        isLoading: false,
      ),
    );
  }

  // ==================== CRUD ====================

  Future<bool> createFareRule(FareRuleCreateRequest request) async {
    state = state.copyWith(isLoading: true);
    final result = await _repository.createFareRule(request);

    return result.fold(
          (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
      },
          (fareRule) {
        final updated = [...state.fareRules, fareRule];
        state = state.copyWith(fareRules: updated, isLoading: false, error: null);
        return true;
      },
    );
  }

  Future<bool> updateFareRule(int id, FareRuleUpdateRequest request) async {
    state = state.copyWith(isLoading: true);
    final result = await _repository.updateFareRule(id, request);

    return result.fold(
          (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
      },
          (fareRule) {
        final updated = state.fareRules.map((f) => f.id == id ? fareRule : f).toList();
        state = state.copyWith(
          fareRules: updated,
          selectedFareRule: fareRule,
        );
        return true;
      },
    );
  }

  Future<bool> deleteFareRule(int id) async {
    state = state.copyWith(isLoading: true);
    final result = await _repository.deleteFareRule(id);

    return result.fold(
          (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
      },
          (_) {
        final updated = state.fareRules.where((f) => f.id != id).toList();
        state = state.copyWith(
          fareRules: updated,
          isLoading: false,
        );
        return true;
      },
    );
  }

  // ==================== CALCULATIONS ====================

  Future<double?> calculateDynamicPrice(int id, double occupancyRate) async {
    final result = await _repository.calculateDynamicPrice(id, occupancyRate);
    return result.fold(
          (failure) {
        state = state.copyWith(error: failure.message);
        return null;
      },
          (price) => price,
    );
  }

  // ==================== FILTERS ====================

  void setRouteFilter(int? routeId) {
    state = state.copyWith(filterRouteId: routeId, clearFilter: routeId == null);
  }

  void clearFilter() {
    state = state.copyWith(selectedFareRule: null);
  }

  // ==================== HELPERS ====================

  void clearSelectedFareRule() {
    state = state.copyWith(selectedFareRule: null);
  }

}

/// ==================== PROVIDER ====================

final fareRuleProvider =
StateNotifierProvider<FareRuleNotifier, FareRuleState>((ref) {
  final repository = ref.watch(fareRuleRepositoryProvider);
  return FareRuleNotifier(repository);
});
