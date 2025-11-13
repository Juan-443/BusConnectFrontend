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