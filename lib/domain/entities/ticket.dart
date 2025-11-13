class Ticket {
  final int? id;
  final int tripId;
  final int passengerId;
  final int fromStopId;
  final int toStopId;
  final String seatNumber;
  final String paymentMethod;
  final double price;
  final String? status;
  final String? qrCode;
  final String? createdAt;
  final String? cancelledAt;
  final double? refundAmount;
  final String? cancellationPolicy;
  final String? passengerType;
  final double? discountAmount;

  Ticket({
    this.id,
    required this.tripId,
    required this.passengerId,
    required this.fromStopId,
    required this.toStopId,
    required this.seatNumber,
    required this.paymentMethod,
    required this.price,
    this.status,
    this.qrCode,
    this.createdAt,
    this.cancelledAt,
    this.refundAmount,
    this.cancellationPolicy,
    this.passengerType,
    this.discountAmount,
  });
}
