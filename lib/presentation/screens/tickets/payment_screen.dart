import 'package:bus_connect/presentation/providers/tickets_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_routes.dart';
import '../../../core/constants/enums/payment_method.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../data/models/ticket_model/ticket_model.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/common/custom_button.dart';

class PaymentScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic> ticketData;

  const PaymentScreen({
    super.key,
    required this.ticketData,
  });

  @override
  ConsumerState<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends ConsumerState<PaymentScreen> {
  PaymentMethod _selectedPaymentMethod = PaymentMethod.CASH;
  bool _isProcessing = false;

  Future<void> _processPayment() async {
    setState(() => _isProcessing = true);

    final authState = ref.read(authProvider);
    final ticketNotifier = ref.read(ticketProvider.notifier);

    // Simular delay de procesamiento
    await Future.delayed(const Duration(seconds: 2));

    // Crear tickets para cada asiento
    bool allSuccess = true;
    final selectedSeats = widget.ticketData['selectedSeats'] as List<String>;

    for (final seat in selectedSeats) {
      final request = TicketCreateRequest(
        tripId: widget.ticketData['tripId'],
        seatNumber: seat,
        fromStopId: 1, // TODO: Obtener de la selección de paradas
        toStopId: 2,
        passengerId: authState.user!.id,
        price: 50.0, // TODO: Calcular precio real
        paymentMethod: _selectedPaymentMethod,
      );

      final success = await ticketNotifier.createTicket(request);
      if (!success) {
        allSuccess = false;
        break;
      }
    }

    setState(() => _isProcessing = false);

    if (!mounted) return;

    if (allSuccess) {
      _showSuccessDialog();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error al procesar el pago'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.success.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle,
                color: AppColors.success,
                size: 64,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              '¡Pago Exitoso!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Tu ticket ha sido generado correctamente',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        actions: [
          CustomButton(
            text: 'Ver Mis Tickets',
            onPressed: () {
              context.go(AppRoutes.myTickets);
            },
            width: double.infinity,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedSeats = widget.ticketData['selectedSeats'] as List<String>;
    final pricePerSeat = 50.0; // TODO: Obtener precio real
    final totalPrice = pricePerSeat * selectedSeats.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Método de Pago'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Order Summary
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Resumen de compra',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Divider(height: 24),
                          _SummaryRow(
                            label: 'Pasajero',
                            value: widget.ticketData['passengerName'],
                          ),
                          const SizedBox(height: 8),
                          _SummaryRow(
                            label: 'CI',
                            value: widget.ticketData['passengerCI'],
                          ),
                          const SizedBox(height: 8),
                          _SummaryRow(
                            label: 'Asientos',
                            value: selectedSeats.join(', '),
                          ),
                          const SizedBox(height: 8),
                          _SummaryRow(
                            label: 'Precio por asiento',
                            value: CurrencyFormatter.format(pricePerSeat),
                          ),
                          const Divider(height: 24),
                          _SummaryRow(
                            label: 'TOTAL',
                            value: CurrencyFormatter.format(totalPrice),
                            isTotal: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Payment Methods
                  const Text(
                    'Método de pago',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  _PaymentMethodTile(
                    method: PaymentMethod.CASH,
                    icon: Icons.money,
                    title: 'Efectivo',
                    subtitle: 'Paga en terminal',
                    isSelected: _selectedPaymentMethod == PaymentMethod.CASH,
                    onTap: () {
                      setState(() => _selectedPaymentMethod = PaymentMethod.CASH);
                    },
                  ),
                  const SizedBox(height: 12),

                  _PaymentMethodTile(
                    method: PaymentMethod.CARD,
                    icon: Icons.credit_card,
                    title: 'Tarjeta',
                    subtitle: 'Débito o crédito',
                    isSelected: _selectedPaymentMethod == PaymentMethod.CARD,
                    onTap: () {
                      setState(() => _selectedPaymentMethod = PaymentMethod.CARD);
                    },
                  ),
                  const SizedBox(height: 12),

                  _PaymentMethodTile(
                    method: PaymentMethod.QR,
                    icon: Icons.qr_code,
                    title: 'QR',
                    subtitle: 'Pago con QR',
                    isSelected: _selectedPaymentMethod == PaymentMethod.QR,
                    onTap: () {
                      setState(() => _selectedPaymentMethod = PaymentMethod.QR);
                    },
                  ),
                  const SizedBox(height: 12),

                  _PaymentMethodTile(
                    method: PaymentMethod.TRANSFER,
                    icon: Icons.account_balance,
                    title: 'Transferencia',
                    subtitle: 'Transferencia bancaria',
                    isSelected: _selectedPaymentMethod == PaymentMethod.TRANSFER,
                    onTap: () {
                      setState(
                              () => _selectedPaymentMethod = PaymentMethod.TRANSFER);
                    },
                  ),
                ],
              ),
            ),
          ),

          // Bottom Button
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total a pagar:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        CurrencyFormatter.format(totalPrice),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    text: 'Confirmar Pago',
                    onPressed: _processPayment,
                    icon: Icons.check_circle,
                    width: double.infinity,
                    isLoading: _isProcessing,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? AppColors.textPrimary : AppColors.textSecondary,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 18 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
            color: isTotal ? AppColors.primary : AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

class _PaymentMethodTile extends StatelessWidget {
  final PaymentMethod method;
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const _PaymentMethodTile({
    required this.method,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.grey300,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
          color: isSelected
              ? AppColors.primary.withOpacity(0.05)
              : AppColors.white,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary.withOpacity(0.1)
                    : AppColors.grey100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: AppColors.primary,
              ),
          ],
        ),
      ),
    );
  }
}