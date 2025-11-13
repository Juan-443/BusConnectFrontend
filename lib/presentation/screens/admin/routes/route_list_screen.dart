import 'package:bus_connect/data/models/route_model/route_model.dart';
import 'package:bus_connect/presentation/providers/route_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../widgets/common/loading_indicator.dart';
import '../../../widgets/common/error_widget.dart' as custom;

class RouteListScreen extends ConsumerStatefulWidget {
  const RouteListScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RouteListScreen> createState() => _RouteListScreenState();
}

class _RouteListScreenState extends ConsumerState<RouteListScreen> {
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    // Fetch routes after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(routeProvider.notifier).fetchAllRoutes();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(routeProvider);
    final notifier = ref.read(routeProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Rutas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.pushNamed(context, '/admin/routes/create'),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: state.isLoading
                ? const LoadingIndicator()
                : state.hasError
                ? custom.ErrorDisplay(
              message: state.error!,
              onRetry: () => notifier.fetchAllRoutes(),
            )
                : _buildRouteList(state.routes, notifier),
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
          hintText: 'Buscar rutas...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
        ),
        onChanged: (value) => setState(() => _searchQuery = value),
      ),
    );
  }

  Widget _buildRouteList(List<RouteResponse> routes, RouteNotifier notifier) {
    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      routes = routes.where((route) {
        return route.code.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            route.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            route.origin.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            route.destination.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }

    if (routes.isEmpty) {
      return const Center(child: Text('No se encontraron rutas'));
    }

    return RefreshIndicator(
      onRefresh: () => notifier.fetchAllRoutes(),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: routes.length,
        itemBuilder: (context, index) {
          final route = routes[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                child: const Icon(Icons.route, color: Colors.white),
              ),
              title: Text(
                '${route.code} - ${route.name}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.place, size: 16, color: Colors.green),
                      const SizedBox(width: 4),
                      Expanded(child: Text(route.origin)),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Icon(Icons.place, size: 16, color: Colors.red),
                      const SizedBox(width: 4),
                      Expanded(child: Text(route.destination)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.timer, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text('${route.durationMin} min'),
                      const SizedBox(width: 16),
                      Icon(Icons.straighten, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text('${route.distanceKm} km'),
                    ],
                  ),
                  if (route.stops != null && route.stops!.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      '${route.stops!.length} paradas',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ],
              ),
              trailing: PopupMenuButton<String>(
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'view',
                    child: Row(
                      children: [
                        Icon(Icons.visibility),
                        SizedBox(width: 8),
                        Text('Ver detalles'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'stops',
                    child: Row(
                      children: [
                        Icon(Icons.location_on),
                        SizedBox(width: 8),
                        Text('Ver paradas'),
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
                onSelected: (value) => _handleMenuAction(value, route, notifier),
              ),
              onTap: () {
                notifier.clearSelectedRoute();
                notifier.fetchRouteById(route.id);
                Navigator.pushNamed(context, '/admin/routes/detail');
              },
            ),
          );
        },
      ),
    );
  }

  void _handleMenuAction(String value, RouteResponse route, RouteNotifier notifier) {
    switch (value) {
      case 'view':
        notifier.clearSelectedRoute();
        notifier.fetchRouteById(route.id);
        Navigator.pushNamed(context, '/admin/routes/detail');
        break;
      case 'stops':
        notifier.clearSelectedRoute();
        notifier.fetchRouteWithStops(route.id);
        Navigator.pushNamed(context, '/admin/stops', arguments: {'routeId': route.id});
        break;
      case 'edit':
        notifier.clearSelectedRoute();
        notifier.fetchRouteById(route.id);
        Navigator.pushNamed(context, '/admin/routes/edit');
        break;
      case 'delete':
        _confirmDelete(route, notifier);
        break;
    }
  }

  void _confirmDelete(RouteResponse route, RouteNotifier notifier) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar eliminación'),
        content: Text('¿Estás seguro de eliminar la ruta ${route.code}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              final success = await notifier.deleteRoute(route.id);
              final state = ref.read(routeProvider);

              if (!mounted) return;

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(success ? 'Ruta eliminada' : state.error ?? 'Error al eliminar'),
                ),
              );
            },
            child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
