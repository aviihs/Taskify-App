import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

enum CrudActionType { view, edit, delete }

/// Reusable compact CRUD action buttons (View, Edit, Delete) for lists and tables.
class CrudButton extends StatelessWidget {
  const CrudButton({
    super.key,
    required this.type,
    required this.onPressed,
    this.size = 36,
    this.tooltip,
  });

  const CrudButton.view({
    super.key,
    required this.onPressed,
    this.size = 36,
    this.tooltip = 'View Details',
  }) : type = CrudActionType.view;

  const CrudButton.edit({
    super.key,
    required this.onPressed,
    this.size = 36,
    this.tooltip = 'Edit Item',
  }) : type = CrudActionType.edit;

  const CrudButton.delete({
    super.key,
    required this.onPressed,
    this.size = 36,
    this.tooltip = 'Delete Item',
  }) : type = CrudActionType.delete;

  final CrudActionType type;
  final VoidCallback onPressed;
  final double size;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color color;
    Color bg;

    switch (type) {
      case CrudActionType.view:
        icon = Icons.visibility_outlined;
        color = AppColors.info;
        bg = AppColors.infoLight;
        break;
      case CrudActionType.edit:
        icon = Icons.edit_outlined;
        color = AppColors.primary;
        bg = AppColors.surfaceVariant;
        break;
      case CrudActionType.delete:
        icon = Icons.delete_outline_rounded;
        color = AppColors.error;
        bg = AppColors.errorLight;
        break;
    }

    final btn = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(icon, size: size * 0.55, color: color),
        onPressed: onPressed,
      ),
    );

    if (tooltip != null) {
      return Tooltip(message: tooltip!, child: btn);
    }
    return btn;
  }
}
