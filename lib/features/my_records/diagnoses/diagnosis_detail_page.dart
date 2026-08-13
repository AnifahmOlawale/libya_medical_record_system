import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';
import 'package:libya_medical_record_system/data/models/diagnosis_model.dart';

import 'package:libya_medical_record_system/core/shared/widgets/sliver_page_header.dart';

class DiagnosisDetailPage extends StatelessWidget {
  const DiagnosisDetailPage({super.key, required this.diagnosis});

  final DiagnosisModel diagnosis;

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    String statusLabel;

    switch (diagnosis.status) {
      case DiagnosisStatus.active:
        statusColor = AppColors.success;
        statusLabel = 'ACTIVE';
        break;
      case DiagnosisStatus.chronic:
        statusColor = AppColors.accent;
        statusLabel = 'CHRONIC';
        break;
      case DiagnosisStatus.resolved:
        statusColor = AppColors.info;
        statusLabel = 'RESOLVED';
        break;
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPageHeader(
            title: diagnosis.conditionName,
            icon: FontAwesomeIcons.clipboardList,
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
                color: statusColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: kIsWeb
                      ? statusColor
                      : Colors.white.withValues(alpha: 0.3),
                ),
              ),
              child: Text(
                statusLabel,
                style: AppTextStyles.labelSmall.copyWith(
                  color: kIsWeb ? statusColor : Colors.white,
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
                  _buildSymptomsSection(),
                  const SizedBox(height: 24),
                  _buildTreatmentSection(),
                  const SizedBox(height: 24),
                  _buildHistorySection(),
                  const SizedBox(height: 24),
                  if (diagnosis.diagnosisDocumentPaths.isNotEmpty) ...[
                    _buildDocumentsSection(),
                    const SizedBox(height: 24),
                  ],
                  if (diagnosis.notes != null &&
                      diagnosis.notes!.isNotEmpty) ...[
                    _buildNotesSection(),
                    const SizedBox(height: 24),
                  ],
                  if (diagnosis.cost != null) ...[
                    _buildCostSection(),
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

  Widget _buildSymptomsSection() {
    return _buildDetailCard(
      title: 'Symptoms',
      icon: FontAwesomeIcons.notesMedical,
      iconColor: Colors.orange,
      child: Text(
        diagnosis.symptoms ?? 'No specific symptoms recorded.',
        style: AppTextStyles.bodyLarge.copyWith(
          color: AppColors.textPrimary,
          height: 1.6,
        ),
      ),
    );
  }

  Widget _buildTreatmentSection() {
    return _buildDetailCard(
      title: 'Treatment Plan',
      icon: FontAwesomeIcons.handHoldingMedical,
      iconColor: AppColors.primary,
      child: Text(
        diagnosis.treatmentPlan ?? 'No treatment plan specified.',
        style: AppTextStyles.bodyLarge.copyWith(
          color: AppColors.textPrimary,
          height: 1.6,
        ),
      ),
    );
  }

  Widget _buildHistorySection() {
    return _buildDetailCard(
      title: 'Clinical History',
      icon: FontAwesomeIcons.calendarCheck,
      iconColor: Colors.blue,
      child: Column(
        children: [
          _buildInfoRow(
            'Diagnosis Date',
            _formatDate(diagnosis.diagnosisDate),
            FontAwesomeIcons.calendarDay,
          ),
          const Divider(height: 24),
          _buildInfoRow(
            'Diagnosed By',
            diagnosis.diagnosedBy,
            FontAwesomeIcons.userDoctor,
          ),
          const Divider(height: 24),
          _buildInfoRow(
            'Severity',
            diagnosis.severity.name.toUpperCase(),
            FontAwesomeIcons.circleExclamation,
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentsSection() {
    return _buildDetailCard(
      title: 'Medical Documents',
      icon: FontAwesomeIcons.fileLines,
      iconColor: Colors.red.shade400,
      child: Column(
        children: diagnosis.diagnosisDocumentPaths.map((path) {
          final fileName = path.split('/').last;
          final isImage =
              path.toLowerCase().endsWith('.jpg') ||
              path.toLowerCase().endsWith('.jpeg') ||
              path.toLowerCase().endsWith('.png');

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: InkWell(
              onTap: () {
                // TODO: Open document
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isImage
                      ? AppColors.accent.withValues(alpha: 0.05)
                      : AppColors.primary.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isImage
                        ? AppColors.accent.withValues(alpha: 0.1)
                        : AppColors.primary.withValues(alpha: 0.1),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isImage ? AppColors.accent : AppColors.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: FaIcon(
                        isImage
                            ? FontAwesomeIcons.fileImage
                            : FontAwesomeIcons.filePdf,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            fileName,
                            style: AppTextStyles.bodyMedium.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            isImage ? 'Image File' : 'PDF Document',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.textSecondary.withValues(
                                alpha: 0.6,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.download_rounded,
                        color: AppColors.primary,
                        size: 20,
                      ),
                      onPressed: () {
                        // TODO: Implement download
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildNotesSection() {
    return _buildDetailCard(
      title: 'Additional Notes',
      icon: FontAwesomeIcons.filePen,
      iconColor: Colors.teal,
      child: Text(
        diagnosis.notes!,
        style: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textSecondary,
          height: 1.6,
        ),
      ),
    );
  }

  Widget _buildCostSection() {
    return _buildDetailCard(
      title: 'Billing Information',
      icon: FontAwesomeIcons.moneyBillWave,
      iconColor: Colors.green,
      child: _buildInfoRow(
        'Service Cost',
        'LYD ${diagnosis.cost!.toStringAsFixed(2)}',
        FontAwesomeIcons.coins,
      ),
    );
  }

  Widget _buildClinicalAuditSection() {
    return _buildDetailCard(
      title: 'Verification',
      icon: FontAwesomeIcons.userShield,
      iconColor: AppColors.primaryDark,
      child: Column(
        children: [
          _buildInfoRow(
            'Added By',
            diagnosis.addedBy ?? 'Patient (Self-Reported)',
            FontAwesomeIcons.userCheck,
          ),
          const Divider(height: 24),
          _buildInfoRow(
            'Last Updated',
            _formatDate(diagnosis.lastUpdated),
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
