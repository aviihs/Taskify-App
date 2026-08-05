import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:taskify_app/core/constants/app_colors.dart';
import 'package:taskify_app/core/constants/app_ui.dart';

class OtpInput extends StatelessWidget {
  const OtpInput({
    super.key,
    required this.controllers,
    required this.focusNodes,
  });

  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        controllers.length,
        (index) => SizedBox(
          width: 46,
          height: 56,
          child: TextField(
            controller: controllers[index],
            focusNode: focusNodes[index],
            maxLength: 1,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            textAlignVertical: TextAlignVertical.center,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              height: 1.0,
            ),
            decoration: InputDecoration(
              counterText: "",
              isCollapsed: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 18),
              filled: true,
              fillColor: AppColors.background,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppUi.borderRadius),
                borderSide: const BorderSide(color: AppColors.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppUi.borderRadius),
                borderSide: const BorderSide(
                  color: AppColors.primary,
                  width: 2,
                ),
              ),
            ),
            onChanged: (value) {
              if (value.isNotEmpty) {
                if (index < controllers.length - 1) {
                  focusNodes[index + 1].requestFocus();
                } else {
                  FocusScope.of(context).unfocus();
                }
              } else if (index > 0) {
                focusNodes[index - 1].requestFocus();
              }
            },
          ),
        ),
      ),
    );
  }
}
