import 'package:bus_connect/core/constants/enums/entity_type.dart';
import 'package:bus_connect/core/constants/enums/incident_type.dart';
import 'package:bus_connect/data/models/incident_model/incident_model.dart';
import 'package:bus_connect/presentation/providers/incident_provider.dart';
import 'package:bus_connect/presentation/providers/trips_provider.dart';
import 'package:bus_connect/presentation/providers/tickets_provider.dart';
import 'package:bus_connect/presentation/providers/parcel_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IncidentFormScreen extends ConsumerStatefulWidget {
  final EntityType entityType;
  final int reportedBy;

  const IncidentFormScreen({
    super.key,
    required this.entityType,
    required this.reportedBy,
  });

  @override
  ConsumerState<IncidentFormScreen> createState() => _IncidentFormScreenState();
}

class _IncidentFormScreenState extends ConsumerState<IncidentFormScreen> {
  final _formKey = GlobalKey<FormState>();
  IncidentType? _selectedType;
  int? _selectedEntityId;
  late TextEditingController _noteController;

  @override
  void initState() {
    super.initState();
    _noteController = TextEditingController();
    _loadEntities();
  }

  void _loadEntities() {
    // Cargar las entidades según el tipo
    Future.microtask(() {
      switch (widget.entityType) {
        case EntityType.TRIP:
          ref.read(tripSearchProvider.notifier).loadAllTrips();
          break;
        case EntityType.TICKET:
          ref.read(ticketProvider.notifier).loadAllTickets();
          break;
        case EntityType.PARCEL:
          ref.read(parcelProvider.notifier).loadAllParcels();
          break;
      }
    });
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedEntityId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Selecciona un ${_getEntityLabel().toLowerCase()}'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final request = IncidentCreateRequest(
      entityType: widget.entityType,
      entityId: _selectedEntityId!,
      type: _selectedType!,
      note: _noteController.text.trim().isEmpty ? null : _noteController.text.trim(),
      reportedBy: widget.reportedBy,
    );

