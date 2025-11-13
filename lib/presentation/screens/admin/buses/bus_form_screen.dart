import 'package:bus_connect/presentation/providers/bus_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/enums/bus_status.dart';
import '../../../../data/models/bus_model/bus_model.dart';
import '../../../widgets/common/custom_button.dart';
import '../../../widgets/common/custom_text_field.dart';

class BusFormScreen extends ConsumerStatefulWidget {
  final bool isEdit;
  const BusFormScreen({Key? key, this.isEdit = false}) : super(key: key);

  @override
  ConsumerState<BusFormScreen> createState() => _BusFormScreenState();
}


class _BusFormScreenState extends ConsumerState<BusFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _plateController = TextEditingController();
  final _capacityController = TextEditingController();

  BusStatus _selectedStatus = BusStatus.ACTIVE;
  bool _hasAC = false;
  bool _hasWifi = false;
  bool _hasUSB = false;
  bool _hasToilet = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.isEdit) {
      _loadBusData();
    }
  }

  void _loadBusData() {
    final bus = ref.watch(busProvider).selectedBus;
    if (bus != null) {
      _plateController.text = bus.plate;
      _capacityController.text = bus.capacity.toString();
      _selectedStatus = BusStatus.values.firstWhere(
            (s) => s.name.toUpperCase() == bus.status.name,
        orElse: () => BusStatus.ACTIVE,
      );

      // Load amenities
      if (bus.amenities != null) {
        _hasAC = bus.amenities!['airConditioning'] ?? false;
        _hasWifi = bus.amenities!['wifi'] ?? false;
        _hasUSB = bus.amenities!['usbCharging'] ?? false;
        _hasToilet = bus.amenities!['toilet'] ?? false;
      }
    }
  }

  @override
  void dispose() {
    _plateController.dispose();
    _capacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEdit ? 'Editar Bus' : 'Nuevo Bus'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildSectionTitle('Información Básica'),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _plateController,
              label: 'Placa',
              prefixIcon: Icons.confirmation_number,
              enabled: !widget.isEdit, // Plate cannot be changed
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'La placa es requerida';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _capacityController,
              label: 'Capacidad',
              prefixIcon: Icons.airline_seat_recline_normal,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'La capacidad es requerida';
                }
                final capacity = int.tryParse(value);
                if (capacity == null || capacity < 1) {
                  return 'Capacidad inválida';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            _buildStatusDropdown(),
            const SizedBox(height: 24),
            _buildSectionTitle('Comodidades'),
            const SizedBox(height: 16),
            _buildAmenitiesCheckboxes(),
            const SizedBox(height: 32),
            CustomButton(
              text: widget.isEdit ? 'Actualizar Bus' : 'Crear Bus',
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
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildStatusDropdown() {
    return DropdownButtonFormField<BusStatus>(
      value: _selectedStatus,
      decoration: const InputDecoration(
        labelText: 'Estado',
        prefixIcon: Icon(Icons.toggle_on),
        border: OutlineInputBorder(),
      ),
      items: BusStatus.values.map((status) {
        return DropdownMenuItem(
          value: status,
          child: Text(_getStatusDisplayName(status)),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) {
          setState(() => _selectedStatus = value);
        }
      },
    );
  }

  Widget _buildAmenitiesCheckboxes() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CheckboxListTile(
              title: const Text('Aire Acondicionado'),
              secondary: const Icon(Icons.ac_unit),
              value: _hasAC,
              onChanged: (value) {
                setState(() => _hasAC = value ?? false);
              },
            ),
            CheckboxListTile(
              title: const Text('WiFi'),
              secondary: const Icon(Icons.wifi),
              value: _hasWifi,
              onChanged: (value) {
                setState(() => _hasWifi = value ?? false);
              },
            ),
            CheckboxListTile(
              title: const Text('Carga USB'),
              secondary: const Icon(Icons.usb),
              value: _hasUSB,
              onChanged: (value) {
                setState(() => _hasUSB = value ?? false);
              },
            ),
            CheckboxListTile(
              title: const Text('Baño'),
              secondary: const Icon(Icons.wc),
              value: _hasToilet,
              onChanged: (value) {
                setState(() => _hasToilet = value ?? false);
              },
            ),
          ],
        ),
      ),
    );
  }

  String _getStatusDisplayName(BusStatus status) {
    switch (status) {
      case BusStatus.ACTIVE:
        return 'Activo';
      case BusStatus.MAINTENANCE:
        return 'Mantenimiento';
      case BusStatus.INACTIVE:
        return 'Inactivo';
    }
  }

  Map<String, dynamic> _getAmenities() {
    return {
      'airConditioning': _hasAC,
      'wifi': _hasWifi,
      'usbCharging': _hasUSB,
      'toilet': _hasToilet,
    };
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    final provider = ref.read(busProvider.notifier);
    bool success;

    if (widget.isEdit) {
      final bus = ref.read(busProvider).selectedBus;
      if (bus == null) return;

      final request = BusUpdateRequest(
        capacity: int.parse(_capacityController.text),
        amenities: _getAmenities(),
        status: _selectedStatus,
      );

      success = await provider.updateBus(bus.id, request);
    } else {
      // Check if plate exists
      final plateExists = await provider.checkPlateExists(_plateController.text);

      if (plateExists) {
        setState(() => _isLoading = false);
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('La placa ya está registrada')),
        );
        return;
      }

      final request = BusCreateRequest(
        plate: _plateController.text,
        capacity: int.parse(_capacityController.text),
        amenities: _getAmenities(),
        status: _selectedStatus,
      );

      success = await provider.createBus(request);
    }

    setState(() => _isLoading = false);

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(widget.isEdit ? 'Bus actualizado' : 'Bus creado'),
        ),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(ref.read(busProvider).error ?? 'Error al guardar')),
      );
    }
  }
}