import 'package:flutter/material.dart';
import '../../../core/constants/enums/trip_status.dart';

class TripFilters extends StatelessWidget {
  final TripStatus? currentStatus;
  final Function(TripStatus?) onStatusChanged;
  final VoidCallback onClearFilters;

  const TripFilters({
    super.key,
    this.currentStatus,
    required this.onStatusChanged,
    required this.onClearFilters,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filtrar por Estado',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Opciones de filtro
          _buildStatusOption(
            context: context,
            status: null,
            label: 'Todos los viajes',
            icon: Icons.list,
            color: Colors.grey,
          ),
          const Divider(),
          _buildStatusOption(
            context: context,
            status: TripStatus.SCHEDULED,
            label: 'Programados',
            icon: Icons.schedule,
            color: Colors.blue,
          ),
          _buildStatusOption(
            context: context,
            status: TripStatus.BOARDING,
            label: 'Abordando',
            icon: Icons.login,
            color: Colors.orange,
          ),
          _buildStatusOption(
            context: context,
            status: TripStatus.DEPARTED,
            label: 'En viaje',
            icon: Icons.flight_takeoff,
            color: Colors.green,
          ),
          _buildStatusOption(
            context: context,
            status: TripStatus.ARRIVED,
            label: 'Llegados',
            icon: Icons.check_circle,
            color: Colors.grey,
          ),
          _buildStatusOption(
            context: context,
            status: TripStatus.CANCELLED,
            label: 'Cancelados',
            icon: Icons.cancel,
            color: Colors.red,
          ),

          const SizedBox(height: 16),

          // Botón limpiar filtros
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: onClearFilters,
              icon: const Icon(Icons.clear_all),
              label: const Text('Limpiar filtros'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusOption({
    required BuildContext context,
    required TripStatus? status,
    required String label,
    required IconData icon,
    required Color color,
  }) {
    final isSelected = currentStatus == status;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(label),
      trailing: isSelected
          ? const Icon(Icons.check, color: Colors.blue)
          : null,
      selected: isSelected,
      onTap: () => onStatusChanged(status),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}