import 'package:flutter/material.dart';
import '../../../../core/constants/enums/ticket_status.dart';

class TicketFilters extends StatelessWidget {
  final TicketStatus? currentStatus;
  final Function(TicketStatus?)? onStatusChanged;
  final VoidCallback? onClearFilters;

  const TicketFilters({
    super.key,
    this.currentStatus,
    this.onStatusChanged,
    this.onClearFilters,
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
                'Filtros',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              TextButton(
                onPressed: onClearFilters,
                child: const Text('Limpiar'),
              ),
            ],
          ),
          const SizedBox(height: 24),

          Text(
            'Estado del Ticket',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              FilterChip(
                label: const Text('Todos'),
                selected: currentStatus == null,
                onSelected: (_) => onStatusChanged?.call(null),
              ),
              ...TicketStatus.values.map((status) {
                return FilterChip(
                  avatar: Icon(
                    _getStatusIcon(status),
                    size: 16,
                    color: currentStatus == status ? Colors.white : null,
                  ),
                  label: Text(status.name),
                  selected: currentStatus == status,
                  onSelected: (_) => onStatusChanged?.call(status),
                  selectedColor: _getStatusColor(status),
                );
              }),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  IconData _getStatusIcon(TicketStatus status) {
    switch (status) {
      case TicketStatus.SOLD:
        return Icons.confirmation_number;
      case TicketStatus.USED:
        return Icons.check_circle;
      case TicketStatus.CANCELLED:
        return Icons.cancel;
      case TicketStatus.NO_SHOW:
        return Icons.event_busy;
    }
  }

  Color _getStatusColor(TicketStatus status) {
    switch (status) {
      case TicketStatus.SOLD:
        return Colors.green;
      case TicketStatus.USED:
        return Colors.blue;
      case TicketStatus.CANCELLED:
        return Colors.red;
      case TicketStatus.NO_SHOW:
        return Colors.orange;
    }
  }
}