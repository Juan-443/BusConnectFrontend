import 'package:bus_connect/presentation/providers/route_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/models/route_model/route_model.dart';
import '../../../widgets/common/custom_button.dart';
import '../../../widgets/common/custom_text_field.dart';

class RouteFormScreen extends ConsumerStatefulWidget {
  final bool isEdit;

  const RouteFormScreen({Key? key, this.isEdit = false}) : super(key: key);

  @override
  ConsumerState<RouteFormScreen> createState() => _RouteFormScreenState();
}

class _RouteFormScreenState extends ConsumerState<RouteFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  final _nameController = TextEditingController();
  final _originController = TextEditingController();
  final _destinationController = TextEditingController();
  final _distanceController = TextEditingController();
  final _durationController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.isEdit) {
      _loadRouteData();
    }
  }

  void _loadRouteData() {
    final route = ref.read(routeProvider).selectedRoute;
    if (route != null) {
      _codeController.text = route.code;
      _nameController.text = route.name;
      _originController.text = route.origin;
      _destinationController.text = route.destination;
      _distanceController.text = route.distanceKm.toString();
      _durationController.text = route.durationMin.toString();
    }
  }

  @override
  void dispose() {
    _codeController.dispose();
    _nameController.dispose();
    _originController.dispose();
    _destinationController.dispose();
    _distanceController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEdit ? 'Editar Ruta' : 'Nueva Ruta'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildSectionTitle('Información de la Ruta'),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _codeController,
              label: 'Código',
              prefixIcon: Icons.qr_code,
              enabled: !widget.isEdit,
              validator: (value) {
                if (value == null || value.isEmpty) return 'El código es requerido';
                return null;
              },
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _nameController,
              label: 'Nombre',
              prefixIcon: Icons.label,
              validator: (value) {
                if (value == null || value.isEmpty) return 'El nombre es requerido';
                return null;
              },
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('Ubicaciones'),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _originController,
              label: 'Origen',
              prefixIcon: Icons.place,
              enabled: !widget.isEdit,
              validator: (value) {
                if (value == null || value.isEmpty) return 'El origen es requerido';
                return null;
              },
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _destinationController,
              label: 'Destino',
              prefixIcon: Icons.place,
              enabled: !widget.isEdit,
              validator: (value) {
                if (value == null || value.isEmpty) return 'El destino es requerido';
                return null;
              },
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('Detalles del Recorrido'),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _distanceController,
              label: 'Distancia (km)',
              prefixIcon: Icons.straighten,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) return 'La distancia es requerida';
                final distance = int.tryParse(value);
                if (distance == null || distance < 1) return 'Distancia inválida';
                return null;
              },
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _durationController,
              label: 'Duración (minutos)',
              prefixIcon: Icons.timer,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) return 'La duración es requerida';
                final duration = int.tryParse(value);
                if (duration == null || duration < 1) return 'Duración inválida';
                return null;
              },
            ),
            const SizedBox(height: 32),
            CustomButton(
              text: widget.isEdit ? 'Actualizar Ruta' : 'Crear Ruta',
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

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final notifier = ref.read(routeProvider.notifier);
    final state = ref.read(routeProvider);
    bool success;

    if (widget.isEdit) {
      final route = state.selectedRoute;
      if (route == null) return;

      final request = RouteUpdateRequest(
        name: _nameController.text,
        distanceKm: int.parse(_distanceController.text),
        durationMin: int.parse(_durationController.text),
      );

      success = await notifier.updateRoute(route.id, request);
    } else {
      final codeExists = await notifier.checkCodeExists(_codeController.text);
      if (codeExists) {
        setState(() => _isLoading = false);
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('El código ya está registrado')),
        );
        return;
      }

      final request = RouteCreateRequest(
        code: _codeController.text,
        name: _nameController.text,
        origin: _originController.text,
        destination: _destinationController.text,
        distanceKm: int.parse(_distanceController.text),
        durationMin: int.parse(_durationController.text),
      );

      success = await notifier.createRoute(request);
    }

    setState(() => _isLoading = false);
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(success
            ? (widget.isEdit ? 'Ruta actualizada' : 'Ruta creada')
            : state.error ?? 'Error al guardar'),
      ),
    );

    if (success) Navigator.pop(context);
  }
}
