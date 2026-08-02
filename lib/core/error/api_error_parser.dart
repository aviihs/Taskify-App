import 'package:dio/dio.dart';

class ApiFailure {
  final String message;

  const ApiFailure({required this.message});
}

class ApiErrorParser {
  static ApiFailure parse(dynamic error) {
    if (error is ApiFailure) {
      return error;
    }

    if (error is DioException) {
      String? errorMessage;

      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.sendTimeout ||
          error.type == DioExceptionType.receiveTimeout) {
        return const ApiFailure(
          message:
              'Request timed out. Make sure the Taskify API is running and the app base URL points to this computer.',
        );
      }

      if (error.type == DioExceptionType.connectionError) {
        return const ApiFailure(
          message:
              'Could not connect to Taskify API. Check Wi-Fi, backend server, and API base URL.',
        );
      }

      if (error.response?.data != null) {
        final data = error.response!.data;
        if (data is Map) {
          final message = data['message'];
          if (message is List) {
            errorMessage = message.join('\n');
          } else {
            errorMessage = message?.toString() ?? data['error']?.toString();
          }
        } else if (data is String) {
          errorMessage = data;
        }
      }

      errorMessage ??= error.message;
      errorMessage ??= 'Something went wrong. Please try again.';
      return ApiFailure(message: errorMessage);
    }

    return ApiFailure(message: error.toString());
  }
}
