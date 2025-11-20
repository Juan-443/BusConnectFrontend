import 'package:bus_connect/data/models/route_model/route_model.dart';
import 'package:bus_connect/presentation/providers/route_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RouteFormScreen extends ConsumerStatefulWidget {
  final int? routeId;

  const RouteFormScreen({super.key, this.routeId});

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

  bool get isEditing => widget.routeId != null;

  @override
  void initState() {
    super.initState();
    if (isEditing) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _loadRouteData();
      });
    }
  }

  Future<void> _loadRouteData() async {
    setState(() => _isLoading = true);

    try {
      await ref.read(routeProvider.notifier).fetchRouteById(widget.routeId!);
      final route = ref.read(routeProvider).selectedRoute;

      if (route != null && mounted) {
        _codeController.text = route.code;
        _nameController.text = route.name;
        _originController.text = route.origin;
        _destinationController.text = route.destination;
        _distanceController.text = route.distanceKm.toString();
        _durationController.text = route.durationMin.toString();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al cargar la ruta: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
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
        title: Text(isEditing ? 'Editar Ruta' : 'Nueva Ruta'),
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
              // Código
              _buildTextField(
                controller: _codeController,
                label: 'Código de ruta',
                icon: Icons.qr_code,
                enabled: !isEditing,
                textCapitalization: TextCapitalization.characters,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese un código';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Nombre
              _buildTextField(
                controller: _nameController,
                label: 'Nombre de la ruta',
                icon: Icons.label,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese un nombre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Origen
              _buildTextField(
                controller: _originController,
                label: 'Origen',
                icon: Icons.trip_origin,
                enabled: !isEditing,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese el origen';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Destino
              _buildTextField(
                controller: _destinationController,
                label: 'Destino',
                icon: Icons.location_on,
                enabled: !isEditing,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese el destino';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Distancia
              _buildTextField(
                controller: _distanceController,
                label: 'Distancia (km)',
                icon: Icons.straighten,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese la distancia';
                  }
                  final distance = int.tryParse(value);
                  if (distance == null || distance < 1) {
                    return 'Distancia debe ser mayor a 0';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Duración
              _buildTextField(
                controller: _durationController,
                label: 'Duración (minutos)',
                icon: Icons.access_time,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese la duración';
                  }
                  final duration = int.tryParse(value);
                  if (duration == null || duration < 1) {
                    return 'Duración debe ser mayor a 0';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),

              // Botón de guardar
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _handleSubmit,
                  child: Text(
                    isEditing ? 'Actualizar' : 'Crear Ruta',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),

              if (!isEditing) ...[
                const SizedBox(height: 16),
                const Text(
                  'Nota: Después de crear la ruta, podrás agregar las paradas.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    bool enabled = true,
    TextCapitalization textCapitalization = TextCapitalization.none,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      enabled: enabled,
      textCapitalization: textCapitalization,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: !enabled,
        fillColor: !enabled ? Colors.grey.shade100 : null,
      ),
      validator: validator,
    );
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    bool success;

    if (isEditing) {
      final request = RouteUpdateRequest(
        name: _nameController.text.trim(),
        distanceKm: int.parse(_distanceController.text.trim()),
        durationMin: int.parse(_durationController.text.trim()),
      );

      success = await ref.read(routeProvider.notifier).updateRoute(
        widget.routeId!,
        request,
      );
    } else {
      // CREAR RUTA
      final request = RouteCreateRequest(
        code: _codeController.text.trim().toUpperCase(),
        name: _nameController.text.trim(),
        origin: _originController.text.trim(),
        destination: _destinationController.text.trim(),
        distanceKm: int.parse(_distanceController.text.trim()),
        durationMin: int.parse(_durationController.text.trim()),
      );

      success = await ref.read(routeProvider.notifier).createRoute(request);
    }

    setState(() => _isLoading = false);

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isEditing
                ? 'Ruta actualizada exitosamente'
                : 'Ruta creada exitosamente',
          ),
        ),
      );
      context.pop();
    } else if (mounted) {
      final error = ref.read(routeProvider).error;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error ?? 'Error al guardar ruta'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}