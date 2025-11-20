import 'package:bus_connect/core/constants/app_routes.dart';
import 'package:bus_connect/core/constants/enums/bus_status.dart';
import 'package:bus_connect/core/constants/enums/trip_status.dart';
import 'package:bus_connect/data/models/trip_model/trip_model.dart';
import 'package:bus_connect/presentation/providers/bus_provider.dart';
import 'package:bus_connect/presentation/providers/route_provider.dart';
import 'package:bus_connect/presentation/providers/trips_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TripFormScreen extends ConsumerStatefulWidget {
  final int? tripId;

  const TripFormScreen({super.key, this.tripId});

  @override
  ConsumerState<TripFormScreen> createState() => _TripFormScreenState();
}

class _TripFormScreenState extends ConsumerState<TripFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController();
  final _departureController = TextEditingController();
  final _arrivalController = TextEditingController();

  DateTime? _selectedDate;
  TimeOfDay? _departureTime;
  TimeOfDay? _arrivalTime;
  int? _selectedRouteId;
  int? _selectedBusId;
  TripStatus _selectedStatus = TripStatus.SCHEDULED;
  bool _isLoading = false;

  bool get isEditing => widget.tripId != null;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(routeProvider.notifier).fetchAllRoutes();
      ref.read(busProvider.notifier).fetchAllBuses();
    });

    if (isEditing) {
      _loadTripData();
    }
  }

  Future<void> _loadTripData() async {
    setState(() => _isLoading = true);

    try {
      // Usar el tripDetailProvider que ya existe
      final trip = await ref.read(tripDetailProvider(widget.tripId!).future);

      if (!mounted) return;

      setState(() {
        _selectedRouteId = trip.routeId;
        _selectedBusId = trip.busId;
        _selectedStatus = trip.status;
        _selectedDate = trip.date;

        // Formatear fecha
        _dateController.text =
        '${trip.date.day.toString().padLeft(2, '0')}/${trip.date.month.toString().padLeft(2, '0')}/${trip.date.year}';

        // Extraer hora de salida
        _departureTime = TimeOfDay(
          hour: trip.departureAt.hour,
          minute: trip.departureAt.minute,
        );
        _departureController.text = _departureTime!.format(context);

        // Extraer hora de llegada
        _arrivalTime = TimeOfDay(
          hour: trip.arrivalEta.hour,
          minute: trip.arrivalEta.minute,
        );
        _arrivalController.text = _arrivalTime!.format(context);

        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al cargar viaje: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
        context.pop();
      }
    }
  }

  @override
  void dispose() {
    _dateController.dispose();
    _departureController.dispose();
    _arrivalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final routesState = ref.watch(routeProvider);
    final busesState = ref.watch(busProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar Viaje' : 'Nuevo Viaje'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Selección de Ruta
              DropdownButtonFormField<int>(
                initialValue: _selectedRouteId,
                decoration: InputDecoration(
                  labelText: 'Ruta *',
                  prefixIcon: const Icon(Icons.route),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: routesState.routes.map((route) {
                  return DropdownMenuItem(
                    value: route.id,
                    child: Text('${route.code} - ${route.name}'),
                  );
                }).toList(),
                onChanged: isEditing
                    ? null
                    : (value) {
                  setState(() => _selectedRouteId = value);
                },
                validator: (value) {
                  if (value == null) {
                    return 'Seleccione una ruta';
                  }
                  return null;
                },
              ),

              // Información de la ruta seleccionada
              if (_selectedRouteId != null) ...[
                const SizedBox(height: 12),
                _buildRouteInfo(),
              ],
              const SizedBox(height: 16),

              // Selección de Bus
              DropdownButtonFormField<int?>(
                initialValue: _selectedBusId,
                decoration: InputDecoration(
                  labelText: 'Bus (opcional)',
                  prefixIcon: const Icon(Icons.directions_bus),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  helperText:
                  'Si no se asigna un bus, se puede asignar después',
                ),
                items: [
                  const DropdownMenuItem(
                    value: null,
                    child: Text('Sin asignar'),
                  ),
                  ...busesState.buses
                      .where((bus) => bus.status == BusStatus.ACTIVE)
                      .map((bus) {
                    return DropdownMenuItem(
                      value: bus.id,
                      child: Text(
                          '${bus.plate} (${bus.capacity} asientos)'),
                    );
                  }),
                ],
                onChanged: (value) {
                  setState(() => _selectedBusId = value);
                },
              ),
              const SizedBox(height: 16),

              // Fecha
              _buildDateField(),
              const SizedBox(height: 16),

              // Horarios
              Row(
                children: [
                  Expanded(
                    child: _buildTimeField(
                      controller: _departureController,
                      label: 'Hora de salida *',
                      icon: Icons.departure_board,
                      onTap: () => _selectTime(context, true),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _arrivalController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Hora de llegada (calculada)',
                        prefixIcon: const Icon(Icons.flight_land),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        helperText: 'Calculada automáticamente',
                        helperStyle: const TextStyle(fontSize: 10),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Requerido';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),

              // Duración estimada
              if (_departureTime != null &&
                  _arrivalTime != null &&
                  _selectedDate != null) ...[
                const SizedBox(height: 12),
                _buildDurationInfo(),
              ],
              const SizedBox(height: 16),


              if (isEditing) ...[
                DropdownButtonFormField<TripStatus>(
                  initialValue: _selectedStatus,
                  decoration: InputDecoration(
                    labelText: 'Estado',
                    prefixIcon: const Icon(Icons.info),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  items: TripStatus.values.map((status) {
                    return DropdownMenuItem(
                      value: status,
                      child: Row(
                        children: [
                          Icon(
                            _getStatusIcon(status),
                            size: 16,
                            color: _getStatusColor(status),
                          ),
                          const SizedBox(width: 8),
                          Text(status.name),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _selectedStatus = value);
                    }
                  },
                ),
                const SizedBox(height: 16),
              ],

              const SizedBox(height: 32),

              // Botón de guardar
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: _handleSubmit,
                  icon: Icon(isEditing ? Icons.save : Icons.add),
                  label: Text(
                    isEditing ? 'Actualizar Viaje' : 'Crear Viaje',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateField() {
    return TextFormField(
      controller: _dateController,
      readOnly: true,
      decoration: InputDecoration(
        labelText: 'Fecha *',
        prefixIcon: const Icon(Icons.calendar_today),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        helperText: 'Seleccione la fecha del viaje',
      ),
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: _selectedDate ?? DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365)),
          helpText: 'Seleccionar fecha del viaje',
          cancelText: 'Cancelar',
          confirmText: 'Aceptar',
        );
        if (date != null) {
          setState(() {
            _selectedDate = date;
            _dateController.text =
            '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
          });
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Seleccione una fecha';
        }
        return null;
      },
    );
  }

  Widget _buildTimeField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onTap: onTap,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Requerido';
        }
        return null;
      },
    );
  }

  Widget _buildRouteInfo() {
    final route = ref.read(routeProvider).routes.firstWhere(
          (r) => r.id == _selectedRouteId,
    );

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.trip_origin, size: 16, color: Colors.green),
              const SizedBox(width: 4),
              Text(
                route.origin,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Icon(Icons.arrow_forward, size: 12),
              ),
              const Icon(Icons.location_on, size: 16, color: Colors.red),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  route.destination,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.straighten, size: 14, color: Colors.grey),
              const SizedBox(width: 4),
              Text(
                '${route.distanceKm} km',
                style: const TextStyle(fontSize: 11, color: Colors.grey),
              ),
              const SizedBox(width: 16),
              const Icon(Icons.schedule, size: 14, color: Colors.grey),
              const SizedBox(width: 4),
              Text(
                '~${route.durationMin} min',
                style: const TextStyle(fontSize: 11, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDurationInfo() {
    final departure = DateTime(
      _selectedDate!.year,
      _selectedDate!.month,
      _selectedDate!.day,
      _departureTime!.hour,
      _departureTime!.minute,
    );

    final arrival = DateTime(
      _selectedDate!.year,
      _selectedDate!.month,
      _selectedDate!.day,
      _arrivalTime!.hour,
      _arrivalTime!.minute,
    );

    final duration = arrival.difference(departure);
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;

    final isValid = duration.isNegative == false && duration.inMinutes > 0;
    final color = isValid ? Colors.blue : Colors.red;
    final icon = isValid ? Icons.check_circle : Icons.error;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              isValid
                  ? 'Duración del viaje: ${hours}h ${minutes}min'
                  : 'Error: La hora de llegada debe ser después de la salida',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: color,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectTime(BuildContext context, bool isDeparture) async {
    final time = await showTimePicker(
      context: context,
      initialTime: isDeparture
          ? (_departureTime ?? TimeOfDay.now())
          : (_arrivalTime ?? TimeOfDay.now()),
      helpText: isDeparture ? 'Hora de salida' : 'Hora de llegada',
      cancelText: 'Cancelar',
      confirmText: 'Aceptar',
    );

    if (time != null) {
      setState(() {
        if (isDeparture) {
          _departureTime = time;
          _departureController.text = time.format(context);
          if (_selectedRouteId != null) {
            final route = ref.read(routeProvider).routes.firstWhere(
                  (r) => r.id == _selectedRouteId,
            );

            final departureDateTime = DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
              time.hour,
              time.minute,
            );

            final arrivalDateTime = departureDateTime.add(
              Duration(minutes: route.durationMin),
            );

            _arrivalTime = TimeOfDay.fromDateTime(arrivalDateTime);
            _arrivalController.text = _arrivalTime!.format(context);

            // Mostrar mensaje informativo
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Hora de llegada calculada: ${_arrivalTime!.format(context)} '
                      '(+${route.durationMin} min)',
                ),
                backgroundColor: Colors.blue,
                duration: const Duration(seconds: 2),
              ),
            );
          }
        } else {
          _arrivalTime = time;
          _arrivalController.text = time.format(context);
        }
      });
    }
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    if (_departureTime == null ||
        _arrivalTime == null ||
        _selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Complete todos los campos requeridos'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    final departureDateTime = DateTime(
      _selectedDate!.year,
      _selectedDate!.month,
      _selectedDate!.day,
      _departureTime!.hour,
      _departureTime!.minute,
    );

    final arrivalDateTime = DateTime(
      _selectedDate!.year,
      _selectedDate!.month,
      _selectedDate!.day,
      _arrivalTime!.hour,
      _arrivalTime!.minute,
    );

    if (arrivalDateTime.isBefore(departureDateTime) ||
        arrivalDateTime.isAtSameMomentAs(departureDateTime)) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('La hora de llegada debe ser después de la salida'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    bool success;

    try {
      if (isEditing) {
        final request = TripUpdateRequest(
          date: _selectedDate,
          departureAt: departureDateTime,
          arrivalEta: arrivalDateTime,
          busId: _selectedBusId,
          status: _selectedStatus,
        );

        success = await ref
            .read(tripSearchProvider.notifier)
            .updateTrip(widget.tripId!, request);
      } else {
        final request = TripCreateRequest(
          routeId: _selectedRouteId!,
          date: _selectedDate!,
          departureAt: departureDateTime,
          arrivalEta: arrivalDateTime,
          busId: _selectedBusId,
        );

        success = await ref
            .read(tripSearchProvider.notifier)
            .createTrip(request);
      }

      setState(() => _isLoading = false);

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isEditing
                  ? 'Viaje actualizado exitosamente'
                  : 'Viaje creado exitosamente',
            ),
            backgroundColor: Colors.green,
              duration: const Duration(seconds: 2),
          ),
        );
        await ref.read(tripSearchProvider.notifier).loadAllTrips();

        if (mounted) {
          if(isEditing){
            Navigator.pop(context, true);
          }else {
            context.go(AppRoutes.adminTrips);
          }
        }
      } else if (mounted) {
        final error = ref.read(tripSearchProvider).error;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error ?? 'Error al guardar viaje'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error inesperado: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Color _getStatusColor(TripStatus status) {
    switch (status) {
      case TripStatus.SCHEDULED:
        return Colors.blue;
      case TripStatus.BOARDING:
        return Colors.orange;
      case TripStatus.DEPARTED:
        return Colors.green;
      case TripStatus.ARRIVED:
        return Colors.grey;
      case TripStatus.CANCELLED:
        return Colors.red;
    }
  }

  IconData _getStatusIcon(TripStatus status) {
    switch (status) {
      case TripStatus.SCHEDULED:
        return Icons.schedule;
      case TripStatus.BOARDING:
        return Icons.login;
      case TripStatus.DEPARTED:
        return Icons.flight_takeoff;
      case TripStatus.ARRIVED:
        return Icons.check_circle;
      case TripStatus.CANCELLED:
        return Icons.cancel;
    }
  }
}