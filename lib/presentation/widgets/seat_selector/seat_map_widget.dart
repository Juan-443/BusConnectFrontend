import 'package:bus_connect/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/providers/seat_api_provider.dart';
import '../../../data/providers/ticket_api_provider.dart';
import '../../../data/models/seat_model/seat_model.dart';

class SeatMapWidget extends ConsumerStatefulWidget {
  final int tripId;
  final int busId;
  final Set<String> selectedSeats;
  final Function(String) onSeatTap;

  const SeatMapWidget({
    super.key,
    required this.tripId,
    required this.busId,
    required this.selectedSeats,
    required this.onSeatTap,
  });

  @override
  ConsumerState<SeatMapWidget> createState() => _SeatMapWidgetState();
}

class _SeatMapWidgetState extends ConsumerState<SeatMapWidget> {
  List<SeatResponse>? _seats;
  Set<String> _occupiedSeats = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSeats();
  }

  Future<void> _loadSeats() async {
    try {
      final apiClient = ref.read(apiClientProvider);
      final seatProvider = SeatApiProvider(apiClient.dio);
      final ticketProvider = TicketApiProvider(apiClient.dio);

      // Cargar asientos del bus
      final seats = await seatProvider.getSeatsByBus(widget.busId);

      // Cargar tickets del viaje para saber asientos ocupados
      final tickets = await ticketProvider.getTicketsByTrip(widget.tripId);
      final occupied = tickets
          .where((t) => t.status.name == 'SOLD' || t.status.name == 'USED')
          .map((t) => t.seatNumber)
          .toSet();

      setState(() {
        _seats = seats;
        _occupiedSeats = occupied;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al cargar asientos: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_seats == null || _seats!.isEmpty) {
      return const Center(child: Text('No hay asientos disponibles'));
    }

    // Organizar asientos en filas (4 por fila: 2-pasillo-2)
    final rows = <List<SeatResponse?>>[];
    final sortedSeats = List<SeatResponse>.from(_seats!)
      ..sort((a, b) => a.number.compareTo(b.number));

    for (int i = 0; i < sortedSeats.length; i += 4) {
      final row = <SeatResponse?>[];
      // Lado izquierdo
      row.add(sortedSeats[i]);
      if (i + 1 < sortedSeats.length) row.add(sortedSeats[i + 1]);

      // Pasillo (null)
      row.add(null);

      // Lado derecho
      if (i + 2 < sortedSeats.length) row.add(sortedSeats[i + 2]);
      if (i + 3 < sortedSeats.length) row.add(sortedSeats[i + 3]);

      rows.add(row);
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          // Driver area
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.grey300,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.person,
                color: AppColors.white,
                size: 32,
              ),
            ),
          ),

          // Seats
          ...rows.map((row) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: row.map((seat) {
                if (seat == null) {
                  // Pasillo
                  return const SizedBox(width: 40);
                }

                final isOccupied = _occupiedSeats.contains(seat.number);
                final isSelected = widget.selectedSeats.contains(seat.number);

                Color seatColor;
                if (isOccupied) {
                  seatColor = AppColors.seatOccupied;
                } else if (isSelected) {
                  seatColor = AppColors.seatSelected;
                } else {
                  seatColor = AppColors.seatAvailable;
                }

                return Padding(
                  padding: const EdgeInsets.all(4),
                  child: InkWell(
                    onTap: isOccupied ? null : () => widget.onSeatTap(seat.number),
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: seatColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          seat.number,
                          style: const TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          )),
        ],
      ),
    );
  }
}