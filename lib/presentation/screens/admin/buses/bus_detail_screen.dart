import 'package:bus_connect/core/constants/app_routes.dart';
import 'package:bus_connect/core/constants/enums/bus_status.dart';
import 'package:bus_connect/presentation/providers/bus_provider.dart';
import 'package:bus_connect/presentation/widgets/common/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BusDetailScreen extends ConsumerWidget {
  final int busId;

  const BusDetailScreen({super.key, required this.busId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final busState = ref.watch(busProvider);
    final bus = busState.selectedBus;

    if (bus == null || bus.id != busId) {
      Future.microtask(() => ref.read(busProvider.notifier).fetchBusById(busId));
      return Scaffold(
        appBar: AppBar(title: const Text('Cargando...')),
        body: const LoadingIndicator(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Bus ${bus.plate}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('${AppRoutes.adminBusEdit}/${bus.id}'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context, bus),
            _buildInfoSection(context, bus),
            const SizedBox(height: 16),
            _buildActionButtons(context, bus, ref),
            const SizedBox(height: 16),
            _buildStatistics(context, bus),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, dynamic bus) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _getStatusColor(bus.status),
            _getStatusColor(bus.status).withValues(alpha: 0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Icon(
              Icons.directions_bus,
              size: 60,
              color: _getStatusColor(bus.status),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            bus.plate,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          _buildStatusBadge(bus.status),
        ],
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context, dynamic bus) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Información del Bus',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(height: 24),
            _buildInfoRow(Icons.tag, 'Placa', bus.plate),
            const SizedBox(height: 12),
            _buildInfoRow(Icons.event_seat, 'Capacidad', '${bus.capacity} pasajeros'),
            const SizedBox(height: 12),
            _buildInfoRow(Icons.info_outline, 'Estado', bus.status.displayName),

            // Mostrar amenities si existen
            if (bus.amenities != null && (bus.amenities as Map).isNotEmpty) ...[
              const Divider(height: 24),
              Text(
                'Comodidades',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: (bus.amenities as Map<String, dynamic>).entries.map((entry) {
                  final isAvailable = entry.value == true;
                  return Chip(
                    avatar: Icon(
                      isAvailable ? Icons.check_circle : Icons.cancel,
                      color: isAvailable ? Colors.green : Colors.grey,
                      size: 16,
                    ),
                    label: Text(entry.key),
                    backgroundColor: isAvailable
                        ? Colors.green.withValues(alpha: 0.1)
                        : Colors.grey.withValues(alpha: 0.1),
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context, dynamic bus, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton.icon(
              onPressed: () => context.pushNamed(
                'adminBusSeats',
                pathParameters: {'busId': bus.id.toString()},
                extra: {'plate': bus.plate},
              ),
              icon: const Icon(Icons.event_seat, size: 28),
              label: const Text(
                'Gestionar Asientos',
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _showChangeStatusDialog(context, bus, ref),
                  icon: const Icon(Icons.swap_horiz),
                  label: const Text('Cambiar Estado'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => context.push('${AppRoutes.adminBusEdit}/${bus.id}'),
                  icon: const Icon(Icons.edit),
                  label: const Text('Editar'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatistics(BuildContext context, dynamic bus) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Estadísticas',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem(
                  context,
                  icon: Icons.event_seat,
                  label: 'Asientos',
                  value: bus.capacity.toString(),
                  color: Colors.blue,
                ),
                _buildStatItem(
                  context,
                  icon: Icons.star,
                  label: 'Comodidades',
                  value: (bus.amenities as Map?)?.length.toString() ?? '0',
                  color: Colors.green,
                ),
                _buildStatItem(
                  context,
                  icon: Icons.check_circle,
                  label: 'Estado',
                  value: bus.status == BusStatus.ACTIVE ? 'OK' : 'N/A',
                  color: _getStatusColor(bus.status),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(
      BuildContext context, {
        required IconData icon,
        required String label,
        required String value,
        required Color color,
      }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 32),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBadge(BusStatus status) {
    final color = _getStatusColor(status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status.displayName,
        style: TextStyle(
          color: color,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Color _getStatusColor(BusStatus status) {
    switch (status) {
      case BusStatus.ACTIVE:
        return Colors.green;
      case BusStatus.MAINTENANCE:
        return Colors.orange;
      case BusStatus.INACTIVE:
        return Colors.grey;
    }
  }

  void _showChangeStatusDialog(BuildContext context, dynamic bus, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) {
        BusStatus? selectedStatus = bus.status;

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Cambiar Estado'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: BusStatus.values.map((status) {
                  return RadioListTile<BusStatus>(
                    title: Text(status.displayName),
                    value: status,
                    groupValue: selectedStatus,
                    onChanged: (value) => setState(() => selectedStatus = value),
                  );
                }).toList(),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (selectedStatus != null && selectedStatus != bus.status) {
                      Navigator.pop(context);
                      final success = await ref
                          .read(busProvider.notifier)
                          .changeBusStatus(bus.id, selectedStatus!);
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              success ? 'Estado actualizado' : 'Error al actualizar',
                            ),
                          ),
                        );
                      }
                    }
                  },
                  child: const Text('Cambiar'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}