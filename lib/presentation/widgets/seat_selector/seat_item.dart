import 'package:flutter/material.dart';
import '../../../core/constants/enums/seat_type.dart';
import '../../../data/models/seat_model/seat_model.dart';

class SeatItem extends StatelessWidget {
  final SeatResponse seat;
  final VoidCallback? onTap;
  final bool isOccupied;
  final bool isSelected;
  final bool showBorder;

  const SeatItem({
    super.key,
    required this.seat,
    this.onTap,
    this.isOccupied = false,
    this.isSelected = false,
    this.showBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isOccupied ? null : onTap,
      child: Container(
        width: 50,
        height: 50,
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: _getSeatColor(),
          borderRadius: BorderRadius.circular(8),
          border: showBorder
              ? Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade400,
            width: isSelected ? 2 : 1,
          )
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getSeatIcon(),
              size: 20,
              color: Colors.white,
            ),
            const SizedBox(height: 2),
            Text(
              seat.number,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getSeatColor() {
    if (isOccupied) {
      return Colors.grey.shade600;
    }
    if (isSelected) {
      return Colors.blue;
    }

    switch (seat.type) {
      case SeatType.STANDARD:
        return Colors.green;
      case SeatType.PREFERENTIAL:
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  IconData _getSeatIcon() {
    if (isOccupied) {
      return Icons.close;
    }
    if (isSelected) {
      return Icons.check;
    }

    switch (seat.type) {
      case SeatType.PREFERENTIAL:
        return Icons.airline_seat_legroom_extra;
      case SeatType.STANDARD:
      default:
        return Icons.airline_seat_recline_normal;
    }
  }
}