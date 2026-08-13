import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';

InputDecoration fieldDecoration({
  required String hint,
  dynamic prefixIcon,
  IconData? suffixIcon,
}) {
  return InputDecoration(
    hintText: hint,
    hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.textDisabled),
    filled: true,
    fillColor: Colors.white,
    prefixIcon: prefixIcon == null
        ? null
        : Container(
            width: 50,
            alignment: Alignment.center,
            child: prefixIcon is IconData
                ? Icon(
                    prefixIcon,
                    size: 18,
                    color: AppColors.primary.withValues(alpha: 0.6),
                  )
                : FaIcon(
                    prefixIcon,
                    size: 18,
                    color: AppColors.primary.withValues(alpha: 0.6),
                  ),
          ),
    prefixIconConstraints: const BoxConstraints(minWidth: 50, minHeight: 50),
    suffixIcon: suffixIcon != null
        ? Icon(suffixIcon, size: 18, color: AppColors.textSecondary)
        : null,
  );
}
