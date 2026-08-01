import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskify_app/core/network/api_constant.dart';
import 'package:taskify_app/core/network/auth_interceptor.dart';
import 'package:taskify_app/core/network/network_logger_interceptor.dart';
import 'package:taskify_app/core/storage/token_storage.dart';
import '../constants/app_constants.dart';

final tokenStorageProvider = Provider<TokenStorage>((ref) {
  return TokenStorage();
});

final dioProvider = Provider<Dio>((ref) {
  final tokenStorage = ref.watch(tokenStorageProvider);

  final dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: AppConstants.connectTimeout,
      receiveTimeout: AppConstants.receiveTimeout,
      sendTimeout: AppConstants.sendTimeout,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  // 1. Auth Interceptor to attach Bearer token
  dio.interceptors.add(AuthInterceptor(tokenStorage));

  // 2. Yellow Toast Logger Interceptor to display floating yellow toasts on API hits/responses
  dio.interceptors.add(NetworkLoggerInterceptor());

  // 3. Console Log Interceptor for debugging
  dio.interceptors.add(
    LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ),
  );

  return dio;
});