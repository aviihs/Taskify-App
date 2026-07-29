import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import 'package:taskify_app/core/constants/app_colors.dart';
import 'package:taskify_app/core/constants/app_spacing.dart';
import 'package:taskify_app/core/constants/app_typography.dart';
import 'package:taskify_app/core/constants/app_ui.dart';
import 'package:taskify_app/core/widget/app_components.dart';
import 'package:taskify_app/router/routes/app_routes.dart';

class FullDetailsScreen extends StatefulWidget {
  const FullDetailsScreen({super.key});

  @override
  State<FullDetailsScreen> createState() => _FullDetailsScreenState();
}

class _FullDetailsScreenState extends State<FullDetailsScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _bioController = TextEditingController();

  File? _profileImage;

  bool _isOnline = true;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _bioController.dispose();

    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();

    final image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
    }
  }

  Widget _avatar() {
    return GestureDetector(
      onTap: _pickImage,

      child: Stack(
        children: [
          CircleAvatar(
            radius: 55,

            backgroundColor: AppColors.primary.withValues(alpha: .15),

            backgroundImage: _profileImage != null
                ? FileImage(_profileImage!)
                : null,

            child: _profileImage == null
                ? const Icon(Icons.person, size: 55, color: AppColors.primary)
                : null,
          ),

          Positioned(
            right: 0,
            bottom: 0,

            child: Container(
              padding: const EdgeInsets.all(8),

              decoration: BoxDecoration(
                color: AppColors.primary,

                shape: BoxShape.circle,

                border: Border.all(color: Colors.white, width: 3),
              ),

              child: const Icon(
                Icons.camera_alt_outlined,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
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
                const SizedBox(height: AppSpacing.xxl),

                const Icon(
                  Icons.account_circle_outlined,

                  size: 46,

                  color: Colors.white,
                ),

                const SizedBox(height: AppSpacing.md),

                Text(
                  "Complete Profile",

                  style: AppTypography.heading2.copyWith(color: Colors.white),
                ),

                const SizedBox(height: 6),

                Text(
                  "Add your details to continue",

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
                          _avatar(),

                          const SizedBox(height: AppSpacing.md),

                          Text(
                            "Upload Profile Photo",

                            style: AppTypography.labelMedium.copyWith(
                              color: themeColor,
                            ),
                          ),

                          const SizedBox(height: AppSpacing.xl),

                          AppTextField(
                            controller: _nameController,

                            label: "Full Name",

                            hintText: "Shiva Bhusal",
                          ),

                          const SizedBox(height: AppSpacing.md),

                          AppTextField(
                            controller: _phoneController,

                            label: "Phone Number",

                            hintText: "+977 98XXXXXXXX",

                            keyboardType: TextInputType.phone,
                          ),

                          const SizedBox(height: AppSpacing.md),

                          AppTextField(
                            controller: _bioController,

                            label: "Bio",

                            hintText: "Tell something about yourself",

                            maxLines: 3,
                          ),

                          const SizedBox(height: AppSpacing.md),

                          Container(
                            padding: const EdgeInsets.all(16),

                            decoration: BoxDecoration(
                              color: AppColors.background,

                              borderRadius: BorderRadius.circular(
                                AppUi.borderRadius,
                              ),

                              border: Border.all(color: AppColors.border),
                            ),

                            child: Row(
                              children: [
                                const Icon(
                                  Icons.verified,
                                  color: AppColors.success,
                                ),

                                const SizedBox(width: 12),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,

                                    children: [
                                      Text(
                                        "Email Verified",

                                        style: AppTypography.labelMedium,
                                      ),

                                      Text(
                                        "Your email has been verified",

                                        style: AppTypography.bodyMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: AppSpacing.md),

                          SwitchListTile(
                            contentPadding: EdgeInsets.zero,

                            title: const Text("Set yourself online"),

                            subtitle: const Text(
                              "Others can see your availability",
                            ),

                            value: _isOnline,

                            activeColor: themeColor,

                            onChanged: (value) {
                              setState(() {
                                _isOnline = value;
                              });
                            },
                          ),

                          const SizedBox(height: AppSpacing.xl),

                          AppButton(
                            text: "Continue",

                            backgroundColor: themeColor,

                            height: 52,

                            borderRadius: 14,

                            onPressed: () {
                              // save profile

                              context.go(AppRoutes.home);
                            },
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
