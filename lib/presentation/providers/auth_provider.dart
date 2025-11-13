import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bus_connect/data/models/user_model/user_model.dart';
import '../../core/network/api_client.dart';
import '../../data/providers/auth_api_provider.dart';
import '../../data/repositories/auth_repository.dart';

/// ==================== API CLIENT PROVIDER ====================

final apiClientProvider = Provider<ApiClient>((ref) => ApiClient());

/// ==================== AUTH API PROVIDER ====================

final authApiProvider = Provider<AuthApiProvider>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return AuthApiProvider(apiClient.dio);
});

/// ==================== AUTH REPOSITORY PROVIDER ====================

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final apiProvider = ref.watch(authApiProvider);
  return AuthRepository(apiProvider);
});

/// ==================== AUTH STATE ====================

class AuthState {
  final bool isAuthenticated;
  final UserInfo? user;
  final bool isLoading;
  final String? error;

  const AuthState({
    this.isAuthenticated = false,
    this.user,
    this.isLoading = false,
    this.error,
  });

  AuthState copyWith({
    bool? isAuthenticated,
    UserInfo? user,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// ==================== AUTH NOTIFIER ====================

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repository;

  AuthNotifier(this._repository) : super(const AuthState()) {
    checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    final isLoggedIn = await _repository.isLoggedIn();

    if (isLoggedIn) {
      final result = await _repository.getCurrentUser();
      result.fold(
            (failure) => state = state.copyWith(isAuthenticated: false),
            (user) => state = state.copyWith(
          isAuthenticated: true,
          user: user,
        ),
      );
    }
  }

  Future<bool> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);

    final request = LoginRequest(email: email, password: password);
    final result = await _repository.login(request);

    return result.fold(
          (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
      },
          (response) {
        state = state.copyWith(
          isAuthenticated: true,
          user: response.user,
          isLoading: false,
        );
        return true;
      },
    );
  }

  Future<bool> loginWithPhone(String phone, String password) async {
    state = state.copyWith(isLoading: true, error: null);

    final request = PhoneLoginRequest(phone: phone, password: password);
    final result = await _repository.loginWithPhone(request);

    return result.fold(
          (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
      },
          (response) {
        state = state.copyWith(
          isAuthenticated: true,
          user: response.user,
          isLoading: false,
        );
        return true;
      },
    );
  }

  Future<bool> register(RegisterRequest request) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _repository.register(request);

    return result.fold(
          (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
      },
          (response) {
        state = state.copyWith(
          isAuthenticated: true,
          user: response.user,
          isLoading: false,
        );
        return true;
      },
    );
  }

  Future<void> logout() async {
    await _repository.logout();
    state = const AuthState();
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return AuthNotifier(repository);
});
