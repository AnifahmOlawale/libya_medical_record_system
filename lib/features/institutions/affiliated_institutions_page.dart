import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:libya_medical_record_system/core/router/app_router.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';
import 'package:libya_medical_record_system/core/shared/widgets/sliver_page_header.dart';
import 'package:libya_medical_record_system/data/models/demo_data.dart';
import 'package:libya_medical_record_system/data/models/institution_model.dart';
import 'package:libya_medical_record_system/data/models/user_workplace.dart';

class AffiliatedInstitutionsPage extends StatelessWidget {
  const AffiliatedInstitutionsPage({super.key});

  void _onInstitutionTap(BuildContext context, UserWorkplace workplace) {
    // Find the full institution model from demo data
    final institution = DemoData.institutions().firstWhere(
      (inst) => inst.id == workplace.institutionId,
      orElse: () => InstitutionModel(
        id: workplace.institutionId,
        name: workplace.institutionName,
        type: workplace.institutionType,
        location: workplace.location,
        specialization: 'General',
      ),
    );

    context.push(AppRoutes.institutionDetail, extra: institution);
  }

  @override
  Widget build(BuildContext context) {
    final userData = DemoData.currentUser();
    final approvedWorkplaces = userData.workplaces
        .where((w) => w.status == WorkplaceApprovalStatus.approved)
        .toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const SliverPageHeader(
            title: 'Affiliated Institutions',
            subtitle: 'Hospitals and clinics where you are verified',
            icon: FontAwesomeIcons.hospitalUser,
          ),
          if (approvedWorkplaces.isEmpty)
            const SliverFillRemaining(
              child: Center(child: Text('No affiliated institutions yet.')),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.all(24),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: MediaQuery.sizeOf(context).width > 900
                      ? 3
                      : (MediaQuery.sizeOf(context).width > 600 ? 2 : 1),
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  mainAxisExtent: 140,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) => _buildAffiliateCard(
                    context,
                    approvedWorkplaces[index],
                  ),
                  childCount: approvedWorkplaces.length,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAffiliateCard(BuildContext context, UserWorkplace workplace) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: AppColors.divider.withValues(alpha: 0.5)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _onInstitutionTap(context, workplace),
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Center(
                        child: FaIcon(
                          FontAwesomeIcons.hospital,
                          size: 24,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            workplace.institutionName,
                            style: AppTextStyles.titleSmall.copyWith(
                              fontWeight: FontWeight.w800,
                              color: AppColors.textPrimary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            workplace.position,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.verified_rounded,
                      color: AppColors.success,
                      size: 20,
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_rounded,
                      size: 14,
                      color: AppColors.textDisabled,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      workplace.location,
                      style: AppTextStyles.bodySmall.copyWith(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
