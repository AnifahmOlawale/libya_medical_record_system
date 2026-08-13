import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';
import 'package:libya_medical_record_system/core/shared/widgets/app_primary_button.dart';
import 'package:libya_medical_record_system/data/models/professional_info_data.dart';
import 'package:libya_medical_record_system/data/models/user_registration_model.dart';
import 'package:libya_medical_record_system/data/models/working_time_data.dart';

import 'package:libya_medical_record_system/core/shared/widgets/sliver_page_header.dart';

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
          SliverPageHeader(
            title: personal.fullNameEnglish,
            expandedHeight: 250,
            hideTitleOnWeb: true,
            centerExtraOnWeb: true,
            extra: Hero(
              tag: 'expert_${personal.fullNameEnglish}',
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: kIsWeb
                      ? AppColors.primary.withValues(alpha: 0.1)
                      : Colors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: kIsWeb ? AppColors.primary : Colors.white,
                    width: 4,
                  ),
                ),
                child: Icon(
                  Icons.person_rounded,
                  size: 80,
                  color: kIsWeb ? AppColors.primary : Colors.white,
                ),
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
                    _buildAvailabilitySection(professional.weeklySchedule!),
                    const SizedBox(height: 24),
                  ],
                  _buildProfessionalCredentials(professional),
                  const SizedBox(height: 32),
                  _buildContactSection(professional),
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

  Widget _buildAvailabilitySection(WeeklySchedule schedule) {
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

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const FaIcon(
                FontAwesomeIcons.calendarCheck,
                color: AppColors.primary,
                size: 16,
              ),
              const SizedBox(width: 10),
              Text(
                'Weekly Availability',
                style: AppTextStyles.headlineSmall.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Column(
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
        ],
      ),
    );
  }

  Widget _buildProfessionalCredentials(ProfessionalInfoData professional) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Professional Details'),
        const SizedBox(height: 16),
        _buildInfoTile(
          FontAwesomeIcons.idCard,
          'License Number',
          professional.licenseNumber ?? 'N/A',
        ),
        _buildInfoTile(
          FontAwesomeIcons.briefcase,
          'Experience',
          '${professional.yearsOfExperience ?? 0} Years',
        ),
        _buildInfoTile(
          FontAwesomeIcons.hospital,
          'Institution',
          professional.institutionName,
        ),
        _buildInfoTile(
          FontAwesomeIcons.mapLocationDot,
          'Office Address',
          professional.officeAddress ?? 'N/A',
        ),
      ],
    );
  }

  Widget _buildContactSection(ProfessionalInfoData professional) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Contact Information'),
        const SizedBox(height: 16),
        _buildInfoTile(
          FontAwesomeIcons.envelope,
          'Work Email',
          professional.workEmail ?? 'N/A',
        ),
        _buildInfoTile(
          FontAwesomeIcons.phone,
          'Work Phone',
          professional.workPhoneNumber ?? 'N/A',
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
          professional.departmentOrSpecialty ?? professional.professionalRole,
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
