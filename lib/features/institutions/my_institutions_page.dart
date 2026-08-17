import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:libya_medical_record_system/core/router/app_router.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';
import 'package:libya_medical_record_system/core/shared/widgets/empty_state_widget.dart';
import 'package:libya_medical_record_system/core/shared/widgets/sliver_page_header.dart';
import 'package:libya_medical_record_system/data/models/demo_data.dart';
import 'package:libya_medical_record_system/data/models/institution_model.dart';

class MyInstitutionsPage extends StatelessWidget {
  const MyInstitutionsPage({super.key, this.showHeader = true});

  final bool showHeader;

  @override
  Widget build(BuildContext context) {
    final ownedInstitutions = DemoData.institutions()
        .where((inst) => inst.ownerId == DemoData.currentUserId)
        .toList();

    final content = CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        if (showHeader)
          const SliverPageHeader(
            title: 'My Institutions',
            subtitle: 'Manage institutions you own',
            icon: FontAwesomeIcons.buildingUser,
          ),
        if (ownedInstitutions.isEmpty)
          const EmptyStateSliver(
            icon: FontAwesomeIcons.buildingCircleExclamation,
            title: 'No institutions found',
            subtitle: 'You don\'t own any medical facilities yet.',
          )
        else
          SliverPadding(
            padding: const EdgeInsets.all(24),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:
                    MediaQuery.sizeOf(context).width > 900
                        ? 3
                        : (MediaQuery.sizeOf(context).width > 600 ? 2 : 1),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                mainAxisExtent: 160,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => _buildOwnedInstitutionCard(
                  context,
                  ownedInstitutions[index],
                ),
                childCount: ownedInstitutions.length,
              ),
            ),
          ),
        const SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );

    if (!showHeader) return content;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: content,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Future: Navigate to institution registration form
        },
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add_business_rounded, color: Colors.white),
        label: Text(
          'Register Facility',
          style: AppTextStyles.labelLarge.copyWith(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildOwnedInstitutionCard(BuildContext context, InstitutionModel inst) {
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
          onTap: () {
            context.push(AppRoutes.ownedInstitutionDetail, extra: inst);
          },
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: FaIcon(
                          inst.icon as dynamic,
                          size: 20,
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
                            inst.name,
                            style: AppTextStyles.titleSmall.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            inst.type,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_rounded,
                          size: 14,
                          color: AppColors.textDisabled,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          inst.municipality,
                          style: AppTextStyles.bodySmall.copyWith(
                            fontSize: 11,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.success.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'OWNER',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.success,
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                        ),
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
