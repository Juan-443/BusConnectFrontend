import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum()
enum UserRole {
  PASSENGER,
  CLERK,
  DRIVER,
  DISPATCHER,
  ADMIN;

  String get displayName {
    switch (this) {
      case UserRole.PASSENGER:
        return 'Pasajero';
      case UserRole.CLERK:
        return 'Vendedor';
      case UserRole.DRIVER:
        return 'Conductor';
      case UserRole.DISPATCHER:
        return 'Despachador';
      case UserRole.ADMIN:
        return 'Administrador';
    }
  }
}