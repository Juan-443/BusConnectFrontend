import 'package:bus_connect/core/constants/enums/parcel_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/parcel_provider.dart';
import '../../../widgets/common/loading_indicator.dart';
import '../../../widgets/common/error_widget.dart' as custom;

class ParcelAdminListScreen extends ConsumerStatefulWidget {
  const ParcelAdminListScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ParcelAdminListScreen> createState() => _ParcelAdminListScreenState();
}

class _ParcelAdminListScreenState extends ConsumerState<ParcelAdminListScreen> {
  String _searchQuery = '';
  ParcelStatus? _filterStatus;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(parcelProvider.notifier).loadAllParcels();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(parcelProvider);
    final notifier = ref.read(parcelProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Gestión de Encomiendas')),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildStatusFilter(notifier),
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
          hintText: 'Buscar por código...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
        ),
        onChanged: (value) => setState(() => _searchQuery = value),
      ),
    );
  }

  Widget _buildStatusFilter(notifier) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          FilterChip(
            label: const Text('Todos'),
            selected: _filterStatus == null,
            onSelected: (_) {
              setState(() => _filterStatus = null);
              notifier.fetchAllParcels();
            },
          ),
          const SizedBox(width: 8),
          ...ParcelStatus.values.map((status) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text(_getStatusName(status)),
                selected: _filterStatus == status,
                onSelected: (_) {
                  setState(() => _filterStatus = status);
                  notifier.fetchParcelsByStatus(status);
                },
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildBody(ParcelState state, ParcelNotifier notifier) {
    if (state.isLoading) return const LoadingIndicator();
    if (state.error != null) {
      return custom.ErrorDisplay(
        message: state.error!,
        onRetry: () => notifier.loadAllParcels(),
      );
    }

    var parcels = state.parcels;

    if (_searchQuery.isNotEmpty) {
      parcels = parcels.where((p) {
        return p.code.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            p.senderName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            p.receiverName.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }

    if (parcels.isEmpty) {
      return const Center(child: Text('No hay encomiendas'));
    }

    return RefreshIndicator(
      onRefresh: () => notifier.loadAllParcels(),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: parcels.length,
        itemBuilder: (context, index) {
          final parcel = parcels[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: _getStatusColor(parcel.status),
                child: const Icon(Icons.inventory, color: Colors.white),
              ),
              title: Text(parcel.code, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text('De: ${parcel.senderName}'),
                  Text('Para: ${parcel.receiverName}'),
                  Text('Precio: \$${parcel.price}'),
                  _buildStatusBadge(parcel.status),
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
                onSelected: (value) => _handleMenuAction(context, value, parcel, notifier),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatusBadge(ParcelStatus status) {
    final color = _getStatusColor(status);
    return Container(
      margin: const EdgeInsets.only(top: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        _getStatusName(status),
        style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }

  Color _getStatusColor(ParcelStatus status) {
    switch (status) {
      case ParcelStatus.CREATED:
        return Colors.orange;
      case ParcelStatus.IN_TRANSIT:
        return Colors.blue;
      case ParcelStatus.DELIVERED:
        return Colors.green;
      case ParcelStatus.FAILED:
        return Colors.red;
    }
  }

  String _getStatusName(ParcelStatus status) {
    switch (status) {
      case ParcelStatus.CREATED:
        return 'Creado';
      case ParcelStatus.IN_TRANSIT:
        return 'En tránsito';
      case ParcelStatus.DELIVERED:
        return 'Entregado';
      case ParcelStatus.FAILED:
        return 'Fallido';
    }
  }

  void _handleMenuAction(context, value, parcel, notifier) {
    if (value == 'detail') {
      _showParcelDetail(parcel);
    } else if (value == 'delete') {
      _confirmDelete(context, parcel, notifier);
    }
  }

  void _showParcelDetail(parcel) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Encomienda: ${parcel.code}'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('REMITENTE', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Nombre: ${parcel.senderName}'),
              Text('Teléfono: ${parcel.senderPhone}'),
              const Divider(),
              const Text('DESTINATARIO', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Nombre: ${parcel.receiverName}'),
              Text('Teléfono: ${parcel.receiverPhone}'),
              const Divider(),
              Text('Precio: \$${parcel.price}'),
              Text('Estado: ${_getStatusName(parcel.status)}'),
              if (parcel.deliveryOtp != null) Text('OTP: ${parcel.deliveryOtp}'),
              if (parcel.deliveredAt != null) Text('Entregado: ${parcel.deliveredAt}'),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cerrar')),
        ],
      ),
    );
  }

  void _confirmDelete(context, parcel, notifier) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar Encomienda'),
        content: Text('¿Eliminar encomienda ${parcel.code}?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              final success = await notifier.deleteParcel(parcel.id);
              if (!mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(success ? 'Eliminado' : 'Error')),
              );
            },
            child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}