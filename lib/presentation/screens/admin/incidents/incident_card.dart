import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../data/models/incident_model/incident_model.dart';

class IncidentCard extends StatelessWidget {
  final IncidentModel incident;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const IncidentCard({
    super.key,
    required this.incident,
    this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: _getIncidentColor(incident.type.name).withOpacity(0.3),
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _getIncidentColor(incident.type.name).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _getIncidentIcon(incident.type.name),
                      color: _getIncidentColor(incident.type.name),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          incident.type.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${incident.entityType} #${incident.entityId}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: onDelete,
                  ),
                ],
              ),
              if (incident.note != null) ...[
                const SizedBox(height: 12),
                Text(
                  incident.note!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.person, size: 14, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    incident.reportedByName ?? 'N/A',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const Spacer(),
                  const Icon(Icons.access_time, size: 14, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    _formatDate(incident.createdAt.toString()),
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
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

  String _formatDate(String? dateTimeStr) {
    if (dateTimeStr == null) return 'N/A';
    try {
      final dateTime = DateTime.parse(dateTimeStr);
      return DateFormat('dd/MM HH:mm').format(dateTime);
    } catch (e) {
      return dateTimeStr;
    }
  }
}