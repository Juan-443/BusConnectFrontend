import 'package:bus_connect/presentation/providers/trips_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_routes.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../data/models/route_model/route_model.dart';
import '../../providers/route_provider.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/loading_indicator.dart';
import '../../widgets/common/error_widget.dart';
import '../../widgets/trip/trip_card.dart';
import 'package:bus_connect/presentation/providers/route_provider.dart';

class SearchTripsScreen extends ConsumerStatefulWidget {
  const SearchTripsScreen({super.key});

  @override
  ConsumerState<SearchTripsScreen> createState() => _SearchTripsScreenState();
}

class _SearchTripsScreenState extends ConsumerState<SearchTripsScreen> {
  RouteResponse? _selectedRoute;
  DateTime _selectedDate = DateTime.now();
  bool _hasSearched = false;

  @override
  void initState() {
    super.initState();
    // Cargar viajes de hoy por defecto
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(tripSearchProvider.notifier).getTodayTrips();
      setState(() => _hasSearched = true);
    });
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  void _searchTrips() {
    if (_selectedRoute == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor selecciona una ruta'),
          backgroundColor: AppColors.warning,
        ),
      );
      return;
    }

    ref.read(tripSearchProvider.notifier).searchTrips(
      routeId: _selectedRoute!.id,
      date: _selectedDate.toIso8601String().split('T')[0],
    );

    setState(() => _hasSearched = true);
  }

  @override
  Widget build(BuildContext context) {
    final routesAsync = ref.watch(allRoutesProvider);


    final tripSearchState = ref.watch(tripSearchProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Viajes'),
      ),
      body: Column(
        children: [
          // Search Form
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                // Route Selector
                routesAsync.when(
                  data: (routes) => _RouteDropdown(
                    routes: routes,
                    selectedRoute: _selectedRoute,
                    onChanged: (route) {
                      setState(() => _selectedRoute = route);
                    },
                  ),
                  loading: () => const LinearProgressIndicator(),
                  error: (error, _) => Text('Error: $error'),
                ),
                const SizedBox(height: 16),

                // Date Selector
                InkWell(
                  onTap: _selectDate,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.grey300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_today, color: AppColors.primary),
                        const SizedBox(width: 12),
                        Text(
                          DateFormatter.formatDateTime(_selectedDate),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        const Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Search Button
                CustomButton(
                  text: 'Buscar',
                  icon: Icons.search,
                  onPressed: _searchTrips,
                  width: double.infinity,
                ),
              ],
            ),
          ),

          // Results
          Expanded(
            child: _hasSearched
                ? _buildResults(tripSearchState)
                : const Center(
              child: Text('Selecciona una ruta y fecha para buscar'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResults(TripSearchState state) {
    if (state.isLoading) {
      return const LoadingIndicator(message: 'Buscando viajes...');
    }

    if (state.error != null) {
      return ErrorDisplay(
        message: state.error!,
        onRetry: _searchTrips,
      );
    }

    if (state.trips.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.sentiment_dissatisfied,
              size: 64,
              color: AppColors.grey400,
            ),
            const SizedBox(height: 16),
            Text(
              'No hay viajes disponibles',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Intenta con otra fecha',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: state.trips.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final trip = state.trips[index];
        return TripCard(
          trip: trip,
          onTap: () {
            context.push('${AppRoutes.selectSeats}/${trip.id}');
          },
        );
      },
    );
  }
}

class _RouteDropdown extends StatelessWidget {
  final List<RouteResponse> routes;
  final RouteResponse? selectedRoute;
  final ValueChanged<RouteResponse?> onChanged;

  const _RouteDropdown({
    required this.routes,
    required this.selectedRoute,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<RouteResponse>(
      value: selectedRoute,
      decoration: InputDecoration(
        labelText: 'Ruta',
        prefixIcon: const Icon(Icons.route),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      items: routes.map((route) {
        return DropdownMenuItem(
          value: route,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                route.name,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(
                '${route.origin} → ${route.destination}',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}