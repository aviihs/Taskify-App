import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:taskify_app/core/auth/authentication/presentation/providers/auth_provider.dart';
import 'package:taskify_app/core/constants/app_colors.dart';
import 'package:taskify_app/core/constants/app_spacing.dart';
import 'package:taskify_app/core/constants/app_typography.dart';
import 'package:taskify_app/core/widget/buttons/app_button.dart';
import 'package:taskify_app/router/routes/app_routes.dart';

import 'biometric_provider.dart';

/// Full-screen gate shown when the app returns from the background after
/// the biometric lock timeout has elapsed. Blocks all interaction with the
/// rest of the app until the user unlocks with biometrics.
class BiometricLockScreen extends ConsumerStatefulWidget {
  const BiometricLockScreen({super.key});

  @override
  ConsumerState<BiometricLockScreen> createState() =>
      _BiometricLockScreenState();
}

class _BiometricLockScreenState extends ConsumerState<BiometricLockScreen> {
  bool _authenticating = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _attemptUnlock());
  }

  Future<void> _attemptUnlock() async {
    if (_authenticating) return;
    setState(() {
      _authenticating = true;
      _error = null;
    });

    final success = await ref
        .read(biometricServiceProvider)
        .authenticate('Unlock Taskify to continue');

    if (!mounted) return;
    setState(() => _authenticating = false);

    if (success) {
      ref.read(appLockProvider.notifier).unlock();
    } else {
      setState(() => _error = 'Authentication failed. Try again.');
    }
  }

  Future<void> _logout() async {
    await ref.read(authProvider.notifier).logout();
    ref.read(appLockProvider.notifier).unlock();
    if (!mounted) return;
    context.go(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      child: SafeArea(
        child: Padding(
          padding: AppSpacing.screenPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 44,
                backgroundColor: AppColors.primary.withValues(alpha: 0.12),
                child: Icon(
                  Icons.fingerprint_rounded,
                  size: 48,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text('Taskify is locked', style: AppTypography.heading2),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Verify it\'s you to continue where you left off.',
                textAlign: TextAlign.center,
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textMuted,
                ),
              ),
              if (_error != null) ...[
                const SizedBox(height: AppSpacing.md),
                Text(
                  _error!,
                  textAlign: TextAlign.center,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.error,
                  ),
                ),
              ],
              const SizedBox(height: AppSpacing.xl),
              AppButton(
                text: _authenticating ? 'Verifying...' : 'Unlock',
                icon: Icons.fingerprint_rounded,
                useGradient: true,
                isLoading: _authenticating,
                onPressed: _authenticating ? null : _attemptUnlock,
              ),
              const SizedBox(height: AppSpacing.md),
              TextButton(
                onPressed: _authenticating ? null : _logout,
                child: const Text('Log out instead'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
