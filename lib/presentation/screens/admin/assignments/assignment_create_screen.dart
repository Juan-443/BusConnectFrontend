import 'package:bus_connect/core/constants/enums/trip_status.dart';
import 'package:bus_connect/core/constants/enums/user_role.dart';
import 'package:bus_connect/core/constants/enums/user_status.dart';
import 'package:bus_connect/data/models/assignment_model/assignment_model.dart';
import 'package:bus_connect/presentation/providers/assignment_provider.dart';
import 'package:bus_connect/presentation/providers/auth_provider.dart';
import 'package:bus_connect/presentation/providers/trips_provider.dart';
import 'package:bus_connect/presentation/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AssignmentCreateScreen extends ConsumerStatefulWidget {
  const AssignmentCreateScreen({super.key});

  @override
  ConsumerState<AssignmentCreateScreen> createState() =>
      _AssignmentCreateScreenState();
}

class _AssignmentCreateScreenState
    extends ConsumerState<AssignmentCreateScreen> {
  final _formKey = GlobalKey<FormState>();

  int? _selectedTripId;
  int? _selectedDriverId;
  bool _checklistOk = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(tripSearchProvider.notifier).getTodayTrips();
      ref.read(userProvider.notifier).fetchUsersByRole(UserRole.DRIVER);
    });
  }

  @override
  Widget build(BuildContext context) {
    final tripsState = ref.watch(tripSearchProvider);
    final usersState = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva Asignación'),
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
              // Selección de viaje
              DropdownButtonFormField<int>(
                initialValue: _selectedTripId,
                decoration: InputDecoration(
                  labelText: 'Viaje *',
                  prefixIcon: const Icon(Icons.route),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: tripsState.trips
                    .where((trip) =>
                trip.status == TripStatus.SCHEDULED ||
                    trip.status == TripStatus.BOARDING)
                    .map((trip) {
                  return DropdownMenuItem(
                    value: trip.id,
                    child: Text(
                      '${trip.route?.name} - ${trip.date}',
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => _selectedTripId = value);
                },
                validator: (value) {
                  if (value == null) {
                    return 'Seleccione un viaje';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Selección de conductor
              DropdownButtonFormField<int>(
                initialValue: _selectedDriverId,
                decoration: InputDecoration(
                  labelText: 'Conductor *',
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: usersState.users
                    .where((user) =>
                user.role == UserRole.DRIVER && user.status == UserStatus.ACTIVE)
                    .map((user) {
                  return DropdownMenuItem(
                    value: user.id,
                    child: Text(user.username),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => _selectedDriverId = value);
                },
                validator: (value) {
                  if (value == null) {
                    return 'Seleccione un conductor';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Checklist
              SwitchListTile(
                title: const Text('Checklist de Vehículo'),
                subtitle: const Text(
                  'Marcar si el vehículo pasó la inspección',
                ),
                value: _checklistOk,
                onChanged: (value) {
                  setState(() => _checklistOk = value);
                },
                secondary: Icon(
                  _checklistOk ? Icons.check_circle : Icons.pending,
                  color: _checklistOk ? Colors.green : Colors.orange,
                ),
              ),
              const SizedBox(height: 32),

              // Botón de guardar
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: _handleSubmit,
                  icon: const Icon(Icons.save),
                  label: const Text(
                    'Crear Asignación',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    // Obtener ID del dispatcher (usuario actual)
    final authUser = ref.read(authProvider).user;
    if (authUser == null) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error: Usuario no autenticado'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Crear el objeto AssignmentCreateRequest
    final assignmentRequest = AssignmentCreateRequest(
      tripId: _selectedTripId!,
      driverId: _selectedDriverId!,
      dispatcherId: authUser.id,
      checklistOk: _checklistOk,
    );

    final success = await ref
        .read(assignmentProvider.notifier)
        .createAssignment(assignmentRequest);

    setState(() => _isLoading = false);

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Asignación creada exitosamente'),
        ),
      );
      context.pop();
    } else if (mounted) {
      final error = ref.read(assignmentProvider).error;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error ?? 'Error al crear asignación'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}