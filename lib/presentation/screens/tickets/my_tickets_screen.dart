import 'package:bus_connect/presentation/providers/tickets_provider.dart';
import 'package:bus_connect/presentation/screens/tickets/ticket_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_routes.dart';
import '../../widgets/common/loading_indicator.dart';
import '../../widgets/common/error_widget.dart';

class MyTicketsScreen extends ConsumerStatefulWidget {
  const MyTicketsScreen({super.key});

  @override
  ConsumerState<MyTicketsScreen> createState() => _MyTicketsScreenState();
}

class _MyTicketsScreenState extends ConsumerState<MyTicketsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    // Cargar tickets
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(ticketProvider.notifier).loadMyTickets();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ticketState = ref.watch(ticketProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Tickets'),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textSecondary,
          indicatorColor: AppColors.primary,
          tabs: const [
            Tab(text: 'Activos'),
            Tab(text: 'Usados'),
            Tab(text: 'Cancelados'),
          ],
        ),
      ),
      body: ticketState.isLoading
          ? const LoadingIndicator(message: 'Cargando tickets...')
          : ticketState.error != null
          ? ErrorDisplay(
        message: ticketState.error!,
        onRetry: () {
          ref.read(ticketProvider.notifier).loadMyTickets();
        },
      )
          : TabBarView(
        controller: _tabController,
        children: [
          _TicketList(
            tickets: ticketState.tickets
                .where((t) => t.status.name == 'SOLD')
                .toList(),
            emptyMessage: 'No tienes tickets activos',
          ),
          _TicketList(
            tickets: ticketState.tickets
                .where((t) => t.status.name == 'USED')
                .toList(),
            emptyMessage: 'No tienes tickets usados',
          ),
          _TicketList(
            tickets: ticketState.tickets
                .where((t) => t.status.name == 'CANCELLED')
                .toList(),
            emptyMessage: 'No tienes tickets cancelados',
          ),
        ],
      ),
    );
  }
}

class _TicketList extends StatelessWidget {
  final List tickets;
  final String emptyMessage;

  const _TicketList({
    required this.tickets,
    required this.emptyMessage,
  });

  @override
  Widget build(BuildContext context) {
    if (tickets.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.confirmation_number_outlined,
              size: 64,
              color: AppColors.grey400,
            ),
            const SizedBox(height: 16),
            Text(
              emptyMessage,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        // Implementar refresh
      },
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: tickets.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final ticket = tickets[index];
          return TicketCard(
            ticket: ticket,
            onTap: () {
              context.push('${AppRoutes.ticketDetail}/${ticket.id}');
            },
          );
        },
      ),
    );
  }
}