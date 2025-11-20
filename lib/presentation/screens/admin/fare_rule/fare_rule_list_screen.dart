import 'package:bus_connect/core/constants/app_routes.dart';
import 'package:bus_connect/presentation/providers/route_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../providers/fare_rule_provider.dart';
import '../../../widgets/common/loading_indicator.dart';
import '../../../widgets/common/error_widget.dart' as custom;

class FareRuleListScreen extends ConsumerStatefulWidget {
  const FareRuleListScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<FareRuleListScreen> createState() => _FareRuleListScreenState();
}

class _FareRuleListScreenState extends ConsumerState<FareRuleListScreen> {
  int? _selectedRouteId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(fareRuleProvider.notifier).fetchAllFareRules();
      ref.read(routeProvider.notifier).fetchAllRoutes();
    });
  }

  @override
  Widget build(BuildContext context) {
    final fareRuleState = ref.watch(fareRuleProvider);
    final fareRuleNotifier = ref.read(fareRuleProvider.notifier);
    final routes = ref.watch(routeProvider).routes;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reglas de Tarifas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push(AppRoutes.adminFareRuleCreate),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildRouteFilter(routes),
          Expanded(child: _buildBody(fareRuleState, fareRuleNotifier)),
        ],
      ),
    );
  }

  Widget _buildRouteFilter(List routes) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: DropdownButtonFormField<int?>(
        initialValue: _selectedRouteId,
        decoration: const InputDecoration(
          labelText: "Filtrar por Ruta",
          prefixIcon: Icon(Icons.route),
          border: OutlineInputBorder(),
        ),
        items: [
          const DropdownMenuItem(value: null, child: Text('Todas')),
          ...routes.map((r) => DropdownMenuItem(
            value: r.id,
            child: Text(r.name),
          )),
        ],
        onChanged: (value) {
          setState(() => _selectedRouteId = value);
          if (value == null) {
            ref.read(fareRuleProvider.notifier).fetchAllFareRules();
          } else {
            ref.read(fareRuleProvider.notifier).fetchFareRulesByRoute(value);
          }
        },
      ),
    );
  }

  Widget _buildBody(FareRuleState state, FareRuleNotifier notifier) {
    if (state.isLoading) return const LoadingIndicator();
    if (state.error != null) {
      return custom.ErrorDisplay(
        message: state.error!,
        onRetry: () => notifier.fetchAllFareRules(),
      );
    }

    final fareRules = state.fareRules;
    if (fareRules.isEmpty) {
      return const Center(child: Text('No hay reglas de tarifas'));
    }

    return RefreshIndicator(
      onRefresh: () => notifier.fetchAllFareRules(),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: fareRules.length,
        itemBuilder: (context, index) {
          final fareRule = fareRules[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.green,
                child: Text(
                  '\$${fareRule.basePrice.toStringAsFixed(0)}',
                  style: const TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
              title: Text(
                '${fareRule.fromStopName} → ${fareRule.toStopName}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text('Precio Base: \$${fareRule.basePrice}'),
                  Text('Pricing: ${_getDynamicPricingName(fareRule.dynamicPricing.name)}'),
                ],
              ),
              trailing: PopupMenuButton(
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'edit',
                    child: Row(children: [
                      Icon(Icons.edit),
                      SizedBox(width: 8),
                      Text('Editar')
                    ]),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Row(children: [
                      Icon(Icons.delete, color: Colors.red),
                      SizedBox(width: 8),
                      Text('Eliminar', style: TextStyle(color: Colors.red))
                    ]),
                  ),
                ],
                onSelected: (value) => _handleMenuAction(context, value, fareRule, notifier),
              ),
            ),
          );
        },
      ),
    );
  }

  String _getDynamicPricingName(String status) {
    switch (status) {
      case 'ACTIVE':
        return 'Activo';
      case 'INACTIVE':
        return 'Inactivo';
      default:
        return status;
    }
  }

  void _handleMenuAction(context, value, fareRule, FareRuleNotifier notifier) {
    if (value == 'edit') {
      context.push(AppRoutes.adminFareRuleEdit, extra: fareRule.id);
    } else if (value == 'delete') {
      _confirmDelete(context, fareRule, notifier);
    }
  }

  void _confirmDelete(context, fareRule, FareRuleNotifier notifier) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar Regla'),
        content: Text(
          '¿Eliminar regla ${fareRule.fromStopName} → ${fareRule.toStopName}?',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              final success = await notifier.deleteFareRule(fareRule.id);
              if (!mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(success ? 'Regla eliminada' : 'Error al eliminar')),
              );
            },
            child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}