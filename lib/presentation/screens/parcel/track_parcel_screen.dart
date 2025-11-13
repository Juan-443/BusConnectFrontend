import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/enums/parcel_status.dart';
import '../../../core/utils/date_formatter.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../data/models/parcel_model/parcel_model.dart';
import '../../providers/parcel_provider.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/custom_text_field.dart';

class TrackParcelScreen extends ConsumerStatefulWidget {
  const TrackParcelScreen({super.key});

  @override
  ConsumerState<TrackParcelScreen> createState() => _TrackParcelScreenState();
}

class _TrackParcelScreenState extends ConsumerState<TrackParcelScreen> {
  final _codeController = TextEditingController();
  ParcelResponse? _trackedParcel;
  bool _isSearching = false;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _trackParcel() async {
    if (_codeController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ingresa el código de la encomienda'),
          backgroundColor: AppColors.warning,
        ),
      );
      return;
    }

    setState(() => _isSearching = true);

    final parcel = await ref
        .read(parcelProvider.notifier)
        .trackParcel(_codeController.text.trim());

    setState(() {
      _isSearching = false;
      _trackedParcel = parcel;
    });

    if (parcel == null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Encomienda no encontrada'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rastrear Encomienda'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Ingresa el código de seguimiento',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            controller: _codeController,
                            label: 'Código',
                            prefixIcon: Icons.qr_code,
                            hint: 'Ej: PCL-12345',
                          ),
                        ),
                        const SizedBox(width: 12),
                        CustomButton(
                          text: 'Buscar',
                          onPressed: _trackParcel,
                          icon: Icons.search,
                          isLoading: _isSearching,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Results
            if (_trackedParcel != null) ...[
              const SizedBox(height: 24),
              _ParcelTrackingInfo(parcel: _trackedParcel!),
            ],
          ],
        ),
      ),
    );
  }
}

class _ParcelTrackingInfo extends StatelessWidget {
  final ParcelResponse parcel;

  const _ParcelTrackingInfo({required this.parcel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Status Card
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _StatusBadge(status: parcel.status),
                const SizedBox(height: 16),
                Text(
                  parcel.status.displayName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Código: ${parcel.code}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Details Card
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Detalles de la Encomienda',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(height: 24),

                _InfoRow(
                  icon: Icons.person,
                  label: 'Remitente',
                  value: parcel.senderName,
                ),
                const SizedBox(height: 16),
                _InfoRow(
                  icon: Icons.phone,
                  label: 'Teléfono',
                  value: parcel.senderPhone,
                ),
                const Divider(height: 24),

                _InfoRow(
                  icon: Icons.person_outline,
                  label: 'Destinatario',
                  value: parcel.receiverName,
                ),
                const SizedBox(height: 16),
                _InfoRow(
                  icon: Icons.phone_outlined,
                  label: 'Teléfono',
                  value: parcel.receiverPhone,
                ),
                const Divider(height: 24),

                if (parcel.fromStop != null)
                  _InfoRow(
                    icon: Icons.location_on,
                    label: 'Origen',
                    value: parcel.fromStop!.name,
                  ),
                const SizedBox(height: 16),
                if (parcel.toStop != null)
                  _InfoRow(
                    icon: Icons.location_on_outlined,
                    label: 'Destino',
                    value: parcel.toStop!.name,
                  ),
                const Divider(height: 24),

                _InfoRow(
                  icon: Icons.attach_money,
                  label: 'Precio',
                  value: CurrencyFormatter.format(parcel.price),
                ),
                const SizedBox(height: 16),
                _InfoRow(
                  icon: Icons.calendar_today,
                  label: 'Fecha de registro',
                  value: DateFormatter.formatDateTime(
                    DateTime.parse(parcel.createdAt),
                  ),
                ),

                if (parcel.deliveredAt != null) ...[
                  const SizedBox(height: 16),
                  _InfoRow(
                    icon: Icons.check_circle,
                    label: 'Fecha de entrega',
                    value: DateFormatter.formatDateTime(
                      DateTime.parse(parcel.deliveredAt!),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),

        // Timeline
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Historial',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _TimelineItem(
                  title: 'Encomienda creada',
                  date: DateFormatter.formatDateTime(
                    DateTime.parse(parcel.createdAt),
                  ),
                  isCompleted: true,
                  isFirst: true,
                ),
                if (parcel.status == ParcelStatus.IN_TRANSIT ||
                    parcel.status == ParcelStatus.DELIVERED)
                  _TimelineItem(
                    title: 'En tránsito',
                    date: 'Viajando',
                    isCompleted: true,
                  ),
                if (parcel.status == ParcelStatus.DELIVERED)
                  _TimelineItem(
                    title: 'Entregado',
                    date: parcel.deliveredAt != null
                        ? DateFormatter.formatDateTime(
                      DateTime.parse(parcel.deliveredAt!),
                    )
                        : '',
                    isCompleted: true,
                    isLast: true,
                  ),
                if (parcel.status == ParcelStatus.FAILED)
                  _TimelineItem(
                    title: 'Entrega fallida',
                    date: 'No se pudo entregar',
                    isCompleted: true,
                    isLast: true,
                    isFailed: true,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final ParcelStatus status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    IconData icon;

    switch (status) {
      case ParcelStatus.CREATED:
        color = AppColors.info;
        icon = Icons.inventory_2;
        break;
      case ParcelStatus.IN_TRANSIT:
        color = AppColors.warning;
        icon = Icons.local_shipping;
        break;
      case ParcelStatus.DELIVERED:
        color = AppColors.success;
        icon = Icons.check_circle;
        break;
      case ParcelStatus.FAILED:
        color = AppColors.error;
        icon = Icons.error;
        break;
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: 48),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: AppColors.primary),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                value,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final String title;
  final String date;
  final bool isCompleted;
  final bool isFirst;
  final bool isLast;
  final bool isFailed;

  const _TimelineItem({
    required this.title,
    required this.date,
    this.isCompleted = false,
    this.isFirst = false,
    this.isLast = false,
    this.isFailed = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isFailed
        ? AppColors.error
        : isCompleted
        ? AppColors.success
        : AppColors.grey300;

    return IntrinsicHeight(
      child: Row(
        children: [
          Column(
            children: [
              if (!isFirst)
                Container(
                  width: 2,
                  height: 20,
                  color: color,
                ),
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.white,
                    width: 3,
                  ),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: color,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    date,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}