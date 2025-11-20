import 'package:bus_connect/data/models/config_model/config_model.dart';
import 'package:bus_connect/presentation/providers/config_provider.dart';
import 'package:bus_connect/presentation/widgets/config_card/config_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConfigsListScreen extends ConsumerStatefulWidget {
  const ConfigsListScreen({super.key});

  @override
  ConsumerState<ConfigsListScreen> createState() => _ConfigsListScreenState();
}

class _ConfigsListScreenState extends ConsumerState<ConfigsListScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    Future.microtask(
          () => ref.read(configProvider.notifier).fetchAllConfigs(),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(configProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuraciones del Sistema'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () =>
                ref.read(configProvider.notifier).fetchAllConfigs(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Barra de búsqueda
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar configuración...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    setState(() => _searchQuery = '');
                  },
                )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                setState(() => _searchQuery = value);
              },
            ),
          ),

          // Lista de configuraciones
          Expanded(
            child: state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : state.error != null
                ? _buildError(state.error!)
                : _buildConfigsList(state.configs),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showConfigDialog(context, null),
        icon: const Icon(Icons.add),
        label: const Text('Nueva Configuración'),
      ),
    );
  }

  Widget _buildError(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            'Error al cargar configuraciones',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () =>
                ref.read(configProvider.notifier).fetchAllConfigs(),
            icon: const Icon(Icons.refresh),
            label: const Text('Reintentar'),
          ),
        ],
      ),
    );
  }

  Widget _buildConfigsList(List<ConfigModel> configs) {
    // Filtrar configuraciones según búsqueda
    final filteredConfigs = _searchQuery.isEmpty
        ? configs
        : configs.where((config) {
      final query = _searchQuery.toLowerCase();
      return config.key.toLowerCase().contains(query) ||
          (config.description?.toLowerCase().contains(query) ?? false) ||
          config.value.toLowerCase().contains(query);
    }).toList();

    if (filteredConfigs.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _searchQuery.isEmpty ? Icons.settings_outlined : Icons.search_off,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              _searchQuery.isEmpty
                  ? 'No hay configuraciones registradas'
                  : 'No se encontraron configuraciones',
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(configProvider.notifier).fetchAllConfigs(),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: filteredConfigs.length,
        itemBuilder: (context, index) {
          final config = filteredConfigs[index];
          return ConfigCard(
            config: config,
            onTap: () => _showConfigDialog(context, config),
            onEdit: () => _showConfigDialog(context, config),
            onDelete: () => _confirmDelete(config.id, config.key),
          );
        },
      ),
    );
  }

  void _showConfigDialog(BuildContext context, ConfigModel? config) {
    final isEditing = config != null;
    final keyController = TextEditingController(text: config?.key ?? '');
    final valueController = TextEditingController(text: config?.value ?? '');
    final descriptionController = TextEditingController(
      text: config?.description ?? '',
    );
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(isEditing ? 'Editar Configuración' : 'Nueva Configuración'),
        content: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: keyController,
                  decoration: const InputDecoration(
                    labelText: 'Clave *',
                    prefixIcon: Icon(Icons.vpn_key),
                    border: OutlineInputBorder(),
                    helperText: 'Ejemplo: max.passengers.per.booking',
                  ),
                  enabled: !isEditing,
                  style: TextStyle(
                    color: isEditing ? Colors.grey : null,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese una clave';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: valueController,
                  decoration: const InputDecoration(
                    labelText: 'Valor *',
                    prefixIcon: Icon(Icons.data_object),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese un valor';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Descripción (opcional)',
                    prefixIcon: Icon(Icons.description),
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (!formKey.currentState!.validate()) return;

              Navigator.pop(ctx);

              bool success;

              if (isEditing) {
                final request = ConfigUpdateRequest(
                  value: valueController.text.trim(),
                  description: descriptionController.text.trim().isEmpty
                      ? null
                      : descriptionController.text.trim(),
                );

                success = await ref
                    .read(configProvider.notifier)
                    .updateConfig(config.id, request);
              } else {
                final request = ConfigCreateRequest(
                  key: keyController.text.trim(),
                  value: valueController.text.trim(),
                  description: descriptionController.text.trim().isEmpty
                      ? null
                      : descriptionController.text.trim(),
                );

                success = await ref
                    .read(configProvider.notifier)
                    .createConfig(request);
              }

              if (success && mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      isEditing
                          ? 'Configuración actualizada exitosamente'
                          : 'Configuración creada exitosamente',
                    ),
                    backgroundColor: Colors.green,
                  ),
                );
              } else if (mounted) {
                final error = ref.read(configProvider).error;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(error ?? 'Error al guardar configuración'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: Text(isEditing ? 'Actualizar' : 'Crear'),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmDelete(int id, String key) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirmar eliminación'),
        content: Text(
          '¿Eliminar la configuración "$key"?\n\nEsta acción no se puede deshacer.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      final success =
      await ref.read(configProvider.notifier).deleteConfig(id);
      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Configuración eliminada exitosamente'),
            backgroundColor: Colors.green,
          ),
        );
      } else if (mounted) {
        final error = ref.read(configProvider).error;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error ?? 'Error al eliminar configuración'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}