import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/storage_keys.dart';
import '../../services/storage_service.dart';
import 'auth_provider.dart';

class CurrentUserState {
  final int? userId;
  final String? userName;
  final String? userEmail;
  final String? userRole;
  final bool isLoading;

  const CurrentUserState({
    this.userId,
    this.userName,
    this.userEmail,
    this.userRole,
    this.isLoading = false,
  });

  bool get isAuthenticated => userId != null;

  CurrentUserState copyWith({
    int? userId,
    String? userName,
    String? userEmail,
    String? userRole,
    bool? isLoading,
  }) {
    return CurrentUserState(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userEmail: userEmail ?? this.userEmail,
      userRole: userRole ?? this.userRole,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class CurrentUserNotifier extends StateNotifier<CurrentUserState> {
  final StorageService _storage = StorageService();

  CurrentUserNotifier() : super(const CurrentUserState()) {
    _loadUserFromStorage();
  }

  Future<void> _loadUserFromStorage() async {
    state = state.copyWith(isLoading: true);

    try {

      final userIdStr = _storage.getString(StorageKeys.userId);
      final userName =  _storage.getString(StorageKeys.userName);
      final userEmail =  _storage.getString(StorageKeys.userEmail);
      final userRole =  _storage.getString(StorageKeys.userRole);


      state = CurrentUserState(
        userId: userIdStr != null ? int.tryParse(userIdStr) : null,
        userName: userName,
        userEmail: userEmail,
        userRole: userRole,
        isLoading: false,
      );
    } catch (e) {
      state = const CurrentUserState(isLoading: false);
    }
  }

  Future<void> setUser({
    required int userId,
    required String userName,
    required String userEmail,
    required String userRole,
  }) async {
    state = CurrentUserState(
      userId: userId,
      userName: userName,
      userEmail: userEmail,
      userRole: userRole,
      isLoading: false,
    );

  }

  Future<void> refresh() async {
    await _loadUserFromStorage();
  }

  Future<void> clear() async {
    await _storage.remove(StorageKeys.userId);
    await _storage.remove(StorageKeys.userName);
    await _storage.remove(StorageKeys.userEmail);
    await _storage.remove(StorageKeys.userRole);
    await _storage.remove(StorageKeys.accessToken);
    await _storage.remove(StorageKeys.refreshToken);

    state = const CurrentUserState();

  }
}

final currentUserProvider = StateNotifierProvider<CurrentUserNotifier, CurrentUserState>((ref) {
  final notifier = CurrentUserNotifier();

  ref.listen<AuthState>(
    authProvider,
        (previous, next) {

      if (next.isAuthenticated && next.user != null) {
        // Actualizar currentUser cuando authProvider se autentica
        notifier.setUser(
          userId: next.user!.id,
          userName: next.user!.username,
          userEmail: next.user!.email,
          userRole: next.user!.role.displayName,
        );
      } else if (!next.isAuthenticated && (previous?.isAuthenticated ?? false)) {
        notifier.clear();
      }
    },
  );

  return notifier;
});