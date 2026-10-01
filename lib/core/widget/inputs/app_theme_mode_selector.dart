import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskify_app/core/constants/app_spacing.dart';
import 'package:taskify_app/core/constants/app_ui.dart';
import 'package:taskify_app/core/design_system/theme/app_palette.dart';
import 'package:taskify_app/core/design_system/theme/theme_mode_provider.dart';

/// Appearance picker (Light / Dark / System) bound to [themeModeProvider].
/// The choice is persisted and applied app-wide immediately.
class AppThemeModeSelector extends ConsumerWidget {
  const AppThemeModeSelector({super.key, this.margin});

  final EdgeInsetsGeometry? margin;

  static const List<_ThemeOption> _options = [
    _ThemeOption(ThemeMode.light, 'Light', Icons.light_mode_rounded),
    _ThemeOption(ThemeMode.dark, 'Dark', Icons.dark_mode_rounded),
    _ThemeOption(ThemeMode.system, 'System', Icons.brightness_auto_rounded),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(themeModeProvider);
    final notifier = ref.read(themeModeProvider.notifier);

    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Appearance',
            style: context.typography.bodyLarge.copyWith(
              fontWeight: FontWeight.w500,
              color: context.colors.textPrimary,
            ),
          ),
          const SizedBox(height: AppUi.paddingXS),
          Text(_subtitleFor(selected), style: context.typography.bodyMedium),
          const SizedBox(height: AppSpacing.sm),
          Container(
            padding: const EdgeInsets.all(AppUi.paddingXS),
            decoration: BoxDecoration(
              color: context.colors.background,
              borderRadius: BorderRadius.circular(AppUi.borderRadius),
              border: Border.all(color: context.colors.border),
            ),
            child: Row(
              children: [
                for (final option in _options)
                  Expanded(
                    child: _ThemeOptionTile(
                      option: option,
                      isSelected: option.mode == selected,
                      onTap: () => notifier.setThemeMode(option.mode),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static String _subtitleFor(ThemeMode mode) => switch (mode) {
    ThemeMode.light => 'Always use the light theme',
    ThemeMode.dark => 'Always use the dark theme',
    ThemeMode.system => 'Match your device settings',
  };
}

class _ThemeOption {
  const _ThemeOption(this.mode, this.label, this.icon);

  final ThemeMode mode;
  final String label;
  final IconData icon;
}

class _ThemeOptionTile extends StatelessWidget {
  const _ThemeOptionTile({
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  final _ThemeOption option;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final fg = isSelected ? colors.primary : colors.textMuted;
    final radius = BorderRadius.circular(AppUi.radiusSM);

    return Semantics(
      button: true,
      selected: isSelected,
      label: '${option.label} theme',
      child: AnimatedContainer(
        duration: AppUi.fastAnimation,
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: isSelected ? colors.surface : Colors.transparent,
          borderRadius: radius,
          border: Border.all(
            color: isSelected
                ? colors.primary.withValues(alpha: 0.35)
                : Colors.transparent,
          ),
          boxShadow: isSelected ? [AppUi.softShadow] : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: radius,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(option.icon, size: AppUi.iconSM, color: fg),
                  const SizedBox(height: AppUi.paddingXS),
                  Text(
                    option.label,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w500,
                      color: isSelected ? colors.textPrimary : fg,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
