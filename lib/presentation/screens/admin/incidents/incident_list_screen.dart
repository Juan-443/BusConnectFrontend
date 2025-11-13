import 'package:bus_connect/data/models/incident_model/incident_model.dart';
import 'package:bus_connect/presentation/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/enums/entity_type.dart';
import '../../../../core/constants/enums/incident_type.dart';
import '../../../widgets/common/loading_indicator.dart';
import '../../../widgets/common/error_widget.dart' as custom;
import '../../../../core/utils/date_formatter.dart';
import '../../../providers/incident_provider.dart';

class IncidentListScreen extends ConsumerStatefulWidget {
  const IncidentListScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<IncidentListScreen> createState() => _IncidentListScreenState();
}

class _IncidentListScreenState extends ConsumerState<IncidentListScreen> {
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(incidentProvider.notifier).fetchAllIncidents();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Incidentes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showCreateIncidentDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildFilterChips(),
          _buildStatistics(),
          Expanded(child: _buildIncidentList()),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Buscar incidentes...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
        ),
        onChanged: (value) {
          setState(() => _searchQuery = value);
        },
      ),
    );
  }

  Widget _buildFilterChips() {
    final state = ref.watch(incidentProvider);
    final provider = ref.read(incidentProvider.notifier);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          if (state.filterType != null)
            Chip(
              label: Text('Tipo: ${state.filterType!.name}'),
              onDeleted: () => provider.setTypeFilter(null),
            ),
          if (state.filterEntityType != null) ...[
            const SizedBox(width: 8),
            Chip(
              label: Text('Entidad: ${state.filterEntityType!.name}'),
              onDeleted: () => provider.setEntityTypeFilter(null),
            ),
          ],
          if (state.filterType != null || state.filterEntityType != null) ...[
            const SizedBox(width: 8),
            ActionChip(
              label: const Text('Limpiar filtros'),
              onPressed: () => provider.clearFilters(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatistics() {
    final state = ref.watch(incidentProvider);
    final byType = state.incidentsByType;

    if (byType.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Resumen por tipo',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: byType.entries.map((entry) {
              return Chip(
                avatar: CircleAvatar(
                  backgroundColor: _getIncidentColor(entry.key),
                  child: Text(
                    '${entry.value.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
                label: Text(entry.key),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildIncidentList() {
    final state = ref.watch(incidentProvider);
    final provider = ref.read(incidentProvider.notifier);

    if (state.isLoading) return const LoadingIndicator();

    if (state.error != null) {
      return custom.ErrorDisplay(
        message: state.error!,
        onRetry: () => provider.fetchAllIncidents(),
      );
    }

    var incidents = state.filteredIncidents;

    if (_searchQuery.isNotEmpty) {
      incidents = incidents.where((incident) {
        return incident.type.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            (incident.note?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false) ||
            (incident.reportedByName?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false);
      }).toList();
    }

    if (incidents.isEmpty) {
      return const Center(child: Text('No se encontraron incidentes'));
    }

    return RefreshIndicator(
      onRefresh: () => provider.fetchAllIncidents(),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: incidents.length,
        itemBuilder: (context, index) {
          final incident = incidents[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ExpansionTile(
              leading: CircleAvatar(
                backgroundColor: _getIncidentColor(incident.type.name),
                child: Icon(
                  _getIncidentIcon(incident.type.name),
                  color: Colors.white,
                ),
              ),
              title: Text(
                _getIncidentTypeDisplayName(incident.type.name),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  if (incident.note != null)
                    Text(
                      incident.note!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.person, size: 14, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        incident.reportedByName ?? 'Desconocido',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                      const SizedBox(width: 16),
                      Icon(Icons.access_time, size: 14, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        DateFormatter.formatRelativeTime(incident.createdAt),
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
              trailing: PopupMenuButton(
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'edit',
                    child: Row(
                      children: [
                        Icon(Icons.edit),
                        SizedBox(width: 8),
                        Text('Editar'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete, color: Colors.red),
                        SizedBox(width: 8),
                        Text('Eliminar', style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),
                ],
                onSelected: (value) => _handleMenuAction(value, incident, provider),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow('Tipo de entidad:', incident.entityType.name),
                      const SizedBox(height: 8),
                      _buildInfoRow('ID de entidad:', incident.entityId.toString()),
                      const SizedBox(height: 8),
                      _buildInfoRow('Reportado por:', incident.reportedByName ?? '--'),
                      const SizedBox(height: 8),
                      _buildInfoRow(
                        'Fecha:',
                        DateFormatter.formatDateTime(incident.createdAt),
                      ),
                      if (incident.note != null) ...[
                        const SizedBox(height: 16),
                        const Text(
                          'Descripción:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(incident.note!),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(width: 8),
        Expanded(child: Text(value)),
      ],
    );
  }

  Color _getIncidentColor(String type) {
    switch (type) {
      case 'SECURITY':
        return Colors.red;
      case 'VEHICLE':
        return Colors.orange;
      case 'DELIVERY_FAIL':
        return Colors.amber;
      case 'OVERBOOK':
        return Colors.purple;
      case 'PASSENGER_COMPLAINT':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  IconData _getIncidentIcon(String type) {
    switch (type) {
      case 'SECURITY':
        return Icons.security;
      case 'VEHICLE':
        return Icons.build;
      case 'DELIVERY_FAIL':
        return Icons.local_shipping;
      case 'OVERBOOK':
        return Icons.people;
      case 'PASSENGER_COMPLAINT':
        return Icons.report_problem;
      default:
        return Icons.warning;
    }
  }

  String _getIncidentTypeDisplayName(String type) {
    switch (type) {
      case 'SECURITY':
        return 'Seguridad';
      case 'VEHICLE':
        return 'Vehículo';
      case 'DELIVERY_FAIL':
        return 'Fallo en entrega';
      case 'OVERBOOK':
        return 'Sobreventa';
      case 'PASSENGER_COMPLAINT':
        return 'Queja de pasajero';
      case 'OTHER':
        return 'Otro';
      default:
        return type;
    }
  }

  void _handleMenuAction(dynamic value, IncidentResponse incident, IncidentNotifier provider) {
    switch (value) {
      case 'edit':
        _showEditIncidentDialog(incident);
        break;
      case 'delete':
        _confirmDelete(incident);
        break;
    }
  }

  // ==================== DIALOGS ====================

  void _showCreateIncidentDialog() {
    final formKey = GlobalKey<FormState>();
    IncidentType selectedType = IncidentType.OTHER;
    EntityType selectedEntityType = EntityType.TRIP;
    final entityIdController = TextEditingController();
    final noteController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Reportar Incidente'),
          content: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<IncidentType>(
                    initialValue: selectedType,
                    decoration: const InputDecoration(
                      labelText: 'Tipo de incidente',
                      border: OutlineInputBorder(),
                    ),
                    items: IncidentType.values.map((type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text(_getIncidentTypeDisplayName(type.name.toUpperCase())),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() => selectedType = value!);
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<EntityType>(
                    initialValue: selectedEntityType,
                    decoration: const InputDecoration(
                      labelText: 'Tipo de entidad',
                      border: OutlineInputBorder(),
                    ),
                    items: EntityType.values.map((type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text(type.name.toUpperCase()),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() => selectedEntityType = value!);
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: entityIdController,
                    decoration: const InputDecoration(
                      labelText: 'ID de entidad',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'El ID es requerido';
                      }
                      if (int.tryParse(value) == null) {
                        return 'ID inválido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: noteController,
                    decoration: const InputDecoration(
                      labelText: 'Descripción',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                if (!formKey.currentState!.validate()) return;

                final provider = ref.read(incidentProvider.notifier);
                final currentUser = ref.read(userProvider).currentUser;

                if (currentUser == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Usuario no autenticado')),
                  );
                  return;
                }

                final request = IncidentCreateRequest(
                  entityType: selectedEntityType,
                  entityId: int.parse(entityIdController.text),
                  type: selectedType,
                  note: noteController.text.isEmpty ? null : noteController.text,
                  reportedBy: currentUser.id,
                );

                final success = await provider.createIncident(request);
                final state = ref.watch(incidentProvider);

                if (!mounted) return;

                Navigator.pop(context);

                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Incidente reportado')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error ?? 'Error al reportar'),
                    ),
                  );
                }
              },
              child: const Text('Reportar'),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterDialog() {
    IncidentType? selectedType;
    EntityType? selectedEntityType;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Filtros'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<IncidentType>(
                initialValue: selectedType,
                decoration: const InputDecoration(
                  labelText: 'Tipo de incidente',
                  border: OutlineInputBorder(),
                ),
                items: [
                  const DropdownMenuItem(value: null, child: Text('Todos')),
                  ...IncidentType.values.map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(_getIncidentTypeDisplayName(type.name.toUpperCase())),
                    );
                  }),
                ],
                onChanged: (value) => setState(() => selectedType = value),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<EntityType>(
                initialValue: selectedEntityType,
                decoration: const InputDecoration(
                  labelText: 'Tipo de entidad',
                  border: OutlineInputBorder(),
                ),
                items: [
                  const DropdownMenuItem(value: null, child: Text('Todas')),
                  ...EntityType.values.map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(type.name.toUpperCase()),
                    );
                  }),
                ],
                onChanged: (value) => setState(() => selectedEntityType = value),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                ref.read(incidentProvider.notifier).clearFilters();
                Navigator.pop(context);
              },
              child: const Text('Limpiar'),
            ),
            TextButton(
              onPressed: () {
                final provider = ref.read(incidentProvider.notifier);
                provider.setTypeFilter(selectedType);
                provider.setEntityTypeFilter(selectedEntityType);
                Navigator.pop(context);
              },
              child: const Text('Aplicar'),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(incident) async {
    final provider = ref.read(incidentProvider.notifier);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar eliminación'),
        content: const Text('¿Estás seguro de eliminar este incidente?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              final success = await provider.deleteIncident(incident.id);
              final state = ref.watch(incidentProvider);
              if (!mounted) return;
              if (success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Incidente eliminado')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error ?? 'Error al eliminar')),
                );
              }
            },
            child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showEditIncidentDialog(incident) {
    final formKey = GlobalKey<FormState>();
    final noteController = TextEditingController(text: incident.note);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Editar Incidente'),
        content: Form(
          key: formKey,
          child: TextFormField(
            controller: noteController,
            decoration: const InputDecoration(
              labelText: 'Descripción',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
            validator: (value) => value == null || value.isEmpty ? 'La descripción es requerida' : null,
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
          TextButton(
            onPressed: () async {
              if (!formKey.currentState!.validate()) return;
              final provider = ref.read(incidentProvider.notifier);
              final request = IncidentUpdateRequest(note: noteController.text);
              final success = await provider.updateIncident(incident.id, request);
              final state = ref.watch(incidentProvider);
              if (!mounted) return;
              Navigator.pop(context);
              if (success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Incidente actualizado')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error ?? 'Error al actualizar')),
                );
              }
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }
}
