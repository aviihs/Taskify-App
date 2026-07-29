import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taskify_app/core/constants/app_ui.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_spacing.dart';
import '../../../../constants/app_typography.dart';
import '../../../../widget/app_components.dart';
import '../../../../../router/routes/app_routes.dart';

/// Pixel-perfect implementation of the Login Screen matching the UI mockup.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = AppColors.primary;

    return Scaffold(
      backgroundColor: themeColor,
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
            top: -70,
            right: -80,
            child: Container(
              width: AppUi.decorativeOrbLarge,
              height: AppUi.decorativeOrbLarge,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.16),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // children: [
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                // =================================================================
                // Header Section (Purple background)
                // =================================================================
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxl),
                const Icon(
                  Icons.task_alt_outlined,
                  size: 46,
                  color: Colors.white,
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  'Sign In to your Account',
                  style: AppTypography.heading2.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 6),
                Text(
                  'Enter your email and password to sign in',
                  style: AppTypography.bodyMedium.copyWith(
                    color: Colors.white.withValues(alpha: 0.85),
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),

                // =================================================================
                // Content Card (White Bottom Container)
                // =================================================================
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(32),
                      ),
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Email or Mobile Field
                          AppTextField(
                            controller: _emailController,
                            label: 'Email or mobile',
                            hintText: 'jhondoe@gmail.com',
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: AppSpacing.md),

                          // Password Field
                          AppPasswordField(
                            controller: _passwordController,
                            label: 'Password',
                            hintText: '••••••••',
                            // helperText: 'Password must be at least 8 characters',
                            prefixIcon: null,
                          ),
                          const SizedBox(height: AppSpacing.sm),

                          // Remember me & Forgot password Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  'Forgot password?',
                                  style: AppTypography.labelMedium.copyWith(
                                    color: themeColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.xl),

                          // Login Button
                          AppButton(
                            text: 'Login',
                            backgroundColor: themeColor,
                            height: 52,
                            borderRadius: 14,
                            onPressed: () {
                              print("object");
                            },
                          ),
                          const SizedBox(height: AppSpacing.xl),

                          // Divider Row ("Or")
                          Row(
                            children: [
                              const Expanded(
                                child: Divider(
                                  color: AppColors.border,
                                  thickness: 1,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Text(
                                  'Or',
                                  style: AppTypography.bodyMedium.copyWith(
                                    color: AppColors.textMuted,
                                  ),
                                ),
                              ),
                              const Expanded(
                                child: Divider(
                                  color: AppColors.border,
                                  thickness: 1,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.lg),

                          // Don't have an account? Sign up
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have an account? ",
                                style: AppTypography.bodyMedium,
                              ),
                              GestureDetector(
                                onTap: () {
                                 context.push(
                                  AppRoutes.otpScreen
                                 );
                                },
                                child: Text(
                                  'Sign up',
                                  style: AppTypography.labelMedium.copyWith(
                                    color: themeColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
