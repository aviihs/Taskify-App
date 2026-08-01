class ApiFailure {
  final String message;

  const ApiFailure({
    required this.message,
  });
}


class ApiErrorParser {

  static ApiFailure parse(dynamic error) {

    if (error is ApiFailure) {
      return error;
    }

    return ApiFailure(
      message: error.toString(),
    );
  }
}