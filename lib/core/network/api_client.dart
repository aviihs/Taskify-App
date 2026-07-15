import 'package:dio/dio.dart';

import '../error/app_exception.dart';
import 'api_result.dart';
import 'dio_client.dart';

class ApiClient {
  ApiClient({DioClient? dioClient}) : _dioClient = dioClient ?? DioClient();

  final DioClient _dioClient;

  DioClient get dioClient => _dioClient;

  Future<ApiResult<T>> get<T>(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dioClient.get<T>(path, queryParameters: queryParameters);
      return ApiSuccess(response.data as T);
    } on DioException catch (error) {
      return _handleError<T>(error);
    } on AppException catch (error) {
      return ApiFailure<T>(error.message, exception: error);
    }
  }

  Future<ApiResult<T>> post<T>(String path, {dynamic data}) async {
    try {
      final response = await _dioClient.post<T>(path, data: data);
      return ApiSuccess(response.data as T);
    } on DioException catch (error) {
      return _handleError<T>(error);
    } on AppException catch (error) {
      return ApiFailure<T>(error.message, exception: error);
    }
  }

  ApiResult<T> _handleError<T>(DioException error) {
    final message = _resolveMessage(error);
    final statusCode = error.response?.statusCode;
    return ApiFailure<T>(message, exception: error, statusCode: statusCode);
  }

  String _resolveMessage(DioException error) {
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.sendTimeout) {
      return 'The request timed out. Please try again.';
    }

    if (error.response?.statusCode != null && error.response!.statusCode! >= 500) {
      return 'The server is currently unavailable. Please try again later.';
    }

    if (error.response?.statusCode == 404) {
      return 'The requested resource was not found.';
    }

    if (error.response?.statusCode == 401) {
      return 'You are not authorized to perform this action.';
    }

    return 'Something went wrong. Please try again.';
  }
}
