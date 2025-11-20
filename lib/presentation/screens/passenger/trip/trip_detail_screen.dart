import 'package:bus_connect/core/constants/app_routes.dart';
import 'package:bus_connect/core/constants/enums/trip_status.dart';
import 'package:bus_connect/presentation/providers/passenger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TripDetailScreen extends ConsumerWidget {
  final int tripId;

  const TripDetailScreen({super.key, required this.tripId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tripAsync = ref.watch(tripDetailsProvider(tripId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del Viaje'),
      ),
      body: tripAsync.when(
        data: (trip) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Route Info Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.location_on, color: Theme.of(context).primaryColor),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              trip.origin.toString(),
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Icon(Icons.arrow_downward, color: Colors.grey[400]),
                      ),
                      Row(
                        children: [
                          Icon(Icons.flag, color: Theme.of(context).colorScheme.secondary),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              trip.destination.toString(),
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Trip Info Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _InfoRow(
                        icon: Icons.calendar_today,
                        label: 'Fecha',
                        value: trip.date.toString(),
                      ),
                      const Divider(),
                      _InfoRow(
                        icon: Icons.access_time,
                        label: 'Hora de Salida',
                        value: trip.departureAt.toString().substring(11, 16),
                      ),
                      const Divider(),
                      _InfoRow(
                        icon: Icons.directions_bus,
                        label: 'Bus',
                        value: trip.busPlate ?? 'No asignado',
                      ),
                      const Divider(),
                      _InfoRow(
                        icon: Icons.event_seat,
                        label: 'Capacidad',
                        value: '${trip.capacity} asientos',
                      ),
                      const Divider(),
                      _InfoRow(
                        icon: Icons.info_outline,
                        label: 'Estado',
                        value: _getStatusText(trip.status.name),
                        valueColor: _getStatusColor(trip.status.name),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Stops List
              Text(
                'Paradas del Recorrido',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              _StopsListWidget(routeId: trip.routeId),

              const SizedBox(height: 24),

              // Book Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: trip.status == TripStatus.SCHEDULED || trip.status == TripStatus.BOARDING
                      ? () => context.push('/passenger/seat-selection/$tripId')
                      : null,
                  icon: const Icon(Icons.event_seat),
                  label: const Text('Seleccionar Asiento'),
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'SCHEDULED': return 'Programado';
      case 'BOARDING': return 'Abordando';
      case 'DEPARTED': return 'En Ruta';
      case 'ARRIVED': return 'Llegó';
      case 'CANCELLED': return 'Cancelado';
      default: return status;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'SCHEDULED': return Colors.blue;
      case 'BOARDING': return Colors.orange;
      case 'DEPARTED': return Colors.green;
      case 'ARRIVED': return Colors.grey;
      case 'CANCELLED': return Colors.red;
      default: return Colors.black;
    }
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 12),
        Text(
          label,
          style: TextStyle(color: Colors.grey[600]),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}

class _StopsListWidget extends ConsumerWidget {
  final int routeId;

  const _StopsListWidget({required this.routeId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stopsAsync = ref.watch(routeStopsProvider(routeId));

    return stopsAsync.when(
      data: (stops) => Card(
        child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: stops.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final stop = stops[index];
            return ListTile(
              dense: true,
              leading: CircleAvatar(
                radius: 12,
                child: Text('${index + 1}'),
              ),
              title: Text(stop.name),
            );
          },
        ),
      ),
      loading: () => const LinearProgressIndicator(),
      error: (e, _) => Text('Error al cargar paradas: $e'),
    );
  }
}