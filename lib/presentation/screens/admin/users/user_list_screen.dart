import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../providers/user_provider.dart';
import '../../../../core/constants/enums/user_role.dart';
import '../../../../core/constants/enums/user_status.dart';
import '../../../widgets/common/loading_indicator.dart';
import '../../../widgets/common/error_widget.dart' as custom;
import '../../../../core/constants/app_routes.dart';

class UserListScreen extends ConsumerStatefulWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends ConsumerState<UserListScreen> {
  UserRole? _selectedRole;
  UserStatus? _selectedStatus;
  String _searchQuery = '';

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(userProvider.notifier).fetchAllUsers(isRefresh: true);
    });
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {

      ref.read(userProvider.notifier).loadMoreUsers();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userProvider);
    final notifier = ref.read(userProvider.notifier);
    final currentUser = state.currentUser;

    var users = state.filteredUsers;

    // Búsqueda local
    if (_searchQuery.isNotEmpty) {
      users = users.where((user) {
        return user.username.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            user.email.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            user.phone.contains(_searchQuery);
      }).toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Gestión de Usuarios'),
            if (users.isNotEmpty)
              Text(
                '${users.length} usuario${users.length != 1 ? 's' : ''}',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.go(AppRoutes.adminUserCreate),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildFilterChips(notifier),

          if (currentUser != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.1),
                border: Border(
                  bottom: BorderSide(
                    color: Colors.blue.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.account_circle,
                    size: 20,
                    color: Colors.blue[700],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sesión actual: ${currentUser.username}',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue[900],
                          ),
                        ),
                        Text(
                          '${currentUser.role.displayName} • ${currentUser.email}',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.blue[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Excluido de lista',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.green[800],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          Expanded(
            child: state.isLoading && users.isEmpty
                ? const LoadingIndicator()
                : state.hasError && users.isEmpty
                ? custom.ErrorDisplay(
              message: state.error!,
              onRetry: () => notifier.fetchAllUsers(isRefresh: true),
            )
                : users.isEmpty
                ? _buildEmptyState()
                : RefreshIndicator(
              onRefresh: () => notifier.fetchAllUsers(isRefresh: true),
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: users.length + (state.hasMorePages ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == users.length) {
                    return _buildLoadingMore(state.isLoadingMore);
                  }

                  final user = users[index];
                  return _buildUserCard(user, notifier);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.people_outline,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No se encontraron usuarios',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _searchQuery.isNotEmpty
                ? 'Intenta con otros términos de búsqueda'
                : 'Agrega el primer usuario para comenzar',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),
          if (_searchQuery.isEmpty)
            ElevatedButton.icon(
              onPressed: () => context.pushNamed('adminUserCreate'),
              icon: const Icon(Icons.add),
              label: const Text('Agregar Usuario'),
            ),
        ],
      ),
    );
  }

  Widget _buildLoadingMore(bool isLoading) {
    if (!isLoading) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(20),
      alignment: Alignment.center,
      child: Column(
        children: [
          const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(strokeWidth: 2.5),
          ),
          const SizedBox(height: 12),
          Text(
            'Cargando más usuarios...',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserCard(dynamic user, UserNotifier notifier) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        leading: CircleAvatar(
          radius: 24,
          backgroundColor: _getRoleColor(user.role),
          child: Text(
            user.username[0].toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        title: Text(
          user.username,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 6),
            Row(
              children: [
                Icon(Icons.email, size: 14, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    user.email,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[700],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.phone, size: 14, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  user.phone,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                _buildRoleBadge(user.role),
                const SizedBox(width: 8),
                _buildStatusBadge(user.status),
              ],
            ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          itemBuilder: (context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'view',
              child: Row(
                children: [
                  Icon(Icons.visibility, size: 20),
                  SizedBox(width: 12),
                  Text('Ver detalles'),
                ],
              ),
            ),
            const PopupMenuItem<String>(
              value: 'edit',
              child: Row(
                children: [
                  Icon(Icons.edit, size: 20),
                  SizedBox(width: 12),
                  Text('Editar'),
                ],
              ),
            ),
            const PopupMenuDivider(),
            PopupMenuItem<String>(
              value: 'status',
              child: Row(
                children: [
                  Icon(
                    user.status == UserStatus.ACTIVE
                        ? Icons.block
                        : Icons.check_circle,
                    size: 20,
                    color: user.status == UserStatus.ACTIVE
                        ? Colors.orange
                        : Colors.green,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    user.status == UserStatus.ACTIVE
                        ? 'Desactivar'
                        : 'Activar',
                  ),
                ],
              ),
            ),
            const PopupMenuItem<String>(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete, color: Colors.red, size: 20),
                  SizedBox(width: 12),
                  Text(
                    'Eliminar',
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
          ],
          onSelected: (value) => _handleMenuAction(value, user, notifier),
        ),
        onTap: () {
          notifier.selectUser(user);
          context.go(AppRoutes.adminUserDetail);
        },
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Buscar por nombre, email o teléfono...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () => setState(() => _searchQuery = ''),
          )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
        onChanged: (value) => setState(() => _searchQuery = value),
      ),
    );
  }

  Widget _buildFilterChips(UserNotifier notifier) {
    final hasFilters = _selectedRole != null || _selectedStatus != null;

    if (!hasFilters) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            if (_selectedRole != null)
              Chip(
                avatar: Icon(
                  Icons.badge,
                  size: 18,
                  color: _getRoleColor(_selectedRole!),
                ),
                label: Text('Rol: ${_selectedRole!.displayName}'),
                deleteIcon: const Icon(Icons.close, size: 18),
                onDeleted: () {
                  setState(() => _selectedRole = null);
                  notifier.setRoleFilter(null);
                },
              ),
            if (_selectedStatus != null) ...[
              const SizedBox(width: 8),
              Chip(
                avatar: Icon(
                  Icons.toggle_on,
                  size: 18,
                  color: _selectedStatus == UserStatus.ACTIVE
                      ? Colors.green
                      : Colors.grey,
                ),
                label: Text('Estado: ${_selectedStatus!.displayName}'),
                deleteIcon: const Icon(Icons.close, size: 18),
                onDeleted: () {
                  setState(() => _selectedStatus = null);
                  notifier.setStatusFilter(null);
                },
              ),
            ],
            const SizedBox(width: 8),
            TextButton.icon(
              icon: const Icon(Icons.clear_all, size: 18),
              label: const Text('Limpiar todo'),
              onPressed: () {
                setState(() {
                  _selectedRole = null;
                  _selectedStatus = null;
                });
                notifier.clearFilters();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleBadge(UserRole role) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: _getRoleColor(role).withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _getRoleColor(role).withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.badge,
            size: 12,
            color: _getRoleColor(role),
          ),
          const SizedBox(width: 4),
          Text(
            role.displayName,
            style: TextStyle(
              color: _getRoleColor(role),
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(UserStatus status) {
    final color = status == UserStatus.ACTIVE ? Colors.green : Colors.grey;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            status.displayName,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Color _getRoleColor(UserRole role) {
    switch (role) {
      case UserRole.ADMIN:
        return Colors.purple;
      case UserRole.DISPATCHER:
        return Colors.blue;
      case UserRole.DRIVER:
        return Colors.orange;
      case UserRole.CLERK:
        return Colors.green;
      case UserRole.PASSENGER:
        return Colors.teal;
    }
  }

  void _handleMenuAction(dynamic value, user, UserNotifier notifier) {
    switch (value) {
      case 'view':
        notifier.selectUser(user);
        context.go(AppRoutes.adminUserDetail);
        break;
      case 'edit':
        notifier.selectUser(user);
        context.go(AppRoutes.adminUserEdit);
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
    final newStatus =
    user.status == UserStatus.ACTIVE ? UserStatus.INACTIVE : UserStatus.ACTIVE;

    final success = await notifier.changeUserStatus(user.id, newStatus);
    final state = ref.read(userProvider);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success
              ? 'Estado actualizado correctamente'
              : state.error ?? 'Error al actualizar estado',
        ),
        backgroundColor: success ? Colors.green : Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _confirmDelete(user, UserNotifier notifier) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Row(
          children: [
            Icon(Icons.warning, color: Colors.red),
            SizedBox(width: 12),
            Text('Confirmar eliminación'),
          ],
        ),
        content: Text(
          '¿Estás seguro de que deseas eliminar a ${user.username}?\n\n'
              'Esta acción no se puede deshacer.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              Navigator.pop(context);

              // Mostrar loading
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Row(
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ),
                      ),
                      SizedBox(width: 16),
                      Text('Eliminando usuario...'),
                    ],
                  ),
                  duration: Duration(seconds: 2),
                ),
              );

              final success = await notifier.deleteUser(user.id);
              final state = ref.read(userProvider);

              if (!mounted) return;

              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    success
                        ? 'Usuario eliminado correctamente'
                        : state.error ?? 'Error al eliminar usuario',
                  ),
                  backgroundColor: success ? Colors.green : Colors.red,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    final notifier = ref.read(userProvider.notifier);

    UserRole? tempRole = _selectedRole;
    UserStatus? tempStatus = _selectedStatus;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Row(
              children: [
                Icon(Icons.filter_list),
                SizedBox(width: 12),
                Text('Filtros'),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<UserRole>(
                  initialValue: tempRole,
                  decoration: const InputDecoration(
                    labelText: 'Rol',
                    prefixIcon: Icon(Icons.badge),
                    border: OutlineInputBorder(),
                  ),
                  items: [
                    const DropdownMenuItem<UserRole>(
                      value: null,
                      child: Text('Todos los roles'),
                    ),
                    ...UserRole.values.map((role) {
                      return DropdownMenuItem<UserRole>(
                        value: role,
                        child: Text(role.displayName),
                      );
                    }),
                  ],
                  onChanged: (value) {
                    setDialogState(() => tempRole = value);
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<UserStatus>(
                  initialValue: tempStatus,
                  decoration: const InputDecoration(
                    labelText: 'Estado',
                    prefixIcon: Icon(Icons.toggle_on),
                    border: OutlineInputBorder(),
                  ),
                  items: [
                    const DropdownMenuItem<UserStatus>(
                      value: null,
                      child: Text('Todos los estados'),
                    ),
                    ...UserStatus.values.map((status) {
                      return DropdownMenuItem<UserStatus>(
                        value: status,
                        child: Text(status.displayName),
                      );
                    }),
                  ],
                  onChanged: (value) {
                    setDialogState(() => tempStatus = value);
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
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
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _selectedRole = tempRole;
                    _selectedStatus = tempStatus;
                  });

                  notifier.setRoleFilter(tempRole);
                  notifier.setStatusFilter(tempStatus);

                  Navigator.pop(context);
                },
                child: const Text('Aplicar'),
              ),
            ],
          );
        },
      ),
    );
  }
}