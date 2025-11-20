import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/enums/user_role.dart';
import '../../../../core/constants/enums/trip_status.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../data/models/assignment_model/assignment_model.dart';
import '../../../providers/assignment_provider.dart';
import '../../../providers/trips_provider.dart';
import '../../../providers/user_provider.dart';
import '../../../widgets/common/custom_button.dart';

class AssignmentFormScreen extends ConsumerStatefulWidget {
  final bool isEdit;
  const AssignmentFormScreen({Key? key, this.isEdit = false}) : super(key: key);

  @override
  ConsumerState<AssignmentFormScreen> createState() =>
      _AssignmentFormScreenState();
}

class _AssignmentFormScreenState extends ConsumerState<AssignmentFormScreen> {
  final _formKey = GlobalKey<FormState>();

  int? _selectedTripId;
  int? _selectedDriverId;
  int? _currentUserId;
  UserRole? _currentUserRole;
  bool _isLoading = false;
  DateTime? _selectedDate;
  bool _checklistOk = false;

  bool get isEditing =>
      widget.isEdit || ref.read(assignmentProvider).selectedAssignment != null;


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
      _loadExistingAssignment();
    });
  }

  Future<void> _loadData() async {
    final userNotifier = ref.read(userProvider.notifier);
    final tripNotifier = ref.read(tripSearchProvider.notifier);

    await userNotifier.fetchCurrentUser();
    final currentUser = ref.read(userProvider).currentUser;
    _currentUserId = currentUser?.id;
    _currentUserRole = currentUser?.role;

    await tripNotifier.getTodayTrips();
    await userNotifier.fetchActiveUsersByRole(UserRole.DRIVER);

    if (mounted) setState(() {});
  }

  void _loadExistingAssignment() {
    final assignment = ref.read(assignmentProvider).selectedAssignment;
    if (assignment != null) {
      _selectedTripId = assignment.tripId;
      _selectedDriverId = assignment.driverId;
      _selectedDate = DateTime.parse(assignment.tripDate);
      _checklistOk = assignment.checklistOk;
      setState(() {});
    }
  }

  bool get canEditChecklist =>
      isEditing || (_currentUserRole == UserRole.ADMIN || _currentUserRole == UserRole.DISPATCHER);

  @override
  Widget build(BuildContext context) {
    final tripState = ref.watch(tripSearchProvider);
    final userState = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar Asignación' : 'Nueva Asignación'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildSectionTitle('Seleccionar Viaje'),
            const SizedBox(height: 16),
            _buildDateSelector(),
            const SizedBox(height: 16),
            _buildTripSelector(tripState),
            const SizedBox(height: 24),
            _buildSectionTitle('Seleccionar Conductor'),
            const SizedBox(height: 16),
            _buildDriverSelector(userState),
            if (canEditChecklist) ...[
              const SizedBox(height: 24),
              if (canEditChecklist)
                SwitchListTile(
                  title: const Text('Checklist OK'),
                  value: _checklistOk,
                  onChanged: (val) => setState(() => _checklistOk = val),
                ),
            ],
            if (_selectedTripId != null && _selectedDriverId != null) ...[
              const SizedBox(height: 24),
              _buildSummaryCard(tripState, userState),
            ],
            const SizedBox(height: 32),
            CustomButton(
              text: isEditing ? 'Actualizar Asignación' : 'Crear Asignación',
              isLoading: _isLoading,
              onPressed: _submitForm,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) => Text(
    title,
    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  );

  Widget _buildDateSelector() {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.calendar_today),
        title: const Text('Fecha de viajes'),
        subtitle: Text(
          _selectedDate != null
              ? DateFormatter.formatDate(_selectedDate!)
              : 'Hoy',
        ),
        trailing: const Icon(Icons.arrow_drop_down),
        onTap: _selectDate,
      ),
    );
  }

  Widget _buildTripSelector(TripSearchState state) {
    if (state.isLoading) return const Center(child: CircularProgressIndicator());

    final availableTrips =
    state.trips.where((t) => t.status == TripStatus.SCHEDULED).toList();

    if (availableTrips.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Center(child: Text('No hay viajes disponibles para asignar')),
        ),
      );
    }

    return Column(
      children: availableTrips.map((trip) {
        final isSelected = _selectedTripId == trip.id;
        return Card(
          color: isSelected ? Colors.blue.withOpacity(0.1) : null,
          child: RadioListTile<int>(
            value: trip.id,
            groupValue: _selectedTripId,
            onChanged: (v) => setState(() => _selectedTripId = v),
            title: Text(
              '${trip.route?.code ?? 'N/A'} - ${trip.route?.name ?? 'Ruta sin nombre'}',
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Bus: ${trip.bus?.plate ?? 'N/A'}'),
                Text('Salida: ${DateFormatter.formatTime(trip.departureAt)}'),
              ],
            ),
            secondary: CircleAvatar(
              backgroundColor: isSelected ? Colors.blue : Colors.grey[300],
              child: const Icon(Icons.directions_bus, color: Colors.white),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDriverSelector(UserState state) {
    if (state.isLoading) return const Center(child: CircularProgressIndicator());

    final drivers = state.users.where((u) => u.role == UserRole.DRIVER).toList();
    if (drivers.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Center(child: Text('No hay conductores disponibles')),
        ),
      );
    }

    return Column(
      children: drivers.map((driver) {
        final isSelected = _selectedDriverId == driver.id;
        return Card(
          color: isSelected ? Colors.green.withOpacity(0.1) : null,
          child: RadioListTile<int>(
            value: driver.id,
            groupValue: _selectedDriverId,
            onChanged: (v) => setState(() => _selectedDriverId = v),
            title: Text(driver.username),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(driver.email),
                Text(driver.phone),
              ],
            ),
            secondary: CircleAvatar(
              backgroundColor: isSelected ? Colors.green : Colors.grey[300],
              child: Text(
                driver.username[0].toUpperCase(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSummaryCard(TripSearchState tripsState, UserState userState) {
    final trip = tripsState.trips.firstWhere((t) => t.id == _selectedTripId);
    final driver = userState.users.firstWhere((u) => u.id == _selectedDriverId);

    return Card(
      color: Colors.blue.withOpacity(0.05),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Resumen de Asignación',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            _buildSummaryRow(
              icon: Icons.directions_bus,
              label: 'Ruta:',
              value: '${trip.route?.code ?? '-'} - ${trip.route?.name ?? '-'}',
            ),
            _buildSummaryRow(
              icon: Icons.calendar_today,
              label: 'Fecha:',
              value: DateFormatter.formatDate(trip.date),
            ),
            _buildSummaryRow(
              icon: Icons.access_time,
              label: 'Hora:',
              value: DateFormatter.formatTime(trip.departureAt),
            ),
            _buildSummaryRow(
              icon: Icons.garage,
              label: 'Bus:',
              value: trip.bus?.plate ?? 'N/A',
            ),
            const Divider(),
            _buildSummaryRow(
              icon: Icons.person,
              label: 'Conductor:',
              value: driver.username,
            ),
            _buildSummaryRow(
              icon: Icons.phone,
              label: 'Teléfono:',
              value: driver.phone,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Text('$label ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );

    if (picked != null && mounted) {
      setState(() {
        _selectedDate = picked;
        _selectedTripId = null;
      });

      final dateStr = picked.toIso8601String().split('T')[0];
      await ref.read(tripSearchProvider.notifier).searchTrips(date: dateStr);
    }
  }

  Future<void> _submitForm() async {
    if (_selectedTripId == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Selecciona un viaje')));
      return;
    }
    if (_selectedDriverId == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Selecciona un conductor')));
      return;
    }
    if (_currentUserId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se pudo obtener el usuario actual')));
      return;
    }

    setState(() => _isLoading = true);
    final assignmentNotifier = ref.read(assignmentProvider.notifier);
    bool success;

    if (isEditing) {
      final assignmentId = ref.read(assignmentProvider).selectedAssignment!.id;
      success = await assignmentNotifier.updateAssignment(
        assignmentId,
        AssignmentUpdateRequest(
          checklistOk: _checklistOk,
        ),
      );
    } else {
      final request = AssignmentCreateRequest(
        tripId: _selectedTripId!,
        driverId: _selectedDriverId!,
        dispatcherId: _currentUserId!,
        checklistOk: _checklistOk,
      );
      success = await assignmentNotifier.createAssignment(request);
    }

    setState(() => _isLoading = false);

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(isEditing
              ? 'Asignación actualizada exitosamente'
              : 'Asignación creada exitosamente')));
      Navigator.pop(context);
    } else {
      final errorMessage =
          ref.read(assignmentProvider).error ?? 'Error al guardar asignación';
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));
    }
  }
}
