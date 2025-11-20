import 'package:bus_connect/core/constants/app_routes.dart';
import 'package:bus_connect/presentation/providers/passenger.dart';
import 'package:bus_connect/presentation/widgets/trip/trip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TripSearchScreen extends ConsumerStatefulWidget {
  const TripSearchScreen({super.key});

  @override
  ConsumerState<TripSearchScreen> createState() => _TripSearchScreenState();
}

class _TripSearchScreenState extends ConsumerState<TripSearchScreen> {
  final TextEditingController _originController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();

  DateTime? selectedDate;

  @override
  void dispose() {
    _originController.dispose();
    _destinationController.dispose();
    super.dispose();
  }

  void _handleSearch(List<String> origins, List<String> destinations) {
    final origin = _originController.text.trim();
    final destination = _destinationController.text.trim();

    final hasOriginAndDestination = origin.isNotEmpty && destination.isNotEmpty;
    final hasOnlyDate = origin.isEmpty && destination.isEmpty && selectedDate != null;

    if (!hasOriginAndDestination && !hasOnlyDate) {
      _showError('Por favor ingresa:\n• Origen y destino, o\n• Solo una fecha para ver todos los viajes');
      return;
    }

    if (hasOnlyDate) {
      FocusScope.of(context).unfocus();
      ref.read(passengerTripsProvider.notifier).searchTripsByFilters(
        date: _formatDate(selectedDate!),
      );
      return;
    }

    final matchedOrigin = origins.firstWhere(
          (city) => city.toLowerCase() == origin.toLowerCase(),
      orElse: () => '',
    );

    final matchedDestination = destinations.firstWhere(
          (city) => city.toLowerCase() == destination.toLowerCase(),
      orElse: () => '',
    );
    if (matchedOrigin.isEmpty) {
      _showError(
          'La ciudad de origen "$origin" no está disponible.\n'
              'Ciudades disponibles: ${origins.take(5).join(", ")}...'
      );
      return;
    }

    if (matchedDestination.isEmpty) {
      _showError(
          'La ciudad de destino "$destination" no está disponible.\n'
              'Ciudades disponibles: ${destinations.take(5).join(", ")}...'
      );
      return;
    }
    if (matchedOrigin.toLowerCase() == matchedDestination.toLowerCase()) {
      _showError('El origen y destino no pueden ser la misma ciudad');
      return;
    }

    FocusScope.of(context).unfocus();
    ref.read(passengerTripsProvider.notifier).searchByCities(
      origin: matchedOrigin,
      destination: matchedDestination,
      date: selectedDate,
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.orange[700],
        duration: const Duration(seconds: 4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final citiesAsync = ref.watch(citiesProvider);
    final tripsAsync = ref.watch(passengerTripsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Viajes'),
      ),
      body: Column(
        children: [
          // Search Filters
          Container(
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
            child: citiesAsync.when(
              data: (cities) => Column(
                children: [
                  Autocomplete<String>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text.isEmpty) {
                        return const Iterable<String>.empty();
                      }

                      final input = textEditingValue.text.toLowerCase();
                      return cities.origins.where((city) {
                        return city.toLowerCase().contains(input);
                      });
                    },
                    onSelected: (String selection) {
                      _originController.text = selection;
                    },
                    fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                      controller.text = _originController.text;
                      controller.selection = _originController.selection;

                      return TextField(
                        controller: controller,
                        focusNode: focusNode,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          labelText: ' Origen',
                          hintText: 'Ej: Cali, Maicao',
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(Icons.location_on),
                          suffixIcon: controller.text.isNotEmpty
                              ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              controller.clear();
                              _originController.clear();
                              setState(() {});
                            },
                          )
                              : null,
                        ),
                        onChanged: (value) {
                          _originController.text = value;
                          setState(() {});
                        },
                      );
                    },
                    optionsViewBuilder: (context, onSelected, options) {
                      return Align(
                        alignment: Alignment.topLeft,
                        child: Material(
                          elevation: 4,
                          borderRadius: BorderRadius.circular(8),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxHeight: 200,
                              maxWidth: 400,
                            ),
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: options.length,
                              itemBuilder: (context, index) {
                                final option = options.elementAt(index);
                                return ListTile(
                                  dense: true,
                                  leading: const Icon(Icons.location_city, size: 20),
                                  title: Text(option),
                                  onTap: () => onSelected(option),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 16),

                  Autocomplete<String>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text.isEmpty) {
                        return const Iterable<String>.empty();
                      }

                      final input = textEditingValue.text.toLowerCase();
                      return cities.destinations.where((city) {
                        return city.toLowerCase().contains(input);
                      });
                    },
                    onSelected: (String selection) {
                      _destinationController.text = selection;
                    },
                    fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                      controller.text = _destinationController.text;
                      controller.selection = _destinationController.selection;

                      return TextField(
                        controller: controller,
                        focusNode: focusNode,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          labelText: ' Destino',
                          hintText: 'Ej: Bogotá, Medellín',
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(Icons.location_on_outlined),
                          suffixIcon: controller.text.isNotEmpty
                              ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              controller.clear();
                              _destinationController.clear();
                              setState(() {});
                            },
                          )
                              : null,
                        ),
                        onChanged: (value) {
                          _destinationController.text = value;
                          setState(() {});
                        },
                      );
                    },
                    optionsViewBuilder: (context, onSelected, options) {
                      return Align(
                        alignment: Alignment.topLeft,
                        child: Material(
                          elevation: 4,
                          borderRadius: BorderRadius.circular(8),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxHeight: 200,
                              maxWidth: 400,
                            ),
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: options.length,
                              itemBuilder: (context, index) {
                                final option = options.elementAt(index);
                                return ListTile(
                                  dense: true,
                                  leading: const Icon(Icons.location_city, size: 20),
                                  title: Text(option),
                                  onTap: () => onSelected(option),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 16),

                  // Date Picker (Optional)
                  InkWell(
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate ?? DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 90)),
                      );
                      if (picked != null) {
                        setState(() => selectedDate = picked);
                      }
                    },
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: ' Fecha (opcional)',
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.calendar_today),
                        suffixIcon: selectedDate != null
                            ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () => setState(() => selectedDate = null),
                        )
                            : null,
                      ),
                      child: Text(
                        selectedDate != null
                            ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                            : 'Cualquier fecha',
                        style: TextStyle(
                          color: selectedDate != null
                              ? Colors.black87
                              : Colors.grey[600],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  ElevatedButton.icon(
                    onPressed: () => _handleSearch(cities.origins, cities.destinations),
                    icon: const Icon(Icons.search),
                    label: const Text('Buscar Viajes'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                    ),
                  ),
                ],
              ),
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(32),
                  child: CircularProgressIndicator(),
                ),
              ),
              error: (e, st) => Center(
                child: Column(
                  children: [
                    const Icon(Icons.error_outline, color: Colors.red),
                    const SizedBox(height: 8),
                    Text('Error cargando ciudades: $e'),
                  ],
                ),
              ),
            ),
          ),

          // Results
          Expanded(
            child: tripsAsync.when(
              data: (trips) {
                // Estado inicial
                if (trips.isEmpty && _originController.text.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search, size: 80, color: Colors.grey[300]),
                        const SizedBox(height: 16),
                        Text(
                          'Escribe tu origen y destino\npara buscar viajes',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  );
                }

                // Sin resultados después de buscar
                if (trips.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.event_busy, size: 80, color: Colors.grey[300]),
                        const SizedBox(height: 16),
                        const Text(
                          'No se encontraron viajes',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          selectedDate != null
                              ? 'No hay viajes disponibles para esta fecha'
                              : 'No hay viajes disponibles en esta ruta',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              _originController.clear();
                              _destinationController.clear();
                              selectedDate = null;
                            });
                            ref.read(passengerTripsProvider.notifier).clearTrips();
                          },
                          icon: const Icon(Icons.refresh),
                          label: const Text('Nueva búsqueda'),
                        ),
                      ],
                    ),
                  );
                }

                // Mostrar resultados
                return Column(
                  children: [
                    // Header con cantidad de resultados
                    Container(
                      padding: const EdgeInsets.all(16),
                      color: Colors.green[50],
                      child: Row(
                        children: [
                          Icon(Icons.check_circle, color: Colors.green[700]),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              '${trips.length} ${trips.length == 1 ? 'viaje encontrado' : 'viajes encontrados'}',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.green[700],
                              ),
                            ),
                          ),
                          Text(
                            selectedDate != null
                                ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                                : 'Todas las fechas',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.green[700],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Lista de viajes
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: trips.length,
                        itemBuilder: (context, index) {
                          final trip = trips[index];
                          return TripCard(
                            trip: trip,
                            onTap: () => context.push(
                              '${AppRoutes.passengerTripDetail}/${trip.id}',
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, st) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 64, color: Colors.red),
                    const SizedBox(height: 16),
                    Text('Error: $e'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        final cities = citiesAsync.value;
                        if (cities != null) {
                          _handleSearch(cities.origins, cities.destinations);
                        }
                      },
                      child: const Text('Reintentar'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}