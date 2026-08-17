import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:libya_medical_record_system/core/router/app_router.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';
import 'package:libya_medical_record_system/core/shared/widgets/snack_bar.dart';

import 'package:libya_medical_record_system/core/shared/widgets/sliver_page_header.dart';

/// Data for a single record-category card.
class _RecordCardData {
  const _RecordCardData({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.route,
  });

  final dynamic icon;
  final String title;
  final String subtitle;
  final String? route;
}

// Order matches the confirmed records list. Kept as a top-level const
// so it's easy to reorder or edit without touching build logic.
final _records = [
  _RecordCardData(
    icon: FontAwesomeIcons.idCardClip,
    title: 'Medical Information',
    subtitle: 'General medical details',
    route: AppRoutes.medicalInfo,
  ),
  _RecordCardData(
    icon: FontAwesomeIcons.heartPulse,
    title: 'Vitals',
    subtitle: 'Blood pressure, temperature, pulse, weight over time',
    route: AppRoutes.vitals,
  ),
  _RecordCardData(
    icon: FontAwesomeIcons.triangleExclamation,
    title: 'Allergy',
    subtitle: 'Known allergies and reactions',
    route: AppRoutes.allergies,
  ),
  _RecordCardData(
    icon: FontAwesomeIcons.pills,
    title: 'Medications',
    subtitle: 'Current and past medications',
    route: AppRoutes.medications,
  ),
  _RecordCardData(
    icon: FontAwesomeIcons.tooth,
    title: 'Dental Records',
    subtitle: 'Dental history and procedures',
    route: AppRoutes.dentalRecords,
  ),
  _RecordCardData(
    icon: FontAwesomeIcons.stethoscope,
    title: 'Diagnoses',
    subtitle: 'Medical diagnoses history',
    route: AppRoutes.diagnoses,
  ),
  _RecordCardData(
    icon: FontAwesomeIcons.userDoctor,
    title: 'Medical Visits',
    subtitle: 'Doctor visits and appointments',
    route: AppRoutes.medicalVisits,
  ),
  _RecordCardData(
    icon: FontAwesomeIcons.flask,
    title: 'Lab Test',
    subtitle: 'Laboratory test results',
    route: AppRoutes.labTests,
  ),
  _RecordCardData(
    icon: FontAwesomeIcons.xRay,
    title: 'Radiology',
    subtitle: 'X-rays, CT scans, MRI reports',
    route: AppRoutes.radiology,
  ),
  _RecordCardData(
    icon: FontAwesomeIcons.microscope,
    title: 'Pathology',
    subtitle: 'Pathology test reports',
    route: AppRoutes.pathology,
  ),
  _RecordCardData(
    icon: FontAwesomeIcons.kitMedical,
    title: 'Surgeries',
    subtitle: 'Surgical procedures history',
    route: AppRoutes.surgeries,
  ),
  _RecordCardData(
    icon: FontAwesomeIcons.syringe,
    title: 'Immunizations',
    subtitle: 'Vaccination records',
    route: AppRoutes.immunizations,
  ),
  _RecordCardData(
    icon: FontAwesomeIcons.fileShield,
    title: 'Documents',
    subtitle: 'Medical reports and certificates',
    route: AppRoutes.documents,
  ),
];

class RecordsPage extends StatelessWidget {
  const RecordsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const SliverPageHeader(
            title: 'Medical Records',
            icon: FontAwesomeIcons.fileMedical,
            showBackButton: true,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
              child: Text(
                'All your health information in one place',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _RecordCard(data: _records[index]),
                ),
                childCount: _records.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}

class _RecordCard extends StatelessWidget {
  const _RecordCard({required this.data});

  final _RecordCardData data;

  @override
  Widget build(BuildContext context) {
    // Allergy is flagged in error color for clinical safety
    final accentColor = data.title == 'Allergy'
        ? AppColors.error
        : AppColors.primary;

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
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (data.route != null) {
              context.push(data.route!);
            } else {
              snackBar(context: context, message: 'Coming soon');
            }
          },
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: data.icon is IconData
                      ? Icon(data.icon, color: accentColor, size: 22)
                      : FaIcon(data.icon, color: accentColor, size: 22),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.title,
                        style: AppTextStyles.titleMedium.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        data.subtitle,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColors.textDisabled.withValues(alpha: 0.6),
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
