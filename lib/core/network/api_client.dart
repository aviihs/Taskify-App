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
