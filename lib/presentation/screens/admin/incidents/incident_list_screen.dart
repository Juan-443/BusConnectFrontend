import 'package:bus_connect/core/constants/enums/incident_type.dart';
import 'package:bus_connect/core/constants/enums/entity_type.dart';
import 'package:bus_connect/presentation/providers/auth_provider.dart';
import 'package:bus_connect/presentation/providers/incident_provider.dart';
import 'package:bus_connect/presentation/providers/current_user_provider.dart'; // ✅ NUEVO
import 'package:bus_connect/presentation/screens/admin/incidents/incident_card.dart';
import 'package:bus_connect/presentation/screens/admin/incidents/incident_from_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IncidentsListScreen extends ConsumerStatefulWidget {
  const IncidentsListScreen({super.key});

  @override
  ConsumerState<IncidentsListScreen> createState() =>
      _IncidentsListScreenState();
}

class _IncidentsListScreenState extends ConsumerState<IncidentsListScreen> {
  IncidentType? _filterType;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(incidentProvider.notifier).fetchAllIncidents();
      ref.read(currentUserProvider.notifier).refresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(incidentProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Incidentes'),
        actions: [
          PopupMenuButton<IncidentType?>(
            icon: const Icon(Icons.filter_list),
            onSelected: (type) {
              setState(() => _filterType = type);
            },
            itemBuilder: (ctx) => [
              const PopupMenuItem(
                value: null,
                child: Text('Todos'),
              ),
              ...IncidentType.values.map((type) {
                return PopupMenuItem(
                  value: type,
                  child: Text(type.name),
                );
              }),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () =>
                ref.read(incidentProvider.notifier).fetchAllIncidents(),
          ),
        ],
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.error != null
          ? _buildError(state.error!)
          : _buildIncidentsList(state.incidents),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showCreateIncidentDialog,
        icon: const Icon(Icons.add),
        label: const Text('Reportar Incidente'),
      ),
    );
  }

  Widget _buildError(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            'Error al cargar incidentes',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () =>
                ref.read(incidentProvider.notifier).fetchAllIncidents(),
            icon: const Icon(Icons.refresh),
            label: const Text('Reintentar'),
          ),
        ],
      ),
    );
  }

  Widget _buildIncidentsList(List incidents) {
    final filteredIncidents = _filterType == null
        ? incidents
        : incidents.where((i) => i.type == _filterType!.name).toList();

    if (filteredIncidents.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle_outline, size: 64, color: Colors.green),
            SizedBox(height: 16),
            Text('No hay incidentes registrados'),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(incidentProvider.notifier).fetchAllIncidents(),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: filteredIncidents.length,
        itemBuilder: (context, index) {
          final incident = filteredIncidents[index];
          return IncidentCard(
            incident: incident,
            onTap: () => _showIncidentDetails(incident),
            onDelete: () => _confirmDelete(incident.id),
          );
        },
      ),
    );
  }

  void _showCreateIncidentDialog() async {
    final authState = ref.read(authProvider);

    if (!authState.isAuthenticated || authState.user?.id == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error: Usuario no autenticado'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final userId = authState.user!.id;

    if (!mounted) return;
    final selectedEntityType = await showDialog<EntityType>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Seleccionar Entidad'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.directions_bus, color: Colors.blue),
              title: const Text('Viaje'),
              subtitle: const Text('Reportar incidente de un viaje'),
              onTap: () => Navigator.pop(ctx, EntityType.TRIP),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.confirmation_number, color: Colors.green),
              title: const Text('Ticket'),
              subtitle: const Text('Reportar incidente de un ticket'),
              onTap: () => Navigator.pop(ctx, EntityType.TICKET),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.inventory_2, color: Colors.orange),
              title: const Text('Encomienda'),
              subtitle: const Text('Reportar incidente de una encomienda'),
              onTap: () => Navigator.pop(ctx, EntityType.PARCEL),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
        ],
      ),
    );

    if (selectedEntityType == null || !mounted) return;

    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => IncidentFormScreen(
          entityType: selectedEntityType,
          reportedBy: userId,
        ),
      ),
    );

    if (result == true && mounted) {
      ref.read(incidentProvider.notifier).fetchAllIncidents();
    }
  }

  void _showIncidentDetails(dynamic incident) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(24),
          child: ListView(
            controller: scrollController,
            children: [
              Row(
                children: [
                  Icon(
                    _getIncidentIcon(incident.type),
                    size: 32,
                    color: _getIncidentColor(incident.type),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      incident.type,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(ctx),
                  ),
                ],
              ),
              const Divider(height: 32),

              if (incident.note != null) ...[
                const Text(
                  'Descripción:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  incident.note,
                  style: const TextStyle(fontSize: 14),
                ),
                const Divider(height: 32),
              ],

              _buildDetailItem(
                icon: Icons.category,
                label: 'Entidad',
                value: '${incident.entityType} #${incident.entityId}',
              ),
              const SizedBox(height: 16),

              _buildDetailItem(
                icon: Icons.person,
                label: 'Reportado por',
                value: incident.reportedByName ?? 'N/A',
              ),
              const SizedBox(height: 16),

              _buildDetailItem(
                icon: Icons.access_time,
                label: 'Fecha',
                value: _formatDateTime(incident.createdAt),
              ),

              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(ctx);
                  _confirmDelete(incident.id);
                },
                icon: const Icon(Icons.delete),
                label: const Text('Eliminar Incidente'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.blue),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _confirmDelete(int id) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirmar eliminación'),
        content: const Text('¿Eliminar este incidente?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      final success = await ref.read(incidentProvider.notifier).deleteIncident(id);
      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Incidente eliminado exitosamente')),
        );
      }
    }
  }

  IconData _getIncidentIcon(String type) {
    switch (type.toUpperCase()) {
      case 'SECURITY':
        return Icons.security;
      case 'DELIVERY_FAIL':
        return Icons.local_shipping;
      case 'OVERBOOK':
        return Icons.airline_seat_recline_extra;
      case 'VEHICLE':
        return Icons.build;
      case 'PASSENGER_COMPLAINT':
        return Icons.report_problem;
      default:
        return Icons.warning;
    }
  }

  Color _getIncidentColor(String type) {
    switch (type.toUpperCase()) {
      case 'SECURITY':
        return Colors.red;
      case 'DELIVERY_FAIL':
        return Colors.orange;
      case 'OVERBOOK':
        return Colors.purple;
      case 'VEHICLE':
        return Colors.blue;
      case 'PASSENGER_COMPLAINT':
        return Colors.amber;
      default:
        return Colors.grey;
    }
  }

  String _formatDateTime(String? dateTimeStr) {
    if (dateTimeStr == null) return 'N/A';
    try {
      final dateTime = DateTime.parse(dateTimeStr);
      return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return dateTimeStr;
    }
  }
}