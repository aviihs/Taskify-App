class AppConstants {
  AppConstants._();

  static const String appName = 'Taskify';
  static const String appTagline = 'Plan your day with clarity';
  static const Duration connectTimeout = Duration(seconds: 20);
  static const Duration receiveTimeout = Duration(seconds: 20);
  static const Duration sendTimeout = Duration(seconds: 20);

  /// How long the app can sit in the background before biometric
  /// re-authentication is required to resume a session.
  static const Duration biometricLockTimeout = Duration(minutes: 3);
}
