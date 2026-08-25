import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskify_app/core/auth/authentication/presentation/providers/auth_provider.dart';
import 'package:taskify_app/core/constants/app_constants.dart';
import 'package:taskify_app/core/network/dio_provider.dart';

import 'biometric_lock_screen.dart';
import 'biometric_provider.dart';

/// Wraps the whole app. Tracks how long the app has been backgrounded and,
/// once it has been enabled by the user and the inactivity timeout has
/// elapsed, overlays [BiometricLockScreen] on top of whatever route is
/// currently showing until the user re-authenticates.
///
/// This is a device-local re-entry gate, separate from access/refresh token
/// validity: tokens keep being managed silently by [AuthInterceptor] on the
/// network layer, this widget only decides whether the *UI* may be seen.
class AppLockGate extends ConsumerStatefulWidget {
  const AppLockGate({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<AppLockGate> createState() => _AppLockGateState();
}

class _AppLockGateState extends ConsumerState<AppLockGate>
    with WidgetsBindingObserver {
  DateTime? _backgroundedAt;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // App was just cold-started (or hot-restarted): check whether it was
    // last closed long enough ago to require an immediate unlock.
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkColdStart());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> _checkColdStart() async {
    final tokenStorage = ref.read(tokenStorageProvider);
    final lastActiveAt = await tokenStorage.getLastActiveAt();
    await _evaluateLock(lastActiveAt);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final tokenStorage = ref.read(tokenStorageProvider);

    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
        _backgroundedAt ??= DateTime.now();
        tokenStorage.setLastActiveAt(DateTime.now());
        break;
      case AppLifecycleState.resumed:
        final backgroundedAt = _backgroundedAt;
        _backgroundedAt = null;
        _evaluateLock(backgroundedAt);
        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  Future<void> _evaluateLock(DateTime? sinceWhen) async {
    if (sinceWhen == null) return;
    if (ref.read(authProvider).user == null) return;

    final biometricEnabled = ref.read(biometricEnabledProvider);
    if (!biometricEnabled) return;

    final elapsed = DateTime.now().difference(sinceWhen);
    if (elapsed >= AppConstants.biometricLockTimeout) {
      ref.read(appLockProvider.notifier).lock();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLocked = ref.watch(appLockProvider);

    return Stack(
      children: [
        widget.child,
        if (isLocked) const BiometricLockScreen(),
      ],
    );
  }
}
