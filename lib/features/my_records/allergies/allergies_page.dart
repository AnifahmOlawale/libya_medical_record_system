import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:libya_medical_record_system/core/router/app_router.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';
import 'package:libya_medical_record_system/core/shared/widgets/empty_state_widget.dart';
import 'package:libya_medical_record_system/core/shared/widgets/sliver_page_header.dart';
import 'package:libya_medical_record_system/data/models/demo_data.dart';
import 'package:libya_medical_record_system/data/models/allergy_model.dart';
import 'package:libya_medical_record_system/data/models/user_registration_model.dart';

class AllergiesPage extends StatelessWidget {
  const AllergiesPage({super.key, this.patient});

  final UserRegistrationModel? patient;

  @override
  Widget build(BuildContext context) {
    final allergies = patient != null ? patient!.allergies : DemoData.allergies();
    final bool isPatientView = patient != null;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPageHeader(
            title: isPatientView ? '${patient!.personalInfo!.fullNameEnglish}\'s Allergies' : 'My Allergies',
            icon: FontAwesomeIcons.virusSlash,
            showBackButton: isPatientView,
          ),
          if (allergies.isEmpty)
            const EmptyStateSliver(
              icon: FontAwesomeIcons.shieldVirus,
              title: 'No Allergies Reported',
              subtitle: 'Allergy records will appear here.',
            )
          else
            _buildAllergyList(allergies, isPatientView),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppRoutes.addAllergy, extra: patient),
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add_rounded, color: Colors.white),
        label: Text(
          'Add Allergy',
          style: AppTextStyles.labelLarge.copyWith(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildAllergyList(List<AllergyModel> allergies, bool isPatientView) {
    return SliverPadding(
      padding: const EdgeInsets.all(20),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final allergy = allergies[index];
          return _buildAllergyCard(context, allergy, isPatientView);
        }, childCount: allergies.length),
      ),
    );
  }

  Widget _buildAllergyCard(BuildContext context, AllergyModel allergy, bool isPatientView) {
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
        onTap: () => context.push(AppRoutes.allergyDetail, extra: allergy),
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
                  color: AppColors.primarySurface.withValues(alpha: 0.3),
                  border: Border(
                    left: BorderSide(color: AppColors.primary, width: 4),
                  ),
                ),
                child: Row(
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.triangleExclamation,
                      color: AppColors.primary,
                      size: 16,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        allergy.allergen,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.titleMedium.copyWith(
                          color: AppColors.primaryDark,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Text(
                      'Active',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.success,
                        fontWeight: FontWeight.w700,
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
                    _buildDetailRow(
                      'Reaction',
                      allergy.reaction,
                      icon: FontAwesomeIcons.bolt,
                    ),
                    if (allergy.onsetDate != null) ...[
                      const SizedBox(height: 16),
                      _buildDetailRow(
                        'Discovered',
                        _formatDate(allergy.onsetDate!),
                        icon: FontAwesomeIcons.calendarDay,
                      ),
                    ],
                    if (allergy.notes != null) ...[
                      const SizedBox(height: 16),
                      _buildDetailRow(
                        'Notes',
                        allergy.notes!,
                        icon: FontAwesomeIcons.fileMedical,
                      ),
                    ],
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
                      'Added by: ${allergy.addedBy ?? 'N/A'}',
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
    return DateFormat("dd MMM, yyyy").format(date);
  }
}
