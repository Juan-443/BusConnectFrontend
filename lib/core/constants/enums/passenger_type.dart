enum PassengerType {
  ADULT,
  CHILD,
  STUDENT,
  SENIOR;

  String get displayName {
    switch (this) {
      case PassengerType.ADULT:
        return 'Adulto';
      case PassengerType.CHILD:
        return 'Niño';
      case PassengerType.STUDENT:
        return 'Estudiante';
      case PassengerType.SENIOR:
        return 'Adulto mayor';
    }
  }
}