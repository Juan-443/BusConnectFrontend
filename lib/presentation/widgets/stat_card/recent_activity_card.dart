import 'package:flutter/material.dart';

class RecentActivityCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final List<Map<String, String>> items;
  final VoidCallback? onViewAll;

  const RecentActivityCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.items,
    this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, color: color),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: color,
                    ),
                  ),
                ),
                if (onViewAll != null)
                  TextButton(
                    onPressed: onViewAll,
                    child: const Text('Ver todo'),
                  ),
              ],
            ),
          ),

          // Items
          ...items.map((item) {
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: color.withOpacity(0.1),
                child: Icon(icon, size: 20, color: color),
              ),
              title: Text(
                item['title'] ?? '',
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Text(item['subtitle'] ?? ''),
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor(item['status'] ?? '').withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  item['status'] ?? '',
                  style: TextStyle(
                    fontSize: 11,
                    color: _getStatusColor(item['status'] ?? ''),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'SCHEDULED':
        return Colors.blue;
      case 'BOARDING':
        return Colors.orange;
      case 'DEPARTED':
        return Colors.green;
      case 'CANCELLED':
        return Colors.red;
      case 'SECURITY':
        return Colors.red;
      case 'VEHICLE':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}