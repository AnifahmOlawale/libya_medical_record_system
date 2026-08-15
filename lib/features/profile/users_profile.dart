import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:libya_medical_record_system/core/router/app_router.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';
import 'package:libya_medical_record_system/data/models/demo_data.dart';
import 'package:libya_medical_record_system/data/models/user_workplace.dart';
import 'package:libya_medical_record_system/data/models/working_time_data.dart';

class UsersProfile extends StatelessWidget {
  const UsersProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final userData = DemoData.currentUser();
    final personalInfo = userData.personalInfo;
    final medicalInfo = userData.medicalInfo;
    final professionalInfo = userData.professionalInfo;

    if (personalInfo == null) {
      return const Scaffold(body: Center(child: Text('Profile not found')));
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildPremiumHeader(context, personalInfo, medicalInfo),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  _buildPersonalInfoSection(personalInfo, medicalInfo),
                  const SizedBox(height: 24),
                  if (professionalInfo != null) ...[
                    _buildProfessionalInfoSection(professionalInfo),
                    const SizedBox(height: 24),
                    if (userData.workplaces.isNotEmpty) ...[
                      _buildWorkplacesSection(userData.workplaces),
                      const SizedBox(height: 24),
                    ],
                    if (professionalInfo.weeklySchedule != null) ...[
                      _buildWorkSchedule(professionalInfo.weeklySchedule!),
                      const SizedBox(height: 24),
                    ],
                  ],
                  if (medicalInfo != null) ...[
                    _buildMedicalHighlights(medicalInfo),
                    const SizedBox(height: 24),
                  ],
                  _buildContactInfoSection(personalInfo),
                  if (medicalInfo != null) ...[
                    const SizedBox(height: 24),
                    _buildPhysicalLifestyleSection(medicalInfo),
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

  Widget _buildPremiumHeader(
    BuildContext context,
    dynamic personalInfo,
    dynamic medicalInfo,
  ) {
    return SliverAppBar(
      expandedHeight: 320,
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
      actions: kIsWeb
          ? []
          : [
              IconButton(
                icon: const Icon(Icons.edit_outlined, color: Colors.white),
                onPressed: () => context.push(AppRoutes.editProfile),
              ),
            ],
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [
          StretchMode.zoomBackground,
          StretchMode.blurBackground,
        ],
        background: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.primary, AppColors.primaryDark],
                ),
              ),
            ),
            Positioned(
              top: -40,
              left: -40,
              child: CircleAvatar(
                radius: 100,
                backgroundColor: Colors.white.withValues(alpha: 0.05),
              ),
            ),
            Positioned(
              bottom: 20,
              right: -30,
              child: CircleAvatar(
                radius: 70,
                backgroundColor: Colors.white.withValues(alpha: 0.03),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                _buildAvatar(),
                const SizedBox(height: 16),
                Text(
                  personalInfo.fullNameEnglish,
                  style: AppTextStyles.headlineLarge.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  personalInfo.occupation,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildHeaderStat(
                      'Blood Type',
                      medicalInfo?.bloodType ?? '--',
                    ),
                    _buildHeaderDivider(),
                    _buildHeaderStat('Gender', medicalInfo?.gender ?? '--'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.primaryLight, width: 2),
        ),
        child: const CircleAvatar(
          radius: 50,
          backgroundColor: AppColors.background,
          child: FaIcon(
            FontAwesomeIcons.user,
            size: 50,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: AppTextStyles.titleMedium.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          label,
          style: AppTextStyles.labelSmall.copyWith(
            color: Colors.white.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderDivider() {
    return Container(
      height: 24,
      width: 1,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      color: Colors.white.withValues(alpha: 0.2),
    );
  }

  Widget _buildMedicalHighlights(dynamic medicalInfo) {
    return _buildPremiumCard(
      title: 'Medical Summary',
      icon: FontAwesomeIcons.heartPulse,
      iconColor: Colors.red.shade400,
      children: [
        Row(
          children: [
            Expanded(child: _buildInfoTile('Genotype', medicalInfo.genotype)),
            Expanded(
              child: _buildInfoTile('Blood Group', medicalInfo.bloodType),
            ),
          ],
        ),
        _buildDivider(),
        _buildInfoTile(
          'Disability Status',
          medicalInfo.disabilityStatus,
          subtitle: 'Verified Medical Record',
          trailingIcon: Icons.info_outline_rounded,
        ),
        if (medicalInfo.lastBloodDonationDate != null) ...[
          _buildDivider(),
          _buildInfoTile(
            'Last Blood Donation',
            _formatDate(medicalInfo.lastBloodDonationDate!),
            trailingIcon: FontAwesomeIcons.droplet,
          ),
        ],
      ],
    );
  }

  Widget _buildProfessionalInfoSection(dynamic professionalInfo) {
    return _buildPremiumCard(
      title: 'Professional Experience',
      icon: FontAwesomeIcons.briefcase,
      iconColor: AppColors.doctorTint,
      children: [
        _buildInfoTile(
          'Specialization',
          professionalInfo.specialization,
          subtitle: 'Verified Healthcare Provider',
          trailingIcon: Icons.verified_rounded,
        ),
        _buildDivider(),
        _buildInfoTile(
          'Experience',
          '${professionalInfo.yearsOfExperience ?? 0} Years',
          subtitle: 'Clinical Practice Duration',
        ),
        if (professionalInfo.aboutMe != null &&
            professionalInfo.aboutMe.isNotEmpty) ...[
          _buildDivider(),
          _buildInfoTile('About', professionalInfo.aboutMe),
        ],
      ],
    );
  }

  Widget _buildWorkplacesSection(List<UserWorkplace> workplaces) {
    return _buildPremiumCard(
      title: 'Affiliated Institutions',
      icon: FontAwesomeIcons.hospital,
      iconColor: AppColors.primary,
      children: [
        for (int i = 0; i < workplaces.length; i++) ...[
          _buildInfoTile(
            workplaces[i].institutionName,
            workplaces[i].position,
            subtitle:
                '${workplaces[i].institutionType} • ${workplaces[i].location}',
            trailingIcon: switch (workplaces[i].status) {
              WorkplaceApprovalStatus.approved => Icons.check_circle_outline,
              WorkplaceApprovalStatus.pending => Icons.access_time,
              WorkplaceApprovalStatus.rejected => Icons.cancel_outlined,
            },
            trailingIconColor: switch (workplaces[i].status) {
              WorkplaceApprovalStatus.approved => AppColors.success,
              WorkplaceApprovalStatus.pending => Colors.orange,
              WorkplaceApprovalStatus.rejected => AppColors.error,
            },
          ),
          if (i < workplaces.length - 1) _buildDivider(),
        ],
      ],
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

  Widget _buildPersonalInfoSection(dynamic personalInfo, dynamic medicalInfo) {
    return _buildPremiumCard(
      title: 'Personal Information',
      icon: FontAwesomeIcons.userCheck,
      iconColor: AppColors.primary,
      children: [
        _buildInfoTile('National ID', personalInfo.nationalId),
        _buildDivider(),
        _buildInfoTile('Full Name (Arabic)', personalInfo.fullNameArabic),
        _buildDivider(),
        _buildInfoTile('Date of Birth', _formatDate(personalInfo.dateOfBirth)),
        _buildDivider(),
        _buildInfoTile(
          'Place of Birth',
          personalInfo.placeOfBirth ?? 'Not Specified',
        ),
        _buildDivider(),
        _buildInfoTile(
          'Marital Status',
          medicalInfo?.maritalStatus ?? 'Not Specified',
        ),
        _buildDivider(),
        _buildInfoTile('Occupation', personalInfo.occupation),
      ],
    );
  }

  Widget _buildContactInfoSection(dynamic personalInfo) {
    return _buildPremiumCard(
      title: 'Contact Details',
      icon: FontAwesomeIcons.addressBook,
      iconColor: AppColors.accent,
      children: [
        _buildInfoTile(
          'Primary Phone',
          personalInfo.primaryPhoneNumber,
          isCopyable: true,
        ),
        if (personalInfo.secondaryPhoneNumber != null) ...[
          _buildDivider(),
          _buildInfoTile(
            'Secondary Phone',
            personalInfo.secondaryPhoneNumber!,
            isCopyable: true,
          ),
        ],
        _buildDivider(),
        _buildInfoTile('Email Address', personalInfo.email, isCopyable: true),
        _buildDivider(),
        _buildInfoTile('Residential Address', personalInfo.residentialAddress),
        _buildDivider(),
        _buildInfoTile('Municipality', personalInfo.municipality),
      ],
    );
  }

  Widget _buildPhysicalLifestyleSection(dynamic medicalInfo) {
    return _buildPremiumCard(
      title: 'Physical & Lifestyle',
      icon: FontAwesomeIcons.dna,
      iconColor: Colors.purple.shade400,
      children: [
        Row(
          children: [
            Expanded(
              child: _buildInfoTile('Height', '${medicalInfo.height} cm'),
            ),
            Expanded(
              child: _buildInfoTile('Weight', '${medicalInfo.weight} kg'),
            ),
          ],
        ),
        _buildDivider(),
        _buildInfoTile('Smoking Status', medicalInfo.smokingStatus),
        _buildDivider(),
        _buildInfoTile('Alcohol Use', medicalInfo.alcoholUse),
        if (medicalInfo.gender == 'Female') ...[
          _buildDivider(),
          _buildInfoTile('Pregnancy Status', medicalInfo.pregnancyStatus),
        ],
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

  Widget _buildInfoTile(
    String label,
    String value, {
    String? subtitle,
    dynamic trailingIcon,
    Color? trailingIconColor,
    bool isCopyable = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                const SizedBox(height: 2),
                Text(
                  value,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (trailingIcon != null)
            trailingIcon is IconData
                ? Icon(
                    trailingIcon,
                    color:
                        trailingIconColor ??
                        AppColors.primary.withValues(alpha: 0.6),
                    size: 20,
                  )
                : FaIcon(
                    trailingIcon,
                    color:
                        trailingIconColor ??
                        AppColors.primary.withValues(alpha: 0.6),
                    size: 16,
                  )
          else if (isCopyable)
            Icon(
              Icons.copy_rounded,
              color: AppColors.primary.withValues(alpha: 0.4),
              size: 18,
            ),
        ],
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

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:${time.minute.toString().padLeft(2, '0')} $period';
  }
}
