import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taskify_app/core/auth/authentication/presentation/widget/otp_input_widget.dart';

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
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final List<TextEditingController> _controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );

  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  Timer? _timer;

  int _seconds = 120;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();

    setState(() {
      _seconds = 120;
      _canResend = false;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds <= 0) {
        timer.cancel();

        setState(() {
          _canResend = true;
        });
      } else {
        setState(() {
          _seconds--;
        });
      }
    });
  }

  String get timerText {
    final minute = (_seconds ~/ 60).toString().padLeft(2, '0');
    final second = (_seconds % 60).toString().padLeft(2, '0');

    return "$minute:$second";
  }

  @override
  void dispose() {
    _timer?.cancel();

    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final focus in _focusNodes) {
      focus.dispose();
    }
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
                  style: AppTypography.heading2.copyWith(color: Colors.white),
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
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "OTP Code",
                              style: AppTypography.labelMedium,
                            ),
                          ),

                          const SizedBox(height: AppSpacing.md),

                          OtpInput(
                            controllers: _controllers,
                            focusNodes: _focusNodes,
                          ),
                          const SizedBox(height: AppSpacing.md),

                          Text(
                            "Code expires in $timerText",
                            style: AppTypography.bodyMedium.copyWith(
                              color: themeColor,
                            ),
                          ),

                          const SizedBox(height: AppSpacing.sm),

                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: _canResend
                                  ? () {
                                      // TODO: Resend OTP API
                                      _startTimer();
                                    }
                                  : null,
                              child: Text(
                                "Resend OTP",
                                style: AppTypography.labelMedium.copyWith(
                                  color: _canResend
                                      ? themeColor
                                      : AppColors.disabled,
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