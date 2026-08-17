import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:libya_medical_record_system/core/router/app_router.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';
import 'package:libya_medical_record_system/core/shared/widgets/empty_state_widget.dart';
import 'package:libya_medical_record_system/core/shared/widgets/sliver_page_header.dart';
import 'package:libya_medical_record_system/data/models/demo_data.dart';
import 'package:libya_medical_record_system/data/models/diagnosis_model.dart';
import 'package:libya_medical_record_system/data/models/user_registration_model.dart';

class DiagnosesPage extends StatelessWidget {
  const DiagnosesPage({super.key, this.patient});

  final UserRegistrationModel? patient;

  @override
  Widget build(BuildContext context) {
    final diagnoses = patient != null ? patient!.diagnoses : DemoData.diagnoses();
    final bool isPatientView = patient != null;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPageHeader(
            title: isPatientView ? '${patient!.personalInfo!.fullNameEnglish}\'s Diagnoses' : 'Diagnoses History',
            icon: FontAwesomeIcons.lungsVirus,
            showBackButton: isPatientView,
          ),
          if (diagnoses.isEmpty)
            const EmptyStateSliver(
              icon: FontAwesomeIcons.clipboardCheck,
              title: 'No Diagnoses Recorded',
              subtitle: 'Medical diagnoses history will appear here.',
            )
          else
            _buildDiagnosesList(diagnoses, isPatientView),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppRoutes.addDiagnosis, extra: patient),
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add_rounded, color: Colors.white),
        label: Text(
          'Add Diagnosis',
          style: AppTextStyles.labelLarge.copyWith(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildDiagnosesList(List<DiagnosisModel> diagnoses, bool isPatientView) {
    return SliverPadding(
      padding: const EdgeInsets.all(20),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final diagnosis = diagnoses[index];
          return _buildDiagnosisCard(context, diagnosis, isPatientView);
        }, childCount: diagnoses.length),
      ),
    );
  }

  Widget _buildDiagnosisCard(BuildContext context, DiagnosisModel diagnosis, bool isPatientView) {
    Color statusColor;
    String statusLabel;

    switch (diagnosis.status) {
      case DiagnosisStatus.active:
        statusColor = AppColors.success;
        statusLabel = 'Active';
        break;
      case DiagnosisStatus.chronic:
        statusColor = AppColors.accent;
        statusLabel = 'Chronic';
        break;
      case DiagnosisStatus.resolved:
        statusColor = AppColors.info;
        statusLabel = 'Resolved';
        break;
    }

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
        onTap: () => context.push(AppRoutes.diagnosisDetail, extra: diagnosis),
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
                  color: statusColor.withValues(alpha: 0.1),
                  border: Border(
                    left: BorderSide(color: statusColor, width: 4),
                  ),
                ),
                child: Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.clipboardList,
                      color: statusColor,
                      size: 16,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        diagnosis.conditionName,
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
                        color: statusColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        statusLabel,
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
                            'Diagnosis Date',
                            _formatDate(diagnosis.diagnosisDate),
                            icon: FontAwesomeIcons.calendarDay,
                          ),
                        ),
                        if (diagnosis.diagnosisDocumentPaths.isNotEmpty)
                          Expanded(
                            child: _buildDetailRow(
                              'Documents',
                              '${diagnosis.diagnosisDocumentPaths.length} Report(s)',
                              icon: FontAwesomeIcons.filePdf,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildDetailRow(
                      'Diagnosed By',
                      diagnosis.diagnosedBy,
                      icon: FontAwesomeIcons.userDoctor,
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
                      'Last Updated: ${_formatDate(diagnosis.lastUpdated)}',
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
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
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

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
