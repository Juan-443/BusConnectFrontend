import 'package:bus_connect/presentation/providers/passenger_seat_selection_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SeatGridWidget extends ConsumerWidget {
  final int tripId;
  final int busId;
  final String? selectedSeat;
  final Function(String) onSeatSelected;

  const SeatGridWidget({
    Key? key,
    required this.tripId,
    required this.busId,
    required this.selectedSeat,
    required this.onSeatSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final seatsAsync = ref.watch(tripSeatsProvider(busId));
    final occupiedSeatsAsync = ref.watch(occupiedSeatsProvider(tripId));

    return Column(
      children: [
        _buildCompactLegend(),
        const SizedBox(height: 8),

        Expanded(
          child: seatsAsync.when(
            data: (seats) => occupiedSeatsAsync.when(
              data: (occupiedSeats) {
                if (seats.isEmpty) return _buildEmptyState();
                return _buildBusView(context, seats, occupiedSeats);
              },
              loading: () => _buildLoadingState(),
              error: (e, _) => _buildErrorState(e.toString()),
            ),
            loading: () => _buildLoadingState(),
            error: (e, _) => _buildErrorState(e.toString()),
          ),
        ),
      ],
    );
  }

  // ==================== VISTA DEL BUS ====================

  Widget _buildBusView(BuildContext context, List seats, List<String> occupiedSeats) {
    final sortedSeats = List.from(seats)
      ..sort((a, b) {
        final aType = a.type.toString().split('.').last;
        final bType = b.type.toString().split('.').last;
        if (aType == 'PREFERENTIAL' && bType != 'PREFERENTIAL') return -1;
        if (aType != 'PREFERENTIAL' && bType == 'PREFERENTIAL') return 1;
        return a.number.compareTo(b.number);
      });

    // Agrupar en filas de 4
    final rows = <List<dynamic>>[];
    for (int i = 0; i < sortedSeats.length; i += 4) {
      rows.add(sortedSeats.skip(i).take(4).toList());
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.grey[200]!, Colors.grey[100]!],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // ✅ Frente minimalista
          _buildMinimalDriverCabin(),

          // Asientos
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              itemCount: rows.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final rowSeats = rows[index];
                return _buildSeatRow(rowSeats, occupiedSeats, index);
              },
            ),
          ),

          // ✅ Sin sección de salida - solo padding
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  // ==================== CABINA MINIMALISTA ====================

  Widget _buildMinimalDriverCabin() {
    return Container(
      height: 40, // ✅ Mucho más pequeño (antes: 60)
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.grey[800]!, Colors.grey[700]!],
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          // Ícono de volante
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[900],
              border: Border.all(color: Colors.grey[600]!, width: 2),
            ),
            child: Icon(Icons.circle, size: 8, color: Colors.grey[700]),
          ),
          const Spacer(),
          // Badge FRENTE
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orange[600]!, Colors.orange[700]!],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.arrow_upward, color: Colors.white, size: 10),
                const SizedBox(width: 4),
                Text(
                  'FRENTE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }

  // ==================== FILA DE ASIENTOS ====================

  Widget _buildSeatRow(List rowSeats, List<String> occupiedSeats, int rowIndex) {
    final leftSeats = rowSeats.take(2).toList();
    final rightSeats = rowSeats.skip(2).take(2).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: [
          _buildWindow(),
          const SizedBox(width: 6),

          ...leftSeats.map((seat) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: _buildCompactSeat(seat, occupiedSeats.contains(seat.number)),
              ),
            );
          }),

          _buildAisle(rowIndex),

          ...rightSeats.map((seat) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: _buildCompactSeat(seat, occupiedSeats.contains(seat.number)),
              ),
            );
          }),

          const SizedBox(width: 6),
          _buildWindow(),
        ],
      ),
    );
  }

  // ==================== ASIENTO CON ÍCONO MÁS VISIBLE ====================

  Widget _buildCompactSeat(dynamic seat, bool isOccupied) {
    final seatType = seat.type.toString().split('.').last;
    final isSelected = selectedSeat == seat.number;
    final isPreferential = seatType == 'PREFERENTIAL';

    Color backgroundColor;
    Color iconColor;
    Color textColor;
    Color borderColor;

    if (isOccupied) {
      backgroundColor = Colors.grey[300]!;
      iconColor = Colors.grey[400]!;
      textColor = Colors.grey[700]!;
      borderColor = Colors.grey[500]!;
    } else if (isSelected) {
      backgroundColor = Colors.green[500]!;
      iconColor = Colors.green[100]!; // ✅ Más claro para mayor contraste
      textColor = Colors.white;
      borderColor = Colors.green[700]!;
    } else if (isPreferential) {
      backgroundColor = Colors.purple[400]!;
      iconColor = Colors.purple[100]!; // ✅ Más claro
      textColor = Colors.white;
      borderColor = Colors.purple[600]!;
    } else {
      backgroundColor = Colors.blue[400]!;
      iconColor = Colors.blue[100]!; // ✅ Más claro
      textColor = Colors.white;
      borderColor = Colors.blue[600]!;
    }

    return GestureDetector(
      onTap: isOccupied ? null : () => onSeatSelected(seat.number),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 55,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: borderColor,
            width: isSelected ? 2.5 : 1.5,
          ),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: Colors.green.withOpacity(0.5),
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ]
              : [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            // ✅ ÍCONO DE SILLA MÁS VISIBLE
            Positioned.fill(
              child: Icon(
                isPreferential
                    ? Icons.airline_seat_recline_extra
                    : Icons.airline_seat_recline_normal,
                size: 50, // ✅ Más grande (antes: 40)
                color: iconColor.withOpacity(0.85), // ✅ Mucho más visible (antes: 0.5)
              ),
            ),

            // Contenido encima
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isOccupied || isSelected) ...[
                    Icon(
                      isOccupied ? Icons.person : Icons.check_circle,
                      color: textColor,
                      size: 16, // ✅ Un poco más grande
                    ),
                    const SizedBox(height: 2),
                  ],

                  // Número con fondo
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.25), // ✅ Fondo más oscuro
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      seat.number,
                      style: TextStyle(
                        color: textColor,
                        fontSize: isSelected ? 13 : 11,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 3,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Badge VIP
                  if (isPreferential && !isOccupied) ...[
                    const SizedBox(height: 2),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.amber[600]!, Colors.amber[800]!],
                        ),
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amber.withOpacity(0.6),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: const Text(
                        'VIP',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 7,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Efecto de brillo
            if (isSelected)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.7),
                        Colors.white.withOpacity(0.0),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(6),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // ==================== VENTANA ====================

  Widget _buildWindow() {
    return Container(
      width: 28,
      height: 50,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.lightBlue[100]!.withOpacity(0.6),
            Colors.lightBlue[50]!.withOpacity(0.4),
          ],
        ),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.grey[400]!, width: 1.5),
      ),
    );
  }

  // ==================== PASILLO ====================

  Widget _buildAisle(int rowIndex) {
    return SizedBox(
      width: 20,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (rowIndex % 2 == 0)
            Icon(Icons.arrow_downward, size: 12, color: Colors.grey[400]),
          Container(
            width: 1.5,
            height: 35,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.grey[300]!, Colors.grey[400]!, Colors.grey[300]!],
              ),
            ),
          ),
          if (rowIndex % 2 == 1)
            Icon(Icons.arrow_downward, size: 12, color: Colors.grey[400]),
        ],
      ),
    );
  }

  // ==================== LEYENDA ====================

  Widget _buildCompactLegend() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
          ),
        ],
      ),
      child: Wrap(
        spacing: 12,
        runSpacing: 6,
        alignment: WrapAlignment.center,
        children: [
          _MiniLegend(color: Colors.blue[400]!, label: 'Estándar'),
          _MiniLegend(color: Colors.purple[400]!, label: 'VIP'),
          _MiniLegend(color: Colors.green[500]!, label: 'Seleccionado'),
          _MiniLegend(color: Colors.grey[400]!, label: 'Ocupado'),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Cargando asientos...'),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.event_seat_outlined, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          const Text('No hay asientos disponibles'),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
            const SizedBox(height: 16),
            const Text('Error al cargar asientos', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(error, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

// ==================== MINI LEGEND ====================

class _MiniLegend extends StatelessWidget {
  final Color color;
  final String label;

  const _MiniLegend({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.4),
                blurRadius: 2,
              ),
            ],
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}