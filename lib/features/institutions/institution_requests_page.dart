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
import 'package:libya_medical_record_system/data/models/user_workplace.dart';

class InstitutionRequestsPage extends StatelessWidget {
  const InstitutionRequestsPage({
    super.key,
    this.showHeader = true,
    this.statusFilter,
  });

  final bool showHeader;
  final WorkplaceApprovalStatus? statusFilter;

  void _onInstitutionTap(BuildContext context, UserWorkplace workplace) {
    // Find the full institution model from demo data
    final institution = DemoData.institutions().firstWhere(
      (inst) => inst.id == workplace.institutionId,
      orElse: () => InstitutionModel(
        id: workplace.institutionId,
        name: workplace.institutionName,
        type: workplace.institutionType,
        municipality: workplace.location,
        specialization: 'General',
      ),
    );

    context.push(AppRoutes.institutionDetail, extra: institution);
  }

  @override
  Widget build(BuildContext context) {
    final userData = DemoData.currentUser();
    final requestedWorkplaces =
        userData.workplaces
            .where((w) {
              if (statusFilter != null) {
                return w.status == statusFilter;
              }
              return w.status == WorkplaceApprovalStatus.pending ||
                  w.status == WorkplaceApprovalStatus.rejected;
            })
            .toList();

    final content = CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        if (showHeader)
          const SliverPageHeader(
            title: 'Approval Requests',
            subtitle: 'Track your pending and rejected affiliation requests',
            icon: FontAwesomeIcons.clockRotateLeft,
          ),
        if (requestedWorkplaces.isEmpty)
          const EmptyStateSliver(
            icon: FontAwesomeIcons.clockRotateLeft,
            title: 'No active requests.',
            subtitle: 'Your pending and rejected requests will appear here.',
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
                (context, index) => _buildRequestCard(
                  context,
                  requestedWorkplaces[index],
                ),
                childCount: requestedWorkplaces.length,
              ),
            ),
          ),
      ],
    );

    if (!showHeader) return content;

    return Scaffold(backgroundColor: AppColors.background, body: content);
  }

  Widget _buildRequestCard(BuildContext context, UserWorkplace workplace) {
    final isRejected = workplace.status == WorkplaceApprovalStatus.rejected;

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
        border: Border.all(
          color: isRejected
              ? AppColors.error.withValues(alpha: 0.3)
              : AppColors.divider.withValues(alpha: 0.5),
        ),
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
                        color: (isRejected ? AppColors.error : AppColors.primary)
                            .withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Center(
                        child: FaIcon(
                          FontAwesomeIcons.hospital,
                          size: 24,
                          color: isRejected ? AppColors.error : AppColors.primary,
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
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
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
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_on_rounded,
                            size: 14,
                            color: AppColors.textDisabled,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              workplace.location,
                              style: AppTextStyles.bodySmall.copyWith(
                                fontSize: 11,
                                color: AppColors.textSecondary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildStatusBadge(workplace.status),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(WorkplaceApprovalStatus status) {
    final bool isRejected = status == WorkplaceApprovalStatus.rejected;
    final color = isRejected ? AppColors.error : Colors.orange;
    final text = isRejected ? 'Rejected' : 'Pending';
    final icon = isRejected ? Icons.cancel_outlined : Icons.access_time_rounded;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: AppTextStyles.labelSmall.copyWith(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
