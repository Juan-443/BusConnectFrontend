import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import '../trip_model/trip_model.dart';
import '../user_model/user_model.dart';

part 'assignment_model.freezed.dart';
part 'assignment_model.g.dart';

DateTime _dateFromJson(String date) => DateTime.parse(date);
String _dateToJson(DateTime date) => date.toIso8601String();


@freezed
class AssignmentModel with _$AssignmentModel {
  const factory AssignmentModel({
    required int id,
    required bool checklistOk,
    @JsonKey(fromJson: _dateFromJson,
        toJson: _dateToJson)
    required DateTime assignedAt,
    required int tripId,
    required int driverId,
    required int dispatcherId,
    TripModel? trip,
    UserModel? driver,
    UserModel? dispatcher,
  }) = _AssignmentModel;

  factory AssignmentModel.fromJson(Map<String, dynamic> json) =>
      _$AssignmentModelFromJson(json);
}

@freezed
class AssignmentCreateRequest with _$AssignmentCreateRequest {
  const factory AssignmentCreateRequest({
    required int tripId,
    required int driverId,
    required int dispatcherId,
    bool? checklistOk,
  }) = _AssignmentCreateRequest;

  factory AssignmentCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$AssignmentCreateRequestFromJson(json);
}

@freezed
class AssignmentUpdateRequest with _$AssignmentUpdateRequest {
  const factory AssignmentUpdateRequest({int? driverId, bool? checklistOk}) =
  _AssignmentUpdateRequest;

  factory AssignmentUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$AssignmentUpdateRequestFromJson(json);
}
typedef AssignmentResponse = AssignmentModel;

extension AssignmentComputed on AssignmentModel {
  String get driverName => driver?.username ?? 'Sin conductor';
  String get dispatcherName => dispatcher?.username ?? 'Sin despachador';
  String get tripInfo {
    final routeName = trip?.route?.name ?? 'Ruta desconocida';
    final busPlate = trip?.bus?.plate ?? 'Sin bus asignado';
    return '$routeName - $busPlate';
  }

  String get tripDateFormatted {
    final date = trip?.date;
    if (date == null) return 'Sin fecha';
    return DateFormat('dd/MM/yyyy').format(date);
  }

  String get tripDepartureTimeFormatted {
    final departure = trip?.departureAt;
    if (departure == null) return 'Sin hora';
    return DateFormat('HH:mm').format(departure);
  }

  String get routeInfo => trip?.route?.name ?? 'Ruta no disponible';
  String get tripStatus => trip?.status.name ?? 'DESCONOCIDO';

  String get tripDate {
    final date = trip?.date;
    if (date == null) return '';
    return DateFormat('yyyy-MM-dd').format(date);
  }

  String get tripDepartureTime {
    final departure = trip?.departureAt;
    if (departure == null) return '';
    return DateFormat('HH:mm').format(departure);
  }

  String get assignedAtFormatted => DateFormat('yyyy-MM-dd HH:mm').format(assignedAt);
}

