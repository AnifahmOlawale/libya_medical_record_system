import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';

class HealthMetrics extends StatelessWidget {
  const HealthMetrics({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Health Metrics',
          style: AppTextStyles.headlineSmall.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 16),
        _buildMetricCard(
          icon: FontAwesomeIcons.handHoldingHand,
          title: 'Last Blood Donation',
          subtitle: 'June 15, 2023',
          color: Colors.red,
        ),
        const SizedBox(height: 12),
        _buildMetricCard(
          icon: FontAwesomeIcons.pills,
          title: 'Current Medications',
          subtitle: 'None',
          color: Colors.purple,
        ),
        const SizedBox(height: 12),
        _buildMetricCard(
          icon: FontAwesomeIcons.triangleExclamation,
          title: 'Known Allergies',
          subtitle: 'Penicillin',
          color: Colors.amber,
        ),
      ],
    );
  }

  Widget _buildMetricCard({
    required dynamic icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(color: AppColors.divider.withValues(alpha: 0.5)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: icon is IconData
                      ? Icon(icon, color: color, size: 20)
                      : FaIcon(icon, color: color, size: 20),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColors.textDisabled.withValues(alpha: 0.6),
                  size: 14,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
