import 'package:bus_connect/core/constants/app_routes.dart';
import 'package:bus_connect/presentation/providers/route_provider.dart';
import 'package:bus_connect/presentation/widgets/route_card/route_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RoutesListScreen extends ConsumerStatefulWidget {
  const RoutesListScreen({super.key});

  @override
  ConsumerState<RoutesListScreen> createState() => _RoutesListScreenState();
}

class _RoutesListScreenState extends ConsumerState<RoutesListScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    Future.microtask(
          () => ref.read(routeProvider.notifier).fetchAllRoutes(),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(routeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Rutas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () =>
                ref.read(routeProvider.notifier).fetchAllRoutes(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Barra de búsqueda
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar por origen o destino...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    setState(() => _searchQuery = '');
                  },
                )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                setState(() => _searchQuery = value);
              },
            ),
          ),

          // Lista de rutas
          Expanded(
            child: state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : state.error != null
                ? _buildError(state.error!)
                : _buildRoutesList(state.routes),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/admin/routes/create'),
        icon: const Icon(Icons.add),
        label: const Text('Nueva Ruta'),
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
            'Error al cargar rutas',
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
                ref.read(routeProvider.notifier).fetchAllRoutes(),
            icon: const Icon(Icons.refresh),
            label: const Text('Reintentar'),
          ),
        ],
      ),
    );
  }

  Widget _buildRoutesList(List routes) {
    final filteredRoutes = _searchQuery.isEmpty
        ? routes
        : routes.where((route) {
      final query = _searchQuery.toLowerCase();
      return route.origin.toLowerCase().contains(query) ||
          route.destination.toLowerCase().contains(query) ||
          route.code.toLowerCase().contains(query) ||
          route.name.toLowerCase().contains(query);
    }).toList();

    if (filteredRoutes.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _searchQuery.isEmpty ? Icons.route_outlined : Icons.search_off,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              _searchQuery.isEmpty
                  ? 'No hay rutas registradas'
                  : 'No se encontraron rutas',
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(routeProvider.notifier).fetchAllRoutes(),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: filteredRoutes.length,
        itemBuilder: (context, index) {
          final route = filteredRoutes[index];
          return RouteCard(
            route: route,
            onTap: () => context.pushNamed(
              'adminRouteDetail',
              pathParameters: {'id': route.id.toString()},
            ),
            onEdit: () => context.pushNamed(
              'adminRouteEdit',
              pathParameters: {'routeId': route.id.toString()},
            ),
            onDelete: () => _confirmDelete(route.id, route.name),
            onManageStops: () => context.pushNamed(
              AppRoutes.adminRouteStopsName,
              pathParameters: {'id': route.id.toString()},
              extra: route.name,
            ),
          );
        },
      ),
    );
  }

  Future<void> _confirmDelete(int id, String name) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirmar eliminación'),
        content: Text(
          '¿Eliminar la ruta "$name"?\n\nEsta acción eliminará también todas las paradas asociadas.',
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
      final success = await ref.read(routeProvider.notifier).deleteRoute(id);
      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ruta eliminada exitosamente')),
        );
      }
    }
  }
}