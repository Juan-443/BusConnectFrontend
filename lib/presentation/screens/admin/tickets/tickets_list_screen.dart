import 'package:bus_connect/core/constants/enums/ticket_status.dart';
import 'package:bus_connect/data/models/ticket_model/ticket_model.dart';
import 'package:bus_connect/presentation/providers/tickets_provider.dart';
import 'package:bus_connect/presentation/widgets/ticket_card/ticket_card.dart';
import 'package:bus_connect/presentation/widgets/ticket_card/ticket_filters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminTicketsListScreen extends ConsumerStatefulWidget {
  const AdminTicketsListScreen({super.key});

  @override
  ConsumerState<AdminTicketsListScreen> createState() =>
      _AdminTicketsListScreenState();
}

class _AdminTicketsListScreenState
    extends ConsumerState<AdminTicketsListScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    Future.microtask(
          () => ref.read(ticketProvider.notifier).loadAllTickets(),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(ticketProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Tickets'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilters(context),
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () =>
                ref.read(ticketProvider.notifier).loadAllTickets(),
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
                hintText: 'Buscar por pasajero, QR, ID...',
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

          // Estadísticas rápidas
          _buildQuickStats(state.tickets),

          // Lista de tickets
          Expanded(
            child: state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : state.error != null
                ? _buildError(state.error!)
                : _buildTicketsList(state.tickets),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats(List<TicketResponse> tickets) {
    final sold = tickets.where((t) => t.status == TicketStatus.SOLD).length;
    final used = tickets.where((t) => t.status == TicketStatus.USED).length;
    final cancelled = tickets.where((t) => t.status == TicketStatus.CANCELLED).length;
    final noShow = tickets.where((t) => t.status == TicketStatus.NO_SHOW).length;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.blue.shade50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatChip('Vendidos', sold, Colors.green),
          _buildStatChip('Usados', used, Colors.blue),
          _buildStatChip('Cancelados', cancelled, Colors.red),
          _buildStatChip('No Show', noShow, Colors.orange),
        ],
      ),
    );
  }

  Widget _buildStatChip(String label, int count, Color color) {
    return Column(
      children: [
        Text(
          count.toString(),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Colors.grey),
        ),
      ],
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
            'Error al cargar tickets',
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
                ref.read(ticketProvider.notifier).loadAllTickets(),
            icon: const Icon(Icons.refresh),
            label: const Text('Reintentar'),
          ),
        ],
      ),
    );
  }

  Widget _buildTicketsList(List<TicketResponse> tickets) {
    var filteredTickets = tickets;

    if (_searchQuery.isNotEmpty) {
      filteredTickets = filteredTickets.where((ticket) {
        final query = _searchQuery.toLowerCase();
        return ticket.qrCode.toLowerCase().contains(query) ||
            ticket.id.toString().contains(query) ||
            ticket.seatNumber.toLowerCase().contains(query) ||
            ticket.passengerId.toString().contains(query);
      }).toList();
    }

    // Filtro de estado
    final filterStatus = ref.read(ticketProvider).filterStatus;
    if (filterStatus != null) {
      filteredTickets = filteredTickets
          .where((ticket) => ticket.status == filterStatus)
          .toList();
    }

    if (filteredTickets.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _searchQuery.isEmpty
                  ? Icons.confirmation_number_outlined
                  : Icons.search_off,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              _searchQuery.isEmpty
                  ? 'No hay tickets registrados'
                  : 'No se encontraron tickets',
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () =>
          ref.read(ticketProvider.notifier).loadAllTickets(),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: filteredTickets.length,
        itemBuilder: (context, index) {
          final ticket = filteredTickets[index];
          return AdminTicketCard(
            ticket: ticket,
            onTap: () => _showTicketDetails(ticket),
            onCancel: ticket.status == TicketStatus.SOLD
                ? () => _confirmCancelTicket(ticket.id, 'pajero ${ticket.passengerId}')
                : null,
            onDelete: () => _confirmDeleteTicket(ticket.id, 'Pasajero ${ticket.passengerId}'),
          );
        },
      ),
    );
  }

  void _showFilters(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => TicketFilters(
        currentStatus: ref.read(ticketProvider).filterStatus,
        onStatusChanged: (status) {
          ref.read(ticketProvider.notifier).filterByStatus(status);
          Navigator.pop(ctx);
        },
        onClearFilters: () {
          ref.read(ticketProvider.notifier).loadAllTickets();
          Navigator.pop(ctx);
        },
      ),
    );
  }

  void _showTicketDetails(TicketResponse ticket) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(24),
          child: ListView(
            controller: scrollController,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.confirmation_number,
                    size: 32,
                    color: _getStatusColor(ticket.status.name),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'Ticket #${ticket.id}',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(ctx),
                  ),
                ],
              ),
              const Divider(height: 32),

              _buildDetailItem(
                icon: Icons.person,
                label: 'Pasajero',
                value: 'ID: ${ticket.passengerId}',
              ),
              const SizedBox(height: 16),

              _buildDetailItem(
                icon: Icons.event_seat,
                label: 'Asiento',
                value: ticket.seatNumber,
              ),
              const SizedBox(height: 16),

              _buildDetailItem(
                icon: Icons.attach_money,
                label: 'Precio',
                value: '\$${ticket.price.toStringAsFixed(2)}',
              ),
              const SizedBox(height: 16),

              _buildDetailItem(
                icon: Icons.info,
                label: 'Estado',
                value: ticket.status.name,
              ),
              const SizedBox(height: 16),

              _buildDetailItem(
                icon: Icons.qr_code,
                label: 'Código QR',
                value: ticket.qrCode,
              ),
              const SizedBox(height: 16),

              _buildDetailItem(
                icon: Icons.route,
                label: 'Ruta',
                value: '${ticket.fromStop?.name ?? 'N/A'} → ${ticket.toStop?.name ?? 'N/A'}',
              ),
              const SizedBox(height: 16),

              _buildDetailItem(
                icon: Icons.calendar_today,
                label: 'Fecha de compra',
                value: _formatDateTime(ticket.createdAt),
              ),

              const SizedBox(height: 24),

              if (ticket.status == TicketStatus.SOLD) ...[
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(ctx);
                    _confirmCancelTicket(ticket.id, 'Pasajero ${ticket.passengerId}');
                  },
                  icon: const Icon(Icons.cancel),
                  label: const Text('Cancelar Ticket'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
              ],

              OutlinedButton.icon(
                onPressed: () {
                  Navigator.pop(ctx);
                  _confirmDeleteTicket(ticket.id, 'Pasajero ${ticket.passengerId}'); // ✅ Cambiar
                },
                icon: const Icon(Icons.delete),
                label: const Text('Eliminar Ticket'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.blue),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _confirmCancelTicket(int id, String? passengerName) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Cancelar Ticket'),
        content: Text(
          '¿Cancelar el ticket del pasajero "${passengerName ?? 'N/A'}"?\n\nSe procesará el reembolso según la política.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('No'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
            ),
            child: const Text('Cancelar Ticket'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      final success =
      await ref.read(ticketProvider.notifier).cancelTicket(id);
      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ticket cancelado exitosamente')),
        );
      }
    }
  }

  Future<void> _confirmDeleteTicket(int id, String? passengerName) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirmar eliminación'),
        content: Text(
          '¿Eliminar permanentemente el ticket del pasajero "${passengerName ?? 'N/A'}"?\n\n⚠️ Esta acción no se puede deshacer.',
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
      await ref.read(ticketProvider.notifier).deleteTicket(id);
      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ticket eliminado exitosamente')),
        );
      }
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'SOLD':
        return Colors.green;
      case 'USED':
        return Colors.blue;
      case 'CANCELLED':
        return Colors.red;
      case 'NO SHOW':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  String _formatDateTime(String? dateTimeStr) {
    if (dateTimeStr == null) return 'N/A';
    try {
      final dateTime = DateTime.parse(dateTimeStr);
      return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return dateTimeStr;
    }
  }
}