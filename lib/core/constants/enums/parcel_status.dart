enum ParcelStatus {
  CREATED,
  IN_TRANSIT,
  DELIVERED,
  FAILED;

  String get displayName {
    switch (this) {
      case ParcelStatus.CREATED:
        return 'Creada';
      case ParcelStatus.IN_TRANSIT:
        return 'En Tránsito';
      case ParcelStatus.DELIVERED:
        return 'Entregada';
      case ParcelStatus.FAILED:
        return 'Fallida';
    }
  }
}