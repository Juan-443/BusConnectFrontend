import 'package:bus_connect/core/constants/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../providers/stop_provider.dart';
import '../../../widgets/common/loading_indicator.dart';
import '../../../widgets/common/error_widget.dart' as custom;

class StopListScreen extends ConsumerStatefulWidget {
  const StopListScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<StopListScreen> createState() => _StopListScreenState();
}

class _StopListScreenState extends ConsumerState<StopListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(stopProvider.notifier).fetchAllStops();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(stopProvider);
    final notifier = ref.read(stopProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Paradas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push(AppRoutes.adminStopCreate),
          ),
        ],
      ),
      body: _buildBody(state, notifier),
    );
  }

  Widget _buildBody(StopState state, StopNotifier notifier) {
    if (state.isLoading) return const LoadingIndicator();
    if (state.error != null) {
      return custom.ErrorDisplay(
        message: state.error!,
        onRetry: () => notifier.fetchAllStops(),
      );
    }

    if (state.stops.isEmpty) {
      return const Center(child: Text('No hay paradas registradas'));
    }

    return RefreshIndicator(
      onRefresh: () => notifier.fetchAllStops(),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: state.stops.length,
        itemBuilder: (context, index) {
          final stop = state.stops[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                child: Text('${stop.order}'),
              ),
              title: Text(stop.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('${stop.routeName} (${stop.routeCode})'),
              trailing: PopupMenuButton(
                itemBuilder: (context) => [
                  const PopupMenuItem(value: 'edit', child: Row(children: [Icon(Icons.edit), SizedBox(width: 8), Text('Editar')])),
                  const PopupMenuItem(value: 'delete', child: Row(children: [Icon(Icons.delete, color: Colors.red), SizedBox(width: 8), Text('Eliminar', style: TextStyle(color: Colors.red))])),
                ],
                onSelected: (value) => _handleMenuAction(context, value, stop, notifier),
              ),
            ),
          );
        },
      ),
    );
  }

  void _handleMenuAction(context, value, stop, StopNotifier notifier) {
    if (value == 'edit') {
      context.push(AppRoutes.adminStopEdit, extra: stop.id);
    } else if (value == 'delete') {
      _confirmDelete(context, stop, notifier);
    }
  }

  void _confirmDelete(context, stop, StopNotifier notifier) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar Parada'),
        content: Text('¿Eliminar ${stop.name}?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              final success = await notifier.deleteStop(stop.id);
              if (!mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(success ? 'Parada eliminada' : 'Error al eliminar')),
              );
            },
            child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}