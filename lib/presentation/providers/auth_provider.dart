import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bus_connect/data/models/user_model/user_model.dart';
import '../../data/repositories/auth_repository.dart';
import 'package:bus_connect/app.dart';

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

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repository;

  AuthNotifier(this._repository) : super(const AuthState()) {
    _initAuthState();
  }

  Future<void> _initAuthState() async {
    try {
      final isLoggedIn = await _repository.isLoggedIn();

      if (!isLoggedIn) {
        return;
      }

      final result = await _repository.getCurrentUser();

      result.fold(
            (failure) {
          _repository.logout();
          state = const AuthState(isAuthenticated: false);
        },
            (user) {
          state = state.copyWith(
            isAuthenticated: true,
            user: user,
          );
        },
      );
    } catch (e) {
      await _repository.logout();
      state = const AuthState(isAuthenticated: false);
    }
  }

  Future<void> checkAuthStatus() async {
    await _initAuthState();
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