class ServerException implements Exception {
  final String message;
  final int? statusCode;

  ServerException(this.message, [this.statusCode]);

  @override
  String toString() => 'ServerException: $message (${statusCode ?? 'N/A'})';
}

class NetworkException implements Exception {
  final String message;

  NetworkException([this.message = 'No hay conexión a internet']);

  @override
  String toString() => 'NetworkException: $message';
}

class CacheException implements Exception {
  final String message;

  CacheException([this.message = 'Error al acceder al cache']);

  @override
  String toString() => 'CacheException: $message';
}

class AuthException implements Exception {
  final String message;

  AuthException([this.message = 'Error de autenticación']);

  @override
  String toString() => 'AuthException: $message';
}

class ValidationException implements Exception {
  final Map<String, List<String>> errors;

  ValidationException(this.errors);

  @override
  String toString() => 'ValidationException: $errors';
}