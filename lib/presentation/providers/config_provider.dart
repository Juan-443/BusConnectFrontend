import 'package:bus_connect/core/network/api_client.dart';
import 'package:bus_connect/data/providers/config_api_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/config_model/config_model.dart';
import '../../data/repositories/config_repository.dart';

/// ==================== REPOSITORY PROVIDER ====================
final configRepositoryProvider = Provider<ConfigRepository>((ref) {
  final dio = ApiClient().dio;
  final apiProvider = ConfigApiProvider(dio);
  return ConfigRepository(apiProvider);
});

/// ==================== STATE ====================
class ConfigState {
  final List<ConfigResponse> configs;
  final ConfigResponse? selectedConfig;
  final bool isLoading;
  final String? error;
  final Map<String, String> configCache;

  const ConfigState({
    this.configs = const [],
    this.selectedConfig,
    this.isLoading = false,
    this.error,
    this.configCache = const {},
  });

  ConfigState copyWith({
    List<ConfigResponse>? configs,
    ConfigResponse? selectedConfig,
    bool? isLoading,
    String? error,
    Map<String, String>? configCache,
  }) {
    return ConfigState(
      configs: configs ?? this.configs,
      selectedConfig: selectedConfig ?? this.selectedConfig,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      configCache: configCache ?? this.configCache,
    );
  }

  String? getCachedValue(String key) => configCache[key];
}

/// ==================== NOTIFIER ====================
class ConfigNotifier extends StateNotifier<ConfigState> {
  final ConfigRepository _repository;

  ConfigNotifier(this._repository) : super(const ConfigState());

  // ==================== FETCH CONFIGS ====================

  Future<void> fetchAllConfigs() async {
    state = state.copyWith(isLoading: true);
    final result = await _repository.getAllConfigs();

    result.fold(
          (failure) => state = state.copyWith(isLoading: false, error: failure.message),
          (configs) {
        final cache = {for (var c in configs) c.key: c.value};
        state = state.copyWith(
          configs: configs,
          configCache: cache,
          isLoading: false,
        );
      },
    );
  }

  Future<void> fetchConfigById(int id) async {
    state = state.copyWith(isLoading: true);
    final result = await _repository.getConfigById(id);

    result.fold(
          (failure) => state = state.copyWith(isLoading: false, error: failure.message),
          (config) {
        state = state.copyWith(
          selectedConfig: config,
          isLoading: false,
          configCache: {...state.configCache, config.key: config.value},
        );
      },
    );
  }

  Future<void> fetchConfigByKey(String key) async {
    state = state.copyWith(isLoading: true);
    final result = await _repository.getConfigByKey(key);

    result.fold(
          (failure) => state = state.copyWith(isLoading: false, error: failure.message),
          (config) {
        final cache = {...state.configCache, config.key: config.value};
        state = state.copyWith(
          selectedConfig: config,
          isLoading: false,
          configCache: cache,
        );
      },
    );
  }

  // ==================== CRUD ====================

  Future<bool> createConfig(ConfigCreateRequest request) async {
    state = state.copyWith(isLoading: true);
    final result = await _repository.createConfig(request);

    return result.fold(
          (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
      },
          (config) {
        final updated = [...state.configs, config];
        final cache = {...state.configCache, config.key: config.value};
        state = state.copyWith(
          configs: updated,
          configCache: cache,
          isLoading: false,
        );
        return true;
      },
    );
  }

  Future<bool> updateConfig(int id, ConfigUpdateRequest request) async {
    state = state.copyWith(isLoading: true);
    final result = await _repository.updateConfig(id, request);

    return result.fold(
          (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
      },
          (config) {
        final updated = state.configs.map((c) => c.id == id ? config : c).toList();
        final cache = {...state.configCache, config.key: config.value};
        state = state.copyWith(
          configs: updated,
          selectedConfig: config,
          configCache: cache,
          isLoading: false,
        );
        return true;
      },
    );
  }

  Future<bool> deleteConfig(int id) async {
    state = state.copyWith(isLoading: true);
    final result = await _repository.deleteConfig(id);

    return result.fold(
          (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
      },
          (_) {
        final config = state.configs.firstWhere((c) => c.id == id);
        final updated = state.configs.where((c) => c.id != id).toList();
        final cache = Map.of(state.configCache)..remove(config.key);
        state = state.copyWith(
          configs: updated,
          selectedConfig: null,
          configCache: cache,
          isLoading: false,
        );
        return true;
      },
    );
  }

  Future<bool> deleteConfigByKey(String key) async {
    state = state.copyWith(isLoading: true);
    final result = await _repository.deleteConfigByKey(key);

    return result.fold(
          (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
      },
          (_) {
        final updated = state.configs.where((c) => c.key != key).toList();
        final cache = Map.of(state.configCache)..remove(key);
        state = state.copyWith(
          configs: updated,
          configCache: cache,
          isLoading: false,
        );
        return true;
      },
    );
  }

  // ==================== CONFIG VALUES ====================

  Future<String?> getConfigValue(String key, {String? defaultValue}) async {
    // Primero usa el cache
    if (state.configCache.containsKey(key)) return state.configCache[key];

    final result = await _repository.getConfigValue(key, defaultValue: defaultValue);
    return result.fold(
          (_) => defaultValue,
          (value) {
        final cache = {...state.configCache, key: value};
        state = state.copyWith(configCache: cache);
        return value;
      },
    );
  }

  Future<int?> getConfigValueAsInt(String key, {int? defaultValue}) async {
    final result = await _repository.getConfigValueAsInt(key, defaultValue: defaultValue);
    return result.fold((_) => defaultValue, (value) => value);
  }

  Future<double?> getConfigValueAsDouble(String key, {double? defaultValue}) async {
    final result = await _repository.getConfigValueAsDouble(key, defaultValue: defaultValue);
    return result.fold((_) => defaultValue, (value) => value);
  }

  // ==================== HELPERS ====================

  void clearSelectedConfig() {
    state = state.copyWith(selectedConfig: null);
  }

  void selectConfig(ConfigResponse config) {
    state = state.copyWith(selectedConfig: config);
  }

  void clearCache() {
    state = state.copyWith(configCache: {});
  }
}

/// ==================== PROVIDER ====================

final configProvider = StateNotifierProvider<ConfigNotifier, ConfigState>((ref) {
  final repository = ref.watch(configRepositoryProvider);
  return ConfigNotifier(repository);
});
