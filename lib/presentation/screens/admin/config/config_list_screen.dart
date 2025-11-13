import 'package:bus_connect/presentation/providers/config_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../admin/config/confi_form_screen.dart';

class ConfigListScreen extends ConsumerStatefulWidget {
  const ConfigListScreen({super.key});

  @override
  ConsumerState<ConfigListScreen> createState() => _ConfigListScreenState();
}

class _ConfigListScreenState extends ConsumerState<ConfigListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(configProvider.notifier).fetchAllConfigs());
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  Future<void> _refreshConfigs() async {
    await ref.read(configProvider.notifier).fetchAllConfigs();
  }

  @override
  Widget build(BuildContext context) {
    final configState = ref.watch(configProvider);
    final notifier = ref.read(configProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuraciones'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshConfigs,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshConfigs,
        child: Builder(
          builder: (context) {
            if (configState.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (configState.error != null) {
              return Center(child: Text('Error: ${configState.error}'));
            }

            if (configState.configs.isEmpty) {
              return const Center(child: Text('No hay configuraciones registradas.'));
            }

            return ListView.builder(
              itemCount: configState.configs.length,
              itemBuilder: (context, index) {
                final config = configState.configs[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(config.key),
                    subtitle: Text(config.value),
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) async {
                        switch (value) {
                          case 'edit':
                            notifier.selectConfig(config);
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ConfigFormScreen(isEdit: true),
                              ),
                            );
                            notifier.clearSelectedConfig();
                            break;

                          case 'delete':
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Confirmar eliminación'),
                                content: Text('¿Eliminar configuración "${config.key}"?'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context, false),
                                    child: const Text('Cancelar'),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.pop(context, true),
                                    child: const Text('Eliminar'),
                                  ),
                                ],
                              ),
                            );

                            if (confirm == true) {
                              final success = await notifier.deleteConfig(config.id);
                              if (success) {
                                _showSnackBar('Configuración eliminada correctamente');
                              } else {
                                _showSnackBar(notifier.debugState.error ?? 'Error al eliminar', isError: true);
                              }
                            }
                            break;
                        }
                      },
                      itemBuilder: (_) => const [
                        PopupMenuItem(value: 'edit', child: Text('Editar')),
                        PopupMenuItem(value: 'delete', child: Text('Eliminar')),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ConfigFormScreen(isEdit: false)),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

extension on ConfigNotifier {
  /// Helper para acceder rápido al estado interno (opcional)
  ConfigState get debugState => state;
}
