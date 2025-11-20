import 'package:bus_connect/core/constants/app_routes.dart';
import 'package:bus_connect/core/constants/enums/user_role.dart';
import 'package:bus_connect/core/constants/enums/user_status.dart';
import 'package:bus_connect/data/models/user_model/user_model.dart';
import 'package:bus_connect/presentation/providers/user_provider.dart';
import 'package:bus_connect/presentation/widgets/common/custom_button.dart';
import 'package:bus_connect/presentation/widgets/common/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class UserFormScreen extends ConsumerStatefulWidget {
  final bool isEdit;
  final int? userId;
  final bool showPasswordField;

  const UserFormScreen({
    Key? key,
    this.isEdit = false,
    this.userId,
    this.showPasswordField = true,
  }) : super(key: key);

  @override
  ConsumerState<UserFormScreen> createState() => _UserFormScreenState();
}

class _UserFormScreenState extends ConsumerState<UserFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _dateController = TextEditingController();

  UserRole _selectedRole = UserRole.PASSENGER;
  UserStatus _selectedStatus = UserStatus.ACTIVE;
  DateTime? _selectedDate;

  bool _isLoadingUser = false;
  bool _isSubmitting = false;
  String? _originalEmail;

  @override
  void initState() {
    super.initState();
    if (widget.isEdit && widget.userId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _loadUserData());
    }
  }

  Future<void> _loadUserData() async {
    setState(() => _isLoadingUser = true);

    await ref.read(userProvider.notifier).fetchUserById(widget.userId!);
    final user = ref.read(userProvider).selectedUser;

    if (user == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error al cargar los datos del usuario")),
        );
        context.go(AppRoutes.adminUsers);
      }
      setState(() => _isLoadingUser = false);
      return;
    }

    _usernameController.text = user.username;
    _emailController.text = user.email;
    _phoneController.text = user.phone;
    _selectedRole = user.role;
    _selectedStatus = user.status;
    _selectedDate = user.dateOfBirth;
    _dateController.text = DateFormat('dd/MM/yyyy').format(user.dateOfBirth);
    _originalEmail = user.email;

    setState(() => _isLoadingUser = false);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoadingUser) {
      return Scaffold(
        appBar: AppBar(title: const Text("Cargando usuario...")),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEdit ? "Editar Usuario" : "Nuevo Usuario"),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildSectionTitle("Información Personal"),
            const SizedBox(height: 16),

            CustomTextField(
              controller: _usernameController,
              label: "Nombre de usuario",
              prefixIcon: Icons.person,
              validator: (v) =>
              v == null || v.isEmpty ? "El nombre es requerido" : null,
            ),
            const SizedBox(height: 16),

            CustomTextField(
              controller: _emailController,
              label: "Correo electrónico",
              prefixIcon: Icons.email,
              keyboardType: TextInputType.emailAddress,
              validator: (v) {
                if (v == null || v.isEmpty) return "El correo es requerido";
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(v)) {
                  return "Correo inválido";
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            CustomTextField(
              controller: _phoneController,
              label: "Teléfono",
              prefixIcon: Icons.phone,
              keyboardType: TextInputType.phone,
              validator: (v) {
                if (v == null || v.isEmpty) return "El teléfono es requerido";
                if (v.length != 10) return "Debe tener 10 dígitos";
                return null;
              },
            ),
            const SizedBox(height: 16),

            if (widget.showPasswordField) ...[
              CustomTextField(
                controller: _passwordController,
                label: widget.isEdit
                    ? "Nueva contraseña (opcional - dejar vacío para no cambiar)"
                    : "Contraseña",
                prefixIcon: Icons.lock,
                obscureText: true,
                validator: (v) {
                  if (!widget.isEdit && (v == null || v.isEmpty)) {
                    return "La contraseña es requerida";
                  }
                  if (v != null && v.isNotEmpty && v.length < 6) {
                    return "Mínimo 6 caracteres";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
            ],

            TextFormField(
              controller: _dateController,
              decoration: const InputDecoration(
                labelText: 'Fecha de nacimiento',
                prefixIcon: Icon(Icons.calendar_today),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                filled: true,
                suffixIcon: Icon(Icons.arrow_drop_down),
              ),
              readOnly: true,
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate ?? DateTime(2000),
                  firstDate: DateTime(1940),
                  lastDate: DateTime.now(),
                  helpText: 'Seleccionar fecha de nacimiento',
                  cancelText: 'Cancelar',
                  confirmText: 'Aceptar',
                );

                if (date != null) {
                  setState(() {
                    _selectedDate = date;
                    _dateController.text = DateFormat('dd/MM/yyyy').format(date);
                  });
                }
              },
              validator: (v) {
                if (v == null || v.isEmpty) {
                  return "La fecha de nacimiento es requerida";
                }
                return null;
              },
            ),
            const SizedBox(height: 24),

            _buildSectionTitle("Información del Sistema"),
            const SizedBox(height: 16),

            DropdownButtonFormField<UserRole>(
              initialValue: _selectedRole,
              decoration: const InputDecoration(
                labelText: "Rol",
                prefixIcon: Icon(Icons.badge),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                filled: true,
              ),
              items: UserRole.values
                  .map((role) => DropdownMenuItem(
                value: role,
                child: Text(role.displayName),
              ))
                  .toList(),
              onChanged: (v) => setState(() => _selectedRole = v!),
            ),
            const SizedBox(height: 16),

            DropdownButtonFormField<UserStatus>(
              initialValue: _selectedStatus,
              decoration: const InputDecoration(
                labelText: "Estado",
                prefixIcon: Icon(Icons.toggle_on),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                filled: true,
              ),
              items: UserStatus.values
                  .map((status) => DropdownMenuItem(
                value: status,
                child: Text(status.displayName),
              ))
                  .toList(),
              onChanged: (v) => setState(() => _selectedStatus = v!),
            ),
            const SizedBox(height: 32),

            CustomButton(
              text: widget.isEdit ? "Actualizar Usuario" : "Crear Usuario",
              isLoading: _isSubmitting,
              onPressed: _submitForm,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    final notifier = ref.read(userProvider.notifier);
    bool success;

    try {
      if (widget.isEdit) {
        if (_emailController.text != _originalEmail) {
          final emailExists = await notifier.checkEmailExists(_emailController.text);
          if (emailExists) {
            setState(() => _isSubmitting = false);
            if (!mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("El correo ya está registrado")),
            );
            return;
          }
        }

        // ✅ ACTUALIZACIÓN - Password opcional (null si está vacío)
        final req = UserUpdateRequest(
          username: _usernameController.text,
          email: _emailController.text,
          phone: _phoneController.text,
          password: _passwordController.text.isNotEmpty
              ? _passwordController.text
              : null, // ✅ null = no se envía (includeIfNull: false)
          role: _selectedRole,
          status: _selectedStatus,
          dateOfBirth: _selectedDate,
        );

        success = await notifier.updateUser(widget.userId!, req);
      } else {
        final emailExists = await notifier.checkEmailExists(_emailController.text);
        if (emailExists) {
          setState(() => _isSubmitting = false);
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("El correo ya está registrado")),
          );
          return;
        }

        final phoneExists = await notifier.checkPhoneExists(_phoneController.text);
        if (phoneExists) {
          setState(() => _isSubmitting = false);
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("El teléfono ya está registrado")),
          );
          return;
        }

        final req = UserCreateRequest(
          username: _usernameController.text,
          email: _emailController.text,
          phone: _phoneController.text,
          password: _passwordController.text,
          role: _selectedRole,
          status: _selectedStatus,
          dateOfBirth: _selectedDate!,
        );

        success = await notifier.createUser(req);
      }

      if (!mounted) return;
      setState(() => _isSubmitting = false);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.isEdit
                ? "Usuario actualizado correctamente"
                : "Usuario creado exitosamente"),
          ),
        );
        context.go(AppRoutes.adminUsers);
      } else {
        final error = ref.read(userProvider).error ?? "Error desconocido";
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $error")),
        );
      }
    } catch (e) {
      setState(() => _isSubmitting = false);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error inesperado: $e")),
      );
    }
  }
}