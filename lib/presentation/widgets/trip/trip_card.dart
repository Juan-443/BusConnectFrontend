import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/enums/trip_status.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../data/models/trip_model/trip_model.dart';

class TripCard extends StatelessWidget {
  final TripResponse trip;
  final VoidCallback onTap;

  const TripCard({
    super.key,
    required this.trip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final departureTime = DateFormatter.formatTime(trip.departureAt);
    final arrivalTime = DateFormatter.formatTime(trip.arrivalEta);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.grey200),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Route info
              Row(
                children: [
                  Expanded(
                    child: Text(
                      trip.route?.name ?? 'Ruta',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  _StatusBadge(status: trip.status),
                ],
              ),
              const SizedBox(height: 16),

              // Time Info
              Row(
                children: [
                  Expanded(
                    child: _TimeInfo(
                      label: 'Salida',
                      time: departureTime,
                      city: trip.route?.origin ?? '',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.arrow_forward,
                          color: AppColors.primary,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _calculateDuration(trip.departureAt, trip.arrivalEta),
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: _TimeInfo(
                      label: 'Llegada',
                      time: arrivalTime,
                      city: trip.route?.destination ?? '',
                      isArrival: true,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Bottom: Bus info and action
              Row(
                children: [
                  if (trip.bus != null) ...[
                    const Icon(
                      Icons.directions_bus,
                      size: 16,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      trip.bus!.plate,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(width: 16),
                  ],
                  const Icon(
                    Icons.event_seat,
                    size: 16,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${trip.bus?.capacity ?? 0} asientos',
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: AppColors.primary,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _calculateDuration(DateTime start, DateTime end) {
    final duration = end.difference(start);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    return '${hours}h ${minutes}m';
  }
}

class _TimeInfo extends StatelessWidget {
  final String label;
  final String time;
  final String city;
  final bool isArrival;

  const _TimeInfo({
    required this.label,
    required this.time,
    required this.city,
    this.isArrival = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      isArrival ? CrossAxisAlignment.end : CrossAxisAlignment.start,
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
          time,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          city,
          style: const TextStyle(
            fontSize: 13,
            color: AppColors.textSecondary,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final TripStatus status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;

    switch (status) {
      case TripStatus.SCHEDULED:
        backgroundColor = AppColors.scheduled.withOpacity(0.1);
        textColor = AppColors.scheduled;
        break;
      case TripStatus.BOARDING:
        backgroundColor = AppColors.boarding.withOpacity(0.1);
        textColor = AppColors.boarding;
        break;
      case TripStatus.DEPARTED:
        backgroundColor = AppColors.departed.withOpacity(0.1);
        textColor = AppColors.departed;
        break;
      case TripStatus.ARRIVED:
        backgroundColor = AppColors.arrived.withOpacity(0.1);
        textColor = AppColors.arrived;
        break;
      case TripStatus.CANCELLED:
        backgroundColor = AppColors.cancelled.withOpacity(0.1);
        textColor = AppColors.cancelled;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status.displayName,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }
}