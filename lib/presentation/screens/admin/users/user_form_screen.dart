import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/user_provider.dart';
import '../../../../core/constants/enums/user_role.dart';
import '../../../../core/constants/enums/user_status.dart';
import '../../../../data/models/user_model/user_model.dart';
import '../../../widgets/common/custom_button.dart';
import '../../../widgets/common/custom_text_field.dart';

class UserFormScreen extends ConsumerStatefulWidget {
  final bool isEdit;

  const UserFormScreen({Key? key, this.isEdit = false}) : super(key: key);

  @override
  ConsumerState<UserFormScreen> createState() => _UserFormScreenState();
}

class _UserFormScreenState extends ConsumerState<UserFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  UserRole _selectedRole = UserRole.PASSENGER;
  UserStatus _selectedStatus = UserStatus.ACTIVE;
  DateTime? _dateOfBirth;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.isEdit) {
      _loadUserData();
    }
  }

  void _loadUserData() {
    final user = ref.read(userProvider).selectedUser;
    if (user != null) {
      _usernameController.text = user.username;
      _emailController.text = user.email;
      _phoneController.text = user.phone;
      _selectedRole = UserRole.values.firstWhere(
            (r) => r.name.toUpperCase() == user.role,
        orElse: () => UserRole.PASSENGER,
      );
      _selectedStatus = UserStatus.values.firstWhere(
            (s) => s.name.toUpperCase() == user.status,
        orElse: () => UserStatus.ACTIVE,
      );
      _dateOfBirth = user.dateOfBirth;
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userProvider);
    final notifier = ref.read(userProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEdit ? 'Editar Usuario' : 'Nuevo Usuario'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildSectionTitle('Información Personal'),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _usernameController,
              label: 'Nombre de usuario',
              prefixIcon: Icons.person,
              validator: (value) =>
              (value == null || value.isEmpty) ? 'El nombre es requerido' : null,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _emailController,
              label: 'Email',
              prefixIcon: Icons.email,
              keyboardType: TextInputType.emailAddress,
              enabled: !widget.isEdit,
              validator: (value) {
                if (value == null || value.isEmpty) return 'El email es requerido';
                if (!value.contains('@')) return 'Email inválido';
                return null;
              },
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _phoneController,
              label: 'Teléfono',
              prefixIcon: Icons.phone,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) return 'El teléfono es requerido';
                if (value.length != 10) return 'El teléfono debe tener 10 dígitos';
                return null;
              },
            ),
            const SizedBox(height: 16),
            _buildDateOfBirthField(),
            const SizedBox(height: 24),
            _buildSectionTitle('Información de la Cuenta'),
            const SizedBox(height: 16),
            _buildRoleDropdown(),
            const SizedBox(height: 16),
            if (widget.isEdit) _buildStatusDropdown(),
            if (!widget.isEdit) ...[
              const SizedBox(height: 24),
              _buildSectionTitle('Contraseña'),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _passwordController,
                label: 'Contraseña',
                prefixIcon: Icons.lock,
                obscureText: _obscurePassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'La contraseña es requerida';
                  if (value.length < 8) return 'La contraseña debe tener al menos 8 caracteres';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _confirmPasswordController,
                label: 'Confirmar contraseña',
                prefixIcon: Icons.lock_outline,
                obscureText: _obscureConfirmPassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () =>
                      setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                ),
                validator: (value) {
                  if (value != _passwordController.text) return 'Las contraseñas no coinciden';
                  return null;
                },
              ),
            ],
            const SizedBox(height: 32),
            CustomButton(
              text: widget.isEdit ? 'Actualizar Usuario' : 'Crear Usuario',
              isLoading: _isLoading,
              onPressed: () => _submitForm(notifier, userState),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) => Text(
    title,
    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  );

  Widget _buildDateOfBirthField() {
    return InkWell(
      onTap: _selectDateOfBirth,
      child: InputDecorator(
        decoration: const InputDecoration(
          labelText: 'Fecha de nacimiento',
          prefixIcon: Icon(Icons.calendar_today),
          border: OutlineInputBorder(),
        ),
        child: Text(_dateOfBirth != null
            ? '${_dateOfBirth!.day}/${_dateOfBirth!.month}/${_dateOfBirth!.year}'
            : 'Seleccionar fecha'),
      ),
    );
  }

  Widget _buildRoleDropdown() {
    return DropdownButtonFormField<UserRole>(
      initialValue: _selectedRole,
      decoration: const InputDecoration(
        labelText: 'Rol',
        prefixIcon: Icon(Icons.admin_panel_settings),
        border: OutlineInputBorder(),
      ),
      items: UserRole.values
          .map((role) => DropdownMenuItem(
        value: role,
        child: Text(_getRoleDisplayName(role)),
      ))
          .toList(),
      onChanged: (value) {
        if (value != null) setState(() => _selectedRole = value);
      },
      validator: (value) => value == null ? 'Selecciona un rol' : null,
    );
  }

  Widget _buildStatusDropdown() {
    return DropdownButtonFormField<UserStatus>(
      initialValue: _selectedStatus,
      decoration: const InputDecoration(
        labelText: 'Estado',
        prefixIcon: Icon(Icons.toggle_on),
        border: OutlineInputBorder(),
      ),
      items: UserStatus.values
          .map((status) => DropdownMenuItem(
        value: status,
        child: Text(_getStatusDisplayName(status)),
      ))
          .toList(),
      onChanged: (value) {
        if (value != null) setState(() => _selectedStatus = value);
      },
    );
  }

  String _getRoleDisplayName(UserRole role) {
    switch (role) {
      case UserRole.ADMIN:
        return 'Administrador';
      case UserRole.DISPATCHER:
        return 'Despachador';
      case UserRole.DRIVER:
        return 'Conductor';
      case UserRole.CLERK:
        return 'Vendedor';
      case UserRole.PASSENGER:
        return 'Pasajero';
    }
  }

  String _getStatusDisplayName(UserStatus status) {
    switch (status) {
      case UserStatus.ACTIVE:
        return 'Activo';
      case UserStatus.INACTIVE:
        return 'Inactivo';
      case UserStatus.BLOCKED:
        return 'Bloqueado';
    }
  }

  Future<void> _selectDateOfBirth() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dateOfBirth ?? DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) setState(() => _dateOfBirth = picked);
  }

  Future<void> _submitForm(UserNotifier notifier, UserState state) async {
    if (!_formKey.currentState!.validate()) return;

    if (_dateOfBirth == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecciona una fecha de nacimiento')),
      );
      return;
    }

    setState(() => _isLoading = true);

    bool success;
    if (widget.isEdit) {
      final user = state.selectedUser;
      if (user == null) return;

      final request = UserUpdateRequest(
        username: _usernameController.text,
        phone: _phoneController.text,
        status: _selectedStatus,
        dateOfBirth: _dateOfBirth,
      );

      success = await notifier.updateUser(user.id, request);
    } else {
      final request = UserCreateRequest(
        username: _usernameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        role: _selectedRole,
        password: _passwordController.text,
        dateOfBirth: _dateOfBirth!,
      );

      success = await notifier.createUser(request);
    }

    setState(() => _isLoading = false);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(success
            ? (widget.isEdit ? 'Usuario actualizado' : 'Usuario creado')
            : state.error ?? 'Error al guardar'),
      ),
    );

    if (success) Navigator.pop(context);
  }
}
