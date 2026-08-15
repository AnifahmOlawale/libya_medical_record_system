import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:libya_medical_record_system/core/router/app_router.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';
import 'package:libya_medical_record_system/data/models/demo_data.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Widget _buildTile(
    BuildContext context, {
    required dynamic icon,
    required String title,
    VoidCallback? onTap,
    Color? iconColor,
    Color? titleColor,
  }) {
    return ListTile(
      leading: icon is IconData
          ? Icon(icon, color: iconColor ?? AppColors.primary)
          : FaIcon(icon, color: iconColor ?? AppColors.primary),
      title: Text(
        title,
        style: TextStyle(
          color: titleColor ?? Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right_rounded,
        color: AppColors.textSecondary,
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    final userData = DemoData.currentUser();
    final personalInfo = userData.personalInfo;
    final String displayName = personalInfo?.fullNameEnglish ?? 'User';
    final String displayEmail = personalInfo?.email ?? 'No email';
    final String displayPhone = personalInfo?.primaryPhoneNumber ?? 'No phone';

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header — avatar + name/email/phone centered inside ──
            GestureDetector(
              onTap: () => context.push(AppRoutes.usersProfile),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.primary, AppColors.primaryDark],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
                    child: Column(
                      children: [
                        // ── Avatar with camera overlay ──────────────
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundColor: AppColors.textOnPrimary
                                  .withValues(alpha: 0.2),
                              child: const CircleAvatar(
                                radius: 38,
                                child: FaIcon(
                                  FontAwesomeIcons.user,
                                  size: 38,
                                ),
                              ),
                            ),
                            Positioned(
                              right: -2,
                              bottom: -2,
                              child: GestureDetector(
                                onTap: () {
                                  // Logic to change profile picture
                                },
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryDark,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AppColors.textOnPrimary,
                                      width: 2,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt_rounded,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),

                        Text(
                          displayName,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.titleLarge.copyWith(
                            color: AppColors.textOnPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          displayEmail,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textOnPrimary.withValues(
                              alpha: 0.85,
                            ),
                          ),
                        ),
                        Text(
                          displayPhone,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textOnPrimary.withValues(
                              alpha: 0.85,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      'Account Settings',
                      style: AppTextStyles.headlineSmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                  Card(
                    child: Column(
                      children: [
                        _buildTile(
                          context,
                          icon: Icons.person_outline,
                          title: 'View Profile',
                          onTap: () => context.push(AppRoutes.usersProfile),
                        ),
                        const Divider(height: 1, indent: 56, endIndent: 16),
                        _buildTile(
                          context,
                          icon: Icons.vpn_key_outlined,
                          title: 'Permissions',
                          onTap: () => context.push(AppRoutes.permissions),
                        ),
                        const Divider(height: 1, indent: 56, endIndent: 16),
                        _buildTile(
                          context,
                          icon: Icons.lock_outline,
                          title: 'Change Password',
                          onTap: () {},
                        ),
                        const Divider(height: 1, indent: 56, endIndent: 16),
                        _buildTile(
                          context,
                          icon: Icons.notifications_outlined,
                          title: 'Notifications',
                          onTap: () {},
                        ),
                        const Divider(height: 1, indent: 56, endIndent: 16),
                        _buildTile(
                          context,
                          icon: Icons.language_outlined,
                          title: 'Change Language',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      'Support & Legal',
                      style: AppTextStyles.headlineSmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                  Card(
                    child: Column(
                      children: [
                        _buildTile(
                          context,
                          icon: Icons.info_outlined,
                          title: 'About Us',
                          onTap: () {},
                        ),
                        const Divider(height: 1, indent: 56, endIndent: 16),
                        _buildTile(
                          context,
                          icon: Icons.contact_support_outlined,
                          title: 'Contact Us',
                          onTap: () {},
                        ),
                        const Divider(height: 1, indent: 56, endIndent: 16),
                        _buildTile(
                          context,
                          icon: Icons.privacy_tip_outlined,
                          title: 'Privacy Policy',
                          onTap: () {},
                        ),
                        const Divider(height: 1, indent: 56, endIndent: 16),
                        _buildTile(
                          context,
                          icon: Icons.description_outlined,
                          title: 'Terms & Condition',
                          onTap: () {},
                        ),
                        const Divider(height: 1, indent: 56, endIndent: 16),
                        _buildTile(
                          context,
                          icon: Icons.star_outline,
                          title: 'Rate Us',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    child: Column(
                      children: [
                        _buildTile(
                          context,
                          icon: Icons.delete_outline,
                          title: 'Delete Account',
                          iconColor: AppColors.error,
                          titleColor: AppColors.error,
                          onTap: () {},
                        ),
                        const Divider(height: 1, indent: 56, endIndent: 16),
                        _buildTile(
                          context,
                          icon: Icons.logout_outlined,
                          title: 'Sign Out',
                          iconColor: AppColors.error,
                          titleColor: AppColors.error,
                          onTap: () => context.go(AppRoutes.login),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
