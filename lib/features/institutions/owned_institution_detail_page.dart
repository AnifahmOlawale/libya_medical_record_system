import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:libya_medical_record_system/core/router/app_router.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';
import 'package:libya_medical_record_system/core/shared/widgets/app_primary_button.dart';
import 'package:libya_medical_record_system/core/shared/widgets/empty_state_widget.dart';
import 'package:libya_medical_record_system/core/shared/widgets/snack_bar.dart';
import 'package:libya_medical_record_system/data/models/demo_data.dart';
import 'package:libya_medical_record_system/data/models/institution_model.dart';
import 'package:libya_medical_record_system/data/models/user_registration_model.dart';
import 'package:libya_medical_record_system/data/models/user_workplace.dart';

class OwnedInstitutionDetailPage extends StatefulWidget {
  const OwnedInstitutionDetailPage({super.key, required this.institution});

  final InstitutionModel institution;

  @override
  State<OwnedInstitutionDetailPage> createState() =>
      _OwnedInstitutionDetailPageState();
}

class _OwnedInstitutionDetailPageState extends State<OwnedInstitutionDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final allExperts = DemoData.experts();

    // Filter staff
    final joinRequests = allExperts.where((exp) {
      final workplace = exp.workplaces.firstWhere(
        (w) => w.institutionId == widget.institution.id,
        orElse: () => UserWorkplace(
          institutionId: '',
          institutionName: '',
          institutionType: '',
          location: '',
          position: '',
          status: WorkplaceApprovalStatus.rejected,
          joinedDate: DateTime.now(),
        ),
      );
      return workplace.institutionId == widget.institution.id &&
          workplace.status == WorkplaceApprovalStatus.pending &&
          exp.id != 'exp_005';
    }).toList();

    final medicalTeam = allExperts.where((exp) {
      final workplace = exp.workplaces.firstWhere(
        (w) => w.institutionId == widget.institution.id,
        orElse: () => UserWorkplace(
          institutionId: '',
          institutionName: '',
          institutionType: '',
          location: '',
          position: '',
          status: WorkplaceApprovalStatus.rejected,
          joinedDate: DateTime.now(),
        ),
      );
      return workplace.institutionId == widget.institution.id &&
          workplace.status == WorkplaceApprovalStatus.approved;
    }).toList();

    final sentInvites = allExperts.where((exp) {
      return exp.id == 'exp_005' &&
          exp.workplaces.any((w) => w.institutionId == widget.institution.id);
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            _buildFacebookStyleHeader(),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            _StaffListTab(
              staff: joinRequests,
              type: _StaffTabType.joinRequests,
              institutionName: widget.institution.name,
            ),
            _StaffListTab(
              staff: medicalTeam,
              type: _StaffTabType.medicalTeam,
              institutionName: widget.institution.name,
            ),
            _StaffListTab(
              staff: sentInvites,
              type: _StaffTabType.sentInvites,
              institutionName: widget.institution.name,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          snackBar(context: context, message: 'Recruitment tool coming soon');
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.person_add_rounded, color: Colors.white),
      ),
    );
  }

  Widget _buildFacebookStyleHeader() {
    return SliverAppBar(
      expandedHeight: 380,
      pinned: true,
      stretch: true,
      backgroundColor: AppColors.primary,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
        onPressed: () => context.pop(),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.edit_note_rounded, color: Colors.white),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.settings_outlined, color: Colors.white),
        ),
        const SizedBox(width: 8),
      ],
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [StretchMode.zoomBackground],
        background: Stack(
          fit: StackFit.expand,
          children: [
            // 1. Cover Photo Area (Background Gradient)
            Column(
              children: [
                Container(
                  height: 180,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppColors.primaryDark, AppColors.primary, AppColors.accent],
                    ),
                  ),
                  child: Center(
                    child: Opacity(
                      opacity: 0.1,
                      child: FaIcon(FontAwesomeIcons.hospital, size: 120, color: Colors.white),
                    ),
                  ),
                ),
                // 2. Info Area (White Surface)
                Expanded(
                  child: Container(
                    width: double.infinity,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 35), // Space for overlapping logo
                        Text(
                          widget.institution.name,
                          style: AppTextStyles.titleLarge.copyWith(
                            fontWeight: FontWeight.w900,
                            color: AppColors.textPrimary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.institution.type,
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              '  •  ${widget.institution.municipality}',
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildStatChip('Verified', Icons.verified_rounded, AppColors.success),
                            const SizedBox(width: 8),
                            _buildStatChip('Public', Icons.public_rounded, AppColors.primary),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 48), // TabBar space
              ],
            ),
            // 3. Overlapping Logo (Centered Circle Avatar)
            Positioned(
              top: 135,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 42,
                      backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                      child: widget.institution.logoUrl != null
                          ? ClipOval(
                              child: Image.network(
                                widget.institution.logoUrl!,
                                fit: BoxFit.cover,
                                errorBuilder: (c, e, s) => _buildPlaceholderIcon(),
                              ),
                            )
                          : _buildPlaceholderIcon(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(48),
        child: Container(
          color: Colors.white,
          child: TabBar(
            controller: _tabController,
            indicatorColor: AppColors.primary,
            indicatorWeight: 3,
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.textSecondary,
            labelStyle: AppTextStyles.labelMedium.copyWith(fontWeight: FontWeight.w800),
            tabs: const [
              Tab(text: 'Requests'),
              Tab(text: 'Team'),
              Tab(text: 'Invites'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatChip(String label, IconData icon, Color color) {
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
            label,
            style: AppTextStyles.labelSmall.copyWith(
              color: color,
              fontWeight: FontWeight.w800,
              fontSize: 9,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderIcon() {
    return FaIcon(
      widget.institution.icon as dynamic ?? FontAwesomeIcons.hospital,
      size: 32,
      color: AppColors.primary,
    );
  }
}

enum _StaffTabType { joinRequests, medicalTeam, sentInvites }

class _StaffListTab extends StatelessWidget {
  const _StaffListTab({
    required this.staff,
    required this.type,
    required this.institutionName,
  });

  final List<UserRegistrationModel> staff;
  final _StaffTabType type;
  final String institutionName;

  @override
  Widget build(BuildContext context) {
    if (staff.isEmpty) {
      return EmptyStateWidget(
        icon: type == _StaffTabType.joinRequests
            ? FontAwesomeIcons.userClock
            : (type == _StaffTabType.medicalTeam
                ? FontAwesomeIcons.usersViewfinder
                : FontAwesomeIcons.paperPlane),
        title: type == _StaffTabType.joinRequests
            ? 'No Join Requests'
            : (type == _StaffTabType.medicalTeam
                ? 'No Staff Members'
                : 'No Sent Invitations'),
        subtitle: type == _StaffTabType.joinRequests
            ? 'Prospective applications will appear here.'
            : (type == _StaffTabType.medicalTeam
                ? 'No verified team members at $institutionName.'
                : 'Invitations you send to experts will appear here.'),
      );
    }

    return LayoutBuilder(builder: (context, constraints) {
      final double width = constraints.maxWidth;
      int crossAxisCount = 1;
      
      if (width > 1200) {
        crossAxisCount = 3;
      } else if (width > 700) {
        crossAxisCount = 2;
      }

      return GridView.builder(
        padding: const EdgeInsets.all(20),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          mainAxisExtent: 185,
        ),
        itemCount: staff.length,
        itemBuilder: (context, index) => Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 550),
            child: _StaffCard(
              expert: staff[index],
              type: type,
            ),
          ),
        ),
      );
    });
  }
}

class _StaffCard extends StatelessWidget {
  const _StaffCard({required this.expert, required this.type});

  final UserRegistrationModel expert;
  final _StaffTabType type;

  @override
  Widget build(BuildContext context) {
    final personal = expert.personalInfo!;
    final professional = expert.professionalInfo!;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => context.push(AppRoutes.expertDetail, extra: expert),
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                      child: const FaIcon(FontAwesomeIcons.userDoctor, size: 22, color: AppColors.primary),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            personal.fullNameEnglish,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.w800),
                          ),
                          Text(
                            professional.specialization,
                            style: AppTextStyles.bodySmall.copyWith(color: AppColors.primary, fontWeight: FontWeight.w700),
                          ),
                          Text(
                            '${professional.yearsOfExperience ?? 0} Yrs Exp • ${personal.municipality}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary, fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                const Divider(height: 20),
                Row(
                  children: [
                    if (type == _StaffTabType.joinRequests) ...[
                      Expanded(
                        child: TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(foregroundColor: AppColors.error),
                          child: const Text('Decline', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12)),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: AppPrimaryButton(
                          label: 'Approve',
                          onPressed: () {
                            snackBar(context: context, message: 'Approved', type: SnackTypeEnum.success);
                          },
                        ),
                      ),
                    ] else if (type == _StaffTabType.medicalTeam) ...[
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.person_remove_rounded, size: 16),
                          label: const Text('Remove Staff Member'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.error,
                            side: const BorderSide(color: AppColors.error),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                    ] else if (type == _StaffTabType.sentInvites) ...[
                      const Expanded(
                        child: Text(
                          'Waiting Response...',
                          style: TextStyle(fontStyle: FontStyle.italic, color: Colors.orange, fontSize: 11, fontWeight: FontWeight.w600),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Cancel', style: TextStyle(color: AppColors.error, fontSize: 12, fontWeight: FontWeight.w700)),
                      ),
                    ],
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
