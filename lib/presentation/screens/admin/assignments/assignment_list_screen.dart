import 'package:bus_connect/data/models/assignment_model/assignment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/assignment_provider.dart';
import '../../../widgets/common/loading_indicator.dart';
import '../../../widgets/common/error_widget.dart' as custom;
import '../../../../core/utils/date_formatter.dart';

class AssignmentListScreen extends ConsumerStatefulWidget {
  const AssignmentListScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AssignmentListScreen> createState() => _AssignmentListScreenState();
}

class _AssignmentListScreenState extends ConsumerState<AssignmentListScreen> {
  String _searchQuery = '';
  bool _showOnlyPending = false;

  @override
  void initState() {
    super.initState();
    // Llama al fetch después de construir el widget
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(assignmentProvider.notifier).fetchAllAssignments();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(assignmentProvider);
    final notifier = ref.read(assignmentProvider.notifier);

    var assignments = _showOnlyPending
        ? state.assignments.where((a) => !a.checklistOk).toList()
        : state.assignments;

    // Filtro de búsqueda
    if (_searchQuery.isNotEmpty) {
      assignments = assignments.where((assignment) {
        return assignment.driverName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            assignment.tripInfo.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Asignaciones'),
        actions: [
          IconButton(
            icon: Icon(_showOnlyPending ? Icons.filter_list : Icons.filter_list_off),
            onPressed: () => setState(() => _showOnlyPending = !_showOnlyPending),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.pushNamed(context, '/admin/assignments/create'),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildFilterChips(),
          Expanded(
            child: _buildAssignmentList(state, notifier, assignments),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Buscar por conductor, viaje...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
        ),
        onChanged: (value) => setState(() => _searchQuery = value),
      ),
    );
  }

  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          FilterChip(
            label: const Text('Solo pendientes'),
            selected: _showOnlyPending,
            onSelected: (selected) => setState(() => _showOnlyPending = selected),
          ),
          const SizedBox(width: 8),
          ActionChip(
            avatar: const Icon(Icons.calendar_today, size: 18),
            label: const Text('Por fecha'),
            onPressed: _showDatePicker,
          ),
        ],
      ),
    );
  }

  Widget _buildAssignmentList(
      AssignmentState state, AssignmentNotifier notifier, List<AssignmentResponse> assignments) {
    if (state.isLoading) return const LoadingIndicator();

    if (state.error != null) {
      return custom.ErrorDisplay(
        message: state.error!,
        onRetry: () => notifier.fetchAllAssignments(),
      );
    }

    if (assignments.isEmpty) {
      return const Center(child: Text('No se encontraron asignaciones'));
    }

    return RefreshIndicator(
      onRefresh: () => notifier.fetchAllAssignments(),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: assignments.length,
        itemBuilder: (context, index) {
          final assignment = assignments[index];
          return _buildAssignmentCard(assignment, notifier);
        },
      ),
    );
  }

  Widget _buildAssignmentCard(AssignmentResponse assignment, AssignmentNotifier notifier) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: _getStatusColor(assignment.checklistOk),
          child: Icon(
            assignment.checklistOk ? Icons.check : Icons.pending,
            color: Colors.white,
          ),
        ),
        title: Text(assignment.driverName, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(assignment.tripInfo),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 14, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  assignment.tripDateFormatted,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                const SizedBox(width: 16),
                _buildStatusBadge(assignment.tripStatus),
              ],
            ),
          ],
        ),
        trailing: PopupMenuButton(
          itemBuilder: (context) => [
            if (!assignment.checklistOk)
              const PopupMenuItem(
                value: 'approve',
                child: Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green),
                    SizedBox(width: 8),
                    Text('Aprobar checklist'),
                  ],
                ),
              ),
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
          onSelected: (value) => _handleMenuAction(value, assignment, notifier),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow('Ruta:', assignment.routeInfo),
                const SizedBox(height: 8),
                _buildInfoRow('Hora salida:', assignment.tripDepartureTimeFormatted),
                const SizedBox(height: 8),
                _buildInfoRow('Despachador:', assignment.dispatcherName),
                const SizedBox(height: 8),
                _buildInfoRow('Asignado:',
                    DateFormatter.formatDate(DateTime.parse(assignment.tripDate))),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text('Checklist: ', style: TextStyle(fontWeight: FontWeight.bold)),
                    Icon(
                      assignment.checklistOk ? Icons.check_circle : Icons.cancel,
                      color: assignment.checklistOk ? Colors.green : Colors.orange,
                      size: 20,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      assignment.checklistOk ? 'Aprobado' : 'Pendiente',
                      style: TextStyle(
                        color: assignment.checklistOk ? Colors.green : Colors.orange,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
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

  Widget _buildStatusBadge(String status) {
    final color = _getTripStatusColor(status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }

  Color _getStatusColor(bool checklistOk) => checklistOk ? Colors.green : Colors.orange;

  Color _getTripStatusColor(String status) {
    switch (status) {
      case 'SCHEDULED':
        return Colors.blue;
      case 'BOARDING':
        return Colors.orange;
      case 'DEPARTED':
        return Colors.purple;
      case 'ARRIVED':
        return Colors.green;
      case 'CANCELLED':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _handleMenuAction(dynamic value, AssignmentResponse assignment, AssignmentNotifier notifier) {
    switch (value) {
      case 'approve':
        _approveChecklist(assignment, notifier);
        break;
      case 'edit':
        notifier.clearSelectedAssignment();
        notifier.fetchAssignmentById(assignment.id);
        Navigator.pushNamed(context, '/admin/assignments/edit');
        break;
      case 'delete':
        _confirmDelete(assignment, notifier);
        break;
    }
  }

  void _approveChecklist(AssignmentResponse assignment, AssignmentNotifier notifier) async {
    final success = await notifier.approveChecklist(assignment.id);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(success ? 'Checklist aprobado' : (notifier.state.error ?? 'Error'))),
    );
  }

  void _confirmDelete(AssignmentResponse assignment, AssignmentNotifier notifier) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar eliminación'),
        content: const Text('¿Estás seguro de eliminar esta asignación?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              final success = await notifier.deleteAssignment(assignment.id);
              if (!mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(success ? 'Asignación eliminada' : (notifier.state.error ?? 'Error')),
                ),
              );
            },
            child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showDatePicker() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (picked != null && mounted) {
      ref.read(assignmentProvider.notifier).setDateFilter(picked.toIso8601String().split('T')[0]);
    }
  }
}
