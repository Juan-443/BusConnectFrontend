class Trip {
  final int? id;
  final int routeId;
  final int? busId;
  final DateTime date;
  final DateTime departureAt;
  final DateTime arrivalEta;
  final String status;

  Trip({
    this.id,
    required this.routeId,
    this.busId,
    required this.date,
    required this.departureAt,
    required this.arrivalEta,
    required this.status,
  });
}
