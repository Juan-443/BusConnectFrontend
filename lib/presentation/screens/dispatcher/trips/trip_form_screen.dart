import 'package:bus_connect/presentation/providers/trips_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/models/trip_model/trip_model.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../widgets/common/custom_button.dart';
import '../../../providers/route_provider.dart';
import '../../../providers/bus_provider.dart';

class TripFormScreen extends ConsumerStatefulWidget {
  final bool isEdit;

  const TripFormScreen({Key? key, this.isEdit = false}) : super(key: key);

  @override
  ConsumerState<TripFormScreen> createState() => _TripFormScreenState();
}

class _TripFormScreenState extends ConsumerState<TripFormScreen> {
  final _formKey = GlobalKey<FormState>();

  DateTime? _selectedDate;
  TimeOfDay? _departureTime;
  TimeOfDay? _arrivalTime;
  int? _selectedRouteId;
  int? _selectedBusId;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
      if (widget.isEdit) {
        _loadTripData();
      }
    });
  }

  Future<void> _loadData() async {
    // Llamamos a los providers de Riverpod
    await Future.wait([
      ref.read(routeProvider.notifier).fetchAllRoutes(),
      ref.read(busProvider.notifier).fetchAvailableBuses(),
    ]);
  }

  void _loadTripData() {
    final trip = ref.read(tripSearchProvider).selectedTrip;
    if (trip != null) {
      _selectedDate = trip.date;
      _departureTime = TimeOfDay(
        hour: trip.departureAt.hour,
        minute: trip.departureAt.minute,
      );

      if (trip.arrivalEta != null) {
        _arrivalTime = TimeOfDay(
          hour: trip.arrivalEta!.hour,
          minute: trip.arrivalEta!.minute,
        );
      }
      _selectedRouteId = trip.routeId;
      _selectedBusId = trip.busId;
    }
  }


  @override
  Widget build(BuildContext context) {
    final routeState = ref.watch(routeProvider);
    final busState = ref.watch(busProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEdit ? 'Editar Viaje' : 'Crear Viaje'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildSectionTitle('Información del Viaje'),
            const SizedBox(height: 16),
            _buildDateField(),
            const SizedBox(height: 16),
            _buildTimeField(
              label: 'Hora de salida',
              value: _departureTime,
              onTap: () => _selectTime(isDeparture: true),
            ),
            const SizedBox(height: 16),
            _buildTimeField(
              label: 'Hora de llegada (opcional)',
              value: _arrivalTime,
              onTap: () => _selectTime(isDeparture: false),
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('Ruta y Bus'),
            const SizedBox(height: 16),
            _buildRouteDropdown(routeState),
            const SizedBox(height: 16),
            _buildBusDropdown(busState),
            const SizedBox(height: 32),
            CustomButton(
              text: widget.isEdit ? 'Actualizar Viaje' : 'Crear Viaje',
              isLoading: _isLoading,
              onPressed: _submitForm,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildDateField() {
    return InkWell(
      onTap: _selectDate,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Fecha del viaje',
          prefixIcon: const Icon(Icons.calendar_today),
          border: const OutlineInputBorder(),
          errorText: _selectedDate == null ? 'Selecciona una fecha' : null,
        ),
        child: Text(
          _selectedDate != null
              ? DateFormatter.formatDate(_selectedDate!)
              : 'Seleccionar fecha',
        ),
      ),
    );
  }

  Widget _buildTimeField({
    required String label,
    required TimeOfDay? value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: const Icon(Icons.access_time),
          border: const OutlineInputBorder(),
        ),
        child: Text(value != null ? value.format(context) : 'Seleccionar hora'),
      ),
    );
  }

  Widget _buildRouteDropdown(RouteState routeState) {
    if (routeState.isLoading) return const Center(child: CircularProgressIndicator());

    return DropdownButtonFormField<int>(
      initialValue: _selectedRouteId,
      decoration: const InputDecoration(
        labelText: 'Ruta',
        prefixIcon: Icon(Icons.route),
        border: OutlineInputBorder(),
      ),
      items: routeState.routes
          .map((route) => DropdownMenuItem(
        value: route.id,
        child: Text('${route.code} - ${route.name}'),
      ))
          .toList(),
      onChanged: widget.isEdit ? null : (value) => setState(() => _selectedRouteId = value),
      validator: (value) => value == null ? 'Selecciona una ruta' : null,
    );
  }

  Widget _buildBusDropdown(BusState busState) {
    if (busState.isLoading) return const Center(child: CircularProgressIndicator());

    return DropdownButtonFormField<int>(
      initialValue: _selectedBusId,
      decoration: const InputDecoration(
        labelText: 'Bus',
        prefixIcon: Icon(Icons.directions_bus),
        border: OutlineInputBorder(),
      ),
      items: busState.availableBuses
          .map((bus) => DropdownMenuItem(
        value: bus.id,
        child: Text('${bus.plate} (${bus.capacity} asientos)'),
      ))
          .toList(),
      onChanged: widget.isEdit ? null : (value) => setState(() => _selectedBusId = value),
      validator: (value) => value == null ? 'Selecciona un bus' : null,
    );
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (picked != null) setState(() => _selectedDate = picked);
  }

  Future<void> _selectTime({required bool isDeparture}) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: isDeparture ? (_departureTime ?? TimeOfDay.now()) : (_arrivalTime ?? TimeOfDay.now()),
    );

    if (picked != null) {
      setState(() {
        if (isDeparture) _departureTime = picked;
        else _arrivalTime = picked;
      });
    }
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedDate == null) return _showSnack('Selecciona una fecha');
    if (_departureTime == null) return _showSnack('Selecciona una hora de salida');

    setState(() => _isLoading = true);

    final tripNotifier = ref.read(tripSearchProvider.notifier);

    // Combinar fecha y hora de salida
    final departureDateTime = DateTime(
      _selectedDate!.year,
      _selectedDate!.month,
      _selectedDate!.day,
      _departureTime!.hour,
      _departureTime!.minute,
    );

    // Combinar fecha y hora de llegada (opcional)
    DateTime? arrivalDateTime;
    if (_arrivalTime != null) {
      arrivalDateTime = DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        _arrivalTime!.hour,
        _arrivalTime!.minute,
      );
    }

    bool success;

    if (widget.isEdit) {
      final trip = ref.read(tripSearchProvider).selectedTrip;
      if (trip == null) return;

      final request = TripUpdateRequest(
        departureAt: departureDateTime,
        arrivalEta: arrivalDateTime,
      );

      success = await tripNotifier.updateTrip(trip.id, request);
    } else {
      final request = TripCreateRequest(
        date: _selectedDate!, // ahora DateTime
        departureAt: departureDateTime,
        arrivalEta: arrivalDateTime,
        routeId: _selectedRouteId!,
        busId: _selectedBusId!,
      );

      success = await tripNotifier.createTrip(request);
    }

    setState(() => _isLoading = false);

    if (!mounted) return;

    if (success) {
      _showSnack(widget.isEdit ? 'Viaje actualizado' : 'Viaje creado');
      Navigator.pop(context);
    } else {
      _showSnack(ref.read(tripSearchProvider).error ?? 'Error al guardar');
    }
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}
