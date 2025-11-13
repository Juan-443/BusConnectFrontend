import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bus_connect/presentation/providers/auth_provider.dart';
import '../../data/providers/parcel_api_provider.dart';
import '../../data/repositories/parcel_repository.dart';
import '../../data/models/parcel_model/parcel_model.dart';

/// ==================== API PROVIDER ====================
final parcelApiProvider = Provider<ParcelApiProvider>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return ParcelApiProvider(apiClient.dio);
});

/// ==================== REPOSITORY PROVIDER ====================
final parcelRepositoryProvider = Provider<ParcelRepository>((ref) {
  final apiProvider = ref.watch(parcelApiProvider);
  return ParcelRepository(apiProvider);
});

/// ==================== STATE ====================
class ParcelState {
  final List<ParcelResponse> parcels;
  final bool isLoading;
  final String? error;

  const ParcelState({
    this.parcels = const [],
    this.isLoading = false,
    this.error,
  });

  ParcelState copyWith({
    List<ParcelResponse>? parcels,
    bool? isLoading,
    String? error,
  }) {
    return ParcelState(
      parcels: parcels ?? this.parcels,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  bool get hasError => error != null && error!.isNotEmpty;
  bool get hasParcels => parcels.isNotEmpty;
}

/// ==================== NOTIFIER ====================
class ParcelNotifier extends StateNotifier<ParcelState> {
  final ParcelRepository _repository;

  ParcelNotifier(this._repository) : super(const ParcelState());

  Future<void> loadAllParcels() async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await _repository.getAllParcels();

    result.fold(
          (failure) => state =
          state.copyWith(isLoading: false, error: failure.message),
          (parcels) =>
      state = state.copyWith(parcels: parcels, isLoading: false, error: null),
    );
  }

  Future<bool> createParcel(ParcelCreateRequest request) async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await _repository.createParcel(request);

    return result.fold(
          (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return false;
      },
          (parcel) {
        state = state.copyWith(
          parcels: [...state.parcels, parcel],
          isLoading: false,
          error: null,
        );
        return true;
      },
    );
  }

  Future<ParcelResponse?> trackParcel(String code) async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await _repository.getParcelByCode(code);

    return result.fold(
          (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
        return null;
      },
          (parcel) {
        state = state.copyWith(isLoading: false, error: null);
        return parcel;
      },
    );
  }

  void clear() {
    state = const ParcelState();
  }
}

/// ==================== PROVIDER ====================
final parcelProvider =
StateNotifierProvider<ParcelNotifier, ParcelState>((ref) {
  final repository = ref.watch(parcelRepositoryProvider);
  return ParcelNotifier(repository);
});
