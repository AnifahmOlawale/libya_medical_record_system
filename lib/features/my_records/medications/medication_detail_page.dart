import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:libya_medical_record_system/core/router/app_router.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';
import 'package:libya_medical_record_system/data/models/medication_model.dart';

import 'package:libya_medical_record_system/core/shared/widgets/sliver_page_header.dart';

class MedicationDetailPage extends StatelessWidget {
  const MedicationDetailPage({super.key, required this.medication});

  final MedicationModel? medication;

  @override
  Widget build(BuildContext context) {
    final med = medication;
    if (med == null) {
      return const Scaffold(
        body: Center(child: Text('Medication data not found')),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPageHeader(
            title: med.medicationName,
            icon: FontAwesomeIcons.pills,
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
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: kIsWeb ? AppColors.primary.withValues(alpha: 0.1) : Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: kIsWeb ? AppColors.primary : Colors.white.withValues(alpha: 0.3),
                ),
              ),
              child: Text(
                med.strength,
                style: AppTextStyles.labelSmall.copyWith(
                  color: kIsWeb ? AppColors.primary : Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildMedicationInfoSection(med),
                const SizedBox(height: 24),
                _buildScheduleSection(med),
                const SizedBox(height: 24),
                _buildAlarmReminderSection(context, med),
                const SizedBox(height: 24),
                if (med.instructions.isNotEmpty) ...[
                  _buildInstructionsSection(med),
                  const SizedBox(height: 24),
                ],
                _buildClinicalAuditSection(med),
                const SizedBox(height: 40),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicationInfoSection(MedicationModel med) {
    return _buildDetailCard(
      title: 'Medication Info',
      icon: FontAwesomeIcons.capsules,
      iconColor: AppColors.primary,
      child: Column(
        children: [
          _buildInfoRow('Form', med.form, FontAwesomeIcons.tablets),
          const Divider(height: 24),
          _buildInfoRow(
            'Intake Method',
            med.intakeMethod,
            FontAwesomeIcons.syringe,
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleSection(MedicationModel med) {
    return _buildDetailCard(
      title: 'Dosage & Schedule',
      icon: FontAwesomeIcons.clock,
      iconColor: AppColors.accent,
      child: Column(
        children: [
          _buildInfoRow('Dosage', med.dosage, FontAwesomeIcons.scaleBalanced),
          const Divider(height: 24),
          _buildInfoRow('Frequency', med.frequency, FontAwesomeIcons.repeat),
          const Divider(height: 24),
          _buildInfoRow(
            'Duration',
            '${med.duration} Days',
            FontAwesomeIcons.hourglassHalf,
          ),
        ],
      ),
    );
  }

  Widget _buildAlarmReminderSection(BuildContext context, MedicationModel med) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withValues(alpha: 0.8),
            AppColors.primaryDark,
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: const FaIcon(
              FontAwesomeIcons.bell,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Set Reminder',
                  style: AppTextStyles.titleMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Never miss a dose',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Using a simple Material button for maximum layout stability
          Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              onTap: () =>
                  context.push(AppRoutes.addMedicationReminder, extra: med),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                child: Text(
                  'Set Alarm',
                  style: AppTextStyles.labelLarge.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionsSection(MedicationModel med) {
    return _buildDetailCard(
      title: 'Instructions',
      icon: FontAwesomeIcons.circleInfo,
      iconColor: Colors.blue,
      child: Text(
        med.instructions,
        style: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textPrimary,
          height: 1.6,
        ),
      ),
    );
  }

  Widget _buildClinicalAuditSection(MedicationModel med) {
    return _buildDetailCard(
      title: 'Prescribing Info',
      icon: FontAwesomeIcons.userShield,
      iconColor: AppColors.primaryDark,
      child: Column(
        children: [
          _buildInfoRow(
            'Prescribed By',
            med.addedBy ?? 'Patient',
            FontAwesomeIcons.userDoctor,
          ),
          const Divider(height: 24),
          _buildInfoRow(
            'Last Updated',
            _formatDate(med.lastUpdated),
            FontAwesomeIcons.clockRotateLeft,
          ),
        ],
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
        Container(
          width: 20,
          alignment: Alignment.center,
          child: icon is IconData
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
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
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
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat("dd, MMM yyyy").format(date);
  }
}
