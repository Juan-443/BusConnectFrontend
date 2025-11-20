import 'package:bus_connect/presentation/providers/passenger_baggage_provider.dart';
import 'package:bus_connect/presentation/providers/passenger_tickets_provider.dart';
import 'package:bus_connect/presentation/widgets/common/error_widget.dart';
import 'package:bus_connect/presentation/widgets/common/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

class TicketDetailScreen extends ConsumerWidget {
  final int ticketId;

  const TicketDetailScreen({super.key, required this.ticketId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ticketAsync = ref.watch(ticketDetailProvider(ticketId));
    final baggageAsync = ref.watch(ticketBaggageProvider(ticketId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del Ticket'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              ticketAsync.whenData((ticket) {
                SharePlus.instance.share(
                  ShareParams(
                    text: 'Mi ticket para ${ticket.fromStop?.name ?? 'N/A'} → ${ticket.toStop?.name ?? 'N/A'}\n'
                        'Fecha: ${ticket.trip?.date.toString().substring(0, 10) ?? 'N/A'}\n'
                        'Hora: ${ticket.trip?.departureAt.toString().substring(11, 16) ?? 'N/A'}\n'
                        'Asiento: ${ticket.seatNumber}\n'
                        'QR: ${ticket.qrCode}',
                  ),
                );
              });
            },
          ),
        ],
      ),
      body: ticketAsync.when(
        data: (ticket) => SingleChildScrollView(
          child: Column(
            children: [
              _buildStatusBanner(context, ticket.status.name),

              // QR Code Section
              Container(
                padding: const EdgeInsets.all(24),
                color: Colors.white,
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: QrImageView(
                          data: ticket.qrCode,
                          version: QrVersions.auto,
                          size: 220.0,
                          backgroundColor: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        ticket.qrCode,
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 12,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // Route Section
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ORIGEN',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            ticket.fromStop?.name ?? 'N/A',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: Theme.of(context).primaryColor,
                      size: 32,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'DESTINO',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            ticket.toStop?.name ?? 'N/A',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Trip Details
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Detalles del Viaje',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Divider(height: 24),
                    _DetailRow(
                      icon: Icons.calendar_today,
                      label: 'Fecha',
                      value: ticket.trip?.date.toString().substring(0, 10) ?? 'N/A',
                    ),
                    const SizedBox(height: 12),
                    _DetailRow(
                      icon: Icons.access_time,
                      label: 'Hora',
                      value: ticket.trip?.departureAt.toString().substring(11, 16) ?? 'N/A',
                    ),
                    const SizedBox(height: 12),
                    _DetailRow(
                      icon: Icons.event_seat,
                      label: 'Asiento',
                      value: ticket.seatNumber,
                      highlighted: true,
                    ),
                   ],
                ),
              ),

              const SizedBox(height: 16),

              // Payment Details
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Información de Pago',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Divider(height: 24),
                    _DetailRow(
                      icon: Icons.payment,
                      label: 'Método de Pago',
                      value: _getPaymentMethodText(ticket.paymentMethod.name),
                    ),
                    const SizedBox(height: 12),
                    _DetailRow(
                      icon: Icons.attach_money,
                      label: 'Precio',
                      value: '\$${ticket.price.toStringAsFixed(2)}',
                      highlighted: true,
                    ),
                    if (ticket.refundAmount != null && ticket.refundAmount! > 0) ...[
                      const SizedBox(height: 12),
                      _DetailRow(
                        icon: Icons.money_off,
                        label: 'Reembolso',
                        value: '\$${ticket.refundAmount!.toStringAsFixed(2)}',
                        valueColor: Colors.green,
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Baggage Section
              baggageAsync.when(
                data: (baggageList) {
                  if (baggageList.isEmpty) {
                    return const SizedBox.shrink();
                  }

                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.luggage, color: Theme.of(context).primaryColor),
                            const SizedBox(width: 8),
                            Text(
                              'Equipaje Registrado',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                        const Divider(height: 24),
                        ...baggageList.map((baggage) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${baggage.weightKg} kg'),
                              Text(
                                '\$${baggage.fee.toStringAsFixed(2)}',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )),
                      ],
                    ),
                  );
                },
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
              ),

              const SizedBox(height: 24),

              // Action Buttons
              if (ticket.status.name == 'SOLD') ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            _showAddBaggageDialog(context, ref, ticketId);
                          },
                          icon: const Icon(Icons.luggage),
                          label: const Text('Agregar Equipaje'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(16),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            _showCancelTicketDialog(context, ref, ticketId);
                          },
                          icon: const Icon(Icons.cancel, color: Colors.red),
                          label: const Text(
                            'Cancelar Ticket',
                            style: TextStyle(color: Colors.red),
                          ),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.all(16),
                            side: const BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 24),
            ],
          ),
        ),
        loading: () => const LoadingIndicator(),
        error: (e, st) => ErrorDisplay(
          message: 'Error al cargar el ticket',
          onRetry: () => ref.invalidate(ticketDetailProvider(ticketId)),
        ),
      ),
    );
  }

  Widget _buildStatusBanner(BuildContext context, String status) {
    Color backgroundColor;
    Color textColor;
    IconData icon;
    String text;

    switch (status.toUpperCase()) {
      case 'SOLD':
        backgroundColor = Colors.green[50]!;
        textColor = Colors.green[700]!;
        icon = Icons.check_circle;
        text = 'Activo';
        break;
      case 'USED':
        backgroundColor = Colors.blue[50]!;
        textColor = Colors.blue[700]!;
        icon = Icons.done_all;
        text = 'Usado';
        break;
      case 'CANCELLED':
        backgroundColor = Colors.red[50]!;
        textColor = Colors.red[700]!;
        icon = Icons.cancel;
        text = 'Cancelado';
        break;
      case 'NO_SHOW':
        backgroundColor = Colors.orange[50]!;
        textColor = Colors.orange[700]!;
        icon = Icons.warning;
        text = 'No Presentado';
        break;
      default:
        backgroundColor = Colors.grey[50]!;
        textColor = Colors.grey[700]!;
        icon = Icons.info;
        text = status;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      color: backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: textColor, size: 20),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  String _getPaymentMethodText(String method) {
    switch (method.toUpperCase()) {
      case 'CASH':
        return 'Efectivo';
      case 'CARD':
        return 'Tarjeta';
      case 'TRANSFER':
        return 'Transferencia';
      default:
        return method;
    }
  }

  void _showAddBaggageDialog(BuildContext context, WidgetRef ref, int ticketId) {
    final weightController = TextEditingController();
    double? calculatedFee;

    showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Agregar Equipaje'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: weightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Peso (kg)',
                  border: OutlineInputBorder(),
                  suffixText: 'kg',
                ),
                onChanged: (value) async {
                  final weight = double.tryParse(value);
                  if (weight != null && weight > 0) {
                    try {
                      final fee = await ref.read(baggageFeeCalculatorProvider(weight).future);
                      setState(() => calculatedFee = fee);
                    } catch (e) {
                      setState(() => calculatedFee = null);
                    }
                  } else {
                    setState(() => calculatedFee = null);
                  }
                },
              ),
              const SizedBox(height: 16),
              if (calculatedFee != null)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Cargo por equipaje:'),
                      Text(
                        '\$${calculatedFee!.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: calculatedFee == null
                  ? null
                  : () async {
                final weight = double.parse(weightController.text);
                await ref.read(addBaggageProvider.notifier).addBaggage(
                  ticketId: ticketId,
                  weightKg: weight,
                  fee: calculatedFee!,
                );

                if (dialogContext.mounted) {
                  Navigator.pop(dialogContext);
                  ref.invalidate(ticketBaggageProvider(ticketId));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Equipaje agregado exitosamente')),
                  );
                }
              },
              child: const Text('Agregar'),
            ),
          ],
        ),
      ),
    );
  }

  void _showCancelTicketDialog(BuildContext context, WidgetRef ref, int ticketId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancelar Ticket'),
        content: const Text(
          '¿Estás seguro que deseas cancelar este ticket?\n\n'
              'El reembolso dependerá de la política de cancelación.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);

              await ref.read(cancelTicketProvider.notifier).cancelTicket(ticketId);

              final state = ref.read(cancelTicketProvider);

              if (context.mounted) {
                state.when(
                  data: (_) {
                    ref.invalidate(ticketDetailProvider(ticketId));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Ticket cancelado exitosamente'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  loading: () {},
                  error: (e, _) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error: $e'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  },
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Sí, Cancelar'),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool highlighted;
  final Color? valueColor;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
    this.highlighted = false,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: highlighted ? FontWeight.bold : FontWeight.w500,
            fontSize: highlighted ? 18 : 14,
            color: valueColor ?? (highlighted ? Theme.of(context).primaryColor : null),
          ),
        ),
      ],
    );
  }
}