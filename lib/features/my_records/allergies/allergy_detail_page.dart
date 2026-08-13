import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';
import 'package:libya_medical_record_system/data/models/allergy_model.dart';

import 'package:libya_medical_record_system/core/shared/widgets/sliver_page_header.dart';

class AllergyDetailPage extends StatelessWidget {
  const AllergyDetailPage({super.key, required this.allergy});

  final AllergyModel allergy;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPageHeader(
            title: allergy.allergen,
            icon: FontAwesomeIcons.triangleExclamation,
            expandedHeight: 240,
            actions: [
              IconButton(
                icon: Icon(
                  Icons.edit_outlined,
                  color: kIsWeb ? AppColors.primary : Colors.white,
                ),
                onPressed: () {
                  // TODO: Navigate to edit page
                },
              ),
            ],
            extra: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: kIsWeb
                      ? AppColors.success
                      : Colors.white.withValues(alpha: 0.3),
                ),
              ),
              child: Text(
                'ACTIVE RECORD',
                style: AppTextStyles.labelSmall.copyWith(
                  color: kIsWeb ? AppColors.success : Colors.white,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildReactionSection(),
                  const SizedBox(height: 24),
                  _buildHistorySection(),
                  const SizedBox(height: 24),
                  if (allergy.notes != null && allergy.notes!.isNotEmpty) ...[
                    _buildNotesSection(),
                    const SizedBox(height: 24),
                  ],
                  _buildClinicalAuditSection(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReactionSection() {
    return _buildDetailCard(
      title: 'Reaction Details',
      icon: FontAwesomeIcons.bolt,
      iconColor: AppColors.accent,
      child: Text(
        allergy.reaction,
        style: AppTextStyles.bodyLarge.copyWith(
          color: AppColors.textPrimary,
          height: 1.6,
        ),
      ),
    );
  }

  Widget _buildHistorySection() {
    return _buildDetailCard(
      title: 'History',
      icon: FontAwesomeIcons.calendarCheck,
      iconColor: AppColors.primary,
      child: Column(
        children: [
          _buildInfoRow(
            'Discovery Date',
            allergy.onsetDate != null
                ? _formatDate(allergy.onsetDate!)
                : 'Not Specified',
            FontAwesomeIcons.calendarDay,
          ),
          const Divider(height: 24),
          _buildInfoRow(
            'Last Updated',
            _formatDate(allergy.lastUpdated),
            FontAwesomeIcons.clockRotateLeft,
          ),
        ],
      ),
    );
  }

  Widget _buildNotesSection() {
    return _buildDetailCard(
      title: 'Clinical Notes',
      icon: FontAwesomeIcons.fileMedical,
      iconColor: Colors.blue,
      child: Text(
        allergy.notes!,
        style: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textSecondary,
          height: 1.6,
        ),
      ),
    );
  }

  Widget _buildClinicalAuditSection() {
    return _buildDetailCard(
      title: 'Verification',
      icon: FontAwesomeIcons.userShield,
      iconColor: AppColors.primaryDark,
      child: _buildInfoRow(
        'Added By',
        allergy.addedBy ?? 'Patient (Self-Reported)',
        FontAwesomeIcons.userDoctor,
      ),
    );
  }

  Widget _buildDetailCard({
    required String title,
    required dynamic icon,
    required Color iconColor,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: icon is IconData
                    ? Icon(icon, color: iconColor, size: 16)
                    : FaIcon(icon, color: iconColor, size: 16),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: AppTextStyles.titleMedium.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, dynamic icon) {
    return Row(
      children: [
        icon is IconData
            ? Icon(
                icon,
                size: 14,
                color: AppColors.textSecondary.withValues(alpha: 0.5),
              )
            : FaIcon(
                icon,
                size: 14,
                color: AppColors.textSecondary.withValues(alpha: 0.5),
              ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            Text(
              value,
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat("dd, MMM yyyy").format(date);
  }
}
