
import 'ticket_model.dart';

extension TicketModelExtensions on TicketModel {
  String get fromStopName => fromStop?.name ?? 'N/A';

  String get toStopName => toStop?.name ?? 'N/A';

  String get tripDate => trip?.date.toString().substring(0, 10) ?? 'N/A';

  String get tripTime => trip?.departureAt.toString().substring(11, 16) ?? 'N/A';

  String get routeName => trip?.origin != null && trip?.destination != null
      ? '${trip!.origin} → ${trip!.destination}'
      : 'N/A';

  String get busPlate => trip?.busPlate ?? 'N/A';

  bool get isUpcoming {
    if (trip?.date == null) return false;
    return trip!.date.isAfter(DateTime.now());
  }

  bool get isActive => status.name == 'SOLD' || status.name == 'CONFIRMED';

  bool get canBeCancelled => status.name == 'SOLD' || status.name == 'CONFIRMED';
}