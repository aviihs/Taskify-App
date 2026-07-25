import 'package:flutter/material.dart';

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
  final _emailController = TextEditingController(text: 'jhondoe@gmail.com');
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
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // =================================================================
            // Header Section (Purple background)
            // =================================================================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
                  onPressed: () {
                    if (Navigator.of(context).canPop()) {
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            const Icon(
              Icons.pets_rounded,
              size: 46,
              color: Colors.white,
            ),
            const SizedBox(height: AppSpacing.md),
            const Text(
              'Sign In to your Account',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Enter your email and password to sign in',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.85),
                fontSize: 13,
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
                        helperText: 'Message!',
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: AppSpacing.md),

                      // Password Field
                      AppPasswordField(
                        controller: _passwordController,
                        label: 'Password',
                        hintText: '••••••••',
                        helperText: 'Password must be at least 8 characters',
                        prefixIcon: null,
                      ),
                      const SizedBox(height: AppSpacing.sm),

                      // Remember me & Forgot password Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 22,
                                height: 22,
                                child: Checkbox(
                                  value: _rememberMe,
                                  activeColor: themeColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  side: const BorderSide(
                                    color: AppColors.disabled,
                                    width: 1.5,
                                  ),
                                  onChanged: (val) {
                                    setState(() {
                                      _rememberMe = val ?? false;
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Remember me',
                                style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              'Forgot password?',
                              style: TextStyle(
                                color: themeColor,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                decorationColor: themeColor,
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
                          Navigator.of(context).pushReplacementNamed(AppRoutes.home);
                        },
                      ),
                      const SizedBox(height: AppSpacing.xl),

                      // Divider Row ("Or")
                      Row(
                        children: [
                          const Expanded(
                            child: Divider(color: AppColors.border, thickness: 1),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'Or',
                              style: AppTypography.bodyMedium.copyWith(
                                color: AppColors.textMuted,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          const Expanded(
                            child: Divider(color: AppColors.border, thickness: 1),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.lg),

                      // Social Login Icons Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Google Button
                          _buildSocialButton(
                            onTap: () {},
                            child: const _GoogleGIcon(),
                          ),
                          const SizedBox(width: 20),

                          // Facebook Button
                          _buildSocialButton(
                            onTap: () {},
                            backgroundColor: AppColors.facebookBlue,
                            child: const Icon(
                              Icons.facebook_rounded,
                              color: Colors.white,
                              size: 26,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xxl),

                      // Don't have an account? Sign up
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account? ",
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 13,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(AppRoutes.register);
                            },
                            child: Text(
                              'Sign up',
                              style: TextStyle(
                                color: themeColor,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
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
    );
  }

  Widget _buildSocialButton({
    required VoidCallback onTap,
    required Widget child,
    Color? backgroundColor,
  }) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        shape: BoxShape.circle,
        border: backgroundColor == null
            ? Border.all(color: AppColors.border, width: 1)
            : null,
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Center(child: child),
      ),
    );
  }
}

/// Custom Google 'G' multicolored icon widget.
class _GoogleGIcon extends StatelessWidget {
  const _GoogleGIcon();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(22, 22),
      painter: _GoogleLogoPainter(),
    );
  }
}

class _GoogleLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    final double stroke = w * 0.22;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.butt;

    final rect = Rect.fromLTWH(
      stroke / 2,
      stroke / 2,
      w - stroke,
      h - stroke,
    );

    // Blue section
    paint.color = AppColors.googleBlue;
    canvas.drawArc(rect, -0.4, 2.0, false, paint);

    // Green section
    paint.color = AppColors.googleGreen;
    canvas.drawArc(rect, 1.6, 1.4, false, paint);

    // Yellow section
    paint.color = AppColors.googleYellow;
    canvas.drawArc(rect, 3.0, 0.8, false, paint);

    // Red section
    paint.color = AppColors.googleRed;
    canvas.drawArc(rect, 3.8, 1.6, false, paint);

    // Center bar for G
    final barPaint = Paint()
      ..color = AppColors.googleBlue
      ..style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromLTWH(w * 0.45, h * 0.38, w * 0.48, h * 0.24),
      barPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
