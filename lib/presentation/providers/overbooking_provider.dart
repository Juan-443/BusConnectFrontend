import 'package:bus_connect/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dartz/dartz.dart';
import '../../data/models/overbooking_model/overbooking_model.dart';
import '../../data/repositories/overbooking_repository.dart';
import '../../core/errors/failures.dart';

// ==================== STATE ====================
class OverbookingState {
  final List<OverbookingResponse> requests;
  final OverbookingResponse? selectedRequest;
  final bool isLoading;
  final String? error;
  final int? filterTripId;

  OverbookingState({
    this.requests = const [],
    this.selectedRequest,
    this.isLoading = false,
    this.error,
    this.filterTripId,
  });

  OverbookingState copyWith({
    List<OverbookingResponse>? requests,
    OverbookingResponse? selectedRequest,
    bool? isLoading,
    String? error,
    int? filterTripId,
  }) {
    return OverbookingState(
      requests: requests ?? this.requests,
      selectedRequest: selectedRequest ?? this.selectedRequest,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      filterTripId: filterTripId ?? this.filterTripId,
    );
  }

  List<OverbookingResponse> get pendingRequests =>
      requests.where((r) => r.status.name == 'PENDING_APPROVAL').toList();

  List<OverbookingResponse> get filteredRequests {
    if (filterTripId == null) return requests;
    return requests.where((r) => r.tripId == filterTripId).toList();
  }
}

// ==================== NOTIFIER ====================
class OverbookingNotifier extends StateNotifier<OverbookingState> {
  final OverbookingRepository _repository;

  OverbookingNotifier(this._repository) : super(OverbookingState());

  // ==================== FETCH ====================
  Future<void> fetchPendingRequests() async {
    state = state.copyWith(isLoading: true, error: null);
    final Either<Failure, List<OverbookingResponse>> result =
    await _repository.getPendingRequests();
    result.fold(
          (failure) => state = state.copyWith(isLoading: false, error: failure.message),
          (requests) => state = state.copyWith(isLoading: false, requests: requests, error: null),
    );
  }

  Future<void> fetchRequestsByTrip(int tripId) async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await _repository.getOverbookingRequestsByTrip(tripId);
    result.fold(
          (failure) => state = state.copyWith(isLoading: false, error: failure.message),
          (requests) => state = state.copyWith(isLoading: false, requests: requests, error: null),
    );
  }

  Future<void> fetchRequestById(int id) async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await _repository.getOverbookingRequestById(id);
    result.fold(
          (failure) => state = state.copyWith(isLoading: false, error: failure.message),
          (request) => state.copyWith(isLoading: false, selectedRequest: request, error: null),
    );
  }

  // ==================== ACTIONS ====================
  Future<bool> requestOverbooking(OverbookingCreateRequest request) async {
    state = state.copyWith(isLoading: true);
    final result = await _repository.requestOverbooking(request);
    state = state.copyWith(isLoading: false);

    return result.fold(
          (failure) {
        state = state.copyWith(error: failure.message);
        return false;
      },
          (overbooking) {
        state = state.copyWith(
          requests: [overbooking, ...state.requests],
          error: null,
        );
        return true;
      },
    );
  }

  Future<bool> approveRequest(int id, OverbookingApproveRequest request) async {
    state = state.copyWith(isLoading: true);
    final result = await _repository.approveOverbooking(id, request);
    state = state.copyWith(isLoading: false);

    return result.fold(
          (failure) {
        state = state.copyWith(error: failure.message);
        return false;
      },
          (overbooking) {
        final updatedRequests = state.requests.map((r) => r.id == id ? overbooking : r).toList();
        final updatedSelected = state.selectedRequest?.id == id ? overbooking : state.selectedRequest;
        state = state.copyWith(requests: updatedRequests, selectedRequest: updatedSelected, error: null);
        return true;
      },
    );
  }

  Future<bool> rejectRequest(int id, OverbookingRejectRequest request) async {
    state = state.copyWith(isLoading: true);
    final result = await _repository.rejectOverbooking(id, request);
    state = state.copyWith(isLoading: false);

    return result.fold(
          (failure) {
        state = state.copyWith(error: failure.message);
        return false;
      },
          (overbooking) {
        final updatedRequests = state.requests.map((r) => r.id == id ? overbooking : r).toList();
        final updatedSelected = state.selectedRequest?.id == id ? overbooking : state.selectedRequest;
        state = state.copyWith(requests: updatedRequests, selectedRequest: updatedSelected, error: null);
        return true;
      },
    );
  }

  // ==================== VALIDATION ====================
  Future<bool> checkCanOverbook(int tripId) async {
    final result = await _repository.canOverbook(tripId);
    return result.fold((_) => false, (can) => can);
  }

  Future<double?> getOccupancyRate(int tripId) async {
    final result = await _repository.getCurrentOccupancyRate(tripId);
    return result.fold((_) => null, (rate) => rate);
  }

  // ==================== FILTERS ====================
  void setTripFilter(int? tripId) {
    state = state.copyWith(filterTripId: tripId);
  }

  void clearFilter() {
    state = state.copyWith(filterTripId: null);
  }

  // ==================== SELECT ====================
  void selectRequest(OverbookingResponse request) {
    state = state.copyWith(selectedRequest: request);
  }

  void clearSelectedRequest() {
    state = state.copyWith(selectedRequest: null);
  }
}

// ==================== PROVIDERS ====================
final overbookingRepositoryProvider = Provider<OverbookingRepository>(
      (ref) => OverbookingRepository(ref.watch(overbookingApiProvider)),
);

final overbookingProvider = StateNotifierProvider<OverbookingNotifier, OverbookingState>(
      (ref) => OverbookingNotifier(ref.watch(overbookingRepositoryProvider)),
);
