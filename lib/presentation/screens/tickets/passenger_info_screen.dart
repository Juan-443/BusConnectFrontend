import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_routes.dart';
import '../../../core/utils/validators.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/custom_text_field.dart';

class PassengerInfoScreen extends ConsumerStatefulWidget {
  final int tripId;
  final List<String> selectedSeats;

  const PassengerInfoScreen({
    super.key,
    required this.tripId,
    required this.selectedSeats,
  });

  @override
  ConsumerState<PassengerInfoScreen> createState() =>
      _PassengerInfoScreenState();
}

class _PassengerInfoScreenState extends ConsumerState<PassengerInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ciController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _ciController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _continueToPayment() {
    if (!_formKey.currentState!.validate()) return;

    final passengerData = {
      'tripId': widget.tripId,
      'selectedSeats': widget.selectedSeats,
      'passengerName': _nameController.text.trim(),
      'passengerCI': _ciController.text.trim(),
      'passengerPhone': _phoneController.text.trim(),
      'passengerEmail': _emailController.text.trim(),
    };

    context.push(AppRoutes.payment, extra: passengerData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Datos del Pasajero'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Selected Seats Info
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Asientos seleccionados',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: widget.selectedSeats.map((seat) {
                                return Chip(
                                  label: Text(seat),
                                  backgroundColor:
                                  AppColors.primary.withOpacity(0.1),
                                  labelStyle: const TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Form Fields
                    Text(
                      'Información del pasajero',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    CustomTextField(
                      controller: _nameController,
                      label: 'Nombre completo',
                      prefixIcon: Icons.person_outline,
                      validator: (value) =>
                          Validators.validateRequired(value, 'El nombre'),
                    ),
                    const SizedBox(height: 16),

                    CustomTextField(
                      controller: _ciController,
                      label: 'Cédula de Identidad',
                      prefixIcon: Icons.badge_outlined,
                      keyboardType: TextInputType.number,
                      validator: Validators.validateCI,
                    ),
                    const SizedBox(height: 16),

                    CustomTextField(
                      controller: _phoneController,
                      label: 'Teléfono',
                      prefixIcon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                      validator: Validators.validatePhone,
                    ),
                    const SizedBox(height: 16),

                    CustomTextField(
                      controller: _emailController,
                      label: 'Correo electrónico (opcional)',
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 24),

                    // Info Card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.info.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.info.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: AppColors.info,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Tu ticket será enviado al correo electrónico y podrás descargarlo desde la app.',
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.info,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
                text: 'Continuar al Pago',
                onPressed: _continueToPayment,
                icon: Icons.payment,
                width: double.infinity,
              ),
            ),
          ),
        ],
      ),
    );
  }
}