import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../../core/constants/enums/user_role.dart';
import '../../core/constants/enums/user_status.dart';
import '../providers/user_api_provider.dart';
import 'package:bus_connect/data/models/user_model/user_model.dart';
import 'package:dio/dio.dart';

class UserRepository {
  final UserApiProvider _apiProvider;

  UserRepository(this._apiProvider);

  // ==================== PROFILE ====================

  Future<Either<Failure, UserResponse>> getMe() async {
    try {
      final result = await _apiProvider.getMe();
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, UserResponse>> updateMe(UserSelfUpdateRequest request) async {
    try {
      final result = await _apiProvider.updateMe(request);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, UserResponse>> getMeComplete() async {
    try {
      final result = await _apiProvider.getMeComplete();
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> updateMyPassword(Map<String, dynamic> request) async {
    try {
      await _apiProvider.updateMyPassword(request);
      return const Right(null);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // ==================== QUERIES (ADMIN/DISPATCHER) ====================

  Future<Either<Failure, UserResponse>> getUserById(int id) async {
    try {
      final result = await _apiProvider.getUserById(id);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, UserResponse>> getUserByEmail(String email) async {
    try {
      final result = await _apiProvider.getUserByEmail(email);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, UserResponse>> getUserByPhone(String phone) async {
    try {
      final result = await _apiProvider.getUserByPhone(phone);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<UserResponse>>> getAllUsers() async {
    try {
      final result = await _apiProvider.getAllUsers();
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<UserResponse>>> getUsersByRole(UserRole role) async {
    try {
      final result = await _apiProvider.getUsersByRole(role);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<UserResponse>>> getUsersByRoleAndStatus(
      UserRole role,
      UserStatus status,
      ) async {
    try {
      final result = await _apiProvider.getUsersByRoleAndStatus(role, status);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<UserResponse>>> getActiveUsersByRole(UserRole role) async {
    try {
      final result = await _apiProvider.getActiveUsersByRole(role);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // ==================== CRUD (ADMIN) ====================

  Future<Either<Failure, UserResponse>> createUser(UserCreateRequest request) async {
    try {
      final result = await _apiProvider.createUser(request.toJson());
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, UserResponse>> updateUser(
      int id, UserUpdateRequest request,
      ) async {
    try {
      final result = await _apiProvider.updateUser(id, request.toJson());
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> deleteUser(int id) async {
    try {
      await _apiProvider.deleteUser(id);
      return const Right(null);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, UserResponse>> changeUserStatus(
      int id,
      UserStatus status,
      ) async {
    try {
      final result = await _apiProvider.changeUserStatus(id, status);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // ==================== VALIDATION ====================

  Future<Either<Failure, bool>> existsByEmail(String email) async {
    try {
      final result = await _apiProvider.existsByEmail(email);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, bool>> existsByPhone(String phone) async {
    try {
      final result = await _apiProvider.existsByPhone(phone);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> checkUser(
      Map<String, dynamic> request,
      ) async {
    try {
      final result = await _apiProvider.checkUser(request);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(_getErrorMessage(e)));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  String _getErrorMessage(DioException error) {
    if (error.response?.data != null && error.response?.data is Map) {
      return error.response?.data['message'] ?? 'Error desconocido';
    }
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Tiempo de espera agotado';
      case DioExceptionType.badResponse:
        return 'Respuesta inválida del servidor';
      case DioExceptionType.cancel:
        return 'Solicitud cancelada';
      default:
        return 'Error de conexión';
    }
  }
}