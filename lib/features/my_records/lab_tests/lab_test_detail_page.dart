import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';
import 'package:libya_medical_record_system/data/models/lab_test_model.dart';

import 'package:libya_medical_record_system/core/shared/widgets/sliver_page_header.dart';

class LabTestDetailPage extends StatelessWidget {
  const LabTestDetailPage({super.key, required this.test});

  final LabTestModel test;

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    String statusLabel;

    switch (test.status) {
      case LabResultStatus.normal:
        statusColor = AppColors.success;
        statusLabel = 'NORMAL';
        break;
      case LabResultStatus.abnormal:
        statusColor = AppColors.warning;
        statusLabel = 'ABNORMAL';
        break;
      case LabResultStatus.critical:
        statusColor = AppColors.error;
        statusLabel = 'CRITICAL';
        break;
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPageHeader(
            title: test.testName,
            icon: FontAwesomeIcons.flask,
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
                  _buildResultValueSection(statusColor),
                  const SizedBox(height: 24),
                  _buildLabInfoSection(),
                  const SizedBox(height: 24),
                  if (test.reportPaths.isNotEmpty) ...[
                    _buildDocumentsSection(),
                    const SizedBox(height: 24),
                  ],
                  if (test.notes != null && test.notes!.isNotEmpty) ...[
                    _buildNotesSection(),
                    const SizedBox(height: 24),
                  ],
                  if (test.cost != null) ...[
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

  Widget _buildResultValueSection(Color statusColor) {
    return _buildDetailCard(
      title: 'Test Result',
      icon: FontAwesomeIcons.chartLine,
      iconColor: statusColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                test.resultValue ?? '--',
                style: AppTextStyles.displayLarge.copyWith(
                  color: statusColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 42,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                test.unit ?? '',
                style: AppTextStyles.titleLarge.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          if (test.referenceRange != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.circleInfo,
                    size: 14,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Reference Range: ',
                    style: AppTextStyles.bodySmall.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(test.referenceRange!, style: AppTextStyles.bodySmall),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildLabInfoSection() {
    return _buildDetailCard(
      title: 'Lab Information',
      icon: FontAwesomeIcons.hospital,
      iconColor: Colors.blue,
      child: Column(
        children: [
          _buildInfoRow(
            'Performing Laboratory',
            test.laboratoryName,
            FontAwesomeIcons.buildingCircleCheck,
          ),
          const Divider(height: 24),
          _buildInfoRow(
            'Test Date',
            _formatDate(test.testDate),
            FontAwesomeIcons.calendarDay,
          ),
          if (test.orderedBy != null) ...[
            const Divider(height: 24),
            _buildInfoRow(
              'Ordered By',
              test.orderedBy!,
              FontAwesomeIcons.userDoctor,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDocumentsSection() {
    return _buildDetailCard(
      title: 'Lab Reports',
      icon: FontAwesomeIcons.fileLines,
      iconColor: Colors.red.shade400,
      child: Column(
        children: test.reportPaths.map((path) {
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
      title: 'Laboratory Notes',
      icon: FontAwesomeIcons.filePen,
      iconColor: Colors.teal,
      child: Text(
        test.notes!,
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
        'Test Cost',
        'LYD ${test.cost!.toStringAsFixed(2)}',
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
            test.addedBy ?? 'Lab Staff',
            FontAwesomeIcons.userCheck,
          ),
          const Divider(height: 24),
          _buildInfoRow(
            'Last Updated',
            _formatDate(test.lastUpdated),
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
