import 'package:bus_connect/core/constants/app_routes.dart';
import 'package:bus_connect/presentation/providers/bus_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/enums/bus_status.dart';
import '../../../widgets/common/custom_button.dart';
import '../../../widgets/common/custom_text_field.dart';
import '../../../../data/models/bus_model/bus_model.dart';

class BusFormScreen extends ConsumerStatefulWidget {
  final bool isEdit;
  final int? busId;
  const BusFormScreen({Key? key, this.isEdit = false, this.busId}) : super(key: key);

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

  bool _isLoadingBus = false;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    if (widget.isEdit && widget.busId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _loadBusData());
    }
  }

  Future<void> _loadBusData() async {
    setState(() => _isLoadingBus = true);

    await ref.read(busProvider.notifier).fetchBusById(widget.busId!);
    final bus = ref.read(busProvider).selectedBus;

    if (bus == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error al cargar los datos del bus")),
        );
      }
      setState(() => _isLoadingBus = false);
      return;
    }

    _plateController.text = bus.plate;
    _capacityController.text = bus.capacity.toString();
    _selectedStatus = bus.status;

    _hasAC = bus.amenities?["Aire acondicionado"] ?? false;
    _hasWifi = bus.amenities?["WIFI"] ?? false;
    _hasUSB = bus.amenities?["Carga USB"] ?? false;
    _hasToilet = bus.amenities?["Baño"] ?? false;

    setState(() => _isLoadingBus = false);
  }

  @override
  void dispose() {
    _plateController.dispose();
    _capacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoadingBus) {
      return Scaffold(
        appBar: AppBar(title: const Text("Cargando Bus...")),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEdit ? "Editar Bus" : "Nuevo Bus"),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildSectionTitle("Información Básica"),
            const SizedBox(height: 16),

            CustomTextField(
              controller: _plateController,
              label: "Placa",
              prefixIcon: Icons.confirmation_number,
              enabled: !widget.isEdit,
              validator: (v) =>
              v == null || v.isEmpty ? "La placa es requerida" : null,
            ),

            const SizedBox(height: 16),

            CustomTextField(
              controller: _capacityController,
              label: "Capacidad",
              prefixIcon: Icons.airline_seat_recline_normal,
              keyboardType: TextInputType.number,
              validator: (v) {
                if (v == null || v.isEmpty) return "La capacidad es requerida";
                final n = int.tryParse(v);
                if (n == null || n < 1) return "Capacidad inválida";
                return null;
              },
            ),

            const SizedBox(height: 16),
            _buildStatusDropdown(),
            const SizedBox(height: 24),

            _buildSectionTitle("Comodidades"),
            const SizedBox(height: 16),
            _buildAmenitiesCheckboxes(),

            const SizedBox(height: 32),
            CustomButton(
              text: widget.isEdit ? "Actualizar Bus" : "Crear Bus",
              isLoading: _isSubmitting,
              onPressed: _submitForm,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildStatusDropdown() {
    return DropdownButtonFormField<BusStatus>(
      initialValue: _selectedStatus,
      decoration: const InputDecoration(
        labelText: "Estado",
        prefixIcon: Icon(Icons.toggle_on),
        border: OutlineInputBorder(),
      ),
      items: BusStatus.values
          .map((s) => DropdownMenuItem(
        value: s,
        child: Text(_getStatusDisplayName(s)),
      ))
          .toList(),
      onChanged: (v) => setState(() => _selectedStatus = v!),
    );
  }

  Widget _buildAmenitiesCheckboxes() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          CheckboxListTile(
            title: const Text("Aire Acondicionado"),
            secondary: const Icon(Icons.ac_unit),
            value: _hasAC,
            onChanged: (v) => setState(() => _hasAC = v ?? false),
          ),
          CheckboxListTile(
            title: const Text("WiFi"),
            secondary: const Icon(Icons.wifi),
            value: _hasWifi,
            onChanged: (v) => setState(() => _hasWifi = v ?? false),
          ),
          CheckboxListTile(
            title: const Text("Carga USB"),
            secondary: const Icon(Icons.usb),
            value: _hasUSB,
            onChanged: (v) => setState(() => _hasUSB = v ?? false),
          ),
          CheckboxListTile(
            title: const Text("Baño"),
            secondary: const Icon(Icons.wc),
            value: _hasToilet,
            onChanged: (v) => setState(() => _hasToilet = v ?? false),
          ),
        ]),
      ),
    );
  }

  Map<String, Object> _getAmenities() => {
    "Aire acondicionado": _hasAC,
    "WIFI": _hasWifi,
    "Carga USB": _hasUSB,
    "Baño": _hasToilet,
  };

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    final notifier = ref.read(busProvider.notifier);
    bool success;

    try {
      if (widget.isEdit) {
        final req = BusUpdateRequest(
          capacity: int.parse(_capacityController.text),
          amenities: _getAmenities(),
          status: _selectedStatus,
        );

        success = await notifier.updateBus(widget.busId!, req);
      } else {
        final exists = await notifier.checkPlateExists(_plateController.text);
        if (exists) {
          setState(() => _isSubmitting = false);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("La placa ya está registrada")),
          );
          return;
        }

        final req = BusCreateRequest(
          plate: _plateController.text,
          capacity: int.parse(_capacityController.text),
          amenities: _getAmenities(),
          status: _selectedStatus,
        );

        success = await notifier.createBus(req);
      }

      if (!mounted) return;
      setState(() => _isSubmitting = false);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.isEdit
                ? "Bus actualizado correctamente"
                : "Bus creado exitosamente"),
          ),
        );
        context.go(AppRoutes.adminBuses);
      } else {
        final error = ref.read(busProvider).error ?? "Error desconocido";
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $error")),
        );
      }
    } catch (e) {
      setState(() => _isSubmitting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error inesperado: $e")),
      );
    }
  }

  String _getStatusDisplayName(BusStatus s) {
    switch (s) {
      case BusStatus.ACTIVE:
        return "Activo";
      case BusStatus.MAINTENANCE:
        return "Mantenimiento";
      case BusStatus.INACTIVE:
        return "Inactivo";
    }
  }
}
