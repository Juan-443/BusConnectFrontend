import 'package:bus_connect/core/constants/enums/ticket_status.dart';
import 'package:bus_connect/data/models/ticket_model/ticket_model.dart';
import 'package:bus_connect/data/models/ticket_model/ticket_model_extensions.dart';
import 'package:bus_connect/presentation/providers/passenger_tickets_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../providers/current_user_provider.dart';

class PassengerDashboardScreen extends ConsumerWidget {
  const PassengerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    final ticketsAsync = ref.watch(passengerTicketsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Panel de Pasajero'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => context.push(AppRoutes.passengerProfile),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(currentUserProvider.notifier).refresh();
          if (ref.read(currentUserProvider).isAuthenticated) {
            ref.invalidate(passengerTicketsProvider);
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildWelcomeHeader(context, currentUser),

              const SizedBox(height: 24),

              // Quick Actions
              Row(
                children: [
                  Expanded(
                    child: _QuickActionCard(
                      icon: Icons.search,
                      title: 'Buscar Viajes',
                      color: Colors.blue,
                      onTap: () => context.push(AppRoutes.passengerTripSearch),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _QuickActionCard(
                      icon: Icons.confirmation_number,
                      title: 'Mis Tickets',
                      color: Colors.green,
                      onTap: () => context.push(AppRoutes.passengerMyTickets),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: _QuickActionCard(
                      icon: Icons.local_shipping,
                      title: 'Rastrear Encomienda',
                      color: Colors.orange,
                      onTap: () => context.push(AppRoutes.passengerParcelTracking),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _QuickActionCard(
                      icon: Icons.report_problem,
                      title: 'Reportar',
                      color: Colors.red,
                      onTap: () => context.push(AppRoutes.passengerIncidentReport),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Upcoming Tickets
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Próximos Viajes',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  TextButton(
                    onPressed: () => context.push(AppRoutes.passengerMyTickets),
                    child: const Text('Ver todos'),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              ticketsAsync.when(
                data: (tickets) {

                  if (tickets.isEmpty) {
                    return _buildEmptyTicketsCard(context);
                  }

                  final upcoming = tickets.where((ticket) {
                    try {
                      if (ticket.trip?.date == null) return false;

                      return ticket.trip!.date.isAfter(DateTime.now()) &&
                          ticket.status == TicketStatus.SOLD;
                    } catch (e) {
                      return false;
                    }
                  }).take(3).toList();

                  if (upcoming.isEmpty) {
                    return _buildEmptyTicketsCard(context);
                  }
                  return Column(
                    children: upcoming.map((ticket) =>
                        _UpcomingTicketCard(ticket: ticket)
                    ).toList(),
                  );
                },
                loading: () {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(32),
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
                error: (e, stack) {
                return _buildEmptyTicketsCard(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeHeader(BuildContext context, CurrentUserState currentUser) {
    if (currentUser.isLoading) {
      return const LinearProgressIndicator();
    }

    if (!currentUser.isAuthenticated) {
      return Card(
        color: Colors.orange[50],
        child: const Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(Icons.warning, color: Colors.orange),
              SizedBox(width: 12),
              Expanded(
                child: Text('No estás autenticado'),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bienvenido,',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          currentUser.userName ?? 'Usuario',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyTicketsCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Icon(
              Icons.confirmation_number_outlined,
              size: 64,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 16),
            Text(
              'No tienes viajes próximos',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Busca y reserva tu próximo viaje',
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => context.push(AppRoutes.passengerTripSearch),
              icon: const Icon(Icons.search),
              label: const Text('Buscar Viajes'),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [
                color.withValues(alpha: 0.1),
                color.withValues(alpha: 0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: [
              Icon(icon, size: 36, color: color),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UpcomingTicketCard extends StatelessWidget {
  final TicketResponse ticket;

  const _UpcomingTicketCard({required this.ticket});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: InkWell(
        onTap: () => context.push('${AppRoutes.passengerTicketDetail}/${ticket.id}'),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.directions_bus, color: Colors.blue),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${ticket.fromStopName} → ${ticket.toStopName}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.calendar_today, size: 14, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          '${ticket.tripDate} - ${ticket.tripTime}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.green),
                    ),
                    child: Text(
                      'Asiento ${ticket.seatNumber}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${ticket.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}