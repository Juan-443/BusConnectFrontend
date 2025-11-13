import 'package:bus_connect/presentation/providers/tickets_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../widgets/common/loading_indicator.dart';
import '../../widgets/common/error_widget.dart';
import '../../widgets/common/custom_button.dart';



class TicketDetailScreen extends ConsumerWidget {
  final int ticketId;

  const TicketDetailScreen({
    super.key,
    required this.ticketId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ticketAsync = ref.watch(ticketDetailProvider(ticketId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del Ticket'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // TODO: Implementar compartir
            },
          ),
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
              // TODO: Implementar descarga
            },
          ),
        ],
      ),
      body: ticketAsync.when(
        data: (ticket) => SingleChildScrollView(
          child: Column(
            children: [
              // QR Code Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(32),
                color: AppColors.white,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: QrImageView(
                        data: ticket.qrCode,
                        version: QrVersions.auto,
                        size: 200,
                        backgroundColor: AppColors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Código: ${ticket.qrCode}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
              ),

              // Ticket Info Card
              Padding(
                padding: const EdgeInsets.all(16),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                ticket.trip?.route?.name ?? 'Ruta',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                'Asiento ${ticket.seatNumber}',
                                style: const TextStyle(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Route
                        _InfoRow(
                          icon: Icons.location_on,
                          label: 'Origen',
                          value: ticket.fromStop?.name ?? 'N/A',
                        ),
                        const SizedBox(height: 16),
                        _InfoRow(
                          icon: Icons.location_on_outlined,
                          label: 'Destino',
                          value: ticket.toStop?.name ?? 'N/A',
                        ),
                        const Divider(height: 32),

                        // Date and Time
                        if (ticket.trip != null) ...[
                          _InfoRow(
                            icon: Icons.calendar_today,
                            label: 'Fecha de viaje',
                            value: DateFormatter.formatDateTime(
                             ticket.trip!.departureAt,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _InfoRow(
                            icon: Icons.access_time,
                            label: 'Hora de salida',
                            value: DateFormatter.formatTime(
                              ticket.trip!.departureAt,
                            ),
                          ),
                          const Divider(height: 32),
                        ],

                        // Bus Info
                        if (ticket.trip?.bus != null) ...[
                          _InfoRow(
                            icon: Icons.directions_bus,
                            label: 'Bus',
                            value: ticket.trip!.bus!.plate,
                          ),
                          const Divider(height: 32),
                        ],

                        // Payment Info
                        _InfoRow(
                          icon: Icons.payment,
                          label: 'Método de pago',
                          value: ticket.paymentMethod.displayName,
                        ),
                        const SizedBox(height: 16),
                        _InfoRow(
                          icon: Icons.attach_money,
                          label: 'Precio',
                          value: CurrencyFormatter.format(ticket.price),
                        ),
                        if (ticket.discountAmount != null &&
                            ticket.discountAmount! > 0) ...[
                          const SizedBox(height: 16),
                          _InfoRow(
                            icon: Icons.discount,
                            label: 'Descuento',
                            value: CurrencyFormatter.format(ticket.discountAmount!),
                            valueColor: AppColors.success,
                          ),
                        ],
                        const Divider(height: 32),

                        // Purchase Date
                        _InfoRow(
                          icon: Icons.receipt,
                          label: 'Fecha de compra',
                          value: DateFormatter.formatDateTime(
                            DateTime.parse(ticket.createdAt),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Action Buttons
              if (ticket.status.name == 'SOLD') ...[
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      CustomButton(
                        text: 'Cancelar Ticket',
                        onPressed: () => _showCancelDialog(context, ref),
                        backgroundColor: AppColors.error,
                        icon: Icons.cancel,
                        width: double.infinity,
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.warning.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.warning.withOpacity(0.3),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: AppColors.warning,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Cancela con 24h de anticipación para reembolso completo',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.warning,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
        loading: () => const LoadingIndicator(message: 'Cargando ticket...'),
        error: (error, _) => ErrorDisplay(message: error.toString()),
      ),
    );
  }

  void _showCancelDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancelar Ticket'),
        content: const Text(
          '¿Estás seguro que deseas cancelar este ticket? Esta acción no se puede deshacer.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);

              final success = await ref
                  .read(ticketProvider.notifier)
                  .cancelTicket(ticketId);

              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      success
                          ? 'Ticket cancelado exitosamente'
                          : 'Error al cancelar ticket',
                    ),
                    backgroundColor: success ? AppColors.success : AppColors.error,
                  ),
                );

                if (success) {
                  Navigator.pop(context);
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
            ),
            child: const Text('Sí, cancelar'),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: AppColors.primary),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: valueColor ?? AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}