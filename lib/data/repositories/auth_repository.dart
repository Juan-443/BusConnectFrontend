import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../core/errors/failures.dart';
import '../../core/constants/storage_keys.dart';
import '../../services/storage_service.dart';
import '../providers/auth_api_provider.dart';
import '../models/user_model/user_model.dart';

class AuthRepository {
  final AuthApiProvider _apiProvider;
  final StorageService _storage = StorageService();

  AuthRepository(this._apiProvider);

  Future<Either<Failure, AuthResponse>> login(LoginRequest request) async {
    try {
      final response = await _apiProvider.login(request);

      // Guardar tokens
      await _storage.saveSecureData(StorageKeys.accessToken, response.accessToken);
      await _storage.saveSecureData(StorageKeys.refreshToken, response.refreshToken);
      await _storage.saveString(StorageKeys.userId, response.user.id.toString());
      await _storage.saveString(StorageKeys.userRole, response.user.role.name);
      await _storage.saveString(StorageKeys.userEmail, response.user.email);
      await _storage.saveString(StorageKeys.userName, response.user.username);

      return Right(response);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, AuthResponse>> loginWithPhone(
      PhoneLoginRequest request,
      ) async {
    try {
      final response = await _apiProvider.loginWithPhone(request);

      await _storage.saveSecureData(StorageKeys.accessToken, response.accessToken);
      await _storage.saveSecureData(StorageKeys.refreshToken, response.refreshToken);
      await _storage.saveString(StorageKeys.userId, response.user.id.toString());
      await _storage.saveString(StorageKeys.userRole, response.user.role.name);
      await _storage.saveString(StorageKeys.userEmail, response.user.email);
      await _storage.saveString(StorageKeys.userName, response.user.username);

      return Right(response);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, AuthResponse>> register(
      RegisterRequest request,
      ) async {
    try {
      final response = await _apiProvider.register(request);

      await _storage.saveSecureData(StorageKeys.accessToken, response.accessToken);
      await _storage.saveSecureData(StorageKeys.refreshToken, response.refreshToken);
      await _storage.saveString(StorageKeys.userId, response.user.id.toString());
      await _storage.saveString(StorageKeys.userRole, response.user.role.name);
      await _storage.saveString(StorageKeys.userEmail, response.user.email);
      await _storage.saveString(StorageKeys.userName, response.user.username);

      return Right(response);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, UserInfo>> getCurrentUser() async {
    try {
      final response = await _apiProvider.getCurrentUser();
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, MessageResponse>> changePassword(
      ChangePasswordRequest request,
      ) async {
    try {
      final response = await _apiProvider.changePassword(request);
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, MessageResponse>> forgotPassword(String email) async {
    try {
      final response = await _apiProvider.forgotPassword({'email': email});
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> logout() async {
    try {
      final refreshToken = await _storage.getSecureData(StorageKeys.refreshToken);

      if (refreshToken != null) {
        await _apiProvider.logout({'refreshToken': refreshToken});
      }

      await _storage.clearAll();
      return const Right(null);
    } on DioException catch (e) {
      await _storage.clearAll();
      return Left(_handleDioError(e));
    } catch (e) {
      await _storage.clearAll();
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.getSecureData(StorageKeys.accessToken);
    return token != null;
  }

  Future<String?> getUserRole() async {
    return _storage.getString(StorageKeys.userRole);
  }

  Failure _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkFailure('Tiempo de espera agotado');
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final message = e.response?.data['message'] ?? 'Error del servidor';

        if (statusCode == 401) {
          return AuthFailure(message);
        } else if (statusCode == 422) {
          return ValidationFailure(
            message,
            e.response?.data['errors'] as Map<String, List<String>>?,
          );
        }
        return ServerFailure(message);
      case DioExceptionType.cancel:
        return const ServerFailure('Solicitud cancelada');
      default:
        return const NetworkFailure();
    }
  }
}