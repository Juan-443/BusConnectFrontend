import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/user_repository.dart';
import '../../data/models/user_model/user_model.dart';
import '../../core/constants/enums/user_role.dart';
import '../../core/constants/enums/user_status.dart';
import 'package:bus_connect/app.dart';

/// ==================== STATE ====================
class UserState {
  final List<UserResponse> users;
  final UserResponse? selectedUser;
  final UserResponse? currentUser;
  final bool isLoading;
  final String? error;

  final UserRole? filterRole;
  final UserStatus? filterStatus;

  final int currentPage;
  final int pageSize;
  final bool hasMorePages;
  final bool isLoadingMore;
  final List<UserResponse> _allUsers;

  const UserState({
    this.users = const [],
    this.selectedUser,
    this.currentUser,
    this.isLoading = false,
    this.error,
    this.filterRole,
    this.filterStatus,
    this.currentPage = 1,
    this.pageSize = 20,
    this.hasMorePages = true,
    this.isLoadingMore = false,
    List<UserResponse> allUsers = const [],
  }) : _allUsers = allUsers;

  UserState copyWith({
    List<UserResponse>? users,
    UserResponse? selectedUser,
    UserResponse? currentUser,
    bool? isLoading,
    String? error,
    bool clearError = false,
    bool clearCurrentUser = false,
    Object? filterRole = _undefined,
    Object? filterStatus = _undefined,
    int? currentPage,
    int? pageSize,
    bool? hasMorePages,
    bool? isLoadingMore,
    List<UserResponse>? allUsers,
  }) {
    return UserState(
      users: users ?? this.users,
      selectedUser: selectedUser ?? this.selectedUser,
      currentUser: clearCurrentUser ? null : (currentUser ?? this.currentUser),
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      filterRole: filterRole == _undefined
          ? this.filterRole
          : filterRole as UserRole?,
      filterStatus: filterStatus == _undefined
          ? this.filterStatus
          : filterStatus as UserStatus?,
      currentPage: currentPage ?? this.currentPage,
      pageSize: pageSize ?? this.pageSize,
      hasMorePages: hasMorePages ?? this.hasMorePages,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      allUsers: allUsers ?? _allUsers,
    );
  }

  List<UserResponse> get filteredUsers {
    var filtered = users;

    if (currentUser != null) {
      filtered = filtered.where((u) => u.id != currentUser!.id).toList();
    }

    if (filterRole != null) {
      filtered = filtered.where((u) => u.role == filterRole!).toList();
    }
    if (filterStatus != null) {
      filtered = filtered.where((u) => u.status == filterStatus!).toList();
    }
    return filtered;
  }

  bool get hasError => error != null && error!.isNotEmpty;
}

/// ==================== NOTIFIER ====================
class UserNotifier extends StateNotifier<UserState> {
  final UserRepository _repository;
  final Ref _ref;

  UserNotifier(this._repository, this._ref) : super(const UserState());

  // 🔹 Helper Methods
  void _setLoading(bool value) => state = state.copyWith(isLoading: value);

  void _setError(String message) =>
      state = state.copyWith(isLoading: false, error: message);

  void _clearError() => state = state.copyWith(clearError: true);

  // ==================== CURRENT USER ====================
  Future<void> loadCurrentUser() async {
    await fetchCurrentUser();
  }

  Future<void> fetchCurrentUser() async {
    _setLoading(true);
    final result = await _repository.getMe();

    result.fold(
          (failure) => _setError(failure.message),
          (user) => state = state.copyWith(
        currentUser: user,
        isLoading: false,
        clearError: true,
      ),
    );
  }

  Future<bool> updateCurrentUser(UserSelfUpdateRequest request) async {
    _setLoading(true);
    final result = await _repository.updateMe(request);

    return result.fold(
          (failure) {
        _setError(failure.message);
        return false;
      },
          (user) {
        state = state.copyWith(currentUser: user, isLoading: false);
        return true;
      },
    );
  }

