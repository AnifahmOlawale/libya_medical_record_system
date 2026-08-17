import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:libya_medical_record_system/core/router/app_router.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';
import 'package:libya_medical_record_system/features/institutions/affiliated_institutions_page.dart';
import 'package:libya_medical_record_system/features/institutions/institution_invites_page.dart';
import 'package:libya_medical_record_system/features/institutions/institution_requests_page.dart';
import 'package:libya_medical_record_system/features/institutions/join_institution_page.dart';
import 'package:libya_medical_record_system/features/institutions/my_institutions_page.dart';
import 'package:libya_medical_record_system/data/models/user_workplace.dart';

class InstitutionalAffiliationsPage extends StatefulWidget {
  const InstitutionalAffiliationsPage({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  State<InstitutionalAffiliationsPage> createState() =>
      _InstitutionalAffiliationsPageState();
}

class _InstitutionalAffiliationsPageState
    extends State<InstitutionalAffiliationsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  bool get _showMyInstitutionsTab => !kIsWeb;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _showMyInstitutionsTab ? 6 : 5,
      vsync: this,
      initialIndex: widget.initialIndex,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: !kIsWeb
            ? IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                  size: 20,
                ),
                onPressed: () => context.go(AppRoutes.home),
              )
            : null,
        title: Text(
          _showMyInstitutionsTab ? 'Medical Institutions' : 'Affiliations',
          style: AppTextStyles.titleLarge.copyWith(color: Colors.white),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          padding: EdgeInsets.zero,
          labelStyle: AppTextStyles.labelMedium.copyWith(
            fontWeight: FontWeight.w700,
          ),
          tabs: [
            if (_showMyInstitutionsTab) const Tab(text: 'My Institutions'),
            const Tab(text: 'Join'),
            const Tab(text: 'Affiliated'),
            const Tab(text: 'Invites'),
            const Tab(text: 'Pending'),
            const Tab(text: 'Rejected'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          if (_showMyInstitutionsTab)
            const MyInstitutionsPage(showHeader: false),
          const JoinInstitutionPage(showHeader: false),
          const AffiliatedInstitutionsPage(showHeader: false),
          const InstitutionInvitesPage(showHeader: false),
          const InstitutionRequestsPage(
            showHeader: false,
            statusFilter: WorkplaceApprovalStatus.pending,
          ),
          const InstitutionRequestsPage(
            showHeader: false,
            statusFilter: WorkplaceApprovalStatus.rejected,
          ),
        ],
      ),
    );
  }
}
