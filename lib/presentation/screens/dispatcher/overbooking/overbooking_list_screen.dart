import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../providers/overbooking_provider.dart';
import '../../../providers/user_provider.dart';
import '../../../widgets/common/loading_indicator.dart';
import '../../../widgets/common/error_widget.dart' as custom;
import '../../../../../core/constants/enums/overbooking_status.dart'; // ajusta ruta si es necesario
import '../../../../../data/models/overbooking_model/overbooking_model.dart'; // opcional, para tipos

class OverbookingListScreen extends ConsumerStatefulWidget {
  const OverbookingListScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<OverbookingListScreen> createState() =>
      _OverbookingListScreenState();
}

class _OverbookingListScreenState
    extends ConsumerState<OverbookingListScreen> {
  String _searchQuery = '';
  bool _showOnlyPending = true;

  @override
  void initState() {
    super.initState();
    // cargar pendientes al iniciar
    Future.microtask(() {
      ref.read(overbookingProvider.notifier).fetchPendingRequests();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(overbookingProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Sobreventa'),
        actions: [
          IconButton(
            icon: Icon(
                _showOnlyPending ? Icons.filter_list : Icons.filter_list_off),
            onPressed: () {
              setState(() => _showOnlyPending = !_showOnlyPending);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildStats(state),
          Expanded(child: _buildRequestList(state)),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Buscar por viaje, solicitante...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
        ),
        onChanged: (value) {
          setState(() => _searchQuery = value);
        },
      ),
    );
  }

  Widget _buildStats(OverbookingState state) {
    final pending = state.pendingRequests.length;
    final total = state.requests.length;

    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.purple.withOpacity(0.1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('Pendientes', pending.toString(), Colors.orange),
          _buildStatItem('Total', total.toString(), Colors.purple),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildRequestList(OverbookingState state) {
    final notifier = ref.read(overbookingProvider.notifier);

    if (state.isLoading) {
      return const LoadingIndicator();
    }

    if (state.error != null) {
      return custom.ErrorDisplay(
        message: state.error!,
        onRetry: () => notifier.fetchPendingRequests(),
      );
    }

    var requests = _showOnlyPending ? state.pendingRequests : state.requests;

    if (_searchQuery.isNotEmpty) {
      requests = requests.where((request) {
        final tripInfoMatch = (request.tripInfo ?? '')
            .toLowerCase()
            .contains(_searchQuery.toLowerCase());
        final requesterMatch = (request.requestedByName ?? '')
            .toLowerCase()
            .contains(_searchQuery.toLowerCase());
        return tripInfoMatch || requesterMatch;
      }).toList();
    }

    if (requests.isEmpty) {
      return const Center(child: Text('No se encontraron solicitudes'));
    }

    return RefreshIndicator(
      onRefresh: () => notifier.fetchPendingRequests(),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: requests.length,
        itemBuilder: (context, index) {
          final request = requests[index];
          final status = request.status; // OverbookingStatus

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ExpansionTile(
              leading: CircleAvatar(
                backgroundColor: _getStatusColor(status),
                child: Icon(
                  _getStatusIcon(status),
                  color: Colors.white,
                ),
              ),
              title: Text(
                request.tripInfo ?? 'Viaje #${request.tripId}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text('Solicitado por: ${request.requestedByName ?? '-'}'),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 14, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        request.requestedAt != null
                            ? DateFormatter.formatRelativeTime(request.requestedAt!)
                            : 'Sin fecha',
                        style:
                        TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                      const SizedBox(width: 16),
                      _buildStatusBadge(status),
                    ],
                  ),
                ],
              ),
              trailing: status == OverbookingStatus.PENDING_APPROVAL
                  ? SizedBox(
                width: 100,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.check, color: Colors.green),
                      onPressed: () => _approveRequest(request),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.red),
                      onPressed: () => _rejectRequest(request),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              )
                  : null,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (request.reason != null && request.reason!.isNotEmpty) ...[
                        _buildInfoRow('Razón:', request.reason!),
                        const SizedBox(height: 8),
                      ],
                      _buildInfoRow(
                        'Fecha solicitud:',
                        request.requestedAt != null
                            ? DateFormatter.formatDateTime(request.requestedAt!)
                            : 'Sin fecha',
                      ),
                      const SizedBox(height: 8),
                      _buildInfoRow(
                        'Expira:',
                          request.requestedAt != null
                              ? DateFormatter.formatDateTime(request.requestedAt!)
                              : 'Sin fecha'
                      ),
                      if (request.approvedByName != null) ...[
                        const SizedBox(height: 8),
                        _buildInfoRow('Aprobado por:', request.approvedByName!),
                        const SizedBox(height: 8),
                        if (request.approvedAt != null)
                          _buildInfoRow(
                            'Fecha aprobación:',
                              request.requestedAt != null
                                  ? DateFormatter.formatDateTime(request.approvedAt!)
                                  : 'Sin fecha'
                          ),
                      ],
                      if (request.status == OverbookingStatus.REJECTED &&
                          request.reason != null) ...[
                        const SizedBox(height: 8),
                        _buildInfoRow('Razón rechazo:', request.reason!),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(width: 8),
        Expanded(child: Text(value)),
      ],
    );
  }

  Widget _buildStatusBadge(OverbookingStatus status) {
    final color = _getStatusColor(status);
    String displayText = '';

    switch (status) {
      case OverbookingStatus.PENDING_APPROVAL:
        displayText = 'Pendiente';
        break;
      case OverbookingStatus.APPROVED:
        displayText = 'Aprobado';
        break;
      case OverbookingStatus.REJECTED:
        displayText = 'Rechazado';
        break;
      case OverbookingStatus.EXPIRED:
        displayText = 'Expirado';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        displayText,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Color _getStatusColor(OverbookingStatus status) {
    switch (status) {
      case OverbookingStatus.PENDING_APPROVAL:
        return Colors.orange;
      case OverbookingStatus.APPROVED:
        return Colors.green;
      case OverbookingStatus.REJECTED:
        return Colors.red;
      case OverbookingStatus.EXPIRED:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(OverbookingStatus status) {
    switch (status) {
      case OverbookingStatus.PENDING_APPROVAL:
        return Icons.pending;
      case OverbookingStatus.APPROVED:
        return Icons.check_circle;
      case OverbookingStatus.REJECTED:
        return Icons.cancel;
      case OverbookingStatus.EXPIRED:
        return Icons.timer_off;
    }
  }

  void _approveRequest(OverbookingResponse request) async {
    final notifier = ref.read(overbookingProvider.notifier);
    final userState = ref.read(userProvider);
    final user = userState.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuario no autenticado')),
      );
      return;
    }

    // crear objeto de petición acorde al provider/repository
    final approveReq = OverbookingApproveRequest(notes: null);

    final success = await notifier.approveRequest(request.id, approveReq);

    // leer estado actualizado para error (state.error)
    final newState = ref.read(overbookingProvider);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            success ? 'Solicitud aprobada' : newState.error ?? 'Error al aprobar'),
      ),
    );

    if (success) {
      // refrescar lista
      await notifier.fetchPendingRequests();
    }
  }

  void _rejectRequest(OverbookingResponse request) {
    final reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Rechazar Solicitud'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Indica la razón del rechazo:'),
            const SizedBox(height: 16),
            TextField(
              controller: reasonController,
              decoration: const InputDecoration(
                labelText: 'Razón',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              if (reasonController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Ingresa una razón')),
                );
                return;
              }

              Navigator.pop(context);
              final notifier = ref.read(overbookingProvider.notifier);

              final rejectReq =
              OverbookingRejectRequest(reason: reasonController.text);

              final success =
              await notifier.rejectRequest(request.id, rejectReq);

              final newState = ref.read(overbookingProvider);

              if (!mounted) return;

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(success
                      ? 'Solicitud rechazada'
                      : newState.error ?? 'Error al rechazar'),
                ),
              );

              if (success) {
                await notifier.fetchPendingRequests();
              }
            },
            child: const Text('Rechazar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
