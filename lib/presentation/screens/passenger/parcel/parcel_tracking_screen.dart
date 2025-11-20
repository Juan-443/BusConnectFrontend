import 'package:bus_connect/core/constants/enums/parcel_status.dart';
import 'package:bus_connect/presentation/providers/passenger_parcel_tracking_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ParcelTrackingScreen extends ConsumerStatefulWidget {
  const ParcelTrackingScreen({super.key});

  @override
  ConsumerState<ParcelTrackingScreen> createState() => _ParcelTrackingScreenState();
}

class _ParcelTrackingScreenState extends ConsumerState<ParcelTrackingScreen> {
  final _codeController = TextEditingController();
  final _phoneController = TextEditingController();
  int _selectedTab = 0;

  @override
  void dispose() {
    _codeController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final parcelAsync = ref.watch(parcelTrackingProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rastrear Encomienda'),
      ),
      body: Column(
        children: [
          // Search Section
          Container(
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            child: Column(
              children: [
                // Tab Selector
                SegmentedButton<int>(
                  segments: const [
                    ButtonSegment(value: 0, label: Text('Por Código'), icon: Icon(Icons.qr_code)),
                    ButtonSegment(value: 1, label: Text('Por Teléfono'), icon: Icon(Icons.phone)),
                  ],
                  selected: {_selectedTab},
                  onSelectionChanged: (Set<int> newSelection) {
                    setState(() {
                      _selectedTab = newSelection.first;
                      ref.read(parcelTrackingProvider.notifier).reset();
                    });
                  },
                ),

                const SizedBox(height: 16),

                // Search Input
                if (_selectedTab == 0)
                  TextField(
                    controller: _codeController,
                    decoration: InputDecoration(
                      labelText: 'Código de Rastreo',
                      hintText: 'PCL-XXXXXXXXXX',
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _codeController.clear();
                          ref.read(parcelTrackingProvider.notifier).reset();
                        },
                      ),
                    ),
                    textCapitalization: TextCapitalization.characters,
                  )
                else
                  TextField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      labelText: 'Número de Teléfono',
                      hintText: '0000000000',
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.phone),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _phoneController.clear();
                          ref.read(parcelTrackingProvider.notifier).reset();
                        },
                      ),
                    ),
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                  ),

                const SizedBox(height: 16),

                // Search Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (_selectedTab == 0 && _codeController.text.isNotEmpty) {
                        ref.read(parcelTrackingProvider.notifier).trackByCode(_codeController.text);
                      } else if (_selectedTab == 1 && _phoneController.text.length == 10) {
                        ref.read(parcelTrackingProvider.notifier).trackByPhone(_phoneController.text);
                      }
                    },
                    icon: const Icon(Icons.search),
                    label: const Text('Buscar'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Results Section
          Expanded(
            child: parcelAsync.when(
              data: (parcel) {
                if (parcel == null) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.local_shipping, size: 64, color: Colors.grey[300]),
                        const SizedBox(height: 16),
                        Text(
                          'Ingresa un código de rastreo\no número de teléfono',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  );
                }

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Parcel Info Card
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Código: ${parcel.code}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  _buildStatusChip(parcel.status.name),
                                ],
                              ),
                              const Divider(height: 24),
                              _InfoRow('Remitente', parcel.senderName),
                              _InfoRow('Teléfono', parcel.senderPhone),
                              const SizedBox(height: 8),
                              _InfoRow('Destinatario', parcel.receiverName),
                              _InfoRow('Teléfono', parcel.receiverPhone),
                              const Divider(height: 24),
                              _InfoRow(
                                'Precio',
                                '\$${parcel.price.toStringAsFixed(2)}',
                                highlighted: true,
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Timeline
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Estado del Envío',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 16),
                              _buildTimeline(parcel.status.name, parcel.createdAt.toString(), parcel.deliveredAt),
                            ],
                          ),
                        ),
                      ),

                      if (parcel.status == ParcelStatus.DELIVERED && parcel.proofPhotoUrl != null) ...[
                        const SizedBox(height: 16),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Comprobante de Entrega',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const SizedBox(height: 16),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    parcel.proofPhotoUrl!,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => Container(
                                      height: 200,
                                      color: Colors.grey[200],
                                      child: const Center(
                                        child: Icon(Icons.broken_image, size: 48),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                    const SizedBox(height: 16),
                    const Text('No se encontró la encomienda'),
                    const SizedBox(height: 8),
                    Text(
                      e.toString(),
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      textAlign: TextAlign.center,
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

  Widget _buildStatusChip(String status) {
    Color color;
    IconData icon;
    String text;

    switch (status) {
      case 'CREATED':
        color = Colors.blue;
        icon = Icons.inventory_2;
        text = 'Creado';
        break;
      case 'IN_TRANSIT':
        color = Colors.orange;
        icon = Icons.local_shipping;
        text = 'En Tránsito';
        break;
      case 'DELIVERED':
        color = Colors.green;
        icon = Icons.check_circle;
        text = 'Entregado';
        break;
      case 'FAILED':
        color = Colors.red;
        icon = Icons.cancel;
        text = 'Fallido';
        break;
      default:
        color = Colors.grey;
        icon = Icons.help;
        text = status;
    }

    return Chip(
      avatar: Icon(icon, color: Colors.white, size: 16),
      label: Text(text, style: const TextStyle(color: Colors.white)),
      backgroundColor: color,
    );
  }

  Widget _buildTimeline(String status, String createdAt, String? deliveredAt) {
    final steps = [
      _TimelineStep('Creado', 'CREATED', Icons.inventory_2, createdAt),
      _TimelineStep('En Tránsito', 'IN_TRANSIT', Icons.local_shipping, null),
      _TimelineStep('Entregado', 'DELIVERED', Icons.check_circle, deliveredAt),
    ];

    final currentIndex = steps.indexWhere((s) => s.status == status);

    return Column(
      children: List.generate(steps.length, (index) {
        final step = steps[index];
        final isCompleted = index <= currentIndex;
        final isLast = index == steps.length - 1;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isCompleted ? Colors.green : Colors.grey[300],
                  ),
                  child: Icon(
                    step.icon,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                if (!isLast)
                  Container(
                    width: 2,
                    height: 40,
                    color: isCompleted ? Colors.green : Colors.grey[300],
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      step.title,
                      style: TextStyle(
                        fontWeight: isCompleted ? FontWeight.bold : FontWeight.normal,
                        fontSize: 16,
                      ),
                    ),
                    if (step.timestamp != null)
                      Text(
                        step.timestamp!,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class _TimelineStep {
  final String title;
  final String status;
  final IconData icon;
  final String? timestamp;

  _TimelineStep(this.title, this.status, this.icon, this.timestamp);
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final bool highlighted;

  const _InfoRow(this.label, this.value, {this.highlighted = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[600])),
          Text(
            value,
            style: TextStyle(
              fontWeight: highlighted ? FontWeight.bold : FontWeight.w500,
              fontSize: highlighted ? 18 : 14,
            ),
          ),
        ],
      ),
    );
  }
}