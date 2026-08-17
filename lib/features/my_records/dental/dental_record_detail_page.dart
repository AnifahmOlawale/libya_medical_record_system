import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:dental_teeth_selector/dental_teeth_selector.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';
import 'package:libya_medical_record_system/core/shared/widgets/sliver_page_header.dart';
import 'package:libya_medical_record_system/data/models/dental_record_model.dart';

class DentalRecordDetailPage extends StatelessWidget {
  const DentalRecordDetailPage({super.key, required this.record});

  final DentalRecordModel record;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPageHeader(
            title: record.procedure,
            subtitle: DateFormat('dd MMMM, yyyy').format(record.date),
            icon: FontAwesomeIcons.tooth,
            showBackButton: true,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Teeth Involved'),
                  const SizedBox(height: 16),
                  _buildTeethDisplay(context),
                  const SizedBox(height: 32),
                  _buildSectionTitle('Procedure Overview'),
                  const SizedBox(height: 16),
                  _buildInfoCard([
                    _buildInfoTile(
                      FontAwesomeIcons.userDoctor,
                      'Dentist',
                      record.doctorName,
                    ),
                    _buildInfoTile(
                      FontAwesomeIcons.hospital,
                      'Facility',
                      record.institutionName,
                    ),
                  ]),
                  if (record.notes != null) ...[
                    const SizedBox(height: 32),
                    _buildSectionTitle('Clinical Notes'),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.divider),
                      ),
                      child: Text(
                        record.notes!,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textPrimary,
                          height: 1.6,
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: AppTextStyles.titleMedium.copyWith(
        fontWeight: FontWeight.w800,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildTeethDisplay(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.divider),
      ),
      child: IgnorePointer(
        child: Center(
          child: DentalTeethSelector(
            initiallySelected: record.selectedTeeth,
            selectedColor: AppColors.primary,
            toothColor: AppColors.textPrimary,
            numberColor: AppColors.textPrimary,
            rightLabel: 'Right',
            leftLabel: 'Left',
            labelColor: AppColors.textSecondary,
            width: MediaQuery.of(context).size.width * 0.8,
            height: 400,
            onSelected: (teeth) {},
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildInfoTile(dynamic icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: icon is IconData
                ? Icon(icon, color: AppColors.primary, size: 18)
                : FaIcon(icon, color: AppColors.primary, size: 18),
          ),
          const SizedBox(width: 16),
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
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
