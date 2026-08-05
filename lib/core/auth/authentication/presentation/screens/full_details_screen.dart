import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskify_app/core/auth/authentication/domain/entity/auth_entity.dart';
import 'package:taskify_app/core/auth/authentication/presentation/providers/auth_provider.dart';
import 'package:taskify_app/core/constants/app_colors.dart';
import 'package:taskify_app/core/constants/app_spacing.dart';
import 'package:taskify_app/core/constants/app_typography.dart';
import 'package:taskify_app/core/constants/app_ui.dart';
import 'package:taskify_app/core/widget/buttons/app_button.dart';
import 'package:taskify_app/core/widget/dialog/app_snackbar.dart';
import 'package:taskify_app/core/widget/inputs/app_date_picker.dart';
import 'package:taskify_app/core/widget/inputs/app_dropdown.dart';
import 'package:taskify_app/core/widget/inputs/app_textfield.dart';
import 'package:taskify_app/router/routes/app_routes.dart';

class FullDetailsScreen extends ConsumerStatefulWidget {
  const FullDetailsScreen({super.key});

  @override
  ConsumerState<FullDetailsScreen> createState() => _FullDetailsScreenState();
}

class _FullDetailsScreenState extends ConsumerState<FullDetailsScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _bioController = TextEditingController();

  File? _profileImage;
  DateTime? _selectedDob;
  String? _selectedGender;

  bool _isOnline = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _syncUserDetails(ref.read(authProvider).user);
    });
  }

  String _fullNameFrom(AuthEntity user) {
    return [user.firstName, user.lastName]
        .where((name) => name != null && name.trim().isNotEmpty)
        .map((name) => name!.trim())
        .join(' ');
  }

  void _syncUserDetails(AuthEntity? user) {
    if (user == null || !mounted) return;

    final fullName = _fullNameFrom(user);
    if (fullName.isNotEmpty && _nameController.text != fullName) {
      _nameController.text = fullName;
    }

    if (user.bio != null && _bioController.text.isEmpty) {
      _bioController.text = user.bio!;
    }

    if (user.phone != null && _phoneController.text.isEmpty) {
      _phoneController.text = user.phone.toString();
    }

    if (user.gender != null && _selectedGender == null) {
      setState(() {
        _selectedGender = user.gender;
      });
    }
  }

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
    final authState = ref.watch(authProvider);

    final authEmail = authState.user?.isEmailVerified;

    ref.listen<AuthState>(authProvider, (previous, next) {
      if (previous?.user != next.user) {
        _syncUserDetails(next.user);
      }

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
                            readOnly: true,
                            label: "Full Name",
                          ),
                          const SizedBox(height: AppSpacing.md),
                          AppDatePicker(
                            label: "Date of Birth",
                            hintText: "Select your date of birth",
                            selectedDate: _selectedDob,
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                            onDateSelected: (date) {
                              setState(() {
                                _selectedDob = date;
                              });
                            },
                          ),
                          const SizedBox(height: AppSpacing.md),
                          AppDropdown<String>(
                            label: "Gender",
                            hintText: "Select Gender",
                            value: _selectedGender,
                            prefixIcon: const Icon(Icons.person_outline),
                            items: const [
                              "Male",
                              "Female",
                              "Other",
                              "Prefer not to say",
                            ],
                            onChanged: (value) {
                              setState(() {
                                _selectedGender = value;
                              });
                            },
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
                                Icon(
                                  Icons.verified,
                                  color: (authEmail ?? false) ? AppColors.success : AppColors.error,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        (authEmail ?? false) ? "Email Verified" : "Email Not Verified",
                                        style: AppTypography.labelMedium,
                                      ),
                                      Text(
                                        authEmail ?? false ? "Your email has been verified" : "Your email has not been verified",
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
                            activeThumbColor: themeColor,
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
                            isLoading: authState.isLoading,
                            onPressed: () async {
                              final phoneNum = num.tryParse(
                                _phoneController.text.trim(),
                              );
                              final dobFormatted = _selectedDob
                                  ?.toIso8601String()
                                  .split('T')
                                  .first;

                              final authPayload = AuthEntity(
                                dob: dobFormatted,
                                gender: _selectedGender,
                                bio: _bioController.text.trim(),
                                phone: phoneNum,
                              );

                              final success = await ref
                                  .read(authProvider.notifier)
                                  .updateProfile(authPayload);

                              if (context.mounted) {
                                if (success) {
                                  AppSnackBar.success(
                                    context,
                                    "Profile updated successfully!",
                                  );
                                  context.go(AppRoutes.home);
                                }
                              }
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
