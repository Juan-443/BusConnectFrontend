import 'package:bus_connect/core/constants/enums/seat_type.dart';
import 'package:bus_connect/data/models/seat_model/seat_model.dart';
import 'package:bus_connect/presentation/providers/seat_provider.dart';
import 'package:bus_connect/presentation/widgets/seat_selector/seat_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BusSeatsScreen extends ConsumerStatefulWidget {
  final int busId;
  final String busPlate;

  const BusSeatsScreen({
    super.key,
    required this.busId,
    required this.busPlate,
  });

  @override
  ConsumerState<BusSeatsScreen> createState() => _BusSeatsScreenState();
}

class _BusSeatsScreenState extends ConsumerState<BusSeatsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
          () => ref.read(seatProvider.notifier).fetchSeatsByBus(widget.busId),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(seatProvider);
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Gestión de Asientos'),
            Text(
              'Bus: ${widget.busPlate}',
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle),
            tooltip: 'Crear asiento individual',
            onPressed: () => _showCreateSeatDialog(context),
          ),
          IconButton(
            icon: const Icon(Icons.grid_on),
            tooltip: 'Crear asientos en lote',
            onPressed: () => _showBulkCreateDialog(context),
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref
                .read(seatProvider.notifier)
                .fetchSeatsByBus(widget.busId),
          ),
        ],
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.error != null
          ? _buildError(state.error!)
          : _buildSeatsView(state.seats),
    );
  }

  Widget _buildError(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            'Error al cargar asientos',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => ref
                .read(seatProvider.notifier)
                .fetchSeatsByBus(widget.busId),
            icon: const Icon(Icons.refresh),
            label: const Text('Reintentar'),
          ),
        ],
      ),
    );
  }

  Widget _buildSeatsView(List<SeatResponse> seats) {
    if (seats.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.event_seat_outlined,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            const Text('No hay asientos configurados'),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => _showBulkCreateDialog(context),
              icon: const Icon(Icons.add),
              label: const Text('Crear Asientos'),
            ),
          ],
        ),
      );
    }

    // Agrupar asientos por fila
    final seatsByRow = <String, List<SeatResponse>>{};
    for (final seat in seats) {
      final row = seat.number.substring(1);
      if (!seatsByRow.containsKey(row)) {
        seatsByRow[row] = [];
      }
      seatsByRow[row]!.add(seat);
    }

    // Ordenar filas
    final sortedRows = seatsByRow.keys.toList()
      ..sort((a, b) => int.parse(a).compareTo(int.parse(b)));

    return Column(
      children: [
        // Estadísticas
        _buildStatistics(seats),
        const Divider(),

        // Leyenda
        _buildLegend(),
        const Divider(),

        // Mapa de asientos
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Cabecera del bus (conductor)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.drive_eta, size: 32),
                      Text(
                        'CONDUCTOR',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(width: 32),
                    ],
                  ),
                ),
                const SizedBox(height: 8),

                // Filas de asientos
                ...sortedRows.map((row) {
                  final rowSeats = seatsByRow[row]!;
                  rowSeats.sort((a, b) => a.number.compareTo(b.number));

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Número de fila
                        SizedBox(
                          width: 30,
                          child: Text(
                            row,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(width: 8),

                        // Asientos de la fila
                        ...rowSeats.asMap().entries.map((entry) {
                          final index = entry.key;
                          final seat = entry.value;

                          if (index == 2) {
                            return Row(
                              children: [
                                SeatItem(
                                  seat: seat,
                                  onTap: () => _showSeatOptions(seat),
                                ),
                                const SizedBox(width: 40), // Pasillo
                              ],
                            );
                          }

                          return SeatItem(
                            seat: seat,
                            onTap: () => _showSeatOptions(seat),
                          );
                        }),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatistics(List<SeatResponse> seats) {
    final totalSeats = seats.length;
    final standardSeats =
        seats.where((s) => s.type == SeatType.STANDARD).length;
    final preferentialSeats =
        seats.where((s) => s.type == SeatType.PREFERENTIAL).length;

    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.blue.shade50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
            label: 'Total',
            value: totalSeats.toString(),
            icon: Icons.event_seat,
            color: Colors.blue,
          ),
          _buildStatItem(
            label: 'Estándar',
            value: standardSeats.toString(),
            icon: Icons.airline_seat_recline_normal,
            color: Colors.green,
          ),
          _buildStatItem(
            label: 'Preferencial',
            value: preferentialSeats.toString(),
            icon: Icons.airline_seat_legroom_extra,
            color: Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required String label,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(icon, color: color),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildLegend() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildLegendItem(
            color: Colors.green,
            label: 'Estándar',
          ),
          _buildLegendItem(
            color: Colors.orange,
            label: 'Preferencial',
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem({required Color color, required String label}) {
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
        Text(label),
      ],
    );
  }

  void _showSeatOptions(SeatResponse seat) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Asiento ${seat.number}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text('Tipo: ${seat.type.name}'),
            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Cambiar tipo'),
              onTap: () {
                Navigator.pop(ctx);
                _showChangeSeatTypeDialog(seat);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title:
              const Text('Eliminar', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(ctx);
                _confirmDeleteSeat(seat);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showCreateSeatDialog(BuildContext context) {
    final numberController = TextEditingController();
    SeatType selectedType = SeatType.STANDARD;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Crear Asiento'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: numberController,
                decoration: const InputDecoration(
                  labelText: 'Número de asiento (ej: A1, B2)',
                  hintText: 'A1',
                  border: OutlineInputBorder(),
                  helperText: 'Debe empezar con letra + número',
                ),
                textCapitalization: TextCapitalization.characters,
                // ⭐ NUEVO: Transformar a mayúsculas mientras escribe
                onChanged: (value) {
                  final cursorPos = numberController.selection.base.offset;
                  numberController.value = TextEditingValue(
                    text: value.toUpperCase(),
                    selection: TextSelection.collapsed(offset: cursorPos),
                  );
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<SeatType>(
                initialValue: selectedType,
                decoration: const InputDecoration(
                  labelText: 'Tipo',
                  border: OutlineInputBorder(),
                ),
                items: SeatType.values.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type.name),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => selectedType = value);
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                final seatNumber = numberController.text.trim().toUpperCase();

                // ⭐ VALIDACIÓN 1: Campo vacío
                if (seatNumber.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Ingresa un número de asiento'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                // ⭐ VALIDACIÓN 2: Formato correcto (Letra + Número)
                final formatoValido = RegExp(r'^[A-Z][0-9]+$');
                if (!formatoValido.hasMatch(seatNumber)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(
                        'Formato inválido.\nEjemplos válidos: A1, B2, C10',
                      ),
                      backgroundColor: Colors.red,
                      duration: const Duration(seconds: 3),
                      action: SnackBarAction(
                        label: 'OK',
                        textColor: Colors.white,
                        onPressed: () {},
                      ),
                    ),
                  );
                  return;
                }

                // ⭐ VALIDACIÓN 3: Verificar si ya existe
                final seatState = ref.read(seatProvider);
                final yaExiste = seatState.seats.any(
                      (s) => s.number.toUpperCase() == seatNumber && s.busId == widget.busId,
                );

                if (yaExiste) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('El asiento $seatNumber ya existe'),
                      backgroundColor: Colors.orange,
                    ),
                  );
                  return;
                }

                Navigator.pop(ctx);

                // Mostrar loading
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (loadingCtx) => const AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text('Creando asiento...'),
                      ],
                    ),
                  ),
                );

                final request = SeatCreateRequest(
                  busId: widget.busId,
                  number: seatNumber,
                  type: selectedType,
                );

                try {
                  final success = await ref
                      .read(seatProvider.notifier)
                      .createSeat(request);

                  // Cerrar loading
                  if (context.mounted) {
                    Navigator.pop(context);
                  }

                  // Refrescar lista
                  ref.read(seatProvider.notifier).fetchSeatsByBus(widget.busId);

                  if (success && mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Asiento $seatNumber creado exitosamente'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Error al crear asiento'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                } catch (e) {
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error: $e'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
              child: const Text('Crear'),
            ),
          ],
        ),
      ),
    );
  }

  void _showBulkCreateDialog(BuildContext context) {
    final rowsController = TextEditingController(text: '10');
    final seatsPerRowController = TextEditingController(text: '4');
    SeatType selectedType = SeatType.STANDARD;

    showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Crear Asientos en Lote'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: rowsController,
                decoration: const InputDecoration(
                  labelText: 'Número de filas',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: seatsPerRowController,
                decoration: const InputDecoration(
                  labelText: 'Asientos por fila (máx 6)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<SeatType>(
                initialValue: selectedType,
                decoration: const InputDecoration(
                  labelText: 'Tipo por defecto',
                  border: OutlineInputBorder(),
                ),
                items: SeatType.values.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type.name),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => selectedType = value);
                  }
                },
              ),
              const SizedBox(height: 16),
              const Text(
                'Se crearán asientos de A1 hasta la configuración especificada',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                final rows = int.tryParse(rowsController.text) ?? 0;
                final seatsPerRow = int.tryParse(seatsPerRowController.text) ?? 0;

                if (rows <= 0 || seatsPerRow <= 0 || seatsPerRow > 6) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Valores inválidos'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                // Cerrar diálogo de configuración
                Navigator.pop(dialogContext);
                BuildContext? loadingDialogContext;

                // Mostrar loading y guardar su contexto
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (ctx) {
                    loadingDialogContext = ctx;
                    return WillPopScope(
                      onWillPop: () async => false,
                      child: const AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 16),
                            Text('Creando asientos...'),
                          ],
                        ),
                      ),
                    );
                  },
                );

                // Variables
                final letters = ['A', 'B', 'C', 'D', 'E', 'F'];
                int successCount = 0;
                int totalSeats = rows * seatsPerRow;

                // Crear asientos
                for (int row = 1; row <= rows; row++) {
                  for (int col = 0; col < seatsPerRow; col++) {
                    final seatNumber = '${letters[col]}$row';
                    final request = SeatCreateRequest(
                      busId: widget.busId,
                      number: seatNumber,
                      type: selectedType,
                    );

                    try {
                      final success = await ref
                          .read(seatProvider.notifier)
                          .createSeat(request);
                      if (success) successCount++;
                    } catch (e) {
                      print('Error creando $seatNumber: $e');
                    }
                  }
                }
                if (loadingDialogContext != null && loadingDialogContext!.mounted) {
                  Navigator.of(loadingDialogContext!).pop();
                }

                // Refrescar lista SIN await (en segundo plano)
                Future.microtask(() {
                  ref.read(seatProvider.notifier).fetchSeatsByBus(widget.busId);
                });

                // Mostrar resultado
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('$successCount de $totalSeats asientos creados exitosamente'),
                      backgroundColor: Colors.green,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
              },
              child: const Text('Crear'),
            ),
          ],
        ),
      ),
    );
  }

  void _showChangeSeatTypeDialog(SeatResponse seat) {
    SeatType selectedType = seat.type;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text('Cambiar tipo - ${seat.number}'),
          content: DropdownButtonFormField<SeatType>(
            initialValue: selectedType,
            decoration: const InputDecoration(
              labelText: 'Tipo',
              border: OutlineInputBorder(),
            ),
            items: SeatType.values.map((type) {
              return DropdownMenuItem(
                value: type,
                child: Text(type.name),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() => selectedType = value);
              }
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(ctx);

                final request = SeatUpdateRequest(type: selectedType);
                final success = await ref.read(seatProvider.notifier)
                    .updateSeat(seat.id, request);

                if (success && mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Tipo actualizado exitosamente'),
                    ),
                  );
                }
              },
              child: const Text('Actualizar'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmDeleteSeat(SeatResponse seat) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirmar eliminación'),
        content: Text('¿Eliminar el asiento ${seat.number}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      final success =
      await ref.read(seatProvider.notifier).deleteSeat(seat.id);
      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Asiento eliminado exitosamente')),
        );
      }
    }
  }
}