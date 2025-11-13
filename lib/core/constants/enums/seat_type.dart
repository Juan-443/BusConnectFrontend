enum SeatType {
  STANDARD,
  PREFERENTIAL;

  String get displayName {
    switch (this) {
      case SeatType.STANDARD:
        return 'Estándar';
      case SeatType.PREFERENTIAL:
        return 'Preferencial';
    }
  }
}