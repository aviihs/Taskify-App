import 'package:local_auth/local_auth.dart';

/// Thin wrapper around [LocalAuthentication] so the rest of the app never
/// touches the plugin directly.
class BiometricService {
  final LocalAuthentication _localAuth = LocalAuthentication();

  /// True when the device has the hardware and OS support required to show
  /// a biometric (or device-credential) prompt at all.
  Future<bool> isDeviceSupported() async {
    try {
      return await _localAuth.isDeviceSupported();
    } catch (_) {
      return false;
    }
  }

  /// True when at least one biometric (fingerprint/face) is enrolled.
  Future<bool> canCheckBiometrics() async {
    try {
      return await _localAuth.canCheckBiometrics;
    } catch (_) {
      return false;
    }
  }

  Future<bool> isAvailable() async {
    return (await isDeviceSupported()) && (await canCheckBiometrics());
  }

  /// Shows the OS biometric prompt. Returns false on any failure, denial,
  /// cancellation, or platform exception rather than throwing.
  Future<bool> authenticate(String reason) async {
    try {
      return await _localAuth.authenticate(
        localizedReason: reason,
        options: const AuthenticationOptions(
          biometricOnly: false,
          stickyAuth: true,
        ),
      );
    } catch (_) {
      return false;
    }
  }
}
