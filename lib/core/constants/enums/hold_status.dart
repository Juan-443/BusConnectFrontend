enum HoldStatus {
  HOLD,
  EXPIRED,
  CONVERTED;

  String get displayName {
    switch (this) {
      case HoldStatus.HOLD:
        return 'Retenido';
      case HoldStatus.EXPIRED:
        return 'Expirado';
      case HoldStatus.CONVERTED:
        return 'Convertido';
    }
  }
}