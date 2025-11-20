import 'package:bus_connect/core/constants/app_routes.dart';
import 'package:bus_connect/data/models/seat_hold_model/seat_hold_model.dart';
import 'package:bus_connect/data/models/stop_model/stop_model.dart';
import 'package:bus_connect/presentation/providers/passenger.dart';
import 'package:bus_connect/presentation/providers/passenger_booking_provider.dart';
import 'package:bus_connect/presentation/providers/passenger_seat_selection_provider.dart';
import 'package:bus_connect/presentation/widgets/seat_selector/seat_grid_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SeatSelectionScreen extends ConsumerStatefulWidget {
  final int tripId;

  const SeatSelectionScreen({super.key, required this.tripId});

  @override
  ConsumerState<SeatSelectionScreen> createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends ConsumerState<SeatSelectionScreen> {
  StopModel? selectedFromStop;
  StopModel? selectedToStop;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(selectedSeatProvider.notifier).state = null;
      ref.read(selectedFromStopProvider.notifier).state = null;
      ref.read(selectedToStopProvider.notifier).state = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final tripAsync = ref.watch(tripDetailsProvider(widget.tripId));
    final selectedSeat = ref.watch(selectedSeatProvider);
    final bookingState = ref.watch(passengerBookingProvider);

    ref.listen<BookingState>(passengerBookingProvider, (previous, next) {
      if (next.error != null && next.error!.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error!),
            backgroundColor: Colors.red,
            action: SnackBarAction(
              label: 'OK',
              textColor: Colors.white,
              onPressed: () {},
            ),
          ),
        );
      }

      if (previous?.currentHold == null && next.currentHold != null) {
        context.push('${AppRoutes.passengerBookingConfirm}/${widget.tripId}');
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleccionar Asiento'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.invalidate(tripDetailsProvider(widget.tripId));
            },
          ),
        ],
      ),
      body: tripAsync.when(
        data: (trip) {
          if (trip.busId == null) {
            return _buildErrorState(
              icon: Icons.directions_bus_outlined,
              message: 'No hay bus asignado a este viaje',
              actionLabel: 'Volver',
              onAction: () => context.pop(),
            );
          }

          return Column(
            children: [
              // Header compacto
              _buildCompactTripHeader(context, trip),

              // Selección de paradas en una línea + asientos (scrollable)
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildCompactStopSelection(trip),

                      // Grid de asientos con altura fija
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: SeatGridWidget(
                          tripId: widget.tripId,
                          busId: trip.busId!,
                          selectedSeat: selectedSeat,
                          onSeatSelected: (seatNumber) {
                            ref.read(selectedSeatProvider.notifier).state = seatNumber;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Hold Timer (si existe)
              if (bookingState.currentHold != null)
                _buildCompactHoldTimer(bookingState),

              // Bottom bar
              _buildCompactBottomBar(context, selectedSeat, bookingState),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => _buildErrorState(
          icon: Icons.error_outline,
          message: 'Error al cargar el viaje',
          subtitle: e.toString(),
          actionLabel: 'Reintentar',
          onAction: () => ref.invalidate(tripDetailsProvider(widget.tripId)),
        ),
      ),
    );
  }

  // ==================== HEADER COMPACTO ====================

  Widget _buildCompactTripHeader(BuildContext context, dynamic trip) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.05),
        border: Border(
          bottom: BorderSide(color: Colors.grey[300]!, width: 1),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            radius: 20,
            child: const Icon(Icons.directions_bus, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${trip.origin} → ${trip.destination}',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 12, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(
                      '${trip.date} - ${trip.departureAt.toString().substring(11, 16)}',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==================== SELECCIÓN DE PARADAS EN UNA LÍNEA ====================

  Widget _buildCompactStopSelection(dynamic trip) {
    final stopsAsync = ref.watch(routeStopsProvider(trip.routeId ?? 0));

    return Container(
      padding: const EdgeInsets.all(12),
      color: Colors.white,
      child: stopsAsync.when(
        data: (stops) {
          if (stops.isEmpty) {
            return Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Icon(Icons.warning_amber, color: Colors.orange[700], size: 20),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'No hay paradas disponibles',
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Título
              Row(
                children: [
                  Icon(Icons.route, size: 16, color: Colors.grey[700]),
                  const SizedBox(width: 6),
                  Text(
                    'Selecciona tu recorrido',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Dropdowns en una línea
              Row(
                children: [
                  // Origen
                  Expanded(
                    child: _buildCompactDropdown(
                      value: selectedFromStop,
                      items: stops,
                      hint: 'Desde',
                      icon: Icons.trip_origin,
                      iconColor: Colors.green,
                      onChanged: (value) {
                        setState(() {
                          selectedFromStop = value;
                          if (selectedToStop != null &&
                              value != null &&
                              value.order >= selectedToStop!.order) {
                            selectedToStop = null;
                            ref.read(selectedToStopProvider.notifier).state = null;
                          }
                        });
                        ref.read(selectedFromStopProvider.notifier).state = value?.id;
                      },
                    ),
                  ),

                  // Separador
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Icon(Icons.arrow_forward, color: Colors.grey[400], size: 20),
                  ),

                  // Destino
                  Expanded(
                    child: _buildCompactDropdown(
                      value: selectedToStop,
                      items: stops
                          .where((s) =>
                      selectedFromStop == null ||
                          s.order > selectedFromStop!.order)
                          .toList(),
                      hint: 'Hasta',
                      icon: Icons.location_on,
                      iconColor: Colors.red,
                      enabled: selectedFromStop != null,
                      onChanged: (value) {
                        setState(() => selectedToStop = value);
                        ref.read(selectedToStopProvider.notifier).state = value?.id;
                      },
                    ),
                  ),
                ],
              ),
            ],
          );
        },
        loading: () => const LinearProgressIndicator(),
        error: (e, _) => Card(
          color: Colors.red[50],
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                const Icon(Icons.error, color: Colors.red, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Error: $e',
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCompactDropdown({
    required StopModel? value,
    required List<StopModel> items,
    required String hint,
    required IconData icon,
    required Color iconColor,
    bool enabled = true,
    required Function(StopModel?) onChanged,
  }) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
        color: enabled ? Colors.white : Colors.grey[100],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<StopModel>(
          value: value,
          hint: Row(
            children: [
              Icon(icon, size: 16, color: enabled ? iconColor : Colors.grey),
              const SizedBox(width: 6),
              Text(
                hint,
                style: TextStyle(
                  fontSize: 13,
                  color: enabled ? Colors.grey[700] : Colors.grey[400],
                ),
              ),
            ],
          ),
          isExpanded: true,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          items: items.map((stop) {
            return DropdownMenuItem(
              value: stop,
              child: Text(
                stop.name,
                style: const TextStyle(fontSize: 13),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
          onChanged: enabled ? onChanged : null,
          icon: Icon(Icons.arrow_drop_down, color: enabled ? Colors.grey[700] : Colors.grey[400]),
        ),
      ),
    );
  }

  // ==================== HOLD TIMER COMPACTO ====================

  Widget _buildCompactHoldTimer(BookingState bookingState) {
    final hold = bookingState.currentHold!;
    final minutesLeft = hold.minutesLeft ?? hold.calculateMinutesLeft;
    final isExpiringSoon = minutesLeft <= 2;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: isExpiringSoon ? Colors.red[50] : Colors.orange[50],
        border: Border(
          top: BorderSide(
            color: isExpiringSoon ? Colors.red : Colors.orange,
            width: 2,
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(
            isExpiringSoon ? Icons.warning_rounded : Icons.timer,
            color: isExpiringSoon ? Colors.red : Colors.orange,
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Asiento ${hold.seatNumber} reservado',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                Text(
                  '$minutesLeft min restantes',
                  style: TextStyle(
                    fontSize: 11,
                    color: isExpiringSoon ? Colors.red[700] : Colors.orange[700],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==================== BOTTOM BAR COMPACTO ====================

  Widget _buildCompactBottomBar(
      BuildContext context,
      String? selectedSeat,
      BookingState bookingState,
      ) {
    final canProceed = _canProceed();

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Indicador de asiento seleccionado
            if (selectedSeat != null)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.green[300]!),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.event_seat, color: Colors.green[700], size: 16),
                    const SizedBox(width: 6),
                    Text(
                      'Asiento $selectedSeat',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Colors.green[700],
                      ),
                    ),
                  ],
                ),
              ),

            // Botones
            Row(
              children: [
                if (bookingState.currentHold != null) ...[
                  Expanded(
                    child: OutlinedButton(
                      onPressed: bookingState.isLoading
                          ? null
                          : () async {
                        final confirmed = await _showReleaseDialog(context);
                        if (confirmed == true && mounted) {
                          ref
                              .read(passengerBookingProvider.notifier)
                              .releaseHold(bookingState.currentHold!.id);
                        }
                      },
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(0, 46),
                      ),
                      child: const Text('Liberar', style: TextStyle(fontSize: 14)),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],

                Expanded(
                  flex: bookingState.currentHold != null ? 2 : 1,
                  child: ElevatedButton(
                    onPressed: canProceed && !bookingState.isLoading
                        ? () => _handleProceed(bookingState)
                        : null,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(0, 46),
                    ),
                    child: bookingState.isLoading
                        ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                    )
                        : Text(
                      bookingState.currentHold != null
                          ? 'Continuar'
                          : 'Reservar',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ==================== ERROR STATE ====================

  Widget _buildErrorState({
    required IconData icon,
    required String message,
    String? subtitle,
    required String actionLabel,
    required VoidCallback onAction,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              message,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: onAction,
              icon: const Icon(Icons.refresh, size: 18),
              label: Text(actionLabel),
            ),
          ],
        ),
      ),
    );
  }

  // ==================== HELPER METHODS ====================

  bool _canProceed() {
    final selectedSeat = ref.read(selectedSeatProvider);
    return selectedSeat != null && selectedFromStop != null && selectedToStop != null;
  }

  Future<void> _handleProceed(BookingState bookingState) async {
    final selectedSeat = ref.read(selectedSeatProvider)!;

    if (bookingState.currentHold == null) {
      await ref.read(passengerBookingProvider.notifier).holdSeat(
        tripId: widget.tripId,
        seatNumber: selectedSeat,
        fromStopId: selectedFromStop!.id,
        toStopId: selectedToStop!.id,
      );
    } else {
      if (mounted) {
        context.push('${AppRoutes.passengerBookingConfirm}/${widget.tripId}');
      }
    }
  }

  Future<bool?> _showReleaseDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Liberar Asiento'),
        content: const Text(
          '¿Estás seguro de que deseas liberar este asiento? '
              'Perderás la reserva temporal.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Liberar'),
          ),
        ],
      ),
    );
  }
}