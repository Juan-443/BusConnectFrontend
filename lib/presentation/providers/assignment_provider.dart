import 'package:bus_connect/app.dart';
import 'package:bus_connect/core/constants/enums/trip_status.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/assignment_model/assignment_model.dart';
import '../../data/repositories/assignment_repository.dart';


// ==================== STATE ====================

class AssignmentState {
  final List<AssignmentResponse> assignments;
  final AssignmentResponse? selectedAssignment;
  final bool isLoading;
  final String? error;
  final int? filterDriverId;
  final int? filterDispatcherId;
  final String? filterDate;

  const AssignmentState({
    this.assignments = const [],
    this.selectedAssignment,
    this.isLoading = false,
    this.error,
    this.filterDriverId,
    this.filterDispatcherId,
    this.filterDate,
  });

  List<AssignmentResponse> get activeAssignments => assignments.where((a) {
    final status = a.trip?.status;
    return status == TripStatus.BOARDING || status == TripStatus.DEPARTED;
  }).toList();

  AssignmentState copyWith({
    List<AssignmentResponse>? assignments,
    AssignmentResponse? selectedAssignment,
    bool? isLoading,
    String? error,
    int? filterDriverId,
    int? filterDispatcherId,
    String? filterDate,
  }) {
    return AssignmentState(
      assignments: assignments ?? this.assignments,
      selectedAssignment: selectedAssignment ?? this.selectedAssignment,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      filterDriverId: filterDriverId ?? this.filterDriverId,
      filterDispatcherId: filterDispatcherId ?? this.filterDispatcherId,
      filterDate: filterDate ?? this.filterDate,
    );
  }
}

// ==================== NOTIFIER ====================

class AssignmentNotifier extends StateNotifier<AssignmentState> {
  final AssignmentRepository _repository;

  AssignmentNotifier(this._repository) : super(const AssignmentState());

  // ==================== FETCH ====================

  Future<void> fetchAllAssignments() async {
    state = state.copyWith(isLoading: true);
    final result = await _repository.getAllAssignments();
    result.fold(
          (failure) => state = state.copyWith(isLoading: false, error: failure.message),
          (assignments) => state = state.copyWith(
        assignments: assignments,
        isLoading: false,
        error: null,
      ),
    );
  }

  Future<void> fetchAssignmentById(int id) async {
    state = state.copyWith(isLoading: true);
    final result = await _repository.getAssignmentById(id);
    result.fold(
          (failure) => state = state.copyWith(isLoading: false, error: failure.message),
          (assignment) => state = state.copyWith(
        selectedAssignment: assignment,
        isLoading: false,
        error: null,
      ),
    );
  }

  // ==================== CRUD ====================

  Future<bool> createAssignment(AssignmentCreateRequest request) async {
    state = state.copyWith(isLoading: true);
    final result = await _repository.createAssignment(request);
    return result.fold(
          (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
      },
          (assignment) {
        state = state.copyWith(
          assignments: [...state.assignments, assignment],
          isLoading: false,
          error: null,
        );
        return true;
      },
    );
  }

  Future<bool> updateAssignment(int id, AssignmentUpdateRequest request) async {
    state = state.copyWith(isLoading: true);
    final result = await _repository.updateAssignment(id, request);
    return result.fold(
          (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
      },
          (assignment) {
        final updated = state.assignments.map((a) {
          return a.id == id ? assignment : a;
        }).toList();
        state = state.copyWith(assignments: updated, isLoading: false, error: null);
        return true;
      },
    );
  }
  Future<bool> approveChecklist(int id) async {
    state = state.copyWith(isLoading: true);
    final result = await _repository.approveChecklist(id);
    return result.fold(
          (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
      },
          (assignment) {
        final updated = state.assignments.map((a) => a.id == id ? assignment : a).toList();
        state = state.copyWith(assignments: updated, isLoading: false, error: null);
        return true;
      },
    );
  }

  Future<bool> deleteAssignment(int id) async {
    state = state.copyWith(isLoading: true);
    final result = await _repository.deleteAssignment(id);
    return result.fold(
          (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
      },
          (_) {
        final updated = state.assignments.where((a) => a.id != id).toList();
        state = state.copyWith(assignments: updated, isLoading: false, error: null);
        return true;
      },
    );
  }

  // ==================== FILTERS ====================

  void setDriverFilter(int? driverId) {
    state = state.copyWith(filterDriverId: driverId);
  }

  void setDispatcherFilter(int? dispatcherId) {
    state = state.copyWith(filterDispatcherId: dispatcherId);
  }

  void setDateFilter(String? date) {
    state = state.copyWith(filterDate: date);
  }

  void clearFilters() {
    state = state.copyWith(
      filterDriverId: null,
      filterDispatcherId: null,
      filterDate: null,
    );
  }

  // ==================== HELPERS ====================

  void clearError() => state = state.copyWith(error: null);

  void clearSelectedAssignment() =>
      state = state.copyWith(selectedAssignment: null);
}

// ==================== PROVIDERS ====================

// Repository provider
final assignmentRepositoryProvider = Provider<AssignmentRepository>((ref) {
  final apiProvider = ref.watch(assignmentApiProvider);
  return AssignmentRepository(apiProvider);
});

// StateNotifier provider
final assignmentProvider =
StateNotifierProvider<AssignmentNotifier, AssignmentState>((ref) {
  final repository = ref.watch(assignmentRepositoryProvider);
  return AssignmentNotifier(repository);
});
