import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum()
enum BusStatus {
  ACTIVE,
  MAINTENANCE,
  INACTIVE;

  String get displayName {
    switch (this) {
      case BusStatus.ACTIVE:
        return 'Activo';
      case BusStatus.MAINTENANCE:
        return 'Mantenimiento';
      case BusStatus.INACTIVE:
        return 'Inactivo';
    }
  }

}
extension BusStatusExtension on BusStatus {
  String toJson() => name.toUpperCase();

  static BusStatus fromJson(String json) {
    return BusStatus.values.firstWhere(
          (e) => e.name.toUpperCase() == json.toUpperCase(),
      orElse: () => BusStatus.INACTIVE,
    );
  }
}

