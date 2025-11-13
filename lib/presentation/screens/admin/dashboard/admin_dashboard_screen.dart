import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../providers/user_provider.dart';
import '../../../providers/bus_provider.dart';
import '../../../providers/assignment_provider.dart';
import '../../../providers/incident_provider.dart';

class AdminDashboardScreen extends ConsumerStatefulWidget {
  const AdminDashboardScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends ConsumerState<AdminDashboardScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => _loadDashboardData());
  }

  Future<void> _loadDashboardData() async {
    final userNotifier = ref.read(userProvider.notifier);
    final busNotifier = ref.read(busProvider.notifier);
    final assignmentNotifier = ref.read(assignmentProvider.notifier);
    final incidentNotifier = ref.read(incidentProvider.notifier);

    await Future.wait([
      userNotifier.fetchAllUsers(),
      busNotifier.fetchAllBuses(),
      assignmentNotifier.fetchAllAssignments(),
      incidentNotifier.fetchAllIncidents(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userProvider);
    final busState = ref.watch(busProvider);
    final assignmentState = ref.watch(assignmentProvider);
    final incidentState = ref.watch(incidentProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Panel de Administración'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadDashboardData,
          ),
        ],
      ),
      drawer: _buildDrawer(userState),
      body: RefreshIndicator(
        onRefresh: _loadDashboardData,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildWelcomeCard(),
              const SizedBox(height: 20),
              _buildStatsGrid(userState, busState, assignmentState, incidentState),
              const SizedBox(height: 20),
              _buildQuickActions(),
              const SizedBox(height: 20),
              _buildRecentIncidents(incidentState),
            ],
          ),
        ),
      ),
    );
  }

  Drawer _buildDrawer(UserState userState) {
    final user = userState.currentUser;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const CircleAvatar(
                  radius: 30,
                  child: Icon(Icons.admin_panel_settings, size: 35),
                ),
                const SizedBox(height: 10),
                Text(
                  user?.username ?? 'Administrador',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  user?.email ?? '',
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
          _buildDrawerItem(Icons.dashboard, 'Dashboard', () => Navigator.pop(context)),
          _buildDrawerItem(Icons.people, 'Usuarios', () => _go('/admin/users')),
          _buildDrawerItem(Icons.directions_bus, 'Buses', () => _go('/admin/buses')),
          _buildDrawerItem(Icons.route, 'Rutas', () => _go('/admin/routes')),
          _buildDrawerItem(Icons.location_on, 'Paradas', () => _go('/admin/stops')),
          _buildDrawerItem(Icons.attach_money, 'Tarifas', () => _go('/admin/fare-rules')),
          _buildDrawerItem(Icons.assignment, 'Asignaciones', () => _go('/admin/assignments')),
          _buildDrawerItem(Icons.warning, 'Incidentes', () => _go('/admin/incidents')),
          _buildDrawerItem(Icons.settings, 'Configuración', () => _go('/admin/config')),
          const Divider(),
          _buildDrawerItem(Icons.logout, 'Cerrar Sesión', () {}),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }

  Future<void> _go(String route) async {
    Navigator.pop(context);
    await Future.delayed(const Duration(milliseconds: 400));
    context.go(route);
  }

  Widget _buildWelcomeCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.admin_panel_settings,
                size: 48, color: Theme.of(context).primaryColor),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('¡Bienvenido Administrador!',
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 4),
                  Text('Gestiona todo el sistema desde aquí',
                      style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsGrid(
      UserState user,
      BusState bus,
      AssignmentState assignment,
      IncidentState incident,
      ) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.5,
      children: [
        _buildStatCard('Usuarios', user.users.length.toString(),
            Icons.people, Colors.blue, onTap: () => _go('/admin/users')),
        _buildStatCard('Buses', bus.buses.length.toString(),
            Icons.directions_bus, Colors.green,
            subtitle: '${bus.availableBuses.length} disponibles',
            onTap: () => _go('/admin/buses')),
        _buildStatCard('Asignaciones', assignment.assignments.length.toString(),
            Icons.assignment, Colors.orange,
            subtitle: '${assignment.activeAssignments.length} activas',
            onTap: () => _go('/admin/assignments')),
        _buildStatCard('Incidentes', incident.incidents.length.toString(),
            Icons.warning, Colors.red,
            onTap: () => _go('/admin/incidents')),
      ],
    );
  }

  Widget _buildStatCard(
      String title,
      String value,
      IconData icon,
      Color color, {
        String? subtitle,
        VoidCallback? onTap,
      }) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Icon(icon, color: color, size: 32),
                Text(value,
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: color)),
              ]),
              const Spacer(),
              Text(title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              if (subtitle != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(subtitle,
                      style:
                      TextStyle(fontSize: 12, color: Colors.grey[600])),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Acciones Rápidas', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _buildActionChip('Nuevo Usuario', Icons.person_add,
                    () => _go('/admin/users/create')),
            _buildActionChip('Nuevo Bus', Icons.add_box,
                    () => _go('/admin/buses/create')),
            _buildActionChip('Nueva Ruta', Icons.add_road,
                    () => _go('/admin/routes/create')),
            _buildActionChip('Nueva Asignación', Icons.assignment_add,
                    () => _go('/admin/assignments/create')),
          ],
        ),
      ],
    );
  }

  Widget _buildActionChip(String label, IconData icon, VoidCallback onTap) {
    return ActionChip(
      avatar: Icon(icon, size: 18),
      label: Text(label),
      onPressed: onTap,
    );
  }

  Widget _buildRecentIncidents(IncidentState incidentState) {
    final recentIncidents = incidentState.incidents.take(5).toList();
    if (recentIncidents.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Incidentes Recientes',
              style: Theme.of(context).textTheme.titleLarge),
          TextButton(
            onPressed: () => _go('/admin/incidents'),
            child: const Text('Ver todos'),
          ),
        ]),
        const SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: recentIncidents.length,
          itemBuilder: (context, index) {
            final incident = recentIncidents[index];
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: _getIncidentColor(incident.type.name),
                  child: Icon(
                    _getIncidentIcon(incident.type.name),
                    color: Colors.white,
                  ),
                ),
                title: Text(incident.type.name),
                subtitle: Text(
                  incident.note ?? 'Sin descripción',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Text(
                  _formatDate(incident.createdAt),
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                onTap: () {
                  ref.read(incidentProvider.notifier).selectIncident(incident);
                  _go('/admin/incidents/detail');
                },
              ),
            );
          },
        ),
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

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    if (difference.inMinutes < 60) return 'Hace ${difference.inMinutes}m';
    if (difference.inHours < 24) return 'Hace ${difference.inHours}h';
    return 'Hace ${difference.inDays}d';
  }
}
