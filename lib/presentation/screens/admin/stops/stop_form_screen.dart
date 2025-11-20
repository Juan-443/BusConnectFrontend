import 'package:bus_connect/core/constants/app_routes.dart';
import 'package:bus_connect/presentation/providers/route_provider.dart';
import 'package:bus_connect/presentation/providers/stop_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../widgets/common/custom_button.dart';
import '../../../widgets/common/custom_text_field.dart';
import '../../../../data/models/stop_model/stop_model.dart';

class StopFormScreen extends ConsumerStatefulWidget {
  final bool isEdit;
  final int? stopId;

  const StopFormScreen({Key? key, this.isEdit = false, this.stopId}) : super(key: key);

  @override
  ConsumerState<StopFormScreen> createState() => _StopFormScreenState();
}

class _StopFormScreenState extends ConsumerState<StopFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _orderController = TextEditingController();
  final _latController = TextEditingController();
  final _lngController = TextEditingController();

  int? _selectedRouteId;
  bool _isLoading = false;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(routeProvider.notifier).fetchAllRoutes();
      if (widget.isEdit && widget.stopId != null) _loadStopData();
    });
  }

  Future<void> _loadStopData() async {
    setState(() => _isLoading = true);
    await ref.read(stopProvider.notifier).fetchStopById(widget.stopId!);
    final stop = ref.read(stopProvider).selectedStop;

    if (stop != null) {
      _nameController.text = stop.name;
      _orderController.text = stop.order.toString();
      _latController.text = stop.lat.toString();
      _lngController.text = stop.lng.toString();
      _selectedRouteId = stop.routeId;
    }
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text("Cargando...")),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final routes = ref.watch(routeProvider).routes;

    return Scaffold(
      appBar: AppBar(title: Text(widget.isEdit ? "Editar Parada" : "Nueva Parada")),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            CustomTextField(
              controller: _nameController,
              label: "Nombre de la Parada",
              prefixIcon: Icons.place,
              validator: (v) => v == null || v.isEmpty ? "Requerido" : null,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<int>(
              initialValue: _selectedRouteId,
              decoration: const InputDecoration(
                labelText: "Ruta",
                prefixIcon: Icon(Icons.route),
                border: OutlineInputBorder(),
              ),
              items: routes.map((r) => DropdownMenuItem(value: r.id, child: Text(r.name))).toList(),
              onChanged: widget.isEdit ? null : (v) => setState(() => _selectedRouteId = v),
              validator: (v) => v == null ? "Selecciona una ruta" : null,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _orderController,
              label: "Orden",
              prefixIcon: Icons.numbers,
              keyboardType: TextInputType.number,
              validator: (v) => v == null || v.isEmpty ? "Requerido" : null,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _latController,
              label: "Latitud",
              prefixIcon: Icons.my_location,
              keyboardType: TextInputType.number,
              validator: (v) => v == null || v.isEmpty ? "Requerido" : null,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _lngController,
              label: "Longitud",
              prefixIcon: Icons.location_on,
              keyboardType: TextInputType.number,
              validator: (v) => v == null || v.isEmpty ? "Requerido" : null,
            ),
            const SizedBox(height: 32),
            CustomButton(
              text: widget.isEdit ? "Actualizar" : "Crear",
              isLoading: _isSubmitting,
              onPressed: _submitForm,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);
    final notifier = ref.read(stopProvider.notifier);
    bool success;

    if (widget.isEdit) {
      final req = StopUpdateRequest(
        name: _nameController.text,
        order: int.parse(_orderController.text),
      );
      success = await notifier.updateStop(widget.stopId!, req);
    } else {
      final req = StopCreateRequest(
        name: _nameController.text,
        order: int.parse(_orderController.text),
        lat: double.parse(_latController.text),
        lng: double.parse(_lngController.text),
        routeId: _selectedRouteId!,
      );
      success = await notifier.createStop(req);
    }

    if (!mounted) return;
    setState(() => _isSubmitting = false);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(widget.isEdit ? "Actualizado" : "Creado")),
      );
      context.go(AppRoutes.adminStops);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(ref.read(stopProvider).error ?? "Error")),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _orderController.dispose();
    _latController.dispose();
    _lngController.dispose();
    super.dispose();
  }
}