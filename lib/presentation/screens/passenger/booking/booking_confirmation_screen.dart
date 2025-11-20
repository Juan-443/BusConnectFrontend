import 'package:bus_connect/core/constants/app_routes.dart';
import 'package:bus_connect/core/constants/enums/payment_method.dart';
import 'package:bus_connect/presentation/providers/current_user_provider.dart';
import 'package:bus_connect/presentation/providers/passenger.dart';
import 'package:bus_connect/presentation/providers/passenger_booking_provider.dart';
import 'package:bus_connect/presentation/providers/passenger_seat_selection_provider.dart';
import 'package:bus_connect/presentation/providers/fare_rule_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BookingConfirmationScreen extends ConsumerStatefulWidget {
  final int tripId;

  const BookingConfirmationScreen({super.key, required this.tripId});

  @override
  ConsumerState<BookingConfirmationScreen> createState() => _BookingConfirmationScreenState();
}

class _BookingConfirmationScreenState extends ConsumerState<BookingConfirmationScreen> {
  PaymentMethod selectedPaymentMethod = PaymentMethod.CASH;
  bool acceptTerms = false;

  @override
  Widget build(BuildContext context) {
    final tripAsync = ref.watch(tripDetailsProvider(widget.tripId));
    final bookingState = ref.watch(passengerBookingProvider);
    final currentUser = ref.watch(currentUserProvider);
    final selectedSeat = ref.watch(selectedSeatProvider);
    final fromStopId = ref.watch(selectedFromStopProvider);
    final toStopId = ref.watch(selectedToStopProvider);

    ref.listen<BookingState>(passengerBookingProvider, (previous, next) {
      if (next.error != null && next.error!.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error!), backgroundColor: Colors.red),
        );
      }

