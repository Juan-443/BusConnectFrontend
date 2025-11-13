enum IncidentType {
  SECURITY,
  DELIVERY_FAIL,
  OVERBOOK,
  VEHICLE,
  PASSENGER_COMPLAINT,
  OTHER;

  String get displayName {
    switch (this) {
      case IncidentType.SECURITY:
        return 'Seguridad';
      case IncidentType.DELIVERY_FAIL:
        return 'Fallo de Entrega';
      case IncidentType.OVERBOOK:
        return 'Sobreventa';
      case IncidentType.VEHICLE:
        return 'Vehículo';
      case IncidentType.PASSENGER_COMPLAINT:
        return 'Queja de Pasajero';
      case IncidentType.OTHER:
        return 'Otro';
    }
  }
}