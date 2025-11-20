import 'package:bus_connect/core/constants/app_routes.dart';
import 'package:bus_connect/data/models/trip_model/trip_model.dart';
import 'package:bus_connect/presentation/providers/trips_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/enums/trip_status.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../widgets/common/loading_indicator.dart';
import '../../../widgets/common/error_widget.dart' as custom;

// ================== Pantalla ==================
class DispatcherTripListScreen extends ConsumerStatefulWidget {
  const DispatcherTripListScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<DispatcherTripListScreen> createState() => _DispatcherTripListScreenState();
}

class _DispatcherTripListScreenState extends ConsumerState<DispatcherTripListScreen> {
  String _searchQuery = '';
  TripStatus? _filterStatus;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(tripSearchProvider.notifier).getTodayTrips();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(tripSearchProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Viajes'),
        actions: [
          IconButton(icon: const Icon(Icons.calendar_today), onPressed: _selectDate),
          IconButton(icon: const Icon(Icons.filter_list), onPressed: _showFilterDialog),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          if (_selectedDate != null) _buildDateChip(),
          _buildStatusFilter(),
          Expanded(child: _buildTripList(state)),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go(AppRoutes.adminTickets),
        icon: const Icon(Icons.add),
        label: const Text('Nuevo Viaje'),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Buscar por ruta, bus...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
        ),
        onChanged: (value) => setState(() => _searchQuery = value),
      ),
    );
  }

  Widget _buildDateChip() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Chip(
        avatar: const Icon(Icons.calendar_today, size: 18),
        label: Text(DateFormatter.formatDate(_selectedDate!)),
        onDeleted: () {
          setState(() => _selectedDate = null);
          ref.read(tripSearchProvider.notifier).getTodayTrips();
        },
      ),
    );
  }

  Widget _buildStatusFilter() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          FilterChip(
            label: const Text('Todos'),
            selected: _filterStatus == null,
            onSelected: (_) => setState(() => _filterStatus = null),
          ),
          const SizedBox(width: 8),
          ...TripStatus.values.map((status) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text(_getStatusDisplayName(status)),
                selected: _filterStatus == status,
                onSelected: (_) => setState(() => _filterStatus = status),
              ),
            );
          })
        ],
      ),
    );
  }

  Widget _buildTripList(TripSearchState state) {
    if (state.isLoading) return const LoadingIndicator();
    if (state.error != null) {
      return custom.ErrorDisplay(
        message: state.error!,
        onRetry: () => ref.read(tripSearchProvider.notifier).getTodayTrips(),
      );
    }

    var trips = state.trips;

    if (_filterStatus != null) {
      trips = trips.where((t) => t.status == _filterStatus).toList();
    }

    if (_searchQuery.isNotEmpty) {
      trips = trips.where((t) =>
      (t.route?.name?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false) ||
          (t.route?.code?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false) ||
          (t.bus?.plate?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false)
      ).toList();
    }

    if (trips.isEmpty) return const Center(child: Text('No se encontraron viajes'));

    return RefreshIndicator(
      onRefresh: () async {
        if (_selectedDate == null) {
          await ref.read(tripSearchProvider.notifier).getTodayTrips();
        } else {
          final dateStr = _selectedDate!.toIso8601String().split('T')[0];
          await ref.read(tripSearchProvider.notifier).fetchTripsByDate(dateStr);
        }
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: trips.length,
        itemBuilder: (context, index) => _buildTripCard(trips[index]),
      ),
    );
  }

  Widget _buildTripCard(TripResponse trip) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: _getTripStatusColor(trip.status),
          child: const Icon(Icons.directions_bus, color: Colors.white),
        ),
        title: Text('${trip.route?.code} - ${trip.route?.name}',
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text('Bus: ${trip.bus?.plate}'),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(DateFormatter.formatTime(trip.departureAt)),
                const SizedBox(width: 16),
                _buildStatusBadge(trip.status),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(TripStatus status) {
    final color = _getTripStatusColor(status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
      child: Text(_getStatusDisplayName(status), style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold)),
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

  String _getStatusDisplayName(TripStatus status) {
    switch (status) {
      case TripStatus.SCHEDULED:
        return 'Programado';
      case TripStatus.BOARDING:
        return 'Abordando';
      case TripStatus.DEPARTED:
        return 'En ruta';
      case TripStatus.ARRIVED:
        return 'Llegado';
      case TripStatus.CANCELLED:
        return 'Cancelado';
    }
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (picked != null && mounted) {
      setState(() => _selectedDate = picked);
      final dateStr = picked.toIso8601String().split('T')[0];
      ref.read(tripSearchProvider.notifier).fetchTripsByDate(dateStr);
    }
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filtrar por estado'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<TripStatus?>(
              title: const Text('Todos'),
              value: null,
              groupValue: _filterStatus,
              onChanged: (value) {
                setState(() => _filterStatus = value);
                Navigator.pop(context);
              },
            ),
            ...TripStatus.values.map((status) {
              return RadioListTile<TripStatus?>(
                title: Text(_getStatusDisplayName(status)),
                value: status,
                groupValue: _filterStatus,
                onChanged: (value) {
                  setState(() => _filterStatus = value);
                  Navigator.pop(context);
                },
              );
            })
          ],
        ),
      ),
    );
  }
}
