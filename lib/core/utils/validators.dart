class Validators {
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email is required";
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(value.trim())) {
      return "Enter valid email";
    }

    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }

    if (value.length < 8) {
      return "Password must be at least 8 characters";
    }

    final passwordRegex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&.#])[A-Za-z\d@$!%*?&.#]+$',
    );

    if (!passwordRegex.hasMatch(value)) {
      return "Use uppercase, lowercase, number, and special character";
    }

    return null;
  }

  static String? username(String? value) {
    final username = value?.trim() ?? '';
    if (username.isEmpty) return null;

    if (username.length < 3) {
      return "Username must be at least 3 characters";
    }

    if (username.length > 30) {
      return "Username must be 30 characters or less";
    }

    final usernameRegex = RegExp(r'^[a-zA-Z0-9_.]+$');
    if (!usernameRegex.hasMatch(username)) {
      return "Only letters, numbers, underscores, and periods";
    }

    return null;
  }

  static String? required(String? value, String field) {
    if (value == null || value.trim().isEmpty) {
      return "$field is required";
    }

    return null;
  }

  static String? confirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return "Confirm password is required";
    }

    if (value != password) {
      return "Password does not match";
    }

    return null;
  }
}
