import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';
import 'package:libya_medical_record_system/data/models/demo_data.dart';
import 'package:libya_medical_record_system/data/models/working_time_data.dart';

class MedicalStaffUserProfile extends StatelessWidget {
  const MedicalStaffUserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final userData = DemoData.professionalUser();
    final personalInfo = userData.personalInfo;
    final professionalInfo = userData.professionalInfo;

    if (personalInfo == null || professionalInfo == null) {
      return const Scaffold(body: Center(child: Text('Profile not found')));
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildPremiumHeader(context, personalInfo, professionalInfo),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  if (professionalInfo.aboutMe != null) ...[
                    _buildAboutSection(professionalInfo.aboutMe!),
                    const SizedBox(height: 24),
                  ],
                  _buildProfessionalCredentials(professionalInfo),
                  const SizedBox(height: 24),
                  if (professionalInfo.weeklySchedule != null) ...[
                    _buildWorkSchedule(professionalInfo.weeklySchedule!),
                    const SizedBox(height: 24),
                  ],
                  _buildPersonalInfoSection(personalInfo),
                  const SizedBox(height: 24),
                  _buildContactInfoSection(personalInfo),
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
    dynamic professionalInfo,
  ) {
    return SliverAppBar(
      expandedHeight: 340,
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
                icon: const Icon(Icons.share_outlined, color: Colors.white),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.more_vert_rounded, color: Colors.white),
                onPressed: () {},
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
            // Gradient Background
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.primaryDark, AppColors.primary],
                ),
              ),
            ),
            // Abstract decorations
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
            // Content
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
                _buildProfileAvatar(),
                const SizedBox(height: 16),
                Text(
                  personalInfo.fullNameEnglish,
                  style: AppTextStyles.headlineLarge.copyWith(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.verified_rounded,
                        color: Colors.white,
                        size: 14,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        professionalInfo.departmentOrSpecialty ??
                            'Medical Staff',
                        style: AppTextStyles.labelMedium.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildHeaderStat(
                      'Experience',
                      '${professionalInfo.yearsOfExperience ?? 0} Yrs',
                    ),
                    _buildHeaderDivider(),
                    _buildHeaderStat(
                      'Institution',
                      professionalInfo.institutionName.split(' ').first,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileAvatar() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 130,
          height: 130,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: const CircleAvatar(
            backgroundColor: Colors.white,
            child: FaIcon(
              FontAwesomeIcons.userDoctor,
              size: 60,
              color: AppColors.primary,
            ),
          ),
        ),
        Positioned(
          bottom: 5,
          right: 5,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_circle_rounded,
              color: AppColors.success,
              size: 24,
            ),
          ),
        ),
      ],
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
      height: 30,
      width: 1,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      color: Colors.white.withValues(alpha: 0.2),
    );
  }

  Widget _buildAboutSection(String about) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const FaIcon(
                FontAwesomeIcons.quoteLeft,
                color: AppColors.primary,
                size: 16,
              ),
              const SizedBox(width: 10),
              Text(
                'Professional Summary',
                style: AppTextStyles.headlineSmall.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            about,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfessionalCredentials(dynamic professionalInfo) {
    return _buildPremiumCard(
      title: 'Professional Info',
      icon: FontAwesomeIcons.briefcase,
      iconColor: AppColors.doctorTint,
      children: [
        _buildInfoTile(
          'Medical License',
          professionalInfo.licenseNumber ?? 'N/A',
          subtitle: 'Verified by Ministry of Health',
          trailingIcon: Icons.verified_user_rounded,
        ),
        _buildDivider(),
        _buildInfoTile(
          'Institution',
          professionalInfo.institutionName,
          subtitle: professionalInfo.officeAddress,
        ),
        _buildDivider(),
        _buildInfoTile(
          'Specialization',
          professionalInfo.departmentOrSpecialty ?? 'General',
          subtitle:
              '${professionalInfo.yearsOfExperience ?? 0} years of experience',
        ),
        _buildDivider(),
        _buildInfoTile(
          'Work Contact',
          professionalInfo.workEmail ?? 'N/A',
          subtitle: professionalInfo.workPhoneNumber,
        ),
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

  Widget _buildPersonalInfoSection(dynamic personalInfo) {
    return _buildPremiumCard(
      title: 'Personal Details',
      icon: FontAwesomeIcons.userGear,
      iconColor: AppColors.primary,
      children: [
        _buildInfoTile('National ID', personalInfo.nationalId),
        _buildDivider(),
        _buildInfoTile('Full Name (Ar)', personalInfo.fullNameArabic),
        _buildDivider(),
        _buildInfoTile('Date of Birth', _formatDate(personalInfo.dateOfBirth)),
        _buildDivider(),
        _buildInfoTile(
          'Gender',
          'Male',
        ), // hardcoded for demo as it's in medicalInfo usually
        _buildDivider(),
        _buildInfoTile(
          'Place of Birth',
          personalInfo.placeOfBirth ?? 'Tripoli',
        ),
      ],
    );
  }

  Widget _buildContactInfoSection(dynamic personalInfo) {
    return _buildPremiumCard(
      title: 'Contact Information',
      icon: FontAwesomeIcons.addressBook,
      iconColor: AppColors.accent,
      children: [
        _buildInfoTile(
          'Primary Phone',
          personalInfo.primaryPhoneNumber,
          isCopyable: true,
        ),
        _buildDivider(),
        _buildInfoTile('Email Address', personalInfo.email, isCopyable: true),
        _buildDivider(),
        _buildInfoTile('Residential Address', personalInfo.residentialAddress),
        _buildDivider(),
        _buildInfoTile('Municipality', personalInfo.municipality),
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
            Icon(trailingIcon, color: AppColors.primary, size: 20)
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