  Future<bool> updateMyPassword(Map<String, dynamic> request) async {
    _setLoading(true);
    final result = await _repository.updateMyPassword(request);

    return result.fold(
          (failure) {
        _setError(failure.message);
        return false;
      },
          (_) {
        _clearError();
        state = state.copyWith(isLoading: false);
        return true;
      },
    );
  }

  // ==================== FETCH USERS (ADMIN) ====================
  Future<void> fetchAllUsers({bool isRefresh = false}) async {
    if (isRefresh) {
      state = state.copyWith(
        isLoading: true,
        currentPage: 1,
        hasMorePages: true,
        clearError: true,
      );
    } else {
      _setLoading(true);
    }

    // Cargar usuario actual si no existe
    if (state.currentUser == null) {
      await loadCurrentUser();
    }

    final result = await _repository.getAllUsers();

    result.fold(
          (failure) => _setError(failure.message),
          (allUsers) {
        final usersWithoutCurrent = allUsers.where((user) {
          return state.currentUser == null ||
              user.id != state.currentUser!.id;
        }).toList();

        final paginatedUsers = usersWithoutCurrent
            .take(state.pageSize)
            .toList();

        state = state.copyWith(
          allUsers: usersWithoutCurrent,
          users: paginatedUsers,
          isLoading: false,
          hasMorePages: usersWithoutCurrent.length > state.pageSize,
          currentPage: 1,
          clearError: true,
        );
      },
    );
  }

  Future<void> loadMoreUsers() async {
    if (state.isLoadingMore || !state.hasMorePages || state.isLoading) {
      return;
    }

    state = state.copyWith(isLoadingMore: true);

    await Future.delayed(const Duration(milliseconds: 300));

    final nextPage = state.currentPage + 1;
    final startIndex = (nextPage - 1) * state.pageSize;
    final endIndex = startIndex + state.pageSize;

    if (startIndex >= state._allUsers.length) {
      state = state.copyWith(
        isLoadingMore: false,
        hasMorePages: false,
      );
      return;
    }

    final newUsers = state._allUsers
        .skip(startIndex)
        .take(state.pageSize)
        .toList();

    final updatedUsers = [...state.users, ...newUsers];

    state = state.copyWith(
      users: updatedUsers,
      currentPage: nextPage,
      hasMorePages: endIndex < state._allUsers.length,
      isLoadingMore: false,
    );
  }

  Future<void> fetchUserById(int id) async {
    _setLoading(true);
    final result = await _repository.getUserById(id);

    result.fold(
          (failure) => _setError(failure.message),
          (user) => state = state.copyWith(
        selectedUser: user,
        isLoading: false,
      ),
    );
  }

  Future<void> fetchUsersByRole(UserRole role) async {
    _setLoading(true);
    final result = await _repository.getUsersByRole(role);

    result.fold(
          (failure) => _setError(failure.message),
          (users) {
        final filtered = users.where((u) {
          return state.currentUser == null || u.id != state.currentUser!.id;
        }).toList();

        state = state.copyWith(
          users: filtered,
          allUsers: filtered,
          isLoading: false,
        );
      },
    );
  }

  Future<void> fetchUsersByRoleAndStatus(
      UserRole role, UserStatus status) async {
    _setLoading(true);
    final result = await _repository.getUsersByRoleAndStatus(role, status);

    result.fold(
          (failure) => _setError(failure.message),
          (users) {
        final filtered = users.where((u) {
          return state.currentUser == null || u.id != state.currentUser!.id;
        }).toList();

        state = state.copyWith(
          users: filtered,
          allUsers: filtered,
          isLoading: false,
        );
      },
    );
  }

  Future<void> fetchActiveUsersByRole(UserRole role) async {
    _setLoading(true);
    final result = await _repository.getActiveUsersByRole(role);

    result.fold(
          (failure) => _setError(failure.message),
          (users) {
        final filtered = users.where((u) {
          return state.currentUser == null || u.id != state.currentUser!.id;
        }).toList();

        state = state.copyWith(
          users: filtered,
          allUsers: filtered,
          isLoading: false,
        );
      },
    );
  }

