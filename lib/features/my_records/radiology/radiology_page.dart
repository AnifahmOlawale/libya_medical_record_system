import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:libya_medical_record_system/core/router/app_router.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';
import 'package:libya_medical_record_system/core/shared/widgets/empty_state_widget.dart';
import 'package:libya_medical_record_system/core/shared/widgets/sliver_page_header.dart';
import 'package:libya_medical_record_system/data/models/demo_data.dart';
import 'package:libya_medical_record_system/data/models/radiology_model.dart';
import 'package:libya_medical_record_system/core/constants/radiology_constants.dart';
import 'package:libya_medical_record_system/data/models/user_registration_model.dart';

class RadiologyPage extends StatelessWidget {
  const RadiologyPage({super.key, this.patient});

  final UserRegistrationModel? patient;

  @override
  Widget build(BuildContext context) {
    final reports = patient != null ? patient!.radiologyReports : DemoData.radiologyReports();
    final bool isPatientView = patient != null;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPageHeader(
            title: isPatientView ? '${patient!.personalInfo!.fullNameEnglish}\'s Imaging' : 'Radiology Reports',
            icon: FontAwesomeIcons.xRay,
            showBackButton: isPatientView,
          ),
          if (reports.isEmpty)
            const EmptyStateSliver(
              icon: FontAwesomeIcons.image,
              title: 'No Reports Found',
              subtitle: 'Imaging reports and scans will appear here.',
            )
          else
            _buildReportsList(reports, isPatientView),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppRoutes.addRadiology, extra: patient),
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add_rounded, color: Colors.white),
        label: Text(
          'Add Radiology',
          style: AppTextStyles.labelLarge.copyWith(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildReportsList(List<RadiologyModel> reports, bool isPatientView) {
    return SliverPadding(
      padding: const EdgeInsets.all(20),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final report = reports[index];
          return _buildReportCard(context, report, isPatientView);
        }, childCount: reports.length),
      ),
    );
  }

  Widget _buildReportCard(BuildContext context, RadiologyModel report, bool isPatientView) {
    final modalityLabel =
        report.modality == RadiologyModality.other &&
            report.customModality != null
        ? report.customModality!
        : (RadiologyConstants.modalityLabels[report.modality] ?? 'Imaging');

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
      child: InkWell(
        onTap: () => context.push(AppRoutes.radiologyDetail, extra: report),
        borderRadius: BorderRadius.circular(20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primarySurface.withValues(alpha: 0.3),
                  border: Border(
                    left: BorderSide(color: AppColors.primary, width: 4),
                  ),
                ),
                child: Row(
                  children: [
                    FaIcon(
                      _getModalityIcon(report.modality),
                      color: AppColors.primary,
                      size: 16,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        report.studyName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.titleMedium.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        modalityLabel,
                        style: AppTextStyles.labelSmall.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _buildDetailRow(
                            'Study Date',
                            _formatDate(report.studyDate),
                            icon: FontAwesomeIcons.calendarDay,
                          ),
                        ),
                        Expanded(
                          child: _buildDetailRow(
                            'Region',
                            report.bodyPart,
                            icon: FontAwesomeIcons.personWalking,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildDetailRow(
                      'Institution',
                      report.institutionName,
                      icon: FontAwesomeIcons.hospital,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'IMPRESSION',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      report.impression,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textPrimary,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Added by: ${report.addedBy ?? 'N/A'}',
                      style: AppTextStyles.bodySmall.copyWith(
                        fontSize: 10,
                        color: AppColors.textDisabled,
                      ),
                    ),
                    if (!isPatientView)
                      Row(
                        children: [
                          _buildActionCircle(Icons.edit_rounded, () {}),
                          const SizedBox(width: 8),
                          _buildActionCircle(
                            Icons.delete_outline_rounded,
                            () {},
                            isDelete: true,
                          ),
                        ],
                      )
                    else
                      const Icon(Icons.arrow_forward_ios_rounded, size: 12, color: AppColors.textDisabled),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {required dynamic icon}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(10),
          ),
          child: icon is IconData
              ? Icon(icon, color: AppColors.textSecondary, size: 14)
              : FaIcon(icon, color: AppColors.textSecondary, size: 14),
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
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionCircle(
    dynamic icon,
    VoidCallback onTap, {
    bool isDelete = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: isDelete
              ? AppColors.error.withValues(alpha: 0.1)
              : Colors.grey.shade100,
          shape: BoxShape.circle,
        ),
        child: icon is IconData
            ? Icon(
                icon,
                size: 16,
                color: isDelete ? AppColors.error : AppColors.textSecondary,
              )
            : FaIcon(
                icon,
                size: 16,
                color: isDelete ? AppColors.error : AppColors.textSecondary,
              ),
      ),
    );
  }

  dynamic _getModalityIcon(RadiologyModality modality) {
    switch (modality) {
      case RadiologyModality.xRay:
        return FontAwesomeIcons.bone;
      case RadiologyModality.ctScan:
        return FontAwesomeIcons.circleNotch;
      case RadiologyModality.mri:
        return FontAwesomeIcons.magnet;
      case RadiologyModality.ultrasound:
        return FontAwesomeIcons.waveSquare;
      default:
        return FontAwesomeIcons.stethoscope;
    }
  }

  String _formatDate(DateTime date) {
    return DateFormat("dd MMM, yyyy").format(date);
  }
}
