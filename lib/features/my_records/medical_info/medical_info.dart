import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:libya_medical_record_system/core/router/app_router.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';
import 'package:libya_medical_record_system/data/models/demo_data.dart';
import 'package:libya_medical_record_system/core/shared/widgets/sliver_page_header.dart';

class MedicalInfo extends StatelessWidget {
  const MedicalInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final userData = DemoData.currentUser();
    final medicalInfo = userData.medicalInfo;

    if (medicalInfo == null) {
      return const Scaffold(
        body: Center(child: Text('No medical information found.')),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const SliverPageHeader(
            title: 'Medical Information',
            icon: FontAwesomeIcons.fileMedical,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(24),
            sliver: SliverGrid.count(
              crossAxisCount: MediaQuery.of(context).size.width > 900
                  ? 4
                  : (MediaQuery.of(context).size.width > 600 ? 3 : 2),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.1,
              children: [
                _buildInfoCard(
                  icon: FontAwesomeIcons.rulerVertical,
                  label: 'Height',
                  value: medicalInfo.height,
                  unit: 'cm',
                  color: Colors.blue,
                ),
                _buildInfoCard(
                  icon: FontAwesomeIcons.weightScale,
                  label: 'Weight',
                  value: medicalInfo.weight,
                  unit: 'kg',
                  color: Colors.green,
                ),
                _buildInfoCard(
                  icon: FontAwesomeIcons.droplet,
                  label: 'Blood Type',
                  value: medicalInfo.bloodType,
                  color: Colors.red,
                ),
                _buildInfoCard(
                  icon: FontAwesomeIcons.dna,
                  label: 'Genotype',
                  value: medicalInfo.genotype,
                  color: Colors.orange,
                ),
                _buildInfoCard(
                  icon: medicalInfo.gender == 'Male'
                      ? FontAwesomeIcons.mars
                      : FontAwesomeIcons.venus,
                  label: 'Gender',
                  value: medicalInfo.gender,
                  color: Colors.purple,
                ),
                _buildInfoCard(
                  icon: FontAwesomeIcons.heartCircleCheck,
                  label: 'Marital Status',
                  value: medicalInfo.maritalStatus,
                  color: Colors.pink,
                ),
                _buildInfoCard(
                  icon: FontAwesomeIcons.handHoldingHand,
                  label: 'Last Donation',
                  value: medicalInfo.lastBloodDonationDate != null
                      ? _formatDate(medicalInfo.lastBloodDonationDate!)
                      : 'N/A',
                  color: Colors.redAccent,
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  _buildSectionHeader('Lifestyle & Health'),
                  const SizedBox(height: 16),
                  _buildStatusTile(
                    label: 'Smoking Status',
                    value: medicalInfo.smokingStatus,
                    icon: FontAwesomeIcons.smoking,
                  ),
                  _buildStatusTile(
                    label: 'Alcohol Use',
                    value: medicalInfo.alcoholUse,
                    icon: FontAwesomeIcons.glassWhiskey,
                  ),
                  _buildStatusTile(
                    label: 'Disability Status',
                    value: medicalInfo.disabilityStatus,
                    icon: FontAwesomeIcons.wheelchair,
                  ),
                  if (medicalInfo.gender == 'Female')
                    _buildStatusTile(
                      label: 'Pregnancy Status',
                      value: medicalInfo.pregnancyStatus,
                      icon: FontAwesomeIcons.baby,
                    ),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppRoutes.editMedicalInfo),
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.edit_rounded, color: Colors.white),
        label: Text(
          'Edit Info',
          style: AppTextStyles.labelLarge.copyWith(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: AppTextStyles.titleMedium.copyWith(
        fontWeight: FontWeight.w800,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildInfoCard({
    required dynamic icon,
    required String label,
    required String value,
    String? unit,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: AppColors.divider.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: icon is IconData
                ? Icon(icon, color: color, size: 22)
                : FaIcon(icon, color: color, size: 22),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  value,
                  style: AppTextStyles.headlineSmall.copyWith(
                    fontWeight: FontWeight.w900,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              if (unit != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 2, left: 4),
                  child: Text(
                    unit,
                    style: AppTextStyles.caption.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDisabled,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusTile({
    required String label,
    required String value,
    required dynamic icon,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: [
          icon is IconData
              ? Icon(icon, color: AppColors.primary, size: 20)
              : FaIcon(icon, color: AppColors.primary, size: 20),
          const SizedBox(width: 16),
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

  String _formatDate(DateTime date) {
    return DateFormat("dd MMM, yyyy").format(date);
  }
}
