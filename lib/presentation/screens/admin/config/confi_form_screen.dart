import 'package:bus_connect/data/models/config_model/config_model.dart';
import 'package:bus_connect/presentation/providers/config_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConfigFormScreen extends ConsumerStatefulWidget {
  final bool isEdit;
  const ConfigFormScreen({Key? key, this.isEdit = false}) : super(key: key);

  @override
  ConsumerState<ConfigFormScreen> createState() => _ConfigFormScreenState();
}

class _ConfigFormScreenState extends ConsumerState<ConfigFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _keyController;
  late final TextEditingController _valueController;
  late final TextEditingController _descriptionController;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    // Usa ref.read porque en initState no es apropiado usar ref.watch
    final selected = ref.read(configProvider).selectedConfig;
    _keyController = TextEditingController(text: selected?.key ?? '');
    _valueController = TextEditingController(text: selected?.value ?? '');
    _descriptionController = TextEditingController(text: selected?.description ?? '');
  }

  @override
  void dispose() {
    _keyController.dispose();
    _valueController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);
    final notifier = ref.read(configProvider.notifier);
    bool ok = false;

    if (widget.isEdit) {
      final selected = ref.read(configProvider).selectedConfig;
      if (selected == null) {
        setState(() => _isSaving = false);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No hay configuración seleccionada')));
        return;
      }

      final req = ConfigUpdateRequest(
        value: _valueController.text,
        description: _descriptionController.text.isEmpty ? null : _descriptionController.text,
      );

      ok = await notifier.updateConfig(selected.id, req);
    } else {
      final req = ConfigCreateRequest(
        key: _keyController.text,
        value: _valueController.text,
        description: _descriptionController.text.isEmpty ? null : _descriptionController.text,
      );
      ok = await notifier.createConfig(req);
    }

    setState(() => _isSaving = false);

    // Leer error desde el state (no del notifier)
    final errorMessage = ref.read(configProvider).error;

    if (!mounted) return;
    if (ok) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(widget.isEdit ? 'Configuración actualizada' : 'Configuración creada'),
      ));
      // limpiar selección en caso de edición
      notifier.clearSelectedConfig();
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(errorMessage ?? 'Error al guardar la configuración'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(configProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEdit ? 'Editar Configuración' : 'Nueva Configuración'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Key (solo editable cuando creas)
              TextFormField(
                controller: _keyController,
                decoration: const InputDecoration(labelText: 'Clave', border: OutlineInputBorder()),
                enabled: !widget.isEdit,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'La clave es requerida';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              // Value
              TextFormField(
                controller: _valueController,
                decoration: const InputDecoration(labelText: 'Valor', border: OutlineInputBorder()),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'El valor es requerido';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              // Description
              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(labelText: 'Descripción (opcional)', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isSaving ? null : _save,
                child: _isSaving ? const SizedBox(height: 18, width: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : Text(widget.isEdit ? 'Actualizar' : 'Crear'),
              ),
              if (state.error != null) ...[
                const SizedBox(height: 8),
                Text('Error: ${state.error}', style: const TextStyle(color: Colors.red)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
