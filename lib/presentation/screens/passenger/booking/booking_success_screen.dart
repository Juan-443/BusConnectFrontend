import 'package:bus_connect/core/constants/app_routes.dart';
import 'package:bus_connect/presentation/providers/tickets_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';

class BookingSuccessScreen extends ConsumerWidget {
  final int ticketId;

  const BookingSuccessScreen({super.key, required this.ticketId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ticketAsync = ref.watch(ticketDetailProvider(ticketId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Compra Exitosa'),
        automaticallyImplyLeading: false,
      ),
      body: ticketAsync.when(
        data: (ticket) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Success Icon
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle,
                  size: 80,
                  color: Colors.green[600],
                ),
              ),

              const SizedBox(height: 24),

              Text(
                '¡Compra Exitosa!',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Tu ticket ha sido generado',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[600],
                ),
              ),

              const SizedBox(height: 32),

              // QR Code
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      QrImageView(
                        data: ticket.qrCode,
                        version: QrVersions.auto,
                        size: 200.0,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        ticket.qrCode,
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Ticket Details
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Detalles del Ticket',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const Divider(),
                      _DetailRow('Origen', ticket.fromStop?.name ?? 'N/A'),
                      _DetailRow('Destino', ticket.toStop?.name ?? 'N/A'),
                      _DetailRow('Fecha', ticket.trip?.date.toString().substring(0, 10) ?? 'N/A'),
                      _DetailRow('Hora', ticket.trip?.departureAt.toString().substring(11, 16) ?? 'N/A'),
                      _DetailRow('Asiento', ticket.seatNumber),
                      _DetailRow('Precio', '\$${ticket.price.toStringAsFixed(2)}'),
                      _DetailRow('Estado', ticket.status.name),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Action Buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    context.push('${AppRoutes.passengerTicketDetail}/$ticketId');
                  },
                  icon: const Icon(Icons.receipt_long),
                  label: const Text('Ver Ticket Completo'),
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    context.go(AppRoutes.passengerDashboard);
                  },
                  icon: const Icon(Icons.home),
                  label: const Text('Ir al Inicio'),
                ),
              ),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text('Error al cargar el ticket'),
              const SizedBox(height: 8),
              Text(e.toString(), textAlign: TextAlign.center),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.go(AppRoutes.passengerDashboard),
                child: const Text('Volver al inicio'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[600])),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}