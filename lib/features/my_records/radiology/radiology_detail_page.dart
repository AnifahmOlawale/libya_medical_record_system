import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';
import 'package:libya_medical_record_system/data/models/radiology_model.dart';
import 'package:libya_medical_record_system/core/constants/radiology_constants.dart';

import 'package:libya_medical_record_system/core/shared/widgets/sliver_page_header.dart';

class RadiologyDetailPage extends StatelessWidget {
  const RadiologyDetailPage({super.key, required this.report});

  final RadiologyModel report;

  @override
  Widget build(BuildContext context) {
    final modalityLabel =
        report.modality == RadiologyModality.other &&
            report.customModality != null
        ? report.customModality!
        : (RadiologyConstants.modalityLabels[report.modality] ?? 'Imaging');

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPageHeader(
            title: report.studyName,
            icon: _getModalityIcon(report.modality),
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
                color: kIsWeb
                    ? AppColors.primary.withValues(alpha: 0.1)
                    : Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: kIsWeb
                      ? AppColors.primary
                      : Colors.white.withValues(alpha: 0.3),
                ),
              ),
              child: Text(
                modalityLabel,
                style: AppTextStyles.labelSmall.copyWith(
                  color: kIsWeb ? AppColors.primary : Colors.white,
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
                  _buildImpressionSection(),
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

  Widget _buildImpressionSection() {
    return _buildDetailCard(
      title: 'Clinical Impression',
      icon: FontAwesomeIcons.quoteLeft,
      iconColor: AppColors.accent,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.accent.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.accent.withValues(alpha: 0.1)),
        ),
        child: Text(
          report.impression,
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }

  Widget _buildFindingsSection() {
    return _buildDetailCard(
      title: 'Detailed Findings',
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
            'Study Date',
            _formatDate(report.studyDate),
            FontAwesomeIcons.calendarDay,
          ),
          const Divider(height: 24),
          _buildInfoRow(
            'Reporting Radiologist',
            report.radiologistName,
            FontAwesomeIcons.userDoctor,
          ),
          if (report.clinicalIndication != null) ...[
            const Divider(height: 24),
            _buildInfoRow(
              'Clinical Indication',
              report.clinicalIndication!,
              FontAwesomeIcons.commentMedical,
            ),
          ],
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
        'Study Cost',
        'LYD ${report.cost!.toStringAsFixed(2)}',
        FontAwesomeIcons.coins,
      ),
    );
  }

  Widget _buildDocumentsSection() {
    return _buildDetailCard(
      title: 'Study Reports & Scans',
      icon: FontAwesomeIcons.fileLines,
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
                            isImage ? 'Scan Image' : 'Radiology Report PDF',
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

  Widget _buildClinicalAuditSection() {
    return _buildDetailCard(
      title: 'Verification',
      icon: FontAwesomeIcons.userShield,
      iconColor: AppColors.primaryDark,
      child: Column(
        children: [
          _buildInfoRow(
            'Added By',
            report.addedBy ?? 'Radiology Dept',
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
    return DateFormat("dd, MMM yyyy").format(date);
  }
}
