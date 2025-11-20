import 'package:bus_connect/core/constants/app_routes.dart';
import 'package:bus_connect/core/constants/enums/dynamic_pricing_status.dart';
import 'package:bus_connect/presentation/providers/route_provider.dart';
import 'package:bus_connect/presentation/providers/stop_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../providers/fare_rule_provider.dart';
import '../../../widgets/common/custom_button.dart';
import '../../../widgets/common/custom_text_field.dart';
import '../../../../data/models/fare_rule_model/fare_rule_model.dart';

class FareRuleFormScreen extends ConsumerStatefulWidget {
  final bool isEdit;
  final int? fareRuleId;

  const FareRuleFormScreen({Key? key, this.isEdit = false, this.fareRuleId}) : super(key: key);

  @override
  ConsumerState<FareRuleFormScreen> createState() => _FareRuleFormScreenState();
}

class _FareRuleFormScreenState extends ConsumerState<FareRuleFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _basePriceController = TextEditingController();

  int? _selectedRouteId;
  int? _selectedFromStopId;
  int? _selectedToStopId;
  DynamicPricingStatus _dynamicPricing = DynamicPricingStatus.OFF;

  bool _isLoading = false;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(routeProvider.notifier).fetchAllRoutes();
      if (widget.isEdit && widget.fareRuleId != null) _loadFareRuleData();
    });
  }

  Future<void> _loadFareRuleData() async {
    setState(() => _isLoading = true);
    await ref.read(fareRuleProvider.notifier).fetchFareRuleById(widget.fareRuleId!);
    final fareRule = ref.read(fareRuleProvider).selectedFareRule;

    if (fareRule != null) {
      _basePriceController.text = fareRule.basePrice.toString();
      _selectedRouteId = fareRule.routeId;
      _selectedFromStopId = fareRule.fromStopId;
      _selectedToStopId = fareRule.toStopId;
      _dynamicPricing = fareRule.dynamicPricing;

      // Cargar stops de la ruta
      await ref.read(stopProvider.notifier).fetchStopsByRoute(fareRule.routeId);
    }
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text("Cargando...")),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final routes = ref.watch(routeProvider).routes;
    final stops = ref.watch(stopProvider).stops;

    return Scaffold(
      appBar: AppBar(title: Text(widget.isEdit ? "Editar Tarifa" : "Nueva Tarifa")),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            DropdownButtonFormField<int>(
              initialValue: _selectedRouteId,
              decoration: const InputDecoration(
                labelText: "Ruta",
                prefixIcon: Icon(Icons.route),
                border: OutlineInputBorder(),
              ),
              items: routes.map((r) => DropdownMenuItem(value: r.id, child: Text(r.name))).toList(),
              onChanged: widget.isEdit
                  ? null
                  : (v) async {
                setState(() {
                  _selectedRouteId = v;
                  _selectedFromStopId = null;
                  _selectedToStopId = null;
                });
                if (v != null) {
                  await ref.read(stopProvider.notifier).fetchStopsByRoute(v);
                }
              },
              validator: (v) => v == null ? "Selecciona una ruta" : null,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<int>(
              initialValue: _selectedFromStopId,
              decoration: const InputDecoration(
                labelText: "Desde",
                prefixIcon: Icon(Icons.location_on),
                border: OutlineInputBorder(),
              ),
              items: stops.map((s) => DropdownMenuItem(value: s.id, child: Text(s.name))).toList(),
              onChanged: widget.isEdit ? null : (v) => setState(() => _selectedFromStopId = v),
              validator: (v) => v == null ? "Selecciona parada origen" : null,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<int>(
              initialValue: _selectedToStopId,
              decoration: const InputDecoration(
                labelText: "Hasta",
                prefixIcon: Icon(Icons.location_on),
                border: OutlineInputBorder(),
              ),
              items: stops.map((s) => DropdownMenuItem(value: s.id, child: Text(s.name))).toList(),
              onChanged: widget.isEdit ? null : (v) => setState(() => _selectedToStopId = v),
              validator: (v) => v == null ? "Selecciona parada destino" : null,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _basePriceController,
              label: "Precio Base",
              prefixIcon: Icons.attach_money,
              keyboardType: TextInputType.number,
              validator: (v) {
                if (v == null || v.isEmpty) return "Requerido";
                if (double.tryParse(v) == null || double.parse(v) < 0) {
                  return "Precio inválido";
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<DynamicPricingStatus>(
              initialValue: _dynamicPricing,
              decoration: const InputDecoration(
                labelText: "Precio Dinámico",
                prefixIcon: Icon(Icons.trending_up),
                border: OutlineInputBorder(),
              ),
              items: DynamicPricingStatus.values
                  .map((s) => DropdownMenuItem(
                value: s,
                child: Text(s == DynamicPricingStatus.ON ? 'Activo' : 'Inactivo'),
              ))
                  .toList(),
              onChanged: (v) => setState(() => _dynamicPricing = v!),
            ),
            const SizedBox(height: 32),
            CustomButton(
              text: widget.isEdit ? "Actualizar" : "Crear",
              isLoading: _isSubmitting,
              onPressed: _submitForm,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);
    final notifier = ref.read(fareRuleProvider.notifier);
    bool success;

    if (widget.isEdit) {
      final req = FareRuleUpdateRequest(
        basePrice: double.parse(_basePriceController.text),
        dynamicPricing: _dynamicPricing,
      );
      success = await notifier.updateFareRule(widget.fareRuleId!, req);
    } else {
      final req = FareRuleCreateRequest(
        basePrice: double.parse(_basePriceController.text),
        dynamicPricing: _dynamicPricing,
        routeId: _selectedRouteId!,
        fromStopId: _selectedFromStopId!,
        toStopId: _selectedToStopId!,
      );
      success = await notifier.createFareRule(req);
    }

    if (!mounted) return;
    setState(() => _isSubmitting = false);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(widget.isEdit ? "Actualizado" : "Creado")),
      );
      context.go(AppRoutes.adminFareRules);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(ref.read(fareRuleProvider).error ?? "Error")),
      );
    }
  }

  @override
  void dispose() {
    _basePriceController.dispose();
    super.dispose();
  }
}