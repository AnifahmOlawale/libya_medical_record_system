import 'package:flutter/material.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';

class CustomFilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final ValueChanged<bool> onSelected;

  const CustomFilterChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      backgroundColor: AppColors.primary.withValues(alpha: 0.15),
      showCheckmark: true,
      checkmarkColor: Colors.white,
      selectedColor: AppColors.primary,
      labelStyle: AppTextStyles.labelSmall.copyWith(
        color: selected ? Colors.white : AppColors.primary,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onSelected: onSelected,
    );
  }
}
