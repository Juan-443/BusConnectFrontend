import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/validators.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../data/models/parcel_model/parcel_model.dart';
import '../../../data/models/stop_model/stop_model.dart';
import '../../providers/parcel_provider.dart';
import '../../providers/route_provider.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/custom_text_field.dart';

class CreateParcelScreen extends ConsumerStatefulWidget {
  const CreateParcelScreen({super.key});

  @override
  ConsumerState<CreateParcelScreen> createState() => _CreateParcelScreenState();
}

class _CreateParcelScreenState extends ConsumerState<CreateParcelScreen> {
  final _formKey = GlobalKey<FormState>();
  final _senderNameController = TextEditingController();
  final _senderPhoneController = TextEditingController();
  final _receiverNameController = TextEditingController();
  final _receiverPhoneController = TextEditingController();
  final _descriptionController = TextEditingController();

  StopResponse? _fromStop;
  StopResponse? _toStop;
  double _estimatedPrice = 0.0;

  @override
  void dispose() {
    _senderNameController.dispose();
    _senderPhoneController.dispose();
    _receiverNameController.dispose();
    _receiverPhoneController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _calculatePrice() {
    if (_fromStop != null && _toStop != null) {
      // Cálculo simple basado en distancia
      // TODO: Implementar cálculo real desde API
      setState(() {
        _estimatedPrice = 25.0 + (10.0 * (_toStop!.order - _fromStop!.order).abs());
      });
    }
  }

  Future<void> _createParcel() async {
    if (!_formKey.currentState!.validate()) return;

    if (_fromStop == null || _toStop == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor selecciona origen y destino'),
          backgroundColor: AppColors.warning,
        ),
      );
      return;
    }

    final request = ParcelCreateRequest(
      senderName: _senderNameController.text.trim(),
      senderPhone: _senderPhoneController.text.trim(),
      receiverName: _receiverNameController.text.trim(),
      receiverPhone: _receiverPhoneController.text.trim(),
      price: _estimatedPrice,
      fromStopId: _fromStop!.id,
      toStopId: _toStop!.id,
    );

    final parcelNotifier = ref.read(parcelProvider.notifier);
    final success = await parcelNotifier.createParcel(request);

    if (!mounted) return;

    if (success) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle,
                  color: AppColors.success,
                  size: 64,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                '¡Encomienda Creada!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Tu encomienda ha sido registrada exitosamente',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          actions: [
            CustomButton(
              text: 'Ver Encomiendas',
              onPressed: () {
                context.pop(); // Close dialog
                context.pop(); // Go back to previous screen
              },
              width: double.infinity,
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(ref.read(parcelProvider).error ?? 'Error al crear encomienda'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final routesAsync = ref.watch(allRoutesProvider);
    final parcelState = ref.watch(parcelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Enviar Encomienda'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Info Card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.inventory_2,
                            color: AppColors.primary,
                            size: 32,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              'Envía paquetes de forma segura y rápida',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Sender Section
                    Text(
                      'Datos del Remitente',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    CustomTextField(
                      controller: _senderNameController,
                      label: 'Nombre del remitente',
                      prefixIcon: Icons.person_outline,
                      validator: (value) =>
                          Validators.validateRequired(value, 'El nombre'),
                    ),
                    const SizedBox(height: 16),

                    CustomTextField(
                      controller: _senderPhoneController,
                      label: 'Teléfono del remitente',
                      prefixIcon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                      validator: Validators.validatePhone,
                    ),
                    const SizedBox(height: 24),

                    // Receiver Section
                    Text(
                      'Datos del Destinatario',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    CustomTextField(
                      controller: _receiverNameController,
                      label: 'Nombre del destinatario',
                      prefixIcon: Icons.person_outline,
                      validator: (value) =>
                          Validators.validateRequired(value, 'El nombre'),
                    ),
                    const SizedBox(height: 16),

                    CustomTextField(
                      controller: _receiverPhoneController,
                      label: 'Teléfono del destinatario',
                      prefixIcon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                      validator: Validators.validatePhone,
                    ),
                    const SizedBox(height: 24),

                    // Route Section
                    Text(
                      'Origen y Destino',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    routesAsync.when(
                      data: (routes) {
                        // Get all stops from all routes
                        final allStops = <StopResponse>[];
                        for (final route in routes) {
                          if (route.stops != null) {
                            allStops.addAll(route.stops!);
                          }
                        }

                        return Column(
                          children: [
                            DropdownButtonFormField<StopResponse>(
                              value: _fromStop,
                              decoration: InputDecoration(
                                labelText: 'Origen',
                                prefixIcon: const Icon(Icons.location_on),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              items: allStops.map((stop) {
                                return DropdownMenuItem(
                                  value: stop,
                                  child: Text(stop.name),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _fromStop = value;
                                  _calculatePrice();
                                });
                              },
                            ),
                            const SizedBox(height: 16),
                            DropdownButtonFormField<StopResponse>(
                              value: _toStop,
                              decoration: InputDecoration(
                                labelText: 'Destino',
                                prefixIcon: const Icon(Icons.location_on_outlined),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              items: allStops.map((stop) {
                                return DropdownMenuItem(
                                  value: stop,
                                  child: Text(stop.name),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _toStop = value;
                                  _calculatePrice();
                                });
                              },
                            ),
                          ],
                        );
                      },
                      loading: () => const CircularProgressIndicator(),
                      error: (error, stack) => Text('Error: ${error.toString()}'),
                    ),
                    const SizedBox(height: 24),

                    // Description (Optional)
                    CustomTextField(
                      controller: _descriptionController,
                      label: 'Descripción del paquete (opcional)',
                      prefixIcon: Icons.description_outlined,
                      maxLines: 3,
                    ),

                    // Price Display
                    if (_estimatedPrice > 0) ...[
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.success.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.success.withOpacity(0.3),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Precio estimado:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              CurrencyFormatter.format(_estimatedPrice),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.success,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),

            // Bottom Button
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SafeArea(
                child: CustomButton(
                  text: 'Registrar Encomienda',
                  onPressed: _createParcel,
                  icon: Icons.send,
                  width: double.infinity,
                  isLoading: parcelState.isLoading,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}