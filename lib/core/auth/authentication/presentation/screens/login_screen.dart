import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:taskify_app/core/auth/authentication/domain/entity/auth_entity.dart';
import 'package:taskify_app/core/auth/authentication/presentation/providers/auth_provider.dart';
import 'package:taskify_app/core/constants/app_colors.dart';
import 'package:taskify_app/core/constants/app_spacing.dart';
import 'package:taskify_app/core/constants/app_typography.dart';
import 'package:taskify_app/core/constants/app_ui.dart';
import 'package:taskify_app/core/utils/validators.dart';
import 'package:taskify_app/core/widget/buttons/app_button.dart';
import 'package:taskify_app/core/widget/dialog/app_snackbar.dart';
import 'package:taskify_app/core/widget/inputs/app_password_field.dart';
import 'package:taskify_app/core/widget/inputs/app_textfield.dart';
import 'package:taskify_app/router/routes/app_routes.dart';

/// Pixel-perfect Login Screen with Riverpod authentication.
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();

    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = AppColors.primary;

    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next.error != null) {
        AppSnackBar.error(context, next.error!);
      }

      if (next.user != null && next.token != null) {
        AppSnackBar.success(context, "Login successful");

        context.go(
          next.user!.isAdmin ? AppRoutes.adminDashboard : AppRoutes.home,
        );
      }
    });

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

                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            AppTextField(
                              controller: _emailController,

                              label: 'Email or mobile',

                              hintText: 'jhondoe@gmail.com',

                              keyboardType: TextInputType.emailAddress,

                              validator: Validators.email,
                            ),

                            const SizedBox(height: AppSpacing.md),

                            AppPasswordField(
                              controller: _passwordController,

                              label: 'Password',

                              hintText: '••••••••',

                              prefixIcon: null,

                              validator: Validators.password,
                            ),

                            const SizedBox(height: AppSpacing.sm),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,

                              children: [
                                GestureDetector(
                                  onTap: () {
                                    context.push(AppRoutes.forgotPassword);
                                  },

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

                            Consumer(
                              builder: (context, ref, child) {
                                final authState = ref.watch(authProvider);

                                return AppButton(
                                  text: "Login",
                                  backgroundColor: themeColor,
                                  height: 52,
                                  borderRadius: 14,
                                  isLoading: authState.isLoading,
                                  onPressed: () async {
                                    if (!_formKey.currentState!.validate()) {
                                      return;
                                    }
                                    final auth = AuthEntity(
                                      email: _emailController.text.trim(),
                                      password: _passwordController.text.trim(),
                                    );
                                    await ref
                                        .read(authProvider.notifier)
                                        .login(auth);
                                  },
                                );
                              },
                            ),

                            const SizedBox(height: AppSpacing.xl),

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

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [
                                const Text(
                                  "Don't have an account? ",

                                  style: AppTypography.bodyMedium,
                                ),

                                GestureDetector(
                                  onTap: () {
                                    context.push(AppRoutes.register);
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
