import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/incident_model/incident_model.dart';
import '../../data/repositories/incident_repository.dart';
import '../../core/constants/enums/entity_type.dart';
import '../../core/constants/enums/incident_type.dart';
import 'package:bus_connect/app.dart';



/// ==================== STATE ====================
class IncidentState {
  final List<IncidentResponse> incidents;
  final IncidentResponse? selectedIncident;
  final bool isLoading;
  final String? error;

  // Filtros
  final IncidentType? filterType;
  final EntityType? filterEntityType;
  final int? filterReportedBy;

  const IncidentState({
    this.incidents = const [],
    this.selectedIncident,
    this.isLoading = false,
    this.error,
    this.filterType,
    this.filterEntityType,
    this.filterReportedBy,
  });

  IncidentState copyWith({
    List<IncidentResponse>? incidents,
    IncidentResponse? selectedIncident,
    bool? isLoading,
    String? error,
    IncidentType? filterType,
    EntityType? filterEntityType,
    int? filterReportedBy,
  }) {
    return IncidentState(
      incidents: incidents ?? this.incidents,
      selectedIncident: selectedIncident ?? this.selectedIncident,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      filterType: filterType ?? this.filterType,
      filterEntityType: filterEntityType ?? this.filterEntityType,
      filterReportedBy: filterReportedBy ?? this.filterReportedBy,
    );
  }

  // ==================== GETTERS DERIVADOS ====================

  List<IncidentResponse> get filteredIncidents {
    var filtered = incidents;

    if (filterType != null) {
      filtered =
          filtered.where((i) => i.type.name == filterType!.name).toList();
    }

    if (filterEntityType != null) {
      filtered = filtered
          .where((i) => i.entityType.name == filterEntityType!.name)
          .toList();
    }

    if (filterReportedBy != null) {
      filtered =
          filtered.where((i) => i.reportedBy == filterReportedBy).toList();
    }

    return filtered;
  }

  Map<String, List<IncidentResponse>> get incidentsByType {
    final Map<String, List<IncidentResponse>> grouped = {};
    for (var incident in incidents) {
      grouped.putIfAbsent(incident.type.name, () => []);
      grouped[incident.type.name]!.add(incident);
    }
    return grouped;
  }
}

/// ==================== NOTIFIER ====================
class IncidentNotifier extends StateNotifier<IncidentState> {
  final IncidentRepository _repository;

  IncidentNotifier(this._repository) : super(const IncidentState());

  // ==================== FETCH INCIDENTS ====================

  Future<void> fetchAllIncidents() async {
    state = state.copyWith(isLoading: true);
    final result = await _repository.getAllIncidents();

    result.fold(
          (failure) => state =
          state.copyWith(isLoading: false, error: failure.message),
          (incidents) => state = state.copyWith(
        incidents: incidents,
        isLoading: false,
        error: null,
      ),
    );
  }

  Future<void> fetchIncidentById(int id) async {
    state = state.copyWith(isLoading: true);
    final result = await _repository.getIncidentById(id);

    result.fold(
          (failure) =>
      state = state.copyWith(isLoading: false, error: failure.message),
          (incident) => state = state.copyWith(
        selectedIncident: incident,
        isLoading: false,
      ),
    );
  }

  Future<void> fetchIncidentsByEntity(EntityType entityType, int entityId) async {
    state = state.copyWith(isLoading: true);
    final result = await _repository.getIncidentsByEntity(entityType, entityId);

    result.fold(
          (failure) =>
      state = state.copyWith(isLoading: false, error: failure.message),
          (incidents) => state =
          state.copyWith(incidents: incidents, isLoading: false, error: null),
    );
  }

  Future<void> fetchIncidentsByType(IncidentType type) async {
    state = state.copyWith(isLoading: true);
    final result = await _repository.getIncidentsByType(type);

    result.fold(
          (failure) =>
      state = state.copyWith(isLoading: false, error: failure.message),
          (incidents) => state =
          state.copyWith(incidents: incidents, isLoading: false, error: null),
    );
  }

  Future<void> fetchIncidentsByReportedBy(int reportedById) async {
    state = state.copyWith(isLoading: true);
    final result = await _repository.getIncidentsByReportedBy(reportedById);

    result.fold(
          (failure) =>
      state = state.copyWith(isLoading: false, error: failure.message),
          (incidents) => state =
          state.copyWith(incidents: incidents, isLoading: false, error: null),
    );
  }

  Future<void> fetchIncidentsByDateRange(String start, String end) async {
    state = state.copyWith(isLoading: true);
    final result = await _repository.getIncidentsByDateRange(start, end);

    result.fold(
          (failure) =>
      state = state.copyWith(isLoading: false, error: failure.message),
          (incidents) => state =
          state.copyWith(incidents: incidents, isLoading: false, error: null),
    );
  }

  Future<int?> fetchIncidentsCountByType(
      IncidentType type, String since) async {
    final result = await _repository.countIncidentsByType(type, since);
    return result.fold(
          (failure) {
        state = state.copyWith(error: failure.message);
        return null;
      },
          (count) => count,
    );
  }

  // ==================== CRUD ====================

  Future<bool> createIncident(IncidentCreateRequest request) async {
    state = state.copyWith(isLoading: true);
    final result = await _repository.createIncident(request);

    return result.fold(
          (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
      },
          (incident) {
        final updated = [incident, ...state.incidents];
        state =
            state.copyWith(incidents: updated, isLoading: false, error: null);
        return true;
      },
    );
  }

  Future<bool> updateIncident(int id, IncidentUpdateRequest request) async {
    state = state.copyWith(isLoading: true);
    final result = await _repository.updateIncident(id, request);

    return result.fold(
          (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
      },
          (incident) {
        final updated = state.incidents.map((i) => i.id == id ? incident : i).toList();
        state = state.copyWith(
          incidents: updated,
          selectedIncident: incident,
          isLoading: false,
          error: null,
        );
        return true;
      },
    );
  }

  Future<bool> deleteIncident(int id) async {
    state = state.copyWith(isLoading: true);
    final result = await _repository.deleteIncident(id);

    return result.fold(
          (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
      },
          (_) {
        final updated = state.incidents.where((i) => i.id != id).toList();
        state = state.copyWith(
          incidents: updated,
          selectedIncident: null,
          isLoading: false,
          error: null,
        );
        return true;
      },
    );
  }

  // ==================== FILTERS ====================

  void setTypeFilter(IncidentType? type) {
    state = state.copyWith(filterType: type);
  }

  void setEntityTypeFilter(EntityType? entityType) {
    state = state.copyWith(filterEntityType: entityType);
  }

  void setReportedByFilter(int? reportedBy) {
    state = state.copyWith(filterReportedBy: reportedBy);
  }

  void clearFilters() {
    state = state.copyWith(
      filterType: null,
      filterEntityType: null,
      filterReportedBy: null,
    );
  }

  // ==================== HELPERS ====================

  void clearSelectedIncident() {
    state = state.copyWith(selectedIncident: null);
  }

  void selectIncident(IncidentResponse incident) {
    state = state.copyWith(selectedIncident: incident);
  }
}

/// ==================== PROVIDER ====================

final incidentProvider =
StateNotifierProvider<IncidentNotifier, IncidentState>((ref) {
  final repository = ref.watch(incidentRepositoryProvider);
  return IncidentNotifier(repository);
});
