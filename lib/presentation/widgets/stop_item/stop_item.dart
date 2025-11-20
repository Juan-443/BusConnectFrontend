import 'package:flutter/material.dart';
import '../../../../data/models/stop_model/stop_model.dart';

class StopItem extends StatelessWidget {
  final StopModel stop;
  final bool isFirst;
  final bool isLast;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const StopItem({
    super.key,
    required this.stop,
    this.isFirst = false,
    this.isLast = false,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Timeline visual
            SizedBox(
              width: 60,
              child: Column(
                children: [
                  // Línea superior
                  if (!isFirst)
                    Expanded(
                      child: Container(
                        width: 3,
                        color: Colors.blue,
                      ),
                    ),

                  // Icono del marcador
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: _getMarkerColor(),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: _getMarkerIcon(),
                    ),
                  ),

                  // Línea inferior
                  if (!isLast)
                    Expanded(
                      child: Container(
                        width: 3,
                        color: Colors.blue,
                      ),
                    ),
                ],
              ),
            ),

            // Contenido de la parada
            Expanded(
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: _getBorderColor(),
                    width: 2,
                  ),
                ),
                child: InkWell(
                  onTap: onTap,
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            // Orden
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: _getMarkerColor().withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '#${stop.order}',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: _getMarkerColor(),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),

                            // Nombre
                            Expanded(
                              child: Text(
                                stop.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            // Menú de opciones
                            PopupMenuButton(
                              icon: const Icon(Icons.more_vert),
                              itemBuilder: (ctx) => [
                                const PopupMenuItem(
                                  value: 'edit',
                                  child: Row(
                                    children: [
                                      Icon(Icons.edit, size: 20),
                                      SizedBox(width: 8),
                                      Text('Editar'),
                                    ],
                                  ),
                                ),
                                const PopupMenuItem(
                                  value: 'delete',
                                  child: Row(
                                    children: [
                                      Icon(Icons.delete, size: 20, color: Colors.red),
                                      SizedBox(width: 8),
                                      Text('Eliminar', style: TextStyle(color: Colors.red)),
                                    ],
                                  ),
                                ),
                              ],
                              onSelected: (value) {
                                switch (value) {
                                  case 'edit':
                                    onEdit?.call();
                                    break;
                                  case 'delete':
                                    onDelete?.call();
                                    break;
                                }
                              },
                            ),
                          ],
                        ),

                        if (stop.lat != null && stop.lng != null) ...[
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.location_on, size: 14, color: Colors.grey),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  'Lat: ${stop.lat?.toStringAsFixed(6)}, Lng: ${stop.lng?.toStringAsFixed(6)}',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],

                        // Etiquetas especiales
                        if (isFirst || isLast) ...[
                          const SizedBox(height: 8),
                          _buildBadge(
                            isFirst ? 'ORIGEN' : 'DESTINO',
                            isFirst ? Colors.green : Colors.red,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getMarkerColor() {
    if (isFirst) return Colors.green;
    if (isLast) return Colors.red;
    return Colors.blue;
  }

  Color _getBorderColor() {
    if (isFirst) return Colors.green.shade200;
    if (isLast) return Colors.red.shade200;
    return Colors.blue.shade200;
  }

  Widget _getMarkerIcon() {
    if (isFirst) {
      return const Icon(Icons.trip_origin, color: Colors.white, size: 20);
    }
    if (isLast) {
      return const Icon(Icons.flag, color: Colors.white, size: 20);
    }
    return const Icon(Icons.location_on, color: Colors.white, size: 20);
  }

  Widget _buildBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}