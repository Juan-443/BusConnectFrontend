import 'package:bus_connect/core/constants/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../providers/bus_provider.dart';
import '../../../../core/constants/enums/bus_status.dart';
import '../../../widgets/common/loading_indicator.dart';
import '../../../widgets/common/error_widget.dart' as custom;

class BusListScreen extends ConsumerStatefulWidget {
  const BusListScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<BusListScreen> createState() => _BusListScreenState();
}

class _BusListScreenState extends ConsumerState<BusListScreen> {
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(busProvider.notifier).fetchAllBuses();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(busProvider);
    final notifier = ref.read(busProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Buses'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push(AppRoutes.adminBusCreate),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildStatusFilter(state, notifier),
          Expanded(child: _buildBusList(state, notifier)),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Buscar por placa...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
        ),
        onChanged: (value) {
          setState(() => _searchQuery = value);
        },
      ),
    );
  }

  Widget _buildStatusFilter(BusState state, BusNotifier notifier) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          FilterChip(
            label: const Text('Todos'),
            selected: state.filterStatus == null,
            onSelected: (_) {
              notifier.setStatusFilter(null);
            },
            selectedColor: Colors.green,
            checkmarkColor: Colors.white,
          ),
          const SizedBox(width: 8),
          ...BusStatus.values.map((status) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text(status.displayName),
                selected: state.filterStatus == status,
                onSelected: (_) => notifier.setStatusFilter(status),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildBusList(BusState state, BusNotifier notifier) {
    if (state.isLoading) {
      return const LoadingIndicator();
    }

    if (state.error != null) {
      return custom.ErrorDisplay(
        message: state.error!,
        onRetry: () => notifier.fetchAllBuses(),
      );
    }

    var buses = state.filteredBuses;

    if (_searchQuery.isNotEmpty) {
      buses = buses.where((bus) {
        return bus.plate.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }

    if (buses.isEmpty) {
      return const Center(
        child: Text('No se encontraron buses'),
      );
    }

    return RefreshIndicator(
      onRefresh: () => notifier.fetchAllBuses(),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: buses.length,
        itemBuilder: (context, index) {
          final bus = buses[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: _getStatusColor(bus.status),
                child: const Icon(Icons.directions_bus, color: Colors.white),
              ),
              title: Text(
                bus.plate,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text('Capacidad: ${bus.capacity} pasajeros'),
                  const SizedBox(height: 4),
                  _buildStatusBadge(bus.status),
                ],
              ),
              trailing: PopupMenuButton(
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'view',
                    child: Row(children: [
                      Icon(Icons.visibility),
                      SizedBox(width: 8),
                      Text('Ver detalles')
                    ]),
                  ),
                  const PopupMenuItem(
                    value: 'edit',
                    child: Row(children: [
                      Icon(Icons.edit),
                      SizedBox(width: 8),
                      Text('Editar')
                    ]),
                  ),
                  const PopupMenuItem(
                    value: 'status',
                    child: Row(children: [
                      Icon(Icons.swap_horiz),
                      SizedBox(width: 8),
                      Text('Cambiar estado')
                    ]),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Row(children: [
                      Icon(Icons.delete, color: Colors.red),
                      SizedBox(width: 8),
                      Text('Eliminar', style: TextStyle(color: Colors.red))
                    ]),
                  ),
                ],
                onSelected: (value) =>
                    _handleMenuAction(context, value, bus, notifier),
              ),
                onTap: () => context.push('${AppRoutes.adminBusDetail}/${bus.id}'),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatusBadge(BusStatus status) {
    final color = _getStatusColor(status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
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

  Color _getStatusColor(BusStatus status) {
    switch (status) {
      case BusStatus.ACTIVE:
        return Colors.green;
      case BusStatus.MAINTENANCE:
        return Colors.orange;
      case BusStatus.INACTIVE:
        return Colors.grey;
    }
  }


  void _handleMenuAction(
      BuildContext context, dynamic value, bus, BusNotifier notifier) async {
    switch (value) {
      case 'view':
        context.push('${AppRoutes.adminBusDetail}/${bus.id}');
        break;
      case 'edit':
        if (!context.mounted) return;
        context.go(AppRoutes.adminBusEdit, extra: bus.id);
        break;
      case 'status':
        _showStatusDialog(context, bus, notifier);
        break;
      case 'delete':
        _confirmDelete(context, bus, notifier);
        break;
    }
  }

  void _showStatusDialog(
      BuildContext context, dynamic bus, BusNotifier notifier) {
    showDialog(
      context: context,
      builder: (context) {
        BusStatus? selectedStatus = bus.status as BusStatus?;

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Cambiar Estado'),
              content: SizedBox(
                width: double.maxFinite,
                child: ListView(
                  shrinkWrap: true,
                  children: BusStatus.values.map((status) {
                    final isSelected = selectedStatus == status;
                    return ListTile(
                      title: Text(status.displayName),
                      leading: Icon(
                        isSelected
                            ? Icons.radio_button_checked
                            : Icons.radio_button_off,
                      ),
                      onTap: () => setState(() => selectedStatus = status),
                    );
                  }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () async {
                    if (selectedStatus != null) {
                      Navigator.pop(context);
                      final success = await notifier.changeBusStatus(
                          bus.id, selectedStatus!);

                      if (!context.mounted) return;
                      final errorMessage = ref.read(busProvider).error;

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(success
                              ? 'Estado actualizado'
                              : (errorMessage ?? 'Error al actualizar')),
                        ),
                      );
                    }
                  },
                  child: const Text('Cambiar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _confirmDelete(BuildContext context, bus, BusNotifier notifier) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar eliminación'),
        content: Text('¿Estás seguro de eliminar el bus ${bus.plate}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              final success = await notifier.deleteBus(bus.id);
              if (!mounted) return;
              if (success) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Bus eliminado')));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(
                          ref.read(busProvider).error ?? 'Error al eliminar')),
                );
              }
            },
            child: const Text('Eliminar',
                style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}