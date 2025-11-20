import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/parcel_model/parcel_model.dart';
import 'package:bus_connect/app.dart';

/// ==================== PARCEL TRACKING NOTIFIER ====================
class ParcelTrackingNotifier extends StateNotifier<AsyncValue<ParcelModel?>> {
  final Ref ref;

  ParcelTrackingNotifier(this.ref) : super(const AsyncValue.data(null));

  /// Rastrear paquete por código
  Future<void> trackByCode(String code) async {
    state = const AsyncValue.loading();

    try {
      final parcelRepo = ref.read(parcelRepositoryProvider);
      final result = await parcelRepo.getParcelByCode(code);

      result.fold(
            (failure) => state = AsyncValue.error(failure.message, StackTrace.current),
            (parcel) => state = AsyncValue.data(parcel), // ✅ Ahora parcel es ParcelModel
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Rastrear paquetes por teléfono
  Future<void> trackByPhone(String phone) async {
    state = const AsyncValue.loading();

    try {
      final parcelRepo = ref.read(parcelRepositoryProvider);
      final result = await parcelRepo.getParcelsByPhone(phone);

      // ✅ Manejar Either
      result.fold(
            (failure) => state = AsyncValue.error(failure.message, StackTrace.current),
            (parcels) => state = AsyncValue.data(
          parcels.isNotEmpty ? parcels.first : null, // ✅ Ahora parcels es List<ParcelModel>
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Resetear estado
  void reset() {
    state = const AsyncValue.data(null);
  }
}

/// ==================== PROVIDERS ====================

final parcelTrackingProvider = StateNotifierProvider<ParcelTrackingNotifier, AsyncValue<ParcelModel?>>((ref) {
  return ParcelTrackingNotifier(ref);
});

/// Provider para obtener parcels por código directamente
final parcelByCodeProvider = FutureProvider.autoDispose.family<ParcelModel, String>((ref, code) async {
  final parcelRepo = ref.read(parcelRepositoryProvider);
  final result = await parcelRepo.getParcelByCode(code);

  return result.fold(
        (failure) => throw Exception(failure.message),
        (parcel) => parcel,
  );
});

/// Provider para obtener parcels por teléfono
final parcelsByPhoneProvider = FutureProvider.autoDispose.family<List<ParcelModel>, String>((ref, phone) async {
  final parcelRepo = ref.read(parcelRepositoryProvider);
  final result = await parcelRepo.getParcelsByPhone(phone);

  return result.fold(
        (failure) => throw Exception(failure.message),
        (parcels) => parcels,
  );
});

/// Provider para obtener parcels por viaje
final parcelsByTripProvider = FutureProvider.autoDispose.family<List<ParcelModel>, int>((ref, tripId) async {
  final parcelRepo = ref.read(parcelRepositoryProvider);
  final result = await parcelRepo.getParcelsByTrip(tripId);

  return result.fold(
        (failure) => throw Exception(failure.message),
        (parcels) => parcels,
  );
});

/// Provider para obtener detalles de un parcel
final parcelDetailsProvider = FutureProvider.autoDispose.family<ParcelModel, int>((ref, parcelId) async {
  final parcelRepo = ref.read(parcelRepositoryProvider);
  final result = await parcelRepo.getParcelById(parcelId);

  return result.fold(
        (failure) => throw Exception(failure.message),
        (parcel) => parcel,
  );
});