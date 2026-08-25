import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:taskify_app/core/auth/authentication/presentation/providers/auth_provider.dart';
import 'package:taskify_app/core/auth/biometric/biometric_provider.dart';
import 'package:taskify_app/core/constants/app_colors.dart';
import 'package:taskify_app/core/constants/app_spacing.dart';
import 'package:taskify_app/core/widget/appbar/app_appbar.dart';
import 'package:taskify_app/core/widget/buttons/app_button.dart';
import 'package:taskify_app/core/widget/cards/app_card.dart';
import 'package:taskify_app/core/widget/dialog/app_snackbar.dart';
import 'package:taskify_app/core/widget/inputs/app_switch.dart';
import 'package:taskify_app/router/routes/app_routes.dart';

class ShellProfilePage extends ConsumerWidget {
  const ShellProfilePage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.showAdminPanelButton = false,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final bool showAdminPanelButton;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    final user = auth.user;
    final name = user?.firstName ?? user?.userName ?? 'Taskify User';
    final email = user?.email ?? 'No email';
    final isAdmin = user?.isAdmin ?? false;

    final biometricAvailable = ref.watch(biometricAvailableProvider);
    final biometricEnabled = ref.watch(biometricEnabledProvider);

    return Scaffold(
      appBar: AppAppBar(title: title),
      body: Padding(
        padding: AppSpacing.screenPadding,
        child: AppCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CircleAvatar(
                radius: 36,
                backgroundColor: AppColors.primary.withValues(alpha: 0.12),
                child: Icon(icon, size: 38, color: AppColors.primary),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                name,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                email,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              if (showAdminPanelButton && isAdmin) ...[
                const SizedBox(height: AppSpacing.xl),
                AppButton(
                  text: 'Go To Admin Panel',
                  icon: Icons.admin_panel_settings_sharp,
                  useGradient: true,
                  onPressed: () => context.go(AppRoutes.adminDashboard),
                ),
              ],

              biometricAvailable.when(
                data: (available) {
                  if (!available) return const SizedBox.shrink();
                  return AppSwitch(
                    margin: const EdgeInsets.only(top: AppSpacing.xl),
                    value: biometricEnabled,
                    title: 'Fingerprint Login',
                    subtitle: biometricEnabled
                        ? 'Unlock Taskify with your fingerprint or face'
                        : 'Use your fingerprint to quickly unlock Taskify',
                    onChanged: (value) async {
                      final notifier = ref.read(
                        biometricEnabledProvider.notifier,
                      );
                      if (!value) {
                        await notifier.setEnabled(false);
                        return;
                      }

                      final confirmed = await ref
                          .read(biometricServiceProvider)
                          .authenticate(
                            'Confirm your fingerprint to enable biometric login',
                          );

                      if (confirmed) {
                        await notifier.setEnabled(true);
                      } else if (context.mounted) {
                        AppSnackBar.error(
                          context,
                          'Could not verify your fingerprint. Please try again.',
                        );
                      }
                    },
                  );
                },
                loading: () => const SizedBox.shrink(),
                error: (_, _) => const SizedBox.shrink(),
              ),

              const SizedBox(height: AppSpacing.xl),
              AppButton(
                text: auth.isLoading ? 'Logging out...' : 'Logout',
                icon: Icons.logout_rounded,
                isLoading: auth.isLoading,
                onPressed: auth.isLoading
                    ? null
                    : () async {
                        await ref.read(authProvider.notifier).logout();
                        if (!context.mounted) return;
                        context.go(AppRoutes.login);
                      },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
