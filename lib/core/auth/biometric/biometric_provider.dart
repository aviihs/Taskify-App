import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:taskify_app/core/network/dio_provider.dart';
import 'package:taskify_app/core/storage/token_storage.dart';

import 'biometric_service.dart';

final biometricServiceProvider = Provider<BiometricService>((ref) {
  return BiometricService();
});

/// Whether the current device is even capable of biometric auth
/// (hardware present + at least one biometric enrolled).
final biometricAvailableProvider = FutureProvider<bool>((ref) async {
  return ref.watch(biometricServiceProvider).isAvailable();
});

/// User's saved preference: has biometric unlock been turned on for this app.
final biometricEnabledProvider =
    StateNotifierProvider<BiometricEnabledNotifier, bool>((ref) {
      return BiometricEnabledNotifier(ref.watch(tokenStorageProvider));
    });

class BiometricEnabledNotifier extends StateNotifier<bool> {
  final TokenStorage _tokenStorage;

  BiometricEnabledNotifier(this._tokenStorage) : super(false) {
    _load();
  }

  Future<void> _load() async {
    state = await _tokenStorage.isBiometricEnabled();
  }

  Future<void> setEnabled(bool enabled) async {
    await _tokenStorage.setBiometricEnabled(enabled);
    state = enabled;
  }
}

/// Whether the app is currently showing the biometric lock screen and
/// blocking access to the rest of the UI.
final appLockProvider = StateNotifierProvider<AppLockNotifier, bool>((ref) {
  return AppLockNotifier();
});

class AppLockNotifier extends StateNotifier<bool> {
  AppLockNotifier() : super(false);

  void lock() => state = true;

  void unlock() => state = false;
}
