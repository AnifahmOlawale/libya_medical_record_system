import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:libya_medical_record_system/core/router/app_router.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';
import 'package:libya_medical_record_system/core/shared/widgets/app_primary_button.dart';
import 'package:libya_medical_record_system/core/shared/widgets/sliver_page_header.dart';
import 'package:libya_medical_record_system/data/models/demo_data.dart';
import 'package:libya_medical_record_system/data/models/institution_model.dart';
import 'package:libya_medical_record_system/data/models/professional_info_data.dart';
import 'package:libya_medical_record_system/data/models/user_registration_model.dart';
import 'package:libya_medical_record_system/data/models/user_workplace.dart';
import 'package:libya_medical_record_system/data/models/working_time_data.dart';

class ExpertDetailPage extends StatelessWidget {
  const ExpertDetailPage({super.key, required this.expert});

  final UserRegistrationModel expert;

  @override
  Widget build(BuildContext context) {
    final personal = expert.personalInfo!;
    final professional = expert.professionalInfo!;

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: !kIsWeb,
            stretch: true,
            backgroundColor: AppColors.primary,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            leading: kIsWeb
                ? null
                : IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                    ),
                    onPressed: () => context.pop(),
                  ),
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [StretchMode.blurBackground],
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [AppColors.primaryDark, AppColors.primary],
                      ),
                    ),
                  ),
                  Positioned(
                    top: -50,
                    right: -50,
                    child: CircleAvatar(
                      radius: 120,
                      backgroundColor: Colors.white.withValues(alpha: 0.05),
                    ),
                  ),
                  Positioned(
                    bottom: 40,
                    left: -30,
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.white.withValues(alpha: 0.03),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 24),
                      Hero(
                        tag: 'expert_${personal.fullNameEnglish}',
                        child: const CircleAvatar(
                          backgroundColor: Colors.white70,
                          radius: 80,
                          child: CircleAvatar(
                            radius: 75,
                            backgroundColor: AppColors.primary,
                            child: FaIcon(
                              FontAwesomeIcons.userDoctor,
                              size: 80,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildExpertPrimaryInfo(personal, professional),
                  const SizedBox(height: 32),
                  _buildAboutSection(
                    professional.aboutMe ?? 'No information provided.',
                  ),
                  const SizedBox(height: 24),
                  if (professional.weeklySchedule != null) ...[
                    _buildWorkSchedule(professional.weeklySchedule!),
                    const SizedBox(height: 24),
                  ],
                  if (expert.workplaces.isNotEmpty) ...[
                    _buildWorkplacesSection(context, expert.workplaces),
                    const SizedBox(height: 24),
                  ],
                  _buildProfessionalExperience(professional),
                  const SizedBox(height: 40),
                  AppPrimaryButton(
                    label: 'Make Appointment',
                    onPressed: () {
                      // Logic for starting appointment flow
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

  Widget _buildWorkplacesSection(
    BuildContext context,
    List<UserWorkplace> workplaces,
  ) {
    return _buildPremiumCard(
      title: 'Affiliated Institutions',
      icon: FontAwesomeIcons.hospital,
      iconColor: AppColors.primary,
      children: [
        for (int i = 0; i < workplaces.length; i++) ...[
          _buildAffiliationTile(context, workplaces[i]),
          if (i < workplaces.length - 1) _buildDivider(),
        ],
      ],
    );
  }

  Widget _buildAffiliationTile(BuildContext context, UserWorkplace workplace) {
    return InkWell(
      onTap: () {
        final institution = DemoData.institutions().firstWhere(
          (inst) => inst.id == workplace.institutionId,
          orElse:
              () => InstitutionModel(
                id: workplace.institutionId,
                name: workplace.institutionName,
                type: workplace.institutionType,
                location: workplace.location,
                specialization: 'General',
              ),
        );
        context.push(AppRoutes.institutionDetail, extra: institution);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    workplace.institutionName,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${workplace.position} • ${workplace.location}',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.check_circle_outline,
              color: AppColors.success,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      indent: 20,
      endIndent: 20,
      color: Colors.grey.shade100,
    );
  }

  Widget _buildWorkSchedule(WeeklySchedule schedule) {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    final scheduleData = [
      schedule.monday,
      schedule.tuesday,
      schedule.wednesday,
      schedule.thursday,
      schedule.friday,
      schedule.saturday,
      schedule.sunday,
    ];

    return _buildPremiumCard(
      title: 'Availability',
      icon: FontAwesomeIcons.calendarCheck,
      iconColor: AppColors.nurseTint,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: List.generate(days.length, (index) {
              final workTime = scheduleData[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    SizedBox(
                      width: 50,
                      child: Text(
                        days[index],
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                          color: workTime.isActive
                              ? AppColors.textPrimary
                              : AppColors.textDisabled,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: workTime.isActive
                              ? AppColors.primarySurface.withValues(alpha: 0.5)
                              : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              workTime.isActive &&
                                      workTime.startTime != null &&
                                      workTime.endTime != null
                                  ? '${_formatTime(workTime.startTime!)} - ${_formatTime(workTime.endTime!)}'
                                  : 'Not Available',
                              style: AppTextStyles.bodySmall.copyWith(
                                fontWeight: workTime.isActive
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                                color: workTime.isActive
                                    ? AppColors.primaryDark
                                    : AppColors.textSecondary,
                              ),
                            ),
                            if (workTime.isActive)
                              const Icon(
                                Icons.circle,
                                size: 8,
                                color: AppColors.success,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildPremiumCard({
    required String title,
    required dynamic icon,
    required Color iconColor,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: iconColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: icon is IconData
                      ? Icon(icon, color: iconColor, size: 18)
                      : FaIcon(icon, color: iconColor, size: 18),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: AppTextStyles.headlineSmall.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          ...children,
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildAboutSection(String about) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('About Me'),
        const SizedBox(height: 12),
        Text(
          about,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildProfessionalExperience(ProfessionalInfoData professional) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Professional Experience'),
        const SizedBox(height: 16),
        _buildInfoTile(
          FontAwesomeIcons.briefcase,
          'Clinical Experience',
          '${professional.yearsOfExperience ?? 0} Years',
        ),
        _buildInfoTile(
          FontAwesomeIcons.stethoscope,
          'Primary Specialization',
          professional.specialization,
        ),
      ],
    );
  }

  Widget _buildExpertPrimaryInfo(dynamic personal, dynamic professional) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          personal.fullNameEnglish,
          textAlign: TextAlign.center,
          style: AppTextStyles.displayMedium.copyWith(
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          professional.specialization,
          style: AppTextStyles.titleMedium.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildStatItem('Rating', '4.9', Icons.star_rounded, Colors.orange),
            Container(
              height: 24,
              width: 1,
              color: Colors.grey.withValues(alpha: 0.3),
              margin: const EdgeInsets.symmetric(horizontal: 24),
            ),
            _buildStatItem(
              'Reviews',
              '124',
              Icons.chat_bubble_rounded,
              Colors.blue,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatItem(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(width: 4),
            Text(
              value,
              style: AppTextStyles.titleSmall.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(label, style: AppTextStyles.caption),
      ],
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
                : FaIcon(icon, size: 16, color: AppColors.primary),
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

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:${time.minute.toString().padLeft(2, '0')} $period';
  }
}
