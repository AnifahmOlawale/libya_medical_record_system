import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';
import 'package:libya_medical_record_system/data/models/pathology_model.dart';

import 'package:libya_medical_record_system/core/shared/widgets/sliver_page_header.dart';

class PathologyDetailPage extends StatelessWidget {
  const PathologyDetailPage({super.key, required this.report});

  final PathologyModel report;

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    String statusLabel;

    switch (report.status) {
      case PathologyStatus.normal:
        statusColor = AppColors.success;
        statusLabel = 'NORMAL';
        break;
      case PathologyStatus.benign:
        statusColor = Colors.blue;
        statusLabel = 'BENIGN';
        break;
      case PathologyStatus.malignant:
        statusColor = AppColors.error;
        statusLabel = 'MALIGNANT';
        break;
      case PathologyStatus.inconclusive:
        statusColor = AppColors.warning;
        statusLabel = 'INCONCLUSIVE';
        break;
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPageHeader(
            title: report.specimenType,
            icon: FontAwesomeIcons.dna,
            expandedHeight: 240,
            actions: [
              IconButton(
                icon: Icon(
                  Icons.edit_outlined,
                  color: kIsWeb ? AppColors.primary : Colors.white,
                ),
                onPressed: () {},
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
                  _buildDiagnosisSection(statusColor),
                  const SizedBox(height: 24),
                  _buildFindingsSection(),
                  const SizedBox(height: 24),
                  _buildStudyDetailsSection(),
                  const SizedBox(height: 24),
                  if (report.cost != null) ...[
                    _buildCostSection(),
                    const SizedBox(height: 24),
                  ],
                  if (report.reportPaths.isNotEmpty) ...[
                    _buildDocumentsSection(),
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

  Widget _buildDiagnosisSection(Color statusColor) {
    return _buildDetailCard(
      title: 'Final Diagnosis',
      icon: FontAwesomeIcons.clipboardCheck,
      iconColor: statusColor,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: statusColor.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: statusColor.withValues(alpha: 0.1)),
        ),
        child: Text(
          report.finalDiagnosis,
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _buildFindingsSection() {
    return _buildDetailCard(
      title: 'Observations',
      icon: FontAwesomeIcons.fileLines,
      iconColor: Colors.blue,
      child: Text(
        report.findings,
        style: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textPrimary,
          height: 1.6,
        ),
      ),
    );
  }

  Widget _buildStudyDetailsSection() {
    return _buildDetailCard(
      title: 'Study Information',
      icon: FontAwesomeIcons.circleInfo,
      iconColor: Colors.teal,
      child: Column(
        children: [
          _buildInfoRow(
            'Institution',
            report.institutionName,
            FontAwesomeIcons.buildingColumns,
          ),
          const Divider(height: 24),
          _buildInfoRow(
            'Collection Date',
            _formatDate(report.collectionDate),
            FontAwesomeIcons.calendarDay,
          ),
          const Divider(height: 24),
          _buildInfoRow(
            'Reporting Pathologist',
            report.pathologistName,
            FontAwesomeIcons.userDoctor,
          ),
          const Divider(height: 24),
          _buildInfoRow(
            'Anatomic Site',
            report.anatomicSite,
            FontAwesomeIcons.personDotsFromLine,
          ),
        ],
      ),
    );
  }

  Widget _buildCostSection() {
    return _buildDetailCard(
      title: 'Billing Information',
      icon: FontAwesomeIcons.moneyBillWave,
      iconColor: Colors.green,
      child: _buildInfoRow(
        'Analysis Cost',
        'LYD ${report.cost!.toStringAsFixed(2)}',
        FontAwesomeIcons.coins,
      ),
    );
  }

  Widget _buildDocumentsSection() {
    return _buildDetailCard(
      title: 'Reports & Micro-photos',
      icon: FontAwesomeIcons.images,
      iconColor: Colors.red.shade400,
      child: Column(
        children: report.reportPaths.map((path) {
          final fileName = path.split('/').last;
          final isImage =
              path.toLowerCase().endsWith('.jpg') ||
              path.toLowerCase().endsWith('.jpeg') ||
              path.toLowerCase().endsWith('.png');

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: InkWell(
              onTap: () {},
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
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            isImage ? 'Micro-photo' : 'Pathology Report PDF',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.textSecondary.withValues(
                                alpha: 0.6,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.download_rounded,
                      color: AppColors.primary,
                      size: 20,
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

  Widget _buildClinicalAuditSection() {
    return _buildDetailCard(
      title: 'Verification',
      icon: FontAwesomeIcons.userShield,
      iconColor: AppColors.primaryDark,
      child: Column(
        children: [
          _buildInfoRow(
            'Added By',
            report.addedBy ?? 'Pathology Dept',
            FontAwesomeIcons.userCheck,
          ),
          const Divider(height: 24),
          _buildInfoRow(
            'Last Updated',
            _formatDate(report.lastUpdated),
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
