import 'package:bus_connect/data/models/overbooking_model/overbooking_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/trips_provider.dart';
import '../../../providers/assignment_provider.dart';
import '../../../providers/bus_provider.dart';
import '../../../providers/overbooking_provider.dart';
import '../../../providers/user_provider.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../core/constants/enums/trip_status.dart';

class DispatcherDashboardScreen extends ConsumerStatefulWidget {
  const DispatcherDashboardScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<DispatcherDashboardScreen> createState() =>
      _DispatcherDashboardScreenState();
}

class _DispatcherDashboardScreenState
    extends ConsumerState<DispatcherDashboardScreen> {
  @override
  void initState() {
    super.initState();
    _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    final tripsNotifier = ref.read(tripSearchProvider.notifier);
    final assignmentNotifier = ref.read(assignmentProvider.notifier);
    final busNotifier = ref.read(busProvider.notifier);
    final overbookingNotifier = ref.read(overbookingProvider.notifier);
    final userNotifier = ref.read(userProvider.notifier);

    await Future.wait([
      tripsNotifier.getTodayTrips(),
      assignmentNotifier.fetchAllAssignments(),
      busNotifier.fetchAllBuses(),
      overbookingNotifier.fetchPendingRequests(),
      userNotifier.fetchCurrentUser(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Panel de Despachador'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadDashboardData,
          ),
        ],
      ),
      drawer: _buildDrawer(),
      body: RefreshIndicator(
        onRefresh: _loadDashboardData,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildWelcomeCard(),
              const SizedBox(height: 20),
              _buildStatsGrid(),
              const SizedBox(height: 20),
              _buildQuickActions(),
              const SizedBox(height: 20),
              _buildTodayTrips(),
              const SizedBox(height: 20),
              _buildPendingOverbooking(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () =>
            Navigator.pushNamed(context, '/dispatcher/trips/create'),
        icon: const Icon(Icons.add),
        label: const Text('Nuevo Viaje'),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme
                  .of(context)
                  .primaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const CircleAvatar(
                  radius: 30,
                  child: Icon(Icons.local_shipping, size: 35),
                ),
                const SizedBox(height: 10),
                Consumer(
                  builder: (context, ref, _) {
                    final currentUser = ref
                        .watch(userProvider)
                        .currentUser;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentUser?.username ?? 'Despachador',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          currentUser?.email ?? '',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          _buildDrawerItem(icon: Icons.dashboard,
              title: 'Dashboard',
              onTap: () => Navigator.pop(context)),
          _buildDrawerItem(
              icon: Icons.directions_bus,
              title: 'Viajes',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/dispatcher/trips');
              }),
          _buildDrawerItem(
              icon: Icons.assignment,
              title: 'Asignaciones',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/dispatcher/assignments');
              }),
          _buildDrawerItem(
              icon: Icons.people,
              title: 'Sobreventa',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/dispatcher/overbooking');
              }),
          _buildDrawerItem(
              icon: Icons.garage,
              title: 'Buses Disponibles',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/dispatcher/buses');
              }),
          _buildDrawerItem(
              icon: Icons.warning,
              title: 'Incidentes',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/dispatcher/incidents');
              }),
          const Divider(),
          _buildDrawerItem(
              icon: Icons.person,
              title: 'Mi Perfil',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/profile');
              }),
          _buildDrawerItem(
              icon: Icons.logout, title: 'Cerrar Sesión', onTap: () {}),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }

  Widget _buildWelcomeCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.local_shipping,
                size: 48, color: Theme
                    .of(context)
                    .primaryColor),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '¡Bienvenido Despachador!',
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Gestiona los viajes de hoy',
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsGrid() {
    final tripsState = ref.watch(tripSearchProvider);
    final todayTrips = tripsState.trips;

    final assignments = ref
        .watch(assignmentProvider)
        .assignments;
    final pendingChecklists = assignments
        .where((a) =>
    a.trip != null &&
        (a.trip!.status == TripStatus.SCHEDULED ||
            a.trip!.status == TripStatus.BOARDING))
        .toList();

    final availableBuses = ref
        .watch(busProvider)
        .availableBuses;
    final pendingRequests = ref
        .watch(overbookingProvider)
        .pendingRequests;

    final activeTrips = todayTrips
        .where((t) =>
    t.status == TripStatus.SCHEDULED ||
        t.status == TripStatus.BOARDING ||
        t.status == TripStatus.DEPARTED)
        .toList();

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.5,
      children: [
        _buildStatCard(
          title: 'Viajes Hoy',
          value: todayTrips.length.toString(),
          icon: Icons.event,
          color: Colors.blue,
          subtitle: '${activeTrips.length} activos',
          onTap: () => Navigator.pushNamed(context, '/dispatcher/trips'),
        ),
        _buildStatCard(
          title: 'Buses Disponibles',
          value: availableBuses.length.toString(),
          icon: Icons.directions_bus,
          color: Colors.green,
          onTap: () => Navigator.pushNamed(context, '/dispatcher/buses'),
        ),
        _buildStatCard(
          title: 'Asignaciones',
          value: assignments.length.toString(),
          icon: Icons.assignment,
          color: Colors.orange,
          subtitle: '${pendingChecklists.length} pendientes',
          onTap: () =>
              Navigator.pushNamed(context, '/dispatcher/assignments'),
        ),
        _buildStatCard(
          title: 'Sobreventa',
          value: pendingRequests.length.toString(),
          icon: Icons.people,
          color: Colors.purple,
          subtitle: 'pendientes',
          onTap: () =>
              Navigator.pushNamed(context, '/dispatcher/overbooking'),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(icon, color: color, size: 32),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
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
        Text(
          'Acciones Rápidas',
          style: Theme
              .of(context)
              .textTheme
              .titleLarge,
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _buildActionChip(
              label: 'Crear Viaje',
              icon: Icons.add_road,
              onTap: () =>
                  Navigator.pushNamed(context, '/dispatcher/trips/create'),
            ),
            _buildActionChip(
              label: 'Nueva Asignación',
              icon: Icons.assignment_add,
              onTap: () =>
                  Navigator.pushNamed(
                      context, '/dispatcher/assignments/create'),
            ),
            _buildActionChip(
              label: 'Reportar Incidente',
              icon: Icons.report,
              onTap: () =>
                  Navigator.pushNamed(context, '/dispatcher/incidents/create'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionChip({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return ActionChip(
      avatar: Icon(icon, size: 18),
      label: Text(label),
      onPressed: onTap,
    );
  }

  Widget _buildTodayTrips() {
    final tripsProvider = ref.watch(tripSearchProvider);
    final trips = tripsProvider.trips.take(5).toList();

    if (trips.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              children: [
                Icon(Icons.event_busy, size: 48, color: Colors.grey[400]),
                const SizedBox(height: 8),
                const Text('No hay viajes programados para hoy'),
              ],
            ),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Viajes de Hoy',
              style: Theme
                  .of(context)
                  .textTheme
                  .titleLarge,
            ),
            TextButton(
              onPressed: () =>
                  Navigator.pushNamed(context, '/dispatcher/trips'),
              child: const Text('Ver todos'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: trips.length,
          itemBuilder: (context, index) {
            final trip = trips[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: _getTripStatusColor(trip.status),
                  child: const Icon(Icons.directions_bus, color: Colors.white),
                ),
                title: Text('${trip.route?.code} - ${trip.route?.name}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Bus: ${trip.bus?.plate}'),
                    Text(
                        'Salida: ${DateFormatter.formatTime(trip.departureAt)}'),
                  ],
                ),
                trailing: _buildStatusBadge(trip.status),
                onTap: () {
                  ref.read(tripSearchProvider.notifier).selectTrip(trip);
                  Navigator.pushNamed(context, '/dispatcher/trips/detail');
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildPendingOverbooking() {
    final overbookingState = ref.watch(overbookingProvider);
    final pending = overbookingState.pendingRequests;

    if (pending.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Sobreventa Pendiente',
              style: Theme
                  .of(context)
                  .textTheme
                  .titleLarge,
            ),
            TextButton(
              onPressed: () =>
                  Navigator.pushNamed(context, '/dispatcher/overbooking'),
              child: const Text('Ver todos'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: pending
              .take(3)
              .length,
          itemBuilder: (context, index) {
            final request = pending[index];
            return Card(
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.purple,
                  child: Icon(Icons.people, color: Colors.white),
                ),
                title: Text('Viaje #${request.tripId}'),
                subtitle: Text('Solicitado por ID: ${request.requestedByName}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.check, color: Colors.green),
                      onPressed: () => _approveOverbooking(request),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.red),
                      onPressed: () => _rejectOverbooking(request),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }


  Widget _buildStatusBadge(TripStatus status) {
    final color = _getTripStatusColor(status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status.displayName,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Color _getTripStatusColor(TripStatus status) {
    switch (status) {
      case TripStatus.SCHEDULED:
        return Colors.blue;
      case TripStatus.BOARDING:
        return Colors.orange;
      case TripStatus.DEPARTED:
        return Colors.purple;
      case TripStatus.ARRIVED:
        return Colors.green;
      case TripStatus.CANCELLED:
        return Colors.red;
    }
  }

  void _approveOverbooking(request) async {
    final provider = ref.read(overbookingProvider.notifier);
    final currentUser = ref
        .read(userProvider)
        .currentUser;

    if (currentUser == null) return;

    final approveRequest = OverbookingApproveRequest(
      notes: 'Aprobado por ${currentUser.username}',
    );

    final success = await provider.approveRequest(request.id, approveRequest);

    if (!mounted) return;

    final error = ref
        .read(overbookingProvider)
        .error;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(success ? 'Sobreventa aprobada' : error ?? 'Error'),
      ),
    );
  }


  void _rejectOverbooking(request) {
    showDialog(
      context: context,
      builder: (context) {
        final reasonController = TextEditingController();
        return AlertDialog(
          title: const Text('Rechazar Sobreventa'),
          content: TextField(
            controller: reasonController,
            decoration: const InputDecoration(
              labelText: 'Razón del rechazo',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                if (reasonController.text.isEmpty) return;

                Navigator.pop(context);

                final provider = ref.read(overbookingProvider.notifier);
                final rejectRequest = OverbookingRejectRequest(
                  reason: reasonController.text,
                );

                final success = await provider.rejectRequest(
                  request.id,
                  rejectRequest,
                );

                if (!mounted) return;
                final error = ref
                    .read(overbookingProvider)
                    .error;

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      success ? 'Sobreventa rechazada' : error ??
                          'Error al rechazar',
                    ),
                  ),
                );
              },
              child: const Text(
                  'Rechazar', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
