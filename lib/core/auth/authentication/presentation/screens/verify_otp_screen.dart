import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:taskify_app/core/constants/app_colors.dart';
import 'package:taskify_app/core/constants/app_spacing.dart';
import 'package:taskify_app/core/constants/app_typography.dart';
import 'package:taskify_app/core/constants/app_ui.dart';
import 'package:taskify_app/core/widget/app_components.dart';
import 'package:taskify_app/router/routes/app_routes.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final _otpController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
                colors: [
                  AppColors.primaryDark,
                  AppColors.primary,
                ],
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
                color: Colors.white.withValues(alpha: .16),
                shape: BoxShape.circle,
              ),
            ),
          ),

          SafeArea(
            bottom: false,
            child: Column(
              children: [
                const SizedBox(height: AppSpacing.lg),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => context.pop(),
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.md),

                const Icon(
                  Icons.verified_user_outlined,
                  color: Colors.white,
                  size: 46,
                ),

                const SizedBox(height: AppSpacing.md),

                Text(
                  "Verify OTP",
                  style: AppTypography.heading2.copyWith(
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  "Enter the OTP and create a new password",
                  textAlign: TextAlign.center,
                  style: AppTypography.bodyMedium.copyWith(
                    color: Colors.white.withValues(alpha: .85),
                  ),
                ),

                const SizedBox(height: AppSpacing.xl),

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
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          AppTextField(
                            controller: _otpController,
                            label: "OTP Code",
                            hintText: "123456",
                            keyboardType: TextInputType.number,
                          ),

                          const SizedBox(height: AppSpacing.sm),

                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {
                                // resend otp
                              },
                              child: Text(
                                "Resend OTP",
                                style: AppTypography.labelMedium.copyWith(
                                  color: themeColor,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: AppSpacing.lg),

                          AppPasswordField(
                            controller: _passwordController,
                            label: "New Password",
                            hintText: "••••••••",
                            prefixIcon: null,
                          ),

                          const SizedBox(height: AppSpacing.md),

                          AppPasswordField(
                            controller: _confirmPasswordController,
                            label: "Confirm Password",
                            hintText: "••••••••",
                            prefixIcon: null,
                          ),

                          const SizedBox(height: AppSpacing.xxl),

                          AppButton(
                            text: "Reset Password",
                            backgroundColor: themeColor,
                            height: 52,
                            borderRadius: 14,
                            onPressed: () {
                              // TODO: Verify OTP & Reset Password

                              context.go(AppRoutes.login);
                            },
                          ),

                          const SizedBox(height: AppSpacing.lg),

                          GestureDetector(
                            onTap: () => context.pop(),
                            child: Text(
                              "Change Email",
                              style: AppTypography.labelMedium.copyWith(
                                color: themeColor,
                              ),
                            ),
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