      if (next.createdTicket != null && previous?.createdTicket == null) {
        // Limpiar selecciones
        ref.read(selectedSeatProvider.notifier).state = null;
        ref.read(selectedFromStopProvider.notifier).state = null;
        ref.read(selectedToStopProvider.notifier).state = null;

        // Navegar a éxito
        context.go('${AppRoutes.passengerBookingSuccess}/${next.createdTicket!.id}');
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirmar Reserva'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Trip Summary
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: tripAsync.when(
                  data: (trip) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Resumen del Viaje',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const Divider(),
                      _SummaryRow('Ruta', '${trip.origin} → ${trip.destination}'),
                      _SummaryRow('Fecha', trip.date.toString().substring(0, 10)),
                      _SummaryRow('Hora', trip.departureAt.toString().substring(11, 16)),
                      _SummaryRow('Asiento', selectedSeat ?? '-'),
                      _SummaryRow('Bus', trip.busPlate ?? '-'),
                    ],
                  ),
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Text('Error: $e'),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Passenger Info
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Información del Pasajero',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Divider(),
                    if (currentUser.isAuthenticated) ...[
                      _SummaryRow('Nombre', currentUser.userName ?? '-'),
                      _SummaryRow('Email', currentUser.userEmail ?? '-'),
                    ] else
                      const Text('Usuario no autenticado'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Price Details
            _buildPriceCard(tripAsync, fromStopId, toStopId),

            const SizedBox(height: 16),

            // Payment Method
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Método de Pago',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Divider(),
                    RadioListTile<PaymentMethod>(
                      title: const Text('Efectivo'),
                      subtitle: const Text('Pagar en efectivo al conductor'),
                      value: PaymentMethod.CASH,
                      groupValue: selectedPaymentMethod,
                      onChanged: (value) {
                        setState(() => selectedPaymentMethod = value!);
                      },
                    ),
                    RadioListTile<PaymentMethod>(
                      title: const Text('Tarjeta'),
                      subtitle: const Text('Pago con tarjeta de débito/crédito'),
                      value: PaymentMethod.CARD,
                      groupValue: selectedPaymentMethod,
                      onChanged: (value) {
                        setState(() => selectedPaymentMethod = value!);
                      },
                    ),
                    RadioListTile<PaymentMethod>(
                      title: const Text('Transferencia'),
                      subtitle: const Text('Transferencia bancaria'),
                      value: PaymentMethod.TRANSFER,
                      groupValue: selectedPaymentMethod,
                      onChanged: (value) {
                        setState(() => selectedPaymentMethod = value!);
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Terms and Conditions
            CheckboxListTile(
              title: const Text('Acepto los términos y condiciones'),
              value: acceptTerms,
              onChanged: (value) {
                setState(() => acceptTerms = value ?? false);
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),

            const SizedBox(height: 24),

            // Confirm Button
            _buildConfirmButton(currentUser, selectedSeat, fromStopId, toStopId, bookingState),

            if (bookingState.currentHold != null) ...[
              const SizedBox(height: 16),
              _buildHoldTimer(bookingState.currentHold!.minutesLeft ?? 0),
            ],
          ],
        ),
      ),
    );
  }

  /// ==================== WIDGETS PRIVADOS ====================

  Widget _buildPriceCard(AsyncValue tripAsync, int? fromStopId, int? toStopId) {
    // Tarifa por defecto
    double baseFare = 10.0;

    // Si hay datos del trip y stops seleccionados, intentar obtener la tarifa
    if (tripAsync.hasValue && fromStopId != null && toStopId != null) {
      final trip = tripAsync.value!;

      // ✅ Usar FareRuleNotifier para obtener la tarifa
      // Esta es una aproximación, ajusta según tu lógica
      return FutureBuilder<double>(
        future: _calculateFare(trip.routeId ?? 0, fromStopId, toStopId),
        builder: (context, snapshot) {
          final fare = snapshot.data ?? baseFare;

          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Detalle de Precio',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Divider(),
                  _SummaryRow('Tarifa Base', '\$${fare.toStringAsFixed(2)}'),
                  _SummaryRow('Descuento', '\$0.00'),
                  const Divider(),
                  _SummaryRow(
                    'Total',
                    '\$${fare.toStringAsFixed(2)}',
                    isTotal: true,
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    // Fallback
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Detalle de Precio',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Divider(),
            _SummaryRow('Tarifa Base', '\$${baseFare.toStringAsFixed(2)}'),
            _SummaryRow('Descuento', '\$0.00'),
            const Divider(),
            _SummaryRow(
              'Total',
              '\$${baseFare.toStringAsFixed(2)}',
              isTotal: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConfirmButton(
      CurrentUserState currentUser,
      String? selectedSeat,
      int? fromStopId,
      int? toStopId,
      BookingState bookingState,
      ) {
    final canProceed = acceptTerms &&
        !bookingState.isLoading &&
        currentUser.isAuthenticated &&
        selectedSeat != null &&
        fromStopId != null &&
        toStopId != null;

    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: canProceed
            ? () => _handleConfirmBooking(currentUser, selectedSeat, fromStopId, toStopId)
            : null,
        child: bookingState.isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text(
          'Confirmar Compra',
          style: TextStyle(fontSize: 18),
       ),
      ),
    );
  }

// ✅ Método separado para manejar la confirmación
  Future<void> _handleConfirmBooking(
      CurrentUserState currentUser,
      String selectedSeat,
      int fromStopId,
      int toStopId,
      ) async {
    try {
      // Obtener trip y calcular precio
      final trip = await ref.read(tripDetailsProvider(widget.tripId).future);
      final fare = await _calculateFare(trip.routeId , fromStopId, toStopId);

      // Crear ticket
      await ref.read(passengerBookingProvider.notifier).createTicket(
        tripId: widget.tripId,
        passengerId: currentUser.userId!,
        fromStopId: fromStopId,
        toStopId: toStopId,
        seatNumber: selectedSeat,
        price: fare,
        paymentMethod: selectedPaymentMethod,
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al procesar la reserva: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Widget _buildHoldTimer(int minutesLeft) {
    final isExpiringSoon = minutesLeft <= 2;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isExpiringSoon ? Colors.red.shade50 : Colors.orange.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isExpiringSoon ? Colors.red : Colors.orange,
          width: 2,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isExpiringSoon ? Icons.warning : Icons.timer,
            color: isExpiringSoon ? Colors.red : Colors.orange,
          ),
          const SizedBox(width: 8),
          Text(
            'Tiempo restante: $minutesLeft minutos',
            style: TextStyle(
              color: isExpiringSoon ? Colors.red.shade700 : Colors.orange.shade700,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  /// ==================== HELPERS ====================

  Future<double> _calculateFare(int routeId, int fromStopId, int toStopId) async {
    try {
      // ✅ Usar el notifier para obtener la tarifa
      await ref.read(fareRuleProvider.notifier).fetchFareRuleForSegment(
        routeId: routeId,
        fromStopId: fromStopId,
        toStopId: toStopId,
      );

      final fareState = ref.read(fareRuleProvider);
      return fareState.selectedFareRule?.basePrice ?? 10.0;
    } catch (e) {
      return 10.0; // Fallback
    }
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;

  const _SummaryRow(
      this.label,
      this.value, {
        this.isTotal = false,
      });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 18 : 14,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
              fontSize: isTotal ? 20 : 14,
              color: isTotal ? Theme.of(context).primaryColor : null,
            ),
          ),
        ],
      ),
    );
  }
}