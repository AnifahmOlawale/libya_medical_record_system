import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';
import 'package:libya_medical_record_system/data/models/surgery_model.dart';

import 'package:libya_medical_record_system/core/shared/widgets/sliver_page_header.dart';

class SurgeryDetailPage extends StatelessWidget {
  const SurgeryDetailPage({super.key, required this.surgery});

  final SurgeryModel surgery;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPageHeader(
            title: surgery.procedureName,
            icon: FontAwesomeIcons.kitMedical,
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
                surgery.status.name.toUpperCase(),
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
                  _buildHospitalSurgeonSection(),
                  const SizedBox(height: 24),
                  if (surgery.operationNotes != null &&
                      surgery.operationNotes!.isNotEmpty) ...[
                    _buildOperationNotesSection(),
                    const SizedBox(height: 24),
                  ],
                  if (surgery.dischargeInstructions != null &&
                      surgery.dischargeInstructions!.isNotEmpty) ...[
                    _buildRecoverySection(),
                    const SizedBox(height: 24),
                  ],
                  if (surgery.cost != null) ...[
                    _buildCostSection(),
                    const SizedBox(height: 24),
                  ],
                  if (surgery.reportPaths.isNotEmpty) ...[
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

  Widget _buildHospitalSurgeonSection() {
    return _buildDetailCard(
      title: 'Facility & Team',
      icon: FontAwesomeIcons.hospital,
      iconColor: AppColors.primary,
      child: Column(
        children: [
          _buildInfoRow(
            'Hospital',
            surgery.hospitalName,
            FontAwesomeIcons.buildingColumns,
          ),
          const Divider(height: 24),
          _buildInfoRow(
            'Lead Surgeon',
            surgery.surgeonName,
            FontAwesomeIcons.userDoctor,
          ),
          const Divider(height: 24),
          _buildInfoRow(
            'Surgery Date',
            _formatDate(surgery.surgeryDate),
            FontAwesomeIcons.calendarDay,
          ),
          if (surgery.anesthesiaType != null) ...[
            const Divider(height: 24),
            _buildInfoRow(
              'Anesthesia Type',
              surgery.anesthesiaType!,
              FontAwesomeIcons.syringe,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildOperationNotesSection() {
    return _buildDetailCard(
      title: 'Operation Notes',
      icon: FontAwesomeIcons.fileLines,
      iconColor: Colors.blue,
      child: Text(
        surgery.operationNotes!,
        style: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textPrimary,
          height: 1.6,
        ),
      ),
    );
  }

  Widget _buildRecoverySection() {
    return _buildDetailCard(
      title: 'Recovery & Instructions',
      icon: FontAwesomeIcons.clipboardCheck,
      iconColor: AppColors.accent,
      child: Text(
        surgery.dischargeInstructions!,
        style: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textPrimary,
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
        'Procedure Cost',
        'LYD ${surgery.cost!.toStringAsFixed(2)}',
        FontAwesomeIcons.coins,
      ),
    );
  }

  Widget _buildDocumentsSection() {
    return _buildDetailCard(
      title: 'Reports & Photos',
      icon: FontAwesomeIcons.images,
      iconColor: Colors.red.shade400,
      child: Column(
        children: surgery.reportPaths.map((path) {
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
                            isImage ? 'Post-op Photo' : 'Discharge Summary PDF',
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
            surgery.addedBy ?? 'Surgical Dept',
            FontAwesomeIcons.userCheck,
          ),
          const Divider(height: 24),
          _buildInfoRow(
            'Last Updated',
            _formatDate(surgery.lastUpdated),
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
