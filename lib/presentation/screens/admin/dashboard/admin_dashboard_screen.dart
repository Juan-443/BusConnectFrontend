import 'package:bus_connect/presentation/providers/auth_provider.dart';
import 'package:bus_connect/presentation/providers/bus_provider.dart';
import 'package:bus_connect/presentation/providers/incident_provider.dart';
import 'package:bus_connect/presentation/providers/route_provider.dart';
import 'package:bus_connect/presentation/providers/tickets_provider.dart';
import 'package:bus_connect/presentation/providers/trips_provider.dart';
import 'package:bus_connect/presentation/providers/user_provider.dart';
import 'package:bus_connect/presentation/widgets/stat_card/quick_action_card.dart';
import 'package:bus_connect/presentation/widgets/stat_card/recent_activity_card.dart';
import 'package:bus_connect/presentation/widgets/stat_card/stat_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AdminDashboardScreen extends ConsumerStatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  ConsumerState<AdminDashboardScreen> createState() =>
      _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends ConsumerState<AdminDashboardScreen> {
  final List<AdminMenuItem> _menuItems = [
    AdminMenuItem(
      icon: Icons.dashboard,
      label: 'Dashboard',
      routeName: 'adminDashboard',
    ),
    AdminMenuItem(
      icon: Icons.people,
      label: 'Usuarios',
      routeName: 'adminUsers',
    ),
    AdminMenuItem(
      icon: Icons.directions_bus,
      label: 'Buses',
      routeName: 'adminBuses',
    ),
    AdminMenuItem(
      icon: Icons.route,
      label: 'Rutas',
      routeName: 'adminRoutes',
    ),
    AdminMenuItem(
      icon: Icons.trip_origin,
      label: 'Viajes',
      routeName: 'adminTrips',
    ),
    AdminMenuItem(
      icon: Icons.confirmation_number,
      label: 'Tickets',
      routeName: 'adminTickets',
    ),
    AdminMenuItem(
      icon: Icons.assignment,
      label: 'Asignaciones',
      routeName: 'adminAssignments',
    ),
    AdminMenuItem(
      icon: Icons.warning,
      label: 'Incidentes',
      routeName: 'adminIncidents',
    ),
    AdminMenuItem(
      icon: Icons.settings,
      label: 'Configuración',
      routeName: 'adminConfig',
    ),
    AdminMenuItem(
      icon: Icons.feed_outlined,
      label: "Tarifas",
      routeName: 'adminFareRules',
    ),
  ];

  @override
  void initState() {
    super.initState();
    Future.microtask(() => _loadDashboardData());
  }

  Future<void> _loadDashboardData() async {
    ref.read(userProvider.notifier).fetchAllUsers();
    ref.read(busProvider.notifier).fetchAllBuses();
    ref.read(routeProvider.notifier).fetchAllRoutes();
    ref.read(tripSearchProvider.notifier).loadAllTrips();
    ref.read(incidentProvider.notifier).fetchAllIncidents();
    ref.read(ticketProvider.notifier).loadAllTickets();
  }

  @override
  Widget build(BuildContext context) {
    final usersState = ref.watch(userProvider);
    final busesState = ref.watch(busProvider);
    final routesState = ref.watch(routeProvider);
    final tripsState = ref.watch(tripSearchProvider);
    final incidentsState = ref.watch(incidentProvider);
    final ticketsState = ref.watch(ticketProvider);

    final isInitialLoading = usersState.isLoading &&
        busesState.isLoading &&
        routesState.isLoading &&
        tripsState.isLoading &&
        incidentsState.isLoading &&
        ticketsState.isLoading;

    final hasError = usersState.error != null ||
        busesState.error != null ||
        routesState.error != null ||
        tripsState.error != null ||
        incidentsState.error != null ||
        ticketsState.error != null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Panel de Administración'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadDashboardData,
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notificaciones próximamente')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () => context.pushNamed('passengerProfile'),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _handleLogout(context),
          ),
        ],
      ),
      drawer: _buildDrawer(),
      body: isInitialLoading
          ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Cargando dashboard...'),
          ],
        ),
      )
          : hasError
          ? _buildErrorView()
          : RefreshIndicator(
        onRefresh: _loadDashboardData,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildWelcomeSection(context),
              const SizedBox(height: 24),
              _buildSectionTitle('Estadísticas'),
              const SizedBox(height: 16),
              _buildStatsGrid(
                usersCount: usersState.users.length,
                busesCount: busesState.buses.length,
                routesCount: routesState.routes.length,
                tripsCount: tripsState.trips.length,
                incidentsCount: incidentsState.incidents.length,
                ticketsCount: ticketsState.tickets.length,
              ),
              const SizedBox(height: 24),
              _buildSectionTitle('Acciones Rápidas'),
              const SizedBox(height: 16),
              _buildQuickActions(context),
              const SizedBox(height: 24),
              _buildSectionTitle('Actividad Reciente'),
              const SizedBox(height: 16),
              _buildRecentActivity(
                trips: tripsState.trips,
                incidents: incidentsState.incidents,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          const Text(
            'Error al cargar datos',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Revisa tu conexión e intenta nuevamente',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _loadDashboardData,
            icon: const Icon(Icons.refresh),
            label: const Text('Reintentar'),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    return NavigationDrawer(
      selectedIndex: 0,
      onDestinationSelected: (index) {
        context.pushNamed(_menuItems[index].routeName);
        Navigator.pop(context);
      },
      children: [
        DrawerHeader(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.admin_panel_settings,
                  size: 30,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Administrador',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Sistema Bus Connect',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        ..._menuItems.map((item) => NavigationDrawerDestination(
          icon: Icon(item.icon),
          label: Text(item.label),
        )),
        const Divider(),
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Versión 1.0.0',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildWelcomeSection(BuildContext context) {
    final hour = DateTime.now().hour;
    String greeting;
    IconData icon;

    if (hour < 12) {
      greeting = 'Buenos días';
      icon = Icons.wb_sunny;
    } else if (hour < 18) {
      greeting = 'Buenas tardes';
      icon = Icons.wb_cloudy;
    } else {
      greeting = 'Buenas noches';
      icon = Icons.nights_stay;
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade700, Colors.blue.shade500],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, size: 40, color: Colors.white),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  greeting,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Bienvenido al panel de administración',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid({
    required int usersCount,
    required int busesCount,
    required int routesCount,
    required int tripsCount,
    required int incidentsCount,
    required int ticketsCount,
  }) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.4,
      children: [
        StatCard(
          title: 'Usuarios',
          value: usersCount.toString(),
          icon: Icons.people,
          color: Colors.blue,
        ),
        StatCard(
          title: 'Buses',
          value: busesCount.toString(),
          icon: Icons.directions_bus,
          color: Colors.purple,
        ),
        StatCard(
          title: 'Rutas',
          value: routesCount.toString(),
          icon: Icons.route,
          color: Colors.green,
        ),
        StatCard(
          title: 'Viajes',
          value: tripsCount.toString(),
          icon: Icons.roundabout_left_outlined,
          color: Colors.orange,
        ),
        StatCard(
          title: 'Incidentes',
          value: incidentsCount.toString(),
          icon: Icons.warning,
          color: incidentsCount > 0 ? Colors.red : Colors.grey,
        ),
        StatCard(
          title: 'Tickets',
          value: ticketsCount.toString(),
          icon: Icons.confirmation_number,
          color: Colors.indigo,
        ),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: QuickActionCard(
                title: 'Nuevo Usuario',
                icon: Icons.person_add,
                color: Colors.blue,
                onTap: () {
                  Future.microtask(() => context.pushNamed('adminUserCreate'));
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: QuickActionCard(
                title: 'Nuevo Bus',
                icon: Icons.add_circle,
                color: Colors.purple,
                onTap: () {
                  Future.microtask(() => context.pushNamed('adminBusCreate'));
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: QuickActionCard(
                title: 'Nueva Ruta',
                icon: Icons.add_road,
                color: Colors.green,
                onTap: () {
                  Future.microtask(() => context.pushNamed('adminRouteCreate'));
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: QuickActionCard(
                title: 'Nuevo Viaje',
                icon: Icons.add_location,
                color: Colors.orange,
                onTap: () {
                  Future.microtask(() => context.pushNamed('adminTripsCreate'));
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
  Widget _buildRecentActivity({
    required List trips,
    required List incidents,
  }) {
    final recentTrips = trips.take(3).toList();
    final recentIncidents = incidents.take(3).toList();

    return Column(
      children: [
        if (recentTrips.isNotEmpty) ...[
          RecentActivityCard(
            title: 'Últimos Viajes',
            icon: Icons.trip_origin,
            color: Colors.blue,
            items: recentTrips.map((trip) {
              return <String, String>{
                'title': trip.route?.name ?? 'Sin nombre',
                'subtitle': trip.date?.toString() ?? 'Sin fecha',
                'status': trip.status.toString(),
              };
            }).toList(),
            onViewAll: () => context.pushNamed('adminTrips'),
          ),
          const SizedBox(height: 12),
        ],
        if (recentIncidents.isNotEmpty) ...[
          RecentActivityCard(
            title: 'Incidentes Recientes',
            icon: Icons.warning,
            color: Colors.red,
            items: recentIncidents.map((incident) {
              return <String, String>{
                'title': incident.type?.toString() ?? 'Sin tipo',
                'subtitle': incident.reportedByName ?? 'N/A',
                'status': incident.entityType?.toString() ?? 'N/A',
              };
            }).toList(),
            onViewAll: () => context.pushNamed('adminIncidents'),
          ),
        ],
        if (recentTrips.isEmpty && recentIncidents.isEmpty)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(32),
              child: Text('No hay actividad reciente'),
            ),
          ),
      ],
    );
  }

  void _handleLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Cerrar Sesión'),
        content: const Text('¿Estás seguro de que quieres salir?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await ref.read(authProvider.notifier).logout();
              ref.invalidate(userProvider);
              ref.invalidate(busProvider);
              ref.invalidate(routeProvider);
              ref.invalidate(tripSearchProvider);
              ref.invalidate(incidentProvider);
              ref.invalidate(ticketProvider);
              if (context.mounted) {
                context.goNamed('login');
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Salir'),
          ),
        ],
      ),
    );
  }
}

class AdminMenuItem {
  final IconData icon;
  final String label;
  final String routeName;

  AdminMenuItem({
    required this.icon,
    required this.label,
    required this.routeName,
  });
}