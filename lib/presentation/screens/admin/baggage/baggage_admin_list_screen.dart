import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/baggage_provider.dart';
import '../../../widgets/common/loading_indicator.dart';
import '../../../widgets/common/error_widget.dart' as custom;

class BaggageAdminListScreen extends ConsumerStatefulWidget {
  const BaggageAdminListScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<BaggageAdminListScreen> createState() => _BaggageAdminListScreenState();
}

class _BaggageAdminListScreenState extends ConsumerState<BaggageAdminListScreen> {
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(baggageProvider.notifier).fetchAllBaggage();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(baggageProvider);
    final notifier = ref.read(baggageProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Gestión de Equipaje')),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(child: _buildBody(state, notifier)),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Buscar por código de etiqueta...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
        ),
        onChanged: (value) => setState(() => _searchQuery = value),
      ),
    );
  }

  Widget _buildBody(BaggageState state, BaggageNotifier notifier) {
    if (state.isLoading) return const LoadingIndicator();
    if (state.error != null) {
      return custom.ErrorDisplay(
        message: state.error!,
        onRetry: () => notifier.fetchAllBaggage(),
      );
    }

    var baggageList = state.baggageList;

    if (_searchQuery.isNotEmpty) {
      baggageList = baggageList.where((b) {
        return b.tagCode.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            (b.passengerName?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false);
      }).toList();
    }

    if (baggageList.isEmpty) {
      return const Center(child: Text('No hay equipaje registrado'));
    }

    return RefreshIndicator(
      onRefresh: () => notifier.fetchAllBaggage(),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: baggageList.length,
        itemBuilder: (context, index) {
          final baggage = baggageList[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: baggage.excessWeight == true ? Colors.red : Colors.green,
                child: Icon(
                  baggage.excessWeight == true ? Icons.warning : Icons.luggage,
                  color: Colors.white,
                ),
              ),
              title: Text(baggage.tagCode, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text('Pasajero: ${baggage.passengerName ?? "N/A"}'),
                  Text('Peso: ${baggage.weightKg} kg'),
                  Text('Tarifa: \$${baggage.fee}'),
                  if (baggage.excessWeight == true)
                    const Text(
                      'EXCESO DE PESO',
                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                ],
              ),
              trailing: PopupMenuButton(
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'detail',
                    child: Row(children: [Icon(Icons.info), SizedBox(width: 8), Text('Ver detalle')]),
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
                onSelected: (value) => _handleMenuAction(context, value, baggage, notifier),
              ),
            ),
          );
        },
      ),
    );
  }

  void _handleMenuAction(context, value, baggage, BaggageNotifier notifier) {
    if (value == 'detail') {
      _showBaggageDetail(baggage);
    } else if (value == 'delete') {
      _confirmDelete(context, baggage, notifier);
    }
  }

  void _showBaggageDetail(baggage) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Equipaje: ${baggage.tagCode}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Pasajero', baggage.passengerName ?? 'N/A'),
            _buildDetailRow('Peso', '${baggage.weightKg} kg'),
            _buildDetailRow('Tarifa', '\$${baggage.fee}'),
            _buildDetailRow('Viaje', baggage.tripInfo ?? 'N/A'),
            if (baggage.excessWeight == true)
              const Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text(
                  'EXCESO DE PESO',
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cerrar')),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }

  void _confirmDelete(context, baggage, BaggageNotifier notifier) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar Equipaje'),
        content: Text('¿Eliminar equipaje ${baggage.tagCode}?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              final success = await notifier.deleteBaggage(baggage.id);
              if (!mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(success ? 'Equipaje eliminado' : 'Error al eliminar')),
              );
            },
            child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}