import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/user_provider.dart';
import '../../../../core/constants/enums/user_role.dart';
import '../../../../core/constants/enums/user_status.dart';
import '../../../widgets/common/loading_indicator.dart';
import '../../../widgets/common/error_widget.dart' as custom;

class UserListScreen extends ConsumerStatefulWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends ConsumerState<UserListScreen> {
  UserRole? _selectedRole;
  UserStatus? _selectedStatus;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    // Cargar usuarios al inicio
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(userProvider.notifier).fetchAllUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userProvider);
    final notifier = ref.read(userProvider.notifier);

    var users = state.filteredUsers;

    // Aplicar filtro de búsqueda
    if (_searchQuery.isNotEmpty) {
      users = users.where((user) {
        return user.username.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            user.email.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            user.phone.contains(_searchQuery);
      }).toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Usuarios'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.pushNamed(context, '/admin/users/create'),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildFilterChips(notifier),
          Expanded(
            child: state.isLoading
                ? const LoadingIndicator()
                : state.hasError
                ? custom.ErrorDisplay(
              message: state.error!,
              onRetry: () => notifier.fetchAllUsers(),
            )
                : users.isEmpty
                ? const Center(child: Text('No se encontraron usuarios'))
                : RefreshIndicator(
              onRefresh: () => notifier.fetchAllUsers(),
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: _getRoleColor(user.role.name),
                        child: Text(
                          user.username[0].toUpperCase(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(user.username),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(user.email),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              _buildRoleBadge(user.role.name),
                              const SizedBox(width: 8),
                              _buildStatusBadge(user.status.name),
                            ],
                          ),
                        ],
                      ),
                      trailing: PopupMenuButton(
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'view',
                            child: Row(
                              children: [
                                Icon(Icons.visibility),
                                SizedBox(width: 8),
                                Text('Ver detalles'),
                              ],
                            ),
                          ),
                          const PopupMenuItem(
                            value: 'edit',
                            child: Row(
                              children: [
                                Icon(Icons.edit),
                                SizedBox(width: 8),
                                Text('Editar'),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 'status',
                            child: Row(
                              children: [
                                Icon(
                                  user.status == 'ACTIVE'
                                      ? Icons.block
                                      : Icons.check_circle,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  user.status == 'ACTIVE'
                                      ? 'Desactivar'
                                      : 'Activar',
                                ),
                              ],
                            ),
                          ),
                          const PopupMenuItem(
                            value: 'delete',
                            child: Row(
                              children: [
                                Icon(Icons.delete, color: Colors.red),
                                SizedBox(width: 8),
                                Text('Eliminar',
                                    style: TextStyle(color: Colors.red)),
                              ],
                            ),
                          ),
                        ],
                        onSelected: (value) => _handleMenuAction(value, user, notifier),
                      ),
                      onTap: () {
                        notifier.selectUser(user);
                        Navigator.pushNamed(context, '/admin/users/detail');
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Buscar usuarios...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
        ),
        onChanged: (value) => setState(() => _searchQuery = value),
      ),
    );
  }

  Widget _buildFilterChips(UserNotifier notifier) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          if (_selectedRole != null)
            Chip(
              label: Text('Rol: ${_selectedRole!.name}'),
              onDeleted: () {
                setState(() => _selectedRole = null);
                notifier.setRoleFilter(null);
              },
            ),
          if (_selectedStatus != null) ...[
            const SizedBox(width: 8),
            Chip(
              label: Text('Estado: ${_selectedStatus!.name}'),
              onDeleted: () {
                setState(() => _selectedStatus = null);
                notifier.setStatusFilter(null);
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRoleBadge(String role) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getRoleColor(role).withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        role,
        style: TextStyle(
          color: _getRoleColor(role),
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    final color = status == 'ACTIVE' ? Colors.green : Colors.grey;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Color _getRoleColor(String role) {
    switch (role) {
      case 'ADMIN':
        return Colors.purple;
      case 'DISPATCHER':
        return Colors.blue;
      case 'DRIVER':
        return Colors.orange;
      case 'CLERK':
        return Colors.green;
      case 'PASSENGER':
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }

  void _handleMenuAction(dynamic value, user, UserNotifier notifier) {
    switch (value) {
      case 'view':
        notifier.selectUser(user);
        Navigator.pushNamed(context, '/admin/users/detail');
        break;
      case 'edit':
        notifier.selectUser(user);
        Navigator.pushNamed(context, '/admin/users/edit');
        break;
      case 'status':
        _changeUserStatus(user, notifier);
        break;
      case 'delete':
        _confirmDelete(user, notifier);
        break;
    }
  }

  void _changeUserStatus(user, UserNotifier notifier) async {
    final newStatus = user.status == 'ACTIVE'
        ? UserStatus.INACTIVE
        : UserStatus.ACTIVE;

    final success = await notifier.changeUserStatus(user.id, newStatus);
    final state = ref.read(userProvider);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(success
            ? 'Estado actualizado'
            : state.error ?? 'Error al actualizar estado'),
      ),
    );
  }

  void _confirmDelete(user, UserNotifier notifier) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar eliminación'),
        content: Text('¿Estás seguro de eliminar a ${user.username}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              final success = await notifier.deleteUser(user.id);
              final state = ref.read(userProvider);

              if (!mounted) return;

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(success
                      ? 'Usuario eliminado'
                      : state.error ?? 'Error al eliminar'),
                ),
              );
            },
            child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    final notifier = ref.read(userProvider.notifier);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filtros'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<UserRole>(
              initialValue: _selectedRole,
              decoration: const InputDecoration(labelText: 'Rol'),
              items: UserRole.values.map((role) {
                return DropdownMenuItem(
                  value: role,
                  child: Text(role.name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() => _selectedRole = value);
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<UserStatus>(
              initialValue: _selectedStatus,
              decoration: const InputDecoration(labelText: 'Estado'),
              items: UserStatus.values.map((status) {
                return DropdownMenuItem(
                  value: status,
                  child: Text(status.name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() => _selectedStatus = value);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _selectedRole = null;
                _selectedStatus = null;
              });
              notifier.clearFilters();
              Navigator.pop(context);
            },
            child: const Text('Limpiar'),
          ),
          TextButton(
            onPressed: () {
              notifier.setRoleFilter(_selectedRole);
              notifier.setStatusFilter(_selectedStatus);
              Navigator.pop(context);
            },
            child: const Text('Aplicar'),
          ),
        ],
      ),
    );
  }
}
