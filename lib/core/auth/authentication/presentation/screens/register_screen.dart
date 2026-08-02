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

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = AppColors.primary;
    final authState = ref.watch(authProvider);

    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next.error != null) {
        AppSnackBar.error(context, next.error!);
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
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: AppTextField(
                                    controller: _firstNameController,
                                    label: "First Name",
                                    hintText: "Shiva",
                                    validator: (v) => v == null || v.isEmpty
                                        ? 'Required'
                                        : null,
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.xs),
                                Expanded(
                                  child: AppTextField(
                                    controller: _lastNameController,
                                    label: "Last Name",
                                    hintText: "Bhusal",
                                    validator: (v) => v == null || v.isEmpty
                                        ? 'Required'
                                        : null,
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
                              validator: Validators.email,
                            ),
                            const SizedBox(height: AppSpacing.md),
                            AppTextField(
                              controller: _usernameController,
                              label: "Username (optional)",
                              hintText: "shivabhusal",
                              validator: Validators.username,
                            ),
                            const SizedBox(height: AppSpacing.md),
                            AppPasswordField(
                              controller: _passwordController,
                              label: "Password",
                              hintText: "••••••••",
                              validator: Validators.password,
                            ),
                            const SizedBox(height: AppSpacing.md),
                            AppPasswordField(
                              controller: _confirmPasswordController,
                              label: "Confirm Password",
                              hintText: "••••••••",
                              validator: (val) {
                                if (val != _passwordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: AppSpacing.xl),
                            AppButton(
                              text: "Register",
                              backgroundColor: themeColor,
                              height: 52,
                              borderRadius: 14,
                              isLoading: authState.isLoading,
                              onPressed: () async {
                                if (!_formKey.currentState!.validate()) {
                                  return;
                                }

                                final email = _emailController.text.trim();
                                final username = _usernameController.text
                                    .trim();
                                final auth = AuthEntity(
                                  firstName: _firstNameController.text.trim(),
                                  lastName: _lastNameController.text.trim(),
                                  email: email,
                                  userName: username.isNotEmpty
                                      ? username
                                      : _usernameFromEmail(email),
                                  password: _passwordController.text.trim(),
                                );

                                final success = await ref
                                    .read(authProvider.notifier)
                                    .register(auth);

                                if (success && context.mounted) {
                                  AppSnackBar.success(
                                    context,
                                    "Registration successful! Enter OTP sent to email.",
                                  );
                                  context.push(
                                    AppRoutes.otpScreen,
                                    extra: email,
                                  );
                                }
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
                                    context.pop();
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _usernameFromEmail(String email) {
    final localPart = email.split('@').first;
    final cleaned = localPart.replaceAll(RegExp(r'[^a-zA-Z0-9_.]'), '_');

    if (cleaned.length >= 3) {
      return cleaned.length > 30 ? cleaned.substring(0, 30) : cleaned;
    }

    return 'user_${DateTime.now().millisecondsSinceEpoch}';
  }
}