  // ==================== CRUD ====================
  Future<bool> createUser(UserCreateRequest request) async {
    _setLoading(true);
    final result = await _repository.createUser(request);

    return result.fold(
          (failure) {
        _setError(failure.message);
        return false;
      },
          (user) {
        if (state.currentUser == null || user.id != state.currentUser!.id) {
          state = state.copyWith(
            users: [...state.users, user],
            allUsers: [...state._allUsers, user],
            isLoading: false,
          );
        } else {
          state = state.copyWith(isLoading: false);
        }
        return true;
      },
    );
  }

  Future<bool> updateUser(int id, UserUpdateRequest request) async {
    _setLoading(true);
    final result = await _repository.updateUser(id, request);

    return result.fold(
          (failure) {
        _setError(failure.message);
        return false;
      },
          (user) {
        final updatedUsers = state.users.map((u) {
          return u.id == id ? user : u;
        }).toList();

        final updatedAllUsers = state._allUsers.map((u) {
          return u.id == id ? user : u;
        }).toList();

        state = state.copyWith(
          users: updatedUsers,
          allUsers: updatedAllUsers,
          selectedUser:
          state.selectedUser?.id == id ? user : state.selectedUser,
          isLoading: false,
        );
        return true;
      },
    );
  }

  Future<bool> deleteUser(int id) async {
    _setLoading(true);
    final result = await _repository.deleteUser(id);

    return result.fold(
          (failure) {
        _setError(failure.message);
        return false;
      },
          (_) {
        final updated = state.users.where((u) => u.id != id).toList();
        final updatedAll = state._allUsers.where((u) => u.id != id).toList();

        state = state.copyWith(
          users: updated,
          allUsers: updatedAll,
          selectedUser:
          state.selectedUser?.id == id ? null : state.selectedUser,
          isLoading: false,
        );
        return true;
      },
    );
  }

  Future<bool> changeUserStatus(int id, UserStatus status) async {
    _setLoading(true);
    final result = await _repository.changeUserStatus(id, status);

    return result.fold(
          (failure) {
        _setError(failure.message);
        return false;
      },
          (user) {
        final updatedUsers = state.users.map((u) {
          return u.id == id ? user : u;
        }).toList();

        final updatedAllUsers = state._allUsers.map((u) {
          return u.id == id ? user : u;
        }).toList();

        state = state.copyWith(
          users: updatedUsers,
          allUsers: updatedAllUsers,
          selectedUser:
          state.selectedUser?.id == id ? user : state.selectedUser,
          isLoading: false,
        );
        return true;
      },
    );
  }

  // ==================== VALIDATION ====================
  Future<bool> checkEmailExists(String email) async {
    final result = await _repository.existsByEmail(email);
    return result.fold((_) => false, (exists) => exists);
  }

  Future<bool> checkPhoneExists(String phone) async {
    final result = await _repository.existsByPhone(phone);
    return result.fold((_) => false, (exists) => exists);
  }

  // ==================== FILTERS ====================
  void setRoleFilter(UserRole? role) {
    state = state.copyWith(filterRole: role);
  }

  void setStatusFilter(UserStatus? status) {
    state = state.copyWith(filterStatus: status);
  }

  void clearFilters() {
    state = state.copyWith(
      filterRole: null,
      filterStatus: null,
    );
  }

  // ==================== HELPERS ====================
  void clearSelectedUser() {
    state = state.copyWith(selectedUser: null);
  }

  void selectUser(UserResponse user) {
    state = state.copyWith(selectedUser: user);
  }

  void resetPagination() {
    state = state.copyWith(
      currentPage: 1,
      hasMorePages: true,
      users: state._allUsers.take(state.pageSize).toList(),
    );
  }
}

const _undefined = Object();

/// ==================== PROVIDER ====================
final userProvider = StateNotifierProvider<UserNotifier, UserState>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return UserNotifier(repository, ref);
});