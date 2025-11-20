import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../data/models/route_model/route_model.dart';
import '../../../providers/route_provider.dart';

class RouteDetailScreen extends ConsumerStatefulWidget {
  final int routeId;

  const RouteDetailScreen({
    super.key,
    required this.routeId,
  });

  @override
  ConsumerState<RouteDetailScreen> createState() => _RouteDetailScreenState();
}

class _RouteDetailScreenState extends ConsumerState<RouteDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(routeProvider.notifier).fetchRouteById(widget.routeId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(routeProvider);
    final route = state.selectedRoute;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de Ruta'),
        actions: [
          if (route != null) ...[
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => context.pushNamed(
                'adminRouteEdit',
                pathParameters: {'routeId': route.id.toString()},
              ),
              tooltip: 'Editar',
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _confirmDelete(route),
              tooltip: 'Eliminar',
            ),
          ],
        ],
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.error != null
          ? _buildError(state.error!)
          : route == null
          ? const Center(child: Text('Ruta no encontrada'))
          : _buildRouteDetails(route),
      floatingActionButton: route != null
          ? FloatingActionButton.extended(
        onPressed: () => context.pushNamed(
          AppRoutes.adminRouteStopsName,
          pathParameters: {'id': route.id.toString()},
          extra: route.name,
        ),
        icon: const Icon(Icons.location_on),
        label: const Text('Gestionar Paradas'),
      )
          : null,
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
            'Error al cargar ruta',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(error, textAlign: TextAlign.center),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => ref
                .read(routeProvider.notifier)
                .fetchRouteById(widget.routeId),
            icon: const Icon(Icons.refresh),
            label: const Text('Reintentar'),
          ),
        ],
      ),
    );
  }

  Widget _buildRouteDetails(RouteModel route) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header con código
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade700, Colors.blue.shade500],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    route.code,
                    style: TextStyle(
                      color: Colors.blue.shade700,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    route.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Información principal
          _buildSection(
            title: 'Información General',
            children: [
              _buildInfoRow(
                icon: Icons.trip_origin,
                label: 'Origen',
                value: route.origin,
                color: Colors.green,
              ),
              const Divider(height: 24),
              _buildInfoRow(
                icon: Icons.location_on,
                label: 'Destino',
                value: route.destination,
                color: Colors.red,
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Características
          _buildSection(
            title: 'Características',
            children: [
              _buildInfoRow(
                icon: Icons.straighten,
                label: 'Distancia',
                value: '${route.distanceKm} km',
                color: Colors.blue,
              ),
              const Divider(height: 24),
              _buildInfoRow(
                icon: Icons.access_time,
                label: 'Duración estimada',
                value: '${route.durationMin} minutos',
                color: Colors.orange,
              ),
              if (route.stops != null && route.stops!.isNotEmpty) ...[
                const Divider(height: 24),
                _buildInfoRow(
                  icon: Icons.location_on_outlined,
                  label: 'Paradas',
                  value: '${route.stops!.length} paradas',
                  color: Colors.purple,
                ),
              ],
            ],
          ),
          const SizedBox(height: 24),

          // Acciones
          _buildActionsSection(route),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionsSection(RouteModel route) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () => context.pushNamed(
              AppRoutes.adminRouteStopsName,
              pathParameters: {'id': route.id.toString()},
              extra: route.name,
            ),
            icon: const Icon(Icons.location_on),
            label: const Text('Gestionar Paradas'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(16),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () => context.pushNamed(
              'adminRouteEdit',
              pathParameters: {'routeId': route.id.toString()},
            ),
            icon: const Icon(Icons.edit),
            label: const Text('Editar Ruta'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.all(16),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () => _confirmDelete(route),
            icon: const Icon(Icons.delete),
            label: const Text('Eliminar Ruta'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.red,
              padding: const EdgeInsets.all(16),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _confirmDelete(RouteModel route) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Row(
          children: [
            Icon(Icons.warning, color: Colors.red),
            SizedBox(width: 12),
            Text('Confirmar eliminación'),
          ],
        ),
        content: Text(
          '¿Eliminar la ruta "${route.name}"?\n\n'
              'Esta acción eliminará también todas las paradas asociadas.',
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
      await ref.read(routeProvider.notifier).deleteRoute(route.id);

      if (!mounted) return;

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ruta eliminada exitosamente')),
        );
        context.go(AppRoutes.adminRoutes);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              ref.read(routeProvider).error ?? 'Error al eliminar la ruta',
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}