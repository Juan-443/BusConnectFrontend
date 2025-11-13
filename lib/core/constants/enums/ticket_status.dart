enum TicketStatus {
  SOLD,
  CANCELLED,
  NO_SHOW,
  USED;

  String get displayName {
    switch (this) {
      case TicketStatus.SOLD:
        return 'Vendido';
      case TicketStatus.CANCELLED:
        return 'Cancelado';
      case TicketStatus.NO_SHOW:
        return 'No Presentado';
      case TicketStatus.USED:
        return 'Usado';
    }
  }
}