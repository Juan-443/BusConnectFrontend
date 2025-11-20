import 'package:bus_connect/core/constants/app_routes.dart';
import 'package:bus_connect/core/constants/enums/ticket_status.dart';
import 'package:bus_connect/presentation/providers/passenger_tickets_provider.dart';
import 'package:bus_connect/presentation/widgets/ticket_card/ticket_card.dart';
import 'package:bus_connect/data/models/ticket_model/ticket_model.dart'; // ✅ AGREGAR IMPORT
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MyTicketsScreen extends ConsumerStatefulWidget {
  const MyTicketsScreen({super.key});

  @override
  ConsumerState<MyTicketsScreen> createState() => _MyTicketsScreenState();
}

class _MyTicketsScreenState extends ConsumerState<MyTicketsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ticketsAsync = ref.watch(passengerTicketsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Tickets'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Próximos'),
            Tab(text: 'Historial'),
            Tab(text: 'Cancelados'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(passengerTicketsProvider),
          ),
        ],
      ),
      body: ticketsAsync.when(
        data: (tickets) {
          final now = DateTime.now();

          final upcoming = tickets.where((t) {
            if (t.trip == null) return false;

            final tripDate = DateTime.parse(t.trip!.departureAt.toString());
            return tripDate.isAfter(now) && t.status == TicketStatus.SOLD;
          }).toList();

          final past = tickets.where((t) {
            if (t.trip == null) return false;

            final tripDate = DateTime.parse(t.trip!.departureAt.toString());
            return (tripDate.isBefore(now) || t.status == TicketStatus.USED) &&
                t.status != TicketStatus.CANCELLED;
          }).toList();

          final cancelled = tickets.where((t) => t.status == TicketStatus.CANCELLED).toList();

          return TabBarView(
            controller: _tabController,
            children: [
              _buildTicketList(upcoming, 'No tienes tickets próximos'),
              _buildTicketList(past, 'No tienes tickets en el historial'),
              _buildTicketList(cancelled, 'No tienes tickets cancelados'),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                const SizedBox(height: 16),
                const Text(
                  'Error al cargar tickets',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  e.toString(),
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () => ref.invalidate(passengerTicketsProvider),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reintentar'),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppRoutes.passengerTripSearch),
        icon: const Icon(Icons.add),
        label: const Text('Nuevo Ticket'),
      ),
    );
  }

  Widget _buildTicketList(List<TicketResponse> tickets, String emptyMessage) {
    if (tickets.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.confirmation_number_outlined, size: 64, color: Colors.grey[300]),
            const SizedBox(height: 16),
            Text(
              emptyMessage,
              style: TextStyle(color: Colors.grey[600], fontSize: 16),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(passengerTicketsProvider);
        // Esperar un poco para que se vea el indicador
        await Future.delayed(const Duration(milliseconds: 500));
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: tickets.length,
        itemBuilder: (context, index) {
          final ticket = tickets[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: AdminTicketCard(
              ticket: ticket,
              onTap: () => context.push('${AppRoutes.passengerTicketDetail}/${ticket.id}'),
            ),
          );
        },
      ),
    );
  }
}