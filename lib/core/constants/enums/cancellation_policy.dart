enum CancellationPolicy {
  FULL_REFUND,
  PARTIAL_REFUND,
  NO_REFUND;

  String get displayName {
    switch (this) {
      case CancellationPolicy.FULL_REFUND:
        return 'Devolución Total';
      case CancellationPolicy.PARTIAL_REFUND:
        return 'Devolución Parcial';
      case CancellationPolicy.NO_REFUND:
        return 'Sin Devolución';
    }
  }
}