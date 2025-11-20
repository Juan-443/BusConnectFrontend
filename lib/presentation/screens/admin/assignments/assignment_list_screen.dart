import 'package:bus_connect/presentation/providers/assignment_provider.dart';
import 'package:bus_connect/presentation/widgets/assignment_card/assignment_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AssignmentsListScreen extends ConsumerStatefulWidget {
  const AssignmentsListScreen({super.key});

  @override
  ConsumerState<AssignmentsListScreen> createState() => _AssignmentsListScreenState();
}

class _AssignmentsListScreenState extends ConsumerState<AssignmentsListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    Future.microtask(
          () => ref.read(assignmentProvider.notifier).fetchAllAssignments(),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(assignmentProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Asignaciones'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.list), text: 'Todas'),
            Tab(icon: Icon(Icons.today), text: 'Hoy'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () =>
                ref.read(assignmentProvider.notifier).fetchAllAssignments(),
          ),
        ],
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.error != null
          ? _buildError(state.error!)
          : TabBarView(
        controller: _tabController,
        children: [
          _buildAssignmentsList(state.assignments, 'all'),
          _buildAssignmentsList(_filterTodayAssignments(state.assignments), 'today'),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/admin/assignments/create'),
        icon: const Icon(Icons.add),
        label: const Text('Nueva Asignación'),
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
            'Error al cargar asignaciones',
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
                ref.read(assignmentProvider.notifier).fetchAllAssignments(),
            icon: const Icon(Icons.refresh),
            label: const Text('Reintentar'),
          ),
        ],
      ),
    );
  }

  Widget _buildAssignmentsList(List assignments, String category) {
    if (assignments.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              category == 'today'
                  ? Icons.event_busy
                  : Icons.assignment_outlined,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              category == 'today'
                  ? 'No hay asignaciones para hoy'
                  : 'No hay asignaciones registradas',
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(assignmentProvider.notifier).fetchAllAssignments(),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: assignments.length,
        itemBuilder: (context, index) {
          final assignment = assignments[index];
          return AssignmentCard(
            assignment: assignment,
            onTap: () => _showAssignmentDetails(assignment),
            onDelete: () => _confirmDelete(assignment.id, assignment.tripInfo),
            onApproveChecklist: assignment.checklistOk
                ? null
                : () => _approveChecklist(assignment.id),
          );
        },
      ),
    );
  }

  List _filterTodayAssignments(List assignments) {
    final today = DateTime.now();
    return assignments.where((assignment) {
      try {
        final tripDate = DateTime.parse(assignment.tripDate);
        return tripDate.year == today.year &&
            tripDate.month == today.month &&
            tripDate.day == today.day;
      } catch (e) {
        return false;
      }
    }).toList();
  }

  void _showAssignmentDetails(dynamic assignment) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(24),
          child: ListView(
            controller: scrollController,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Detalles de Asignación',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(ctx),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              _buildDetailItem(
                icon: Icons.route,
                label: 'Viaje',
                value: assignment.tripInfo ?? 'N/A',
              ),
              const Divider(height: 32),

              _buildDetailItem(
                icon: Icons.person,
                label: 'Conductor',
                value: assignment.driverName ?? 'N/A',
              ),
              const Divider(height: 32),

              _buildDetailItem(
                icon: Icons.assignment_ind,
                label: 'Despachador',
                value: assignment.dispatcherName ?? 'N/A',
              ),
              const Divider(height: 32),

              _buildDetailItem(
                icon: Icons.calendar_today,
                label: 'Fecha del viaje',
                value: assignment.tripDate ?? 'N/A',
              ),
              const Divider(height: 32),

              _buildDetailItem(
                icon: Icons.access_time,
                label: 'Hora de salida',
                value: assignment.tripDepartureTime != null
                    ? _formatDateTime(assignment.tripDepartureTime)
                    : 'N/A',
              ),
              const Divider(height: 32),

              _buildDetailItem(
                icon: assignment.checklistOk
                    ? Icons.check_circle
                    : Icons.pending,
                label: 'Checklist',
                value: assignment.checklistOk ? 'Aprobado' : 'Pendiente',
              ),

              if (!assignment.checklistOk) ...[
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(ctx);
                      _approveChecklist(assignment.id);
                    },
                    icon: const Icon(Icons.check_circle),
                    label: const Text('Aprobar Checklist'),
                  ),
                ),
              ],

              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pop(ctx);
                    _confirmDelete(assignment.id, assignment.tripInfo);
                  },
                  icon: const Icon(Icons.delete),
                  label: const Text('Eliminar Asignación'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                  ),
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
        Icon(icon, size: 24, color: Colors.blue),
        const SizedBox(width: 16),
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
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
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

  Future<void> _confirmDelete(int id, String? tripInfo) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirmar eliminación'),
        content: Text(
          '¿Eliminar la asignación para "${tripInfo ?? 'este viaje'}"?',
        ),
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
      final success = await ref.read(assignmentProvider.notifier).deleteAssignment(id);
      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Asignación eliminada exitosamente')),
        );
      }
    }
  }

  Future<void> _approveChecklist(int id) async {
    final success = await ref.read(assignmentProvider.notifier).approveChecklist(id);
    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Checklist aprobado exitosamente')),
      );
    }
  }
}