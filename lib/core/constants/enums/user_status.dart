
enum UserStatus {
  ACTIVE,
  INACTIVE,
  BLOCKED;

  String get displayName {
    switch (this) {
      case UserStatus.ACTIVE:
        return 'Activo';
      case UserStatus.INACTIVE:
        return 'Inactivo';
      case UserStatus.BLOCKED:
        return 'Bloqueado';
    }
  }

}