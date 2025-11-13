enum OverbookingStatus {
  PENDING_APPROVAL,
  APPROVED,
  REJECTED,
  EXPIRED;

  String get displayName {
    switch (this) {
      case OverbookingStatus.PENDING_APPROVAL:
        return 'Pendiente';
      case OverbookingStatus.APPROVED:
        return 'Aprobado';
      case OverbookingStatus.REJECTED:
        return 'Rechazado';
      case OverbookingStatus.EXPIRED:
        return 'Expirado';
    }
  }
}