    final success = await ref.read(incidentProvider.notifier).createIncident(request);

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Incidente creado con éxito"),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context, true);
    } else {
      final error = ref.read(incidentProvider).error ?? "Error desconocido";
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  String _getEntityLabel() {
    switch (widget.entityType) {
      case EntityType.TRIP:
        return 'Viaje';
      case EntityType.TICKET:
        return 'Ticket';
      case EntityType.PARCEL:
        return 'Encomienda';
    }
  }

  Widget _buildEntitySelector() {
    switch (widget.entityType) {
      case EntityType.TRIP:
        return _buildTripSelector();
      case EntityType.TICKET:
        return _buildTicketSelector();
      case EntityType.PARCEL:
        return _buildParcelSelector();
    }
  }

  Widget _buildTripSelector() {
    final tripsState = ref.watch(tripSearchProvider);

    if (tripsState.isLoading) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    if (tripsState.error != null) {
      return Card(
        color: Colors.red.shade50,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(Icons.error_outline, color: Colors.red.shade700, size: 32),
              const SizedBox(height: 8),
              Text(
                'Error al cargar viajes',
                style: TextStyle(color: Colors.red.shade700),
              ),
              TextButton.icon(
                onPressed: () => ref.read(tripSearchProvider.notifier).loadAllTrips(),
                icon: const Icon(Icons.refresh),
                label: const Text('Reintentar'),
              ),
            ],
          ),
        ),
      );
    }

    if (tripsState.trips.isEmpty) {
      return Card(
        color: Colors.orange.shade50,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(Icons.info_outline, color: Colors.orange.shade700, size: 32),
              const SizedBox(height: 8),
              Text(
                'No hay viajes disponibles',
                style: TextStyle(color: Colors.orange.shade700),
              ),
            ],
          ),
        ),
      );
    }

    return DropdownButtonFormField<int>(
      decoration: const InputDecoration(
        labelText: 'Seleccionar Viaje',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.directions_bus),
        helperText: 'Selecciona el viaje para reportar el incidente',
      ),
      value: _selectedEntityId,
      isExpanded: true,
      items: tripsState.trips.map((trip) {
        // Construir descripción del viaje
        final origin = trip.route?.origin ?? 'N/A';
        final destination = trip.route?.destination ?? 'N/A';
        final departureTime = trip.departureAt ?? 'Sin horario';

        return DropdownMenuItem(
          value: trip.id,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Viaje #${trip.id}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                '$origin → $destination',
                style: const TextStyle(fontSize: 12),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      }).toList(),
      onChanged: (value) => setState(() => _selectedEntityId = value),
      validator: (value) => value == null ? 'Selecciona un viaje' : null,
    );
  }

  Widget _buildTicketSelector() {
    final ticketsState = ref.watch(ticketProvider);

    if (ticketsState.isLoading) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    if (ticketsState.error != null) {
      return Card(
        color: Colors.red.shade50,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(Icons.error_outline, color: Colors.red.shade700, size: 32),
              const SizedBox(height: 8),
              Text(
                'Error al cargar tickets',
                style: TextStyle(color: Colors.red.shade700),
              ),
              TextButton.icon(
                onPressed: () => ref.read(ticketProvider.notifier).loadAllTickets(),
                icon: const Icon(Icons.refresh),
                label: const Text('Reintentar'),
              ),
            ],
          ),
        ),
      );
    }

    if (ticketsState.tickets.isEmpty) {
      return Card(
        color: Colors.orange.shade50,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(Icons.info_outline, color: Colors.orange.shade700, size: 32),
              const SizedBox(height: 8),
              Text(
                'No hay tickets disponibles',
                style: TextStyle(color: Colors.orange.shade700),
              ),
            ],
          ),
        ),
      );
    }

    return DropdownButtonFormField<int>(
      decoration: const InputDecoration(
        labelText: 'Seleccionar Ticket',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.confirmation_number),
        helperText: 'Selecciona el ticket para reportar el incidente',
      ),
      value: _selectedEntityId,
      isExpanded: true,
      items: ticketsState.tickets.map((ticket) {
        return DropdownMenuItem(
          value: ticket.id,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Ticket #${ticket.id}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Pasajero: ${ticket.passengerId}',
                style: const TextStyle(fontSize: 12),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      }).toList(),
      onChanged: (value) => setState(() => _selectedEntityId = value),
      validator: (value) => value == null ? 'Selecciona un ticket' : null,
    );
  }

  Widget _buildParcelSelector() {
    final parcelsState = ref.watch(parcelProvider);

    if (parcelsState.isLoading) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    if (parcelsState.error != null) {
      return Card(
        color: Colors.red.shade50,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(Icons.error_outline, color: Colors.red.shade700, size: 32),
              const SizedBox(height: 8),
              Text(
                'Error al cargar encomiendas',
                style: TextStyle(color: Colors.red.shade700),
              ),
              TextButton.icon(
                onPressed: () => ref.read(parcelProvider.notifier).loadAllParcels(),
                icon: const Icon(Icons.refresh),
                label: const Text('Reintentar'),
              ),
            ],
          ),
        ),
      );
    }

    if (parcelsState.parcels.isEmpty) {
      return Card(
        color: Colors.orange.shade50,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(Icons.info_outline, color: Colors.orange.shade700, size: 32),
              const SizedBox(height: 8),
              Text(
                'No hay encomiendas disponibles',
                style: TextStyle(color: Colors.orange.shade700),
              ),
            ],
          ),
        ),
      );
    }

    return DropdownButtonFormField<int>(
      decoration: const InputDecoration(
        labelText: 'Seleccionar Encomienda',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.inventory_2),
        helperText: 'Selecciona la encomienda para reportar el incidente',
      ),
      value: _selectedEntityId,
      isExpanded: true,
      items: parcelsState.parcels.map((parcel) {
        return DropdownMenuItem(
          value: parcel.id,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Encomienda #${parcel.id}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Remitente: ${parcel.senderName}',
                style: const TextStyle(fontSize: 12),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      }).toList(),
      onChanged: (value) => setState(() => _selectedEntityId = value),
      validator: (value) => value == null ? 'Selecciona una encomienda' : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(incidentProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Reportar Incidente - ${_getEntityLabel()}"),
      ),
      body: AbsorbPointer(
        absorbing: state.isLoading,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                // INFO CARD
                Card(
                  color: Colors.blue.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.blue.shade700),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Reportando incidente para: ${_getEntityLabel()}',
                            style: TextStyle(
                              color: Colors.blue.shade700,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // ENTITY SELECTOR
                _buildEntitySelector(),

                const SizedBox(height: 16),

                // TYPE SELECTOR
                DropdownButtonFormField<IncidentType>(
                  decoration: const InputDecoration(
                    labelText: "Tipo de incidente",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.report_problem),
                  ),
                  items: IncidentType.values
                      .map((type) => DropdownMenuItem(
                    value: type,
                    child: Text(type.name.toUpperCase()),
                  ))
                      .toList(),
                  onChanged: (value) => setState(() => _selectedType = value),
                  validator: (value) =>
                  value == null ? "Selecciona un tipo" : null,
                ),

                const SizedBox(height: 16),

                // NOTE FIELD
                TextFormField(
                  controller: _noteController,
                  decoration: const InputDecoration(
                    labelText: "Descripción / Nota (opcional)",
                    hintText: "Describe el incidente...",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.note),
                  ),
                  maxLines: 4,
                  maxLength: 250,
                  validator: (value) => value != null && value.length > 250
                      ? "Máximo 250 caracteres"
                      : null,
                ),

                const SizedBox(height: 20),

                // LOADING
                if (state.isLoading)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: CircularProgressIndicator(),
                    ),
                  ),

                // SUBMIT BUTTON
                FilledButton.icon(
                  onPressed: state.isLoading ? null : _submit,
                  icon: const Icon(Icons.add),
                  label: const Text("Crear incidente"),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}