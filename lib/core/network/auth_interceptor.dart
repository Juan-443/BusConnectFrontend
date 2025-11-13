import 'package:dio/dio.dart';
import '../../services/storage_service.dart';
import '../constants/storage_keys.dart';

class AuthInterceptor extends Interceptor {
  final Dio _dio;
  final StorageService _storage = StorageService();

  AuthInterceptor(this._dio);

  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    // Obtener token de almacenamiento
    final token = await _storage.getSecureData(StorageKeys.accessToken);

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Token expirado, intentar refresh
      try {
        final refreshToken = await _storage.getSecureData(StorageKeys.refreshToken);

        if (refreshToken != null) {
          final response = await _dio.post(
            '/api/auth/refresh',
            data: {'refreshToken': refreshToken},
          );

          if (response.statusCode == 200) {
            final newAccessToken = response.data['accessToken'];
            final newRefreshToken = response.data['refreshToken'];

            // Guardar nuevos tokens
            await _storage.saveSecureData(StorageKeys.accessToken, newAccessToken);
            await _storage.saveSecureData(StorageKeys.refreshToken, newRefreshToken);

            // Reintentar request original
            final opts = err.requestOptions;
            opts.headers['Authorization'] = 'Bearer $newAccessToken';

            final retryResponse = await _dio.fetch(opts);
            return handler.resolve(retryResponse);
          }
        }
      } catch (e) {
        // Refresh falló, logout
        await _storage.clearAll();
      }
    }

    handler.next(err);
  }
}