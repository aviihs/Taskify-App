import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taskify_app/core/constants/app_colors.dart';
import 'package:taskify_app/core/constants/app_spacing.dart';
import 'package:taskify_app/core/constants/app_typography.dart';
import 'package:taskify_app/core/constants/app_ui.dart';
import 'package:taskify_app/core/widget/app_components.dart';
import 'package:taskify_app/router/routes/app_routes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
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
                  Icons.person_add_alt_1,
                  size: 46,
                  color: Colors.white,
                ),

                const SizedBox(height: AppSpacing.md),

                Text(
                  "Create Account",
                  style: AppTypography.heading2.copyWith(color: Colors.white),
                ),

                const SizedBox(height: 6),

                Text(
                  "Create your account to continue",
                  style: AppTypography.bodyMedium.copyWith(
                    color: Colors.white.withValues(alpha: 0.85),
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
                      padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: AppTextField(
                                  controller: _firstNameController,
                                  label: "First Name",
                                  hintText: "Shiva",
                                ),
                              ),

                              const SizedBox(width: AppSpacing.xs),

                              Expanded(
                                child: AppTextField(
                                  controller: _lastNameController,
                                  label: "Last Name",
                                  hintText: "Bhusal",
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: AppSpacing.md),

                          AppTextField(
                            controller: _emailController,
                            label: "Email",
                            hintText: "bhusalshiva@gmail.com",
                            keyboardType: TextInputType.emailAddress,
                          ),

                          const SizedBox(height: AppSpacing.md),

                          AppPasswordField(
                            controller: _passwordController,
                            label: "Password",
                            hintText: "••••••••",
                          ),

                          const SizedBox(height: AppSpacing.md),

                          AppPasswordField(
                            controller: _confirmPasswordController,
                            label: "Confirm Password",
                            hintText: "••••••••",
                          ),

                          const SizedBox(height: AppSpacing.xl),

                          AppButton(
                            text: "Register",
                            backgroundColor: themeColor,
                            height: 52,
                            borderRadius: 14,
                            onPressed: () {
                              context.push(AppRoutes.otpScreen);
                            },
                          ),

                          const SizedBox(height: AppSpacing.xl),

                          Row(
                            children: [
                              const Expanded(
                                child: Divider(color: AppColors.border),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Text(
                                  "Or",
                                  style: AppTypography.bodyMedium.copyWith(
                                    color: AppColors.textMuted,
                                  ),
                                ),
                              ),
                              const Expanded(
                                child: Divider(color: AppColors.border),
                              ),
                            ],
                          ),

                          const SizedBox(height: AppSpacing.lg),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Already have an account? ",
                                style: AppTypography.bodyMedium,
                              ),
                              GestureDetector(
                                onTap: () {
                                  context.pop(AppRoutes.login);
                                },
                                child: Text(
                                  "Login",
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
