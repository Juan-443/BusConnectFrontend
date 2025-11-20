import 'package:dio/dio.dart';
import '../../services/storage_service.dart';
import '../constants/storage_keys.dart';

class AuthInterceptor extends Interceptor {
  final Dio _dio;
  final StorageService _storage = StorageService();
  bool _isRefreshing = false;

  // ⭐ NUEVO: Callback para logout
  final Function()? onUnauthorized;

  AuthInterceptor(this._dio, {this.onUnauthorized});

  @override
  Future<void> onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    print('📤 Request: ${options.method} ${options.path}');

    final token = await _storage.getSecureData(StorageKeys.accessToken);

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
      print('🔑 Token agregado (${token.length} chars)');
      print('   Primeros 30: ${token.substring(0, 30)}...');
    } else {
      print('⚠️ NO HAY TOKEN para: ${options.path}');
    }

    return handler.next(options);
  }

  @override
  Future<void> onError(
      DioException err,
      ErrorInterceptorHandler handler,
      ) async {
    final statusCode = err.response?.statusCode;
    final requestPath = err.requestOptions.path;

    print('❌ Error: $statusCode - $requestPath');

    if (statusCode == 401 &&
        !requestPath.contains('/auth/refresh') &&
        !requestPath.contains('/auth/login')) {

      if (_isRefreshing) {
        print('⏳ Ya hay un refresh en proceso');
        return handler.next(err);
      }

      print('🔄 Intentando refresh token...');
      _isRefreshing = true;

      try {
        final refreshToken = await _storage.getSecureData(StorageKeys.refreshToken);

        if (refreshToken == null || refreshToken.isEmpty) {
          print('❌ No hay refresh token');
          await _clearAllDataAndLogout();
          _isRefreshing = false;
          return handler.next(err);
        }

        print('📤 Enviando refresh: ${refreshToken.substring(0, 30)}...');

        final refreshDio = Dio(BaseOptions(
          baseUrl: _dio.options.baseUrl,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ));

        final response = await refreshDio.post(
          '/auth/refresh',
          data: {'refreshToken': refreshToken},
        );

        if (response.statusCode == 200) {
          final data = response.data;
          final newAccessToken = data['accessToken'];
          final newRefreshToken = data['refreshToken'];

          if (newAccessToken == null || newRefreshToken == null) {
            print('❌ Respuesta sin tokens');
            await _clearAllDataAndLogout();
            _isRefreshing = false;
            return handler.next(err);
          }

          print('✅ Nuevos tokens recibidos');

          await _storage.saveSecureData(StorageKeys.accessToken, newAccessToken);
          await _storage.saveSecureData(StorageKeys.refreshToken, newRefreshToken);

          _isRefreshing = false;

          // Reintentar request
          final opts = err.requestOptions;
          opts.headers['Authorization'] = 'Bearer $newAccessToken';

          print('🔄 Reintentando: ${opts.path}');

          try {
            final retryResponse = await _dio.fetch(opts);
            return handler.resolve(retryResponse);
          } catch (e) {
            print('❌ Error al reintentar: $e');
            return handler.next(err);
          }
        } else {
          print('❌ Refresh falló: ${response.statusCode}');
          await _clearAllDataAndLogout();
          _isRefreshing = false;
        }
      } on DioException catch (e) {
        print('❌ Refresh error: ${e.response?.statusCode}');
        print('   Message: ${e.message}');

        // ⭐ Si el refresh falla con 401, el refresh token está expirado
        if (e.response?.statusCode == 401) {
          print('🔐 Refresh token expirado - Requiere login');
        }

        await _clearAllDataAndLogout();
        _isRefreshing = false;
      } catch (e) {
        print('❌ Error inesperado: $e');
        await _clearAllDataAndLogout();
        _isRefreshing = false;
      }
    }

    return handler.next(err);
  }

  // ⭐ MODIFICADO: Llama al callback de logout
  Future<void> _clearAllDataAndLogout() async {
    print('🗑️ Limpiando datos y cerrando sesión...');

    await _storage.remove(StorageKeys.accessToken);
    await _storage.remove(StorageKeys.refreshToken);
    await _storage.remove(StorageKeys.userId);
    await _storage.remove(StorageKeys.userName);
    await _storage.remove(StorageKeys.userEmail);
    await _storage.remove(StorageKeys.userRole);

    print('✅ Datos limpiados');

    // ⭐ Notificar al AuthProvider
    onUnauthorized?.call();
  }
}