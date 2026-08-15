import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:libya_medical_record_system/core/router/app_router.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';
import 'package:libya_medical_record_system/data/models/demo_data.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    final userData = DemoData.currentUser();
    final personalInfo = userData.personalInfo;
    final professionalInfo = userData.professionalInfo;
    final medicalInfo = userData.medicalInfo;

    final bool isProfessional = professionalInfo != null;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.primary.withValues(alpha: 0.8)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => context.push(AppRoutes.usersProfile),
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Avatar
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                      ),
                      child: CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.white,
                        child: FaIcon(
                          isProfessional
                              ? FontAwesomeIcons.userDoctor
                              : FontAwesomeIcons.user,
                          size: 40,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Name and ID
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            personalInfo?.fullNameEnglish ?? 'User',
                            style: AppTextStyles.titleLarge.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'ID: ${personalInfo?.nationalId ?? 'N/A'}',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: Colors.white70,
                            ),
                          ),
                          if (isProfessional)
                            Text(
                              professionalInfo.specialization,
                              style: AppTextStyles.bodySmall.copyWith(
                                color: Colors.white.withValues(alpha: 0.9),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Divider(color: Colors.white30, height: 1),
                const SizedBox(height: 16),
                // Blood Info Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildBloodInfoItem(
                      icon: FontAwesomeIcons.droplet,
                      label: 'Blood Type',
                      value: medicalInfo?.bloodType ?? 'N/A',
                    ),
                    Container(width: 1, height: 40, color: Colors.white30),
                    _buildBloodInfoItem(
                      icon: FontAwesomeIcons.dna,
                      label: 'Genotype',
                      value: medicalInfo?.genotype ?? 'N/A',
                    ),
                    Container(width: 1, height: 40, color: Colors.white30),
                    _buildBloodInfoItem(
                      icon: FontAwesomeIcons.heartPulse,
                      label: 'Rh Factor',
                      value: (medicalInfo?.bloodType ?? '').contains('+')
                          ? 'Positive'
                          : 'Negative',
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

  Widget _buildBloodInfoItem({
    required dynamic icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        icon is IconData
            ? Icon(icon, color: Colors.white, size: 20)
            : FaIcon(icon, color: Colors.white, size: 20),
        const SizedBox(height: 8),
        Text(
          value,
          style: AppTextStyles.titleMedium.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(color: Colors.white70),
        ),
      ],
    );
  }
}
