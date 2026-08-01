class Failure implements Exception {
  final String message;
  final int? statusCode;

  const Failure({
    required this.message,
    this.statusCode,
  });

  @override
  String toString() => message;
}

class ServerFailure extends Failure {
  const ServerFailure(String message, {int? statusCode})
      : super(message: message, statusCode: statusCode);
}

class CacheFailure extends Failure {
  const CacheFailure(String message, {int? statusCode})
      : super(message: message, statusCode: statusCode);
}

class NetworkFailure extends Failure {
  const NetworkFailure([
    String message = 'No internet connection',
    int? statusCode,
  ]) : super(message: message, statusCode: statusCode);
}

class ValidationFailure extends Failure {
  const ValidationFailure(String message, {int? statusCode})
      : super(message: message, statusCode: statusCode);
}

class AuthenticationFailure extends Failure {
  const AuthenticationFailure(String message, {int? statusCode})
      : super(message: message, statusCode: statusCode);
}
