import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
  });

  final dynamic icon;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.textDisabled.withValues(alpha: 0.05),
                shape: BoxShape.circle,
              ),
              child: icon is IconData
                  ? Icon(
                      icon,
                      size: 60,
                      color: AppColors.textDisabled.withValues(alpha: 0.5),
                    )
                  : FaIcon(
                      icon,
                      size: 60,
                      color: AppColors.textDisabled.withValues(alpha: 0.5),
                    ),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.titleMedium.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w700,
              ),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 8),
              Text(
                subtitle!,
                textAlign: TextAlign.center,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textDisabled,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class EmptyStateSliver extends StatelessWidget {
  const EmptyStateSliver({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
  });

  final dynamic icon;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: EmptyStateWidget(
        icon: icon,
        title: title,
        subtitle: subtitle,
      ),
    );
  }
}
