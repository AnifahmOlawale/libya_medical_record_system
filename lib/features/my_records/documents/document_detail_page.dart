import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';
import 'package:libya_medical_record_system/data/models/document_model.dart';
import 'package:libya_medical_record_system/core/constants/document_constants.dart';

import 'package:libya_medical_record_system/core/shared/widgets/sliver_page_header.dart';

class DocumentDetailPage extends StatelessWidget {
  const DocumentDetailPage({super.key, required this.document});

  final DocumentModel document;

  @override
  Widget build(BuildContext context) {
    final categoryLabel =
        document.category == DocumentCategory.other &&
            document.customCategory != null
        ? document.customCategory!
        : (DocumentConstants.categoryLabels[document.category] ?? 'Document');

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPageHeader(
            title: document.title,
            icon: DocumentConstants.getCategoryIcon(document.category),
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
                categoryLabel.toUpperCase(),
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
                  _buildInformationSection(categoryLabel),
                  const SizedBox(height: 24),
                  if (document.description != null &&
                      document.description!.isNotEmpty) ...[
                    _buildDescriptionSection(),
                    const SizedBox(height: 24),
                  ],
                  if (document.filePaths.isNotEmpty) ...[
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

  Widget _buildInformationSection(String categoryLabel) {
    return _buildDetailCard(
      title: 'Document Information',
      icon: FontAwesomeIcons.circleInfo,
      iconColor: AppColors.primary,
      child: Column(
        children: [
          _buildInfoRow(
            'Issue Date',
            _formatDate(document.issueDate),
            FontAwesomeIcons.calendarDay,
          ),
          const Divider(height: 24),
          _buildInfoRow(
            'Issued By',
            document.issuedBy,
            FontAwesomeIcons.buildingColumns,
          ),
          const Divider(height: 24),
          _buildInfoRow('Category', categoryLabel, FontAwesomeIcons.tag),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection() {
    return _buildDetailCard(
      title: 'Description',
      icon: FontAwesomeIcons.fileLines,
      iconColor: Colors.blue,
      child: Text(
        document.description!,
        style: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textPrimary,
          height: 1.6,
        ),
      ),
    );
  }

  Widget _buildDocumentsSection() {
    return _buildDetailCard(
      title: 'Vault Files',
      icon: FontAwesomeIcons.folderOpen,
      iconColor: Colors.red.shade400,
      child: Column(
        children: document.filePaths.map((path) {
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
                            isImage ? 'Scanned Page' : 'Digital Document PDF',
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
            document.addedBy ?? 'Patient',
            FontAwesomeIcons.userCheck,
          ),
          const Divider(height: 24),
          _buildInfoRow(
            'Last Updated',
            _formatDate(document.lastUpdated),
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
