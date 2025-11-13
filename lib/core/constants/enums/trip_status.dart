enum TripStatus {
  SCHEDULED,
  BOARDING,
  DEPARTED,
  ARRIVED,
  CANCELLED;

  String get displayName {
    switch (this) {
      case TripStatus.SCHEDULED:
        return 'Programado';
      case TripStatus.BOARDING:
        return 'Abordando';
      case TripStatus.DEPARTED:
        return 'En Ruta';
      case TripStatus.ARRIVED:
        return 'Llegado';
      case TripStatus.CANCELLED:
        return 'Cancelado';
    }
  }
}