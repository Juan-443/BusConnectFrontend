import 'dart:ui';
import 'package:bus_connect/data/models/stop_model/stop_model.dart';
import 'package:bus_connect/presentation/providers/stop_provider.dart';
import 'package:bus_connect/presentation/providers/route_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RouteStopsScreen extends ConsumerStatefulWidget {
  final int routeId;
  final String? routeName;

  const RouteStopsScreen({
    super.key,
    required this.routeId,
    this.routeName,
  });

  @override
  ConsumerState<RouteStopsScreen> createState() => _RouteStopsScreenState();
}

class _RouteStopsScreenState extends ConsumerState<RouteStopsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(stopProvider.notifier).fetchStopsByRoute(widget.routeId);
      ref.read(routeProvider.notifier).fetchRouteById(widget.routeId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(stopProvider);
    final routeState = ref.watch(routeProvider);
    final route = routeState.selectedRoute;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Gestión de Paradas'),
            if (widget.routeName != null)
              Text(
                widget.routeName!,
                style: const TextStyle(fontSize: 14),
              ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(stopProvider.notifier).fetchStopsByRoute(widget.routeId);
              ref.read(routeProvider.notifier).fetchRouteById(widget.routeId);
            },
          ),
        ],
      ),
      body: state.isLoading || routeState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.error != null
          ? _buildError(state.error!)
          : _buildStopsView(state.stops, route),
      floatingActionButton: route != null
          ? FloatingActionButton.extended(
        onPressed: () => _showCreateStopDialog(context, state.stops, route),
        icon: const Icon(Icons.add_location),
        label: const Text('Nueva Parada'),
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
            'Error al cargar paradas',
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
            onPressed: () => ref
                .read(stopProvider.notifier)
                .fetchStopsByRoute(widget.routeId),
            icon: const Icon(Icons.refresh),
            label: const Text('Reintentar'),
          ),
        ],
      ),
    );
  }

  Widget _buildStopsView(List<StopModel> stops, dynamic route) {
    if (route == null) {
      return const Center(child: Text('Cargando información de ruta...'));
    }

    return Column(
      children: [
        // ⭐ Header mostrando origen → paradas → destino
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade700, Colors.blue.shade500],
            ),
          ),
          child: Column(
            children: [
              // Origen → Destino
              Row(
                children: [
                  Expanded(
                    child: _buildEndpoint(
                      icon: Icons.trip_origin,
                      label: 'ORIGEN',
                      value: route.origin,
                      color: Colors.green,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.white.withValues(alpha: 0.8),
                      size: 32,
                    ),
                  ),
                  Expanded(
                    child: _buildEndpoint(
                      icon: Icons.flag,
                      label: 'DESTINO',
                      value: route.destination,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Info de paradas
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.location_on, color: Colors.white, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      stops.isEmpty
                          ? 'Sin paradas intermedias'
                          : '${stops.length} parada${stops.length != 1 ? 's' : ''} intermedia${stops.length != 1 ? 's' : ''}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Info explicativa
        Container(
          padding: const EdgeInsets.all(12),
          color: Colors.blue.shade50,
          child: Row(
            children: [
              Icon(Icons.info_outline, size: 18, color: Colors.blue.shade700),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Las paradas son puntos intermedios entre el origen y destino',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.blue.shade900,
                  ),
                ),
              ),
            ],
          ),
        ),

        if (stops.isEmpty)
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_off,
                    size: 64,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'No hay paradas intermedias',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'El bus va directo de ${route.origin} a ${route.destination}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () => _showCreateStopDialog(context, stops, route),
                    icon: const Icon(Icons.add),
                    label: const Text('Agregar Parada Intermedia'),
                  ),
                ],
              ),
            ),
          )
        else ...[
          // Banner de reordenamiento
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Colors.grey.shade100,
            child: Row(
              children: [
                Icon(Icons.drag_handle, size: 20, color: Colors.grey.shade600),
                const SizedBox(width: 8),
                Text(
                  'Mantén presionado el ícono ≡ para reordenar',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // Lista de paradas
          Expanded(
            child: ReorderableListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: stops.length,
              proxyDecorator: (child, index, animation) {
                return AnimatedBuilder(
                  animation: animation,
                  builder: (context, child) {
                    final double animValue = Curves.easeInOut.transform(animation.value);
                    final double elevation = lerpDouble(2, 8, animValue)!;
                    final double scale = lerpDouble(1, 1.02, animValue)!;

                    return Transform.scale(
                      scale: scale,
                      child: Material(
                        elevation: elevation,
                        color: Colors.transparent,
                        shadowColor: Colors.blue.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(12),
                        child: child,
                      ),
                    );
                  },
                  child: child,
                );
              },
              onReorder: (oldIndex, newIndex) => _handleReorder(oldIndex, newIndex, stops),
              itemBuilder: (context, index) {
                final stop = stops[index];

                return Container(
                  key: ValueKey(stop.id),
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      // Handle de drag
                      Material(
                        color: Colors.blue.shade100,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                        ),
                        child: ReorderableDragStartListener(
                          index: index,
                          child: Container(
                            width: 48,
                            height: 100,
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.drag_handle,
                                  color: Colors.blue.shade700,
                                  size: 28,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '#${index + 1}',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue.shade700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Contenido
                      Expanded(
                        child: _buildStopContent(stop, route),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildEndpoint({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.white, size: 32),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.8),
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildStopContent(StopModel stop, dynamic route) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
        side: BorderSide(
          color: Colors.blue.shade200,
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: () => _showStopDetails(stop, route),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Icono de parada
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.location_on,
                  color: Colors.blue.shade700,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),

              // Nombre y coordenadas
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stop.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 12, color: Colors.grey),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            'Lat: ${stop.lat.toStringAsFixed(4)}, Lng: ${stop.lng.toStringAsFixed(4)}',
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Menú
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert),
                itemBuilder: (ctx) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'edit',
                    child: Row(
                      children: [
                        Icon(Icons.edit, size: 20),
                        SizedBox(width: 8),
                        Text('Editar'),
                      ],
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete, size: 20, color: Colors.red),
                        SizedBox(width: 8),
                        Text('Eliminar', style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),
                ],
                onSelected: (value) {
                  switch (value) {
                    case 'edit':
                      _showEditStopDialog(stop, ref.read(stopProvider).stops, route);
                      break;
                    case 'delete':
                      _confirmDeleteStop(stop);
                      break;
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleReorder(int oldIndex, int newIndex, List<StopModel> stops) async {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    if (oldIndex == newIndex) return;

    // Crear lista reordenada
    final updatedStops = List<StopModel>.from(stops);
    final movedStop = updatedStops.removeAt(oldIndex);
    updatedStops.insert(newIndex, movedStop);

    // Mostrar loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => const Center(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Reordenando paradas...'),
              ],
            ),
          ),
        ),
      ),
    );

    bool success = false;

    try {
     bool phase1Success = true;

      for (int i = 0; i < updatedStops.length; i++) {
        final stop = updatedStops[i];
        final tempOrder = 9000 + i;

        final tempRequest = StopUpdateRequest(
          name: stop.name,
          order: tempOrder,
        );

        final result = await ref
            .read(stopProvider.notifier)
            .updateStop(stop.id, tempRequest);

        if (!result) {
          phase1Success = false;
          break;
        }
      }

      if (!phase1Success) {
        throw Exception('Error en Fase 1: asignación de órdenes temporales');
      }
      await Future.delayed(const Duration(milliseconds: 300));
      bool phase2Success = true;

      for (int i = 0; i < updatedStops.length; i++) {
        final stop = updatedStops[i];
        final finalOrder = i + 1;

        final finalRequest = StopUpdateRequest(
          name: stop.name,
          order: finalOrder,
        );
        final result = await ref
            .read(stopProvider.notifier)
            .updateStop(stop.id, finalRequest);

        if (!result) {
          phase2Success = false;
          break;
        }
      }

      if (!phase2Success) {
        throw Exception('Error en Fase 2: asignación de órdenes finales');
      }

      success = true;

    } catch (e) {
      debugPrint(' Error durante reordenamiento: $e');
      success = false;
    }

    if (!mounted) return;
    Navigator.pop(context);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Paradas reordenadas exitosamente'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
      await Future.delayed(const Duration(milliseconds: 500));
      ref.read(stopProvider.notifier).fetchStopsByRoute(widget.routeId);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Error al reordenar paradas. Intenta nuevamente.'),
          backgroundColor: Colors.red,
          action: SnackBarAction(
            label: 'Reintentar',
            textColor: Colors.white,
            onPressed: () => _handleReorder(oldIndex, newIndex, stops),
          ),
          duration: const Duration(seconds: 4),
        ),
      );

      ref.read(stopProvider.notifier).fetchStopsByRoute(widget.routeId);
    }
  }

  void _showStopDetails(StopModel stop, dynamic route) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(24),
          child: ListView(
            controller: scrollController,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      stop.name,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(ctx),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              _buildDetailItem(
                icon: Icons.numbers,
                label: 'Posición',
                value: 'Parada #${stop.order}',
              ),
              const SizedBox(height: 16),

              _buildDetailItem(
                icon: Icons.route,
                label: 'Ruta',
                value: '${route.origin} → ${route.destination}',
              ),
              const SizedBox(height: 16),

              _buildDetailItem(
                icon: Icons.location_on,
                label: 'Coordenadas',
                value: 'Lat: ${stop.lat.toStringAsFixed(6)}, Lng: ${stop.lng.toStringAsFixed(6)}',
              ),
              const SizedBox(height: 16),

              const Divider(),
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pop(ctx);
                        _showEditStopDialog(stop, ref.read(stopProvider).stops, route);
                      },
                      icon: const Icon(Icons.edit),
                      label: const Text('Editar'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(ctx);
                        _confirmDeleteStop(stop);
                      },
                      icon: const Icon(Icons.delete),
                      label: const Text('Eliminar'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.blue),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ⭐ VALIDAR que el nombre NO sea igual a origen o destino
  void _showCreateStopDialog(BuildContext context, List<StopModel> existingStops, dynamic route) {
    final nameController = TextEditingController();
    final orderController = TextEditingController(
      text: (existingStops.length + 1).toString(),
    );
    final latController = TextEditingController();
    final lngController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text('Nueva Parada Intermedia'),
        content: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Info
                Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blue.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.blue.shade700, size: 20),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Parada entre ${route.origin} y ${route.destination}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue.shade900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre de la parada',
                    prefixIcon: Icon(Icons.location_city),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese un nombre';
                    }

                    final trimmed = value.trim().toLowerCase();

                    // ⭐ Validar que NO sea el origen
                    if (trimmed == route.origin.toLowerCase()) {
                      return 'No puede ser el origen (${route.origin}).\nEl origen no es una parada.';
                    }

                    // ⭐ Validar que NO sea el destino
                    if (trimmed == route.destination.toLowerCase()) {
                      return 'No puede ser el destino (${route.destination}).\nEl destino no es una parada.';
                    }

                    // Validar duplicados
                    final duplicate = existingStops.any(
                          (stop) => stop.name.toLowerCase() == trimmed,
                    );
                    if (duplicate) {
                      return 'Ya existe una parada con este nombre';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: orderController,
                  decoration: const InputDecoration(
                    labelText: 'Orden',
                    prefixIcon: Icon(Icons.numbers),
                    border: OutlineInputBorder(),
                    helperText: 'Posición en el recorrido',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese el orden';
                    }
                    final order = int.tryParse(value);
                    if (order == null || order < 1) {
                      return 'Orden inválido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: latController,
                  decoration: const InputDecoration(
                    labelText: 'Latitud',
                    prefixIcon: Icon(Icons.my_location),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                    signed: true,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese la latitud';
                    }
                    final lat = double.tryParse(value);
                    if (lat == null || lat < -90 || lat > 90) {
                      return 'Latitud inválida (-90 a 90)';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: lngController,
                  decoration: const InputDecoration(
                    labelText: 'Longitud',
                    prefixIcon: Icon(Icons.place),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                    signed: true,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese la longitud';
                    }
                    final lng = double.tryParse(value);
                    if (lng == null || lng < -180 || lng > 180) {
                      return 'Longitud inválida (-180 a 180)';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),

                const Text(
                  'Tip: Usa Google Maps para obtener las coordenadas',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (!formKey.currentState!.validate()) return;

              Navigator.pop(ctx);

              final request = StopCreateRequest(
                name: nameController.text.trim(),
                order: int.parse(orderController.text.trim()),
                lat: double.parse(latController.text.trim()),
                lng: double.parse(lngController.text.trim()),
                routeId: widget.routeId,
              );

              final success = await ref
                  .read(stopProvider.notifier)
                  .createStop(request);

              if (success && mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Parada creada exitosamente'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
            child: const Text('Crear'),
          ),
        ],
      ),
    );
  }

  void _showEditStopDialog(StopModel stop, List<StopModel> existingStops, dynamic route) {
    final nameController = TextEditingController(text: stop.name);
    final orderController = TextEditingController(text: stop.order.toString());
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text('Editar Parada'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre de la parada',
                  prefixIcon: Icon(Icons.location_city),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese un nombre';
                  }

                  final trimmed = value.trim().toLowerCase();

                  // ⭐ Validar que NO sea el origen
                  if (trimmed == route.origin.toLowerCase()) {
                    return 'No puede ser el origen';
                  }

                  // ⭐ Validar que NO sea el destino
                  if (trimmed == route.destination.toLowerCase()) {
                    return 'No puede ser el destino';
                  }

                  // Validar duplicados (excepto el actual)
                  final duplicate = existingStops.any(
                        (s) => s.id != stop.id &&
                        s.name.toLowerCase() == trimmed,
                  );
                  if (duplicate) {
                    return 'Ya existe otra parada con este nombre';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: orderController,
                decoration: const InputDecoration(
                  labelText: 'Orden',
                  prefixIcon: Icon(Icons.numbers),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese el orden';
                  }
                  final order = int.tryParse(value);
                  if (order == null || order < 1) {
                    return 'Orden inválido';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (!formKey.currentState!.validate()) return;

              Navigator.pop(ctx);

              final request = StopUpdateRequest(
                name: nameController.text.trim(),
                order: int.parse(orderController.text.trim()),
              );

              final success = await ref
                  .read(stopProvider.notifier)
                  .updateStop(stop.id, request);

              if (success && mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Parada actualizada exitosamente'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
            child: const Text('Actualizar'),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmDeleteStop(StopModel stop) async {
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
            Expanded(child: Text('Confirmar eliminación')),
          ],
        ),
        content: Text('¿Eliminar la parada "${stop.name}"?'),
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
      await ref.read(stopProvider.notifier).deleteStop(stop.id);
      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Parada eliminada exitosamente'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }
}