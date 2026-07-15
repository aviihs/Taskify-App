class AppException implements Exception {
  const AppException({required this.message, this.code, this.details});

  final String message;
  final String? code;
  final Object? details;

  @override
  String toString() => 'AppException(message: $message, code: $code)';
}

class NetworkException extends AppException {
  const NetworkException({required super.message, super.code, super.details});
}

class ServerException extends AppException {
  const ServerException({required super.message, super.code, super.details});
}

class CacheException extends AppException {
  const CacheException({required super.message, super.code, super.details});
}
