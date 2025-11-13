import 'package:bus_connect/presentation/providers/trips_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_routes.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/loading_indicator.dart';
import '../../widgets/common/error_widget.dart';
import '../../widgets/seat_selector/seat_map_widget.dart';

class SelectSeatsScreen extends ConsumerStatefulWidget {
  final int tripId;

  const SelectSeatsScreen({
    super.key,
    required this.tripId,
  });

  @override
  ConsumerState<SelectSeatsScreen> createState() => _SelectSeatsScreenState();
}

class _SelectSeatsScreenState extends ConsumerState<SelectSeatsScreen> {
  final Set<String> _selectedSeats = {};

  void _toggleSeat(String seatNumber) {
    setState(() {
      if (_selectedSeats.contains(seatNumber)) {
        _selectedSeats.remove(seatNumber);
      } else {
        if (_selectedSeats.length < 5) {
          // Máximo 5 asientos
          _selectedSeats.add(seatNumber);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Máximo 5 asientos por compra'),
              backgroundColor: AppColors.warning,
            ),
          );
        }
      }
    });
  }

  void _continueToPassengerInfo() {
    if (_selectedSeats.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor selecciona al menos un asiento'),
          backgroundColor: AppColors.warning,
        ),
      );
      return;
    }

    context.push(
      AppRoutes.passengerInfo,
      extra: {
        'tripId': widget.tripId,
        'selectedSeats': _selectedSeats.toList(),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final tripAsync = ref.watch(tripDetailProvider(widget.tripId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleccionar Asientos'),
      ),
      body: tripAsync.when(
        data: (trip) => Column(
          children: [
            // Trip Info Header
            Container(
              padding: const EdgeInsets.all(16),
              color: AppColors.grey50,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          trip.route?.name ?? 'Ruta',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${trip.route?.origin} → ${trip.route?.destination}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (trip.bus != null)
                    Chip(
                      label: Text(trip.bus!.plate),
                      backgroundColor: AppColors.primary.withOpacity(0.1),
                    ),
                ],
              ),
            ),

            // Legend
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _LegendItem(
                    color: AppColors.seatAvailable,
                    label: 'Disponible',
                  ),
                  _LegendItem(
                    color: AppColors.seatSelected,
                    label: 'Seleccionado',
                  ),
                  _LegendItem(
                    color: AppColors.seatOccupied,
                    label: 'Ocupado',
                  ),
                ],
              ),
            ),

            // Seat Map
            Expanded(
              child: SeatMapWidget(
                tripId: widget.tripId,
                busId: trip.busId ?? 0,
                selectedSeats: _selectedSeats,
                onSeatTap: _toggleSeat,
              ),
            ),

            // Bottom Bar
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
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${_selectedSeats.length} asiento(s)',
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          if (_selectedSeats.isNotEmpty)
                            Text(
                              _selectedSeats.join(', '),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    CustomButton(
                      text: 'Continuar',
                      onPressed:
                      _selectedSeats.isEmpty ? null : _continueToPassengerInfo,
                      icon: Icons.arrow_forward,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        loading: () => const LoadingIndicator(message: 'Cargando viaje...'),
        error: (error, _) => ErrorDisplay(message: error.toString()),
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}