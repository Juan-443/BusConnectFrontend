import 'package:bus_connect/core/constants/app_routes.dart';
import 'package:bus_connect/core/constants/enums/trip_status.dart';
import 'package:bus_connect/data/models/trip_model/trip_model.dart'; // ✅ AGREGAR
import 'package:bus_connect/presentation/providers/trips_provider.dart';
import 'package:bus_connect/presentation/screens/admin/trip/from_screen.dart';
import 'package:bus_connect/presentation/widgets/trip/trip_card.dart';
import 'package:bus_connect/presentation/widgets/trip/trip_filters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TripsListScreen extends ConsumerStatefulWidget {
  const TripsListScreen({super.key});

  @override
  ConsumerState<TripsListScreen> createState() => _TripsListScreenState();
}

class _TripsListScreenState extends ConsumerState<TripsListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(tripSearchProvider.notifier).loadAllTrips();
      ref.read(tripSearchProvider.notifier).startAutoUpdateTimer();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    ref.read(tripSearchProvider.notifier).stopAutoUpdateTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(tripSearchProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Viajes'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.list), text: 'Todos'),
            Tab(icon: Icon(Icons.today), text: 'Hoy'),
            Tab(icon: Icon(Icons.schedule), text: 'Próximos'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilters(context),
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () =>
                ref.read(tripSearchProvider.notifier).loadAllTrips(),
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
          _buildTripsList(state.trips, 'all'),
          _buildTripsList(_filterTodayTrips(state.trips), 'today'),
          _buildTripsList(
              _filterUpcomingTrips(state.trips), 'upcoming'),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppRoutes.adminTripsCreate),
        icon: const Icon(Icons.add),
        label: const Text('Nuevo Viaje'),
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
            'Error al cargar viajes',
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
                ref.read(tripSearchProvider.notifier).loadAllTrips(),
            icon: const Icon(Icons.refresh),
            label: const Text('Reintentar'),
          ),
        ],
      ),
    );
  }

  Widget _buildTripsList(List<TripResponse> trips, String category) {
    if (trips.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              category == 'today'
                  ? Icons.event_busy
                  : Icons.trip_origin_outlined,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              category == 'today'
                  ? 'No hay viajes programados para hoy'
                  : category == 'upcoming'
                  ? 'No hay viajes próximos'
                  : 'No hay viajes registrados',
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(tripSearchProvider.notifier).loadAllTrips();
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: trips.length,
        itemBuilder: (context, index) {
          final trip = trips[index];
          return TripCard(
            trip: trip,
            onTap: () => _showTripEditDialog(trip),
            onEdit: () => _showTripEditDialog(trip),
            onDelete: () => _confirmDelete(trip.id, trip.routeName ?? 'Sin nombre'),
            onChangeStatus: (status) => _changeStatus(trip, status),
            onCancel: () => _confirmCancel(trip),
          );
        },
      ),
    );
  }

  void _showTripEditDialog(TripResponse trip) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (_, controller) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: TripFormScreen(tripId: trip.id),
        ),
      ),
    ).then((result) {
      if (result == true && mounted) {
        ref.read(tripSearchProvider.notifier).loadAllTrips();
      }
    });
  }

  List<TripResponse> _filterTodayTrips(List<TripResponse> trips) {
    final today = DateTime.now();
    return trips.where((trip) {
      try {
        return trip.date.year == today.year &&
            trip.date.month == today.month &&
            trip.date.day == today.day;
      } catch (e) {
        return false;
      }
    }).toList();
  }

  List<TripResponse> _filterUpcomingTrips(List<TripResponse> trips) {
    final today = DateTime.now();
    final todayStart = DateTime(today.year, today.month, today.day);

    return trips.where((trip) {
      try {
        final tripDate =
        DateTime(trip.date.year, trip.date.month, trip.date.day);
        return tripDate.isAfter(todayStart) &&
            trip.status != TripStatus.CANCELLED &&
            trip.status != TripStatus.ARRIVED;
      } catch (e) {
        return false;
      }
    }).toList();
  }

  void _showFilters(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => TripFilters(
        currentStatus: ref.read(tripSearchProvider).filterStatus,
        onStatusChanged: (status) {
          ref.read(tripSearchProvider.notifier).filterByStatus(status);
          Navigator.pop(ctx);
        },
        onClearFilters: () {
          ref.read(tripSearchProvider.notifier).loadAllTrips();
          Navigator.pop(ctx);
        },
      ),
    );
  }

  Future<void> _confirmDelete(int id, String routeName) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirmar eliminación'),
        content: Text(
          '¿Eliminar el viaje de la ruta "$routeName"?\n\nEsta acción no se puede deshacer.',
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
      final success =
      await ref.read(tripSearchProvider.notifier).deleteTrip(id);
      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Viaje eliminado exitosamente')),
        );
      }
    }
  }

  Future<void> _confirmCancel(TripResponse trip) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Cancelar Viaje'),
        content: Text(
          '¿Cancelar el viaje de la ruta "${trip.routeName ?? 'Sin nombre'}"?\n\nSe notificará a los pasajeros con tickets.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('No'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
            ),
            child: const Text('Cancelar Viaje'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      final request = TripUpdateRequest(
        date: trip.date,
        departureAt: trip.departureAt,
        arrivalEta: trip.arrivalEta,
        busId: trip.busId,
        status: TripStatus.CANCELLED,
      );

      final success = await ref
          .read(tripSearchProvider.notifier)
          .updateTrip(trip.id, request);

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Viaje cancelado exitosamente')),
        );
      } else if (mounted) {
        final error = ref.read(tripSearchProvider).error;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error ?? 'Error al cancelar viaje'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _changeStatus(TripResponse trip, TripStatus status) async {
    final request = TripUpdateRequest(
      date: trip.date,
      departureAt: trip.departureAt,
      arrivalEta: trip.arrivalEta,
      busId: trip.busId,
      status: status,
    );

    final success = await ref
        .read(tripSearchProvider.notifier)
        .updateTrip(trip.id, request);

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Estado actualizado a ${status.displayName}')),
      );
    } else if (mounted) {
      final error = ref
          .read(tripSearchProvider)
          .error;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error ?? 'Error al cambiar estado'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}