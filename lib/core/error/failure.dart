class Failure implements Exception {
  final String message;
  final int? statusCode;

  const Failure({required this.message, this.statusCode});

  @override
  String toString() => message;
}

class ServerFailure extends Failure {
  const ServerFailure(String message, {super.statusCode})
    : super(message: message);
}

class CacheFailure extends Failure {
  const CacheFailure(String message, {super.statusCode})
    : super(message: message);
}

class NetworkFailure extends Failure {
  const NetworkFailure([
    String message = 'No internet connection',
    int? statusCode,
  ]) : super(message: message, statusCode: statusCode);
}

class ValidationFailure extends Failure {
  const ValidationFailure(String message, {super.statusCode})
    : super(message: message);
}

class AuthenticationFailure extends Failure {
  const AuthenticationFailure(String message, {super.statusCode})
    : super(message: message);
}
