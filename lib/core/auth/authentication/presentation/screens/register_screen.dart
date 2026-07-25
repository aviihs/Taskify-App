import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_spacing.dart';
import '../../../../constants/app_typography.dart';
import '../../../../constants/app_ui.dart';
import '../../../../widget/app_components.dart';
import '../../../../../router/routes/app_routes.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primaryDark, AppColors.primary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Positioned(
            top: -60,
            right: -50,
            child: Container(
              width: AppUi.decorativeOrbLarge,
              height: AppUi.decorativeOrbLarge,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.16),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -90,
            left: -40,
            child: Container(
              width: AppUi.decorativeOrbSmall,
              height: AppUi.decorativeOrbSmall,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: AppSpacing.screenPadding,
                child: AppCard(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.sm),
                        decoration: BoxDecoration(
                          color: AppColors.secondary.withValues(alpha: 0.14),
                          borderRadius: BorderRadius.circular(AppUi.borderRadius),
                        ),
                        child: const Icon(
                          Icons.person_add_alt_1_rounded,
                          color: AppColors.secondary,
                          size: AppUi.iconSize,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      const Text('Create your account', style: AppTypography.heading1),
                      const SizedBox(height: AppSpacing.xs),
                      const Text('Get organized and stay on top of your tasks', style: AppTypography.bodyLarge),
                      const SizedBox(height: AppSpacing.xl),
                      const AppTextField(
                        hintText: 'Full name',
                        prefixIcon: Icon(Icons.person_outline_rounded),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      const AppTextField(
                        hintText: 'Email address',
                        prefixIcon: Icon(Icons.email_outlined),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      const AppPasswordField(
                        hintText: 'Password',
                      ),
                      const SizedBox(height: AppSpacing.md),
                      const AppPasswordField(
                        hintText: 'Confirm password',
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      AppButton(
                        text: 'Create Account',
                        backgroundColor: AppColors.secondary,
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed(AppRoutes.home);
                        },
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Already have an account? '),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(AppRoutes.login);
                            },
                            child: Text(
                              'Sign in',
                              style: AppTypography.labelMedium.copyWith(color: AppColors.secondary),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
