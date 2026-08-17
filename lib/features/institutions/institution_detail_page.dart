import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';
import 'package:libya_medical_record_system/core/shared/widgets/app_primary_button.dart';
import 'package:libya_medical_record_system/core/shared/widgets/sliver_page_header.dart';
import 'package:libya_medical_record_system/core/shared/widgets/snack_bar.dart';
import 'package:libya_medical_record_system/data/models/institution_model.dart';

class InstitutionDetailPage extends StatelessWidget {
  const InstitutionDetailPage({super.key, required this.institution});

  final InstitutionModel institution;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPageHeader(
            title: institution.name,
            subtitle: institution.type,
            icon: institution.icon,
            expandedHeight: 250,
            showBackButton: true,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Overview'),
                  const SizedBox(height: 16),
                  _buildInfoTile(
                    FontAwesomeIcons.hospital,
                    'Institution Type',
                    institution.type,
                  ),
                  _buildInfoTile(
                    FontAwesomeIcons.stethoscope,
                    'Specialization',
                    institution.specialization,
                  ),
                  _buildInfoTile(
                    FontAwesomeIcons.locationDot,
                    'Municipality',
                    institution.municipality,
                  ),
                  const SizedBox(height: 32),
                  _buildSectionTitle('Contact Details'),
                  const SizedBox(height: 16),
                  _buildInfoTile(
                    FontAwesomeIcons.phone,
                    'Phone Number',
                    institution.phoneNumber ?? 'Not Available',
                  ),
                  _buildInfoTile(
                    FontAwesomeIcons.mapLocationDot,
                    'Address',
                    institution.address ?? 'Not Available',
                  ),
                  const SizedBox(height: 48),
                  AppPrimaryButton(
                    label: 'Join Institution',
                    onPressed: () {
                      snackBar(
                        context: context,
                        message: 'Join request sent to ${institution.name}',
                        type: SnackTypeEnum.success,
                      );
                    },
                  ),
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
      style: AppTextStyles.titleLarge.copyWith(
        fontWeight: FontWeight.w800,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildInfoTile(dynamic icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: icon is IconData
                ? Icon(icon, size: 16, color: AppColors.primary)
                : FaIcon(icon as dynamic, size: 16, color: AppColors.primary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyles.caption.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
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
