import 'package:bus_connect/presentation/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/providers/user_api_provider.dart';
import '../../data/repositories/user_repository.dart';
import '../../data/models/user_model/user_model.dart';
import '../../core/constants/enums/user_role.dart';
import '../../core/constants/enums/user_status.dart';

/// ==================== API PROVIDER ====================
final userApiProvider = Provider<UserApiProvider>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return UserApiProvider(apiClient.dio);
});

/// ==================== REPOSITORY PROVIDER ====================
final userRepositoryProvider = Provider<UserRepository>((ref) {
  final apiProvider = ref.watch(userApiProvider);
  return UserRepository(apiProvider);
});

/// ==================== STATE ====================
class UserState {
  final List<UserResponse> users;
  final UserResponse? selectedUser;
  final UserResponse? currentUser;
  final bool isLoading;
  final String? error;

  final UserRole? filterRole;
  final UserStatus? filterStatus;

  const UserState({
    this.users = const [],
    this.selectedUser,
    this.currentUser,
    this.isLoading = false,
    this.error,
    this.filterRole,
    this.filterStatus,
  });

  UserState copyWith({
    List<UserResponse>? users,
    UserResponse? selectedUser,
    UserResponse? currentUser,
    bool? isLoading,
    String? error,
    UserRole? filterRole,
    UserStatus? filterStatus,
  }) {
    return UserState(
      users: users ?? this.users,
      selectedUser: selectedUser ?? this.selectedUser,
      currentUser: currentUser ?? this.currentUser,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      filterRole: filterRole ?? this.filterRole,
      filterStatus: filterStatus ?? this.filterStatus,
    );
  }

  List<UserResponse> get filteredUsers {
    var filtered = users;

    if (filterRole != null) {
      filtered =
          filtered.where((u) => u.role == filterRole!.name).toList();
    }
    if (filterStatus != null) {
      filtered =
          filtered.where((u) => u.status == filterStatus!.name).toList();
    }

    return filtered;
  }

  bool get hasError => error != null && error!.isNotEmpty;
}

/// ==================== NOTIFIER ====================
class UserNotifier extends StateNotifier<UserState> {
  final UserRepository _repository;

  UserNotifier(this._repository) : super(const UserState());

  // 🔹 Helper Methods
  void _setLoading(bool value) =>
      state = state.copyWith(isLoading: value);

  void _setError(String message) =>
      state = state.copyWith(isLoading: false, error: message);

  void _clearError() =>
      state = state.copyWith(error: null);

  // ==================== CURRENT USER ====================
  Future<void> fetchCurrentUser() async {
    _setLoading(true);
    final result = await _repository.getMe();

    result.fold(
          (failure) => _setError(failure.message),
          (user) => state = state.copyWith(
        currentUser: user,
        isLoading: false,
        error: null,
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
        return true;
      },
    );
  }

  // ==================== FETCH USERS (ADMIN) ====================
  Future<void> fetchAllUsers() async {
    _setLoading(true);
    final result = await _repository.getAllUsers();

    result.fold(
          (failure) => _setError(failure.message),
          (users) => state = state.copyWith(users: users, isLoading: false),
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
          (users) => state = state.copyWith(users: users, isLoading: false),
    );
  }

  Future<void> fetchUsersByRoleAndStatus(
      UserRole role, UserStatus status) async {
    _setLoading(true);
    final result = await _repository.getUsersByRoleAndStatus(role, status);

    result.fold(
          (failure) => _setError(failure.message),
          (users) => state = state.copyWith(users: users, isLoading: false),
    );
  }

  Future<void> fetchActiveUsersByRole(UserRole role) async {
    _setLoading(true);
    final result = await _repository.getActiveUsersByRole(role);

    result.fold(
          (failure) => _setError(failure.message),
          (users) => state = state.copyWith(users: users, isLoading: false),
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
        state = state.copyWith(
          users: [...state.users, user],
          isLoading: false,
        );
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

        state = state.copyWith(
          users: updatedUsers,
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
        state = state.copyWith(
          users: updated,
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

        state = state.copyWith(
          users: updatedUsers,
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
    state = state.copyWith(filterRole: null, filterStatus: null);
  }

  // ==================== HELPERS ====================
  void clearSelectedUser() {
    state = state.copyWith(selectedUser: null);
  }

  void selectUser(UserResponse user) {
    state = state.copyWith(selectedUser: user);
  }
}

/// ==================== PROVIDER ====================
final userProvider = StateNotifierProvider<UserNotifier, UserState>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return UserNotifier(repository);
});
