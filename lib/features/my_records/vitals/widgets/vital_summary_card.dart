import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:libya_medical_record_system/core/constants/vital_constants.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';

class VitalSummaryCard extends StatelessWidget {
  final String label;
  final String value;
  final String type;
  final dynamic icon;
  final Color color;
  final String? status;
  final Color? statusColor;

  const VitalSummaryCard({
    super.key,
    required this.label,
    required this.value,
    required this.type,
    required this.icon,
    required this.color,
    this.status,
    this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: icon is IconData
                    ? Icon(icon, color: color, size: 14)
                    : FaIcon(icon, color: color, size: 14),
              ),
              Text(
                VitalConstants.getUnit(type),
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 10,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            value,
            style: AppTextStyles.headlineSmall.copyWith(
              fontWeight: FontWeight.w900,
              fontSize: 18,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (status != null)
                Text(
                  status!,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: statusColor ?? AppColors.textSecondary,
                    fontWeight: FontWeight.w800,
                    fontSize: 8,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
