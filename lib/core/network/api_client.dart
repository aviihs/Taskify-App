// import 'package:dio/dio.dart';

// import '../error/app_exception.dart';
// import 'api_result.dart';
// import 'dio_client.dart';

// class ApiClient {
//   ApiClient({DioClient? dioClient}) : _dioClient = dioClient ?? DioClient();

//   final DioClient _dioClient;

//   DioClient get dioClient => _dioClient;

//   Future<ApiResult<T>> get<T>(String path, {Map<String, dynamic>? queryParameters}) async {
//     try {
//       final response = await _dioClient.get<T>(path, queryParameters: queryParameters);
//       return ApiSuccess(response.data as T);
//     } on DioException catch (error) {
//       return _handleError<T>(error);
//     } on AppException catch (error) {
//       return ApiFailure<T>(error.message, exception: error);
//     }
//   }

//   Future<ApiResult<T>> post<T>(String path, {dynamic data}) async {
//     try {
//       final response = await _dioClient.post<T>(path, data: data);
//       return ApiSuccess(response.data as T);
//     } on DioException catch (error) {
//       return _handleError<T>(error);
//     } on AppException catch (error) {
//       return ApiFailure<T>(error.message, exception: error);
//     }
//   }

//   ApiResult<T> _handleError<T>(DioException error) {
//     final message = _resolveMessage(error);
//     final statusCode = error.response?.statusCode;
//     return ApiFailure<T>(message, exception: error, statusCode: statusCode);
//   }

//   String _resolveMessage(DioException error) {
//     if (error.type == DioExceptionType.connectionTimeout ||
//         error.type == DioExceptionType.receiveTimeout ||
//         error.type == DioExceptionType.sendTimeout) {
//       return 'The request timed out. Please try again.';
//     }

//     if (error.response?.statusCode != null && error.response!.statusCode! >= 500) {
//       return 'The server is currently unavailable. Please try again later.';
//     }

//     if (error.response?.statusCode == 404) {
//       return 'The requested resource was not found.';
//     }

//     if (error.response?.statusCode == 401) {
//       return 'You are not authorized to perform this action.';
//     }

//     return 'Something went wrong. Please try again.';
//   }
// }

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:taskify_app/core/error/api_error_parser.dart';
import 'package:taskify_app/core/error/failure.dart';

class ApiClient {
  final Dio dio;

  ApiClient(this.dio);

  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) => _request(
    () => dio.get(path, queryParameters: queryParameters, options: options),
  );

  Future<dynamic> post(String path, {dynamic data, Options? options}) =>
      _request(() => dio.post(path, data: data, options: options));

  Future<dynamic> put(String path, {dynamic data, Options? options}) =>
      _request(() => dio.put(path, data: data, options: options));

  Future<dynamic> patch(String path, {dynamic data, Options? options}) =>
      _request(() => dio.patch(path, data: data, options: options));

  Future<dynamic> delete(
    String path, {
    dynamic data,
    Options? options,
    Map<String, dynamic>? queryParameters,
  }) => _request(
    () => dio.delete(
      path,
      data: data,
      options: options,
      queryParameters: queryParameters,
    ),
  );

  Future<void> postNoContent(
    String path, {
    dynamic data,
    Options? options,
  }) async {
    try {
      await dio.post(path, data: data, options: options);
    } on DioException catch (e) {
      throw ApiErrorParser.parse(e);
    }
  }

  Future<dynamic> uploadFile(
    String path, {
    required File file,
    String fieldName = "file",
    ProgressCallback? onSendProgress,
  }) async {
    final fileName = file.path.split(Platform.pathSeparator).last;

    final formData = FormData.fromMap({
      fieldName: await MultipartFile.fromFile(file.path, filename: fileName),
    });

    return _request(
      () => dio.patch(path, data: formData, onSendProgress: onSendProgress),
    );
  }

  Future<dynamic> _request(Future<Response<dynamic>> Function() call) async {
    try {
      final response = await call();

      final data = response.data;

      if (data == null && response.statusCode != 204) {
        throw const Failure(message: "Empty response from server");
      }

      return data;
    } on DioException catch (e) {
      throw ApiErrorParser.parse(e);
    } on Failure {
      rethrow;
    } catch (e) {
      throw ApiErrorParser.parse(e);
    }
  }
}
