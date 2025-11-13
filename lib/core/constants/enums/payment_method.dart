enum PaymentMethod {
  CASH,
  TRANSFER,
  QR,
  CARD;

  String get displayName {
    switch (this) {
      case PaymentMethod.CASH:
        return 'Efectivo';
      case PaymentMethod.TRANSFER:
        return 'Transferencia';
      case PaymentMethod.QR:
        return 'QR';
      case PaymentMethod.CARD:
        return 'Tarjeta';
    }
  }
}