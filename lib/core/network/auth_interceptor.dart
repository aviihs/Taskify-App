import 'package:dio/dio.dart';
import 'package:taskify_app/core/network/api_constant.dart';
import '../storage/token_storage.dart';

/// Interceptor that attaches JWT Bearer access token to all outgoing requests.
class AuthInterceptor extends Interceptor {
  final TokenStorage _tokenStorage;
  final Dio _refreshDio;
  static const Set<String> _publicAuthPaths = {
    ApiConstants.login,
    ApiConstants.register,
    ApiConstants.refreshToken,
    ApiConstants.logout,
    ApiConstants.forgotPassword,
    ApiConstants.resetPassword,
    ApiConstants.verifyEmail,
    ApiConstants.resendOtp,
  };

  AuthInterceptor(this._tokenStorage)
    : _refreshDio = Dio(
        BaseOptions(
          baseUrl: ApiConstants.baseUrl,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (_publicAuthPaths.contains(options.path)) {
      return super.onRequest(options, handler);
    }

    final token = await _tokenStorage.getAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final statusCode = err.response?.statusCode;
    final hasRetried = err.requestOptions.extra['authRetry'] == true;
    final isPublicAuthRequest = _publicAuthPaths.contains(
      err.requestOptions.path,
    );

    if (statusCode != 401 || hasRetried || isPublicAuthRequest) {
      return handler.next(err);
    }

    final refreshToken = await _tokenStorage.getRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) {
      await _tokenStorage.clearAll();
      return handler.next(err);
    }

    try {
      final refreshResponse = await _refreshDio.post(
        ApiConstants.refreshToken,
        data: {'token': refreshToken},
      );

      final data = refreshResponse.data;
      if (data is! Map) {
        return handler.next(err);
      }

      final accessToken = data['accessToken']?.toString();
      final rotatedRefreshToken = data['refreshToken']?.toString();

      if (accessToken == null || accessToken.isEmpty) {
        return handler.next(err);
      }

      await _tokenStorage.saveTokens(
        accessToken: accessToken,
        refreshToken: rotatedRefreshToken,
      );

      final retryOptions = err.requestOptions;
      retryOptions.extra['authRetry'] = true;
      retryOptions.headers['Authorization'] = 'Bearer $accessToken';

      final retryResponse = await _refreshDio.fetch<dynamic>(retryOptions);
      return handler.resolve(retryResponse);
    } catch (_) {
      await _tokenStorage.clearAll();
      return handler.next(err);
    }
  }
}
