import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';
import 'package:libya_medical_record_system/core/shared/widgets/snack_bar.dart';
import 'package:libya_medical_record_system/features/permissions/widgets/generate_token_dialog.dart';
import 'package:libya_medical_record_system/features/permissions/widgets/qr_code_display.dart';

class PermissionsPage extends StatelessWidget {
  const PermissionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildPremiumHeader(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildGrantAccessCard(context),
                  const SizedBox(height: 32),
                  Text(
                    'Recent Access Tokens',
                    style: AppTextStyles.titleMedium.copyWith(
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildTokenList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumHeader(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: !kIsWeb,
      backgroundColor: AppColors.primary,
      elevation: 0,
      leading: kIsWeb
          ? null
          : IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
                size: 20,
              ),
              onPressed: () => context.pop(),
            ),
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          'Records Access',
          style: AppTextStyles.titleLarge.copyWith(color: Colors.white),
        ),
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
              right: -20,
              top: -20,
              child: FaIcon(
                FontAwesomeIcons.key,
                size: 150,
                color: Colors.white.withValues(alpha: 0.1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGrantAccessCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.25),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 32,
            backgroundColor: Colors.white,
            child: FaIcon(
              FontAwesomeIcons.userShield,
              color: AppColors.primary,
              size: 28,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Grant Clinical Access',
            style: AppTextStyles.titleLarge.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Generate a secure 6-digit token to allow a doctor to view your records temporarily.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall.copyWith(
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const GenerateTokenDialog(),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.primary,
              minimumSize: const Size(double.infinity, 56),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              elevation: 0,
            ),
            child: Text(
              'Generate Access Token',
              style: AppTextStyles.labelLarge.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTokenList() {
    // Mock data for display
    final tokens = [
      {
        'code': '884 102 234 175 846 152 142 209',
        'status': 'Active',
        'expiry': '12 Aug, 11:45 AM',
        'doctor': 'Pending Use',
        'modules': 'Medical Information, Vitals',
      },
      {
        'code': '884 102 234 175 846 152 142 209',
        'status': 'Used',
        'expiry': '12 Aug, 09:30 AM',
        'doctor': 'Dr. Ahmed Al-Zahrani (ID: DOC-402)',
        'modules': 'Vitals, Lab Tests',
      },
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tokens.length,
      itemBuilder: (context, index) {
        final token = tokens[index];
        final isActive = token['status'] == 'Active';

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isActive
                  ? AppColors.primary.withValues(alpha: 0.1)
                  : Colors.transparent,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      token['code']!,
                      style: AppTextStyles.headlineMedium.copyWith(
                        letterSpacing: token['code']!.length > 10 ? 0 : 2,
                        fontWeight: FontWeight.w900,
                        color: isActive
                            ? AppColors.primary
                            : AppColors.textDisabled,
                        fontSize: token['code']!.length > 12 ? 14 : 18,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 12),
                  if (isActive) ...[
                    _buildActionButton(
                      icon: FontAwesomeIcons.qrcode,
                      color: AppColors.primary,
                      onTap: () => _showQRCodeDialog(context, token['code']!),
                    ),
                    const SizedBox(width: 8),
                    _buildActionButton(
                      icon: FontAwesomeIcons.copy,
                      color: AppColors.primary,
                      onTap: () {
                        Clipboard.setData(
                          ClipboardData(
                            text: token['code']!.replaceAll(' ', ''),
                          ),
                        );
                        snackBar(
                          context: context,
                          message: 'Token copied to clipboard',
                          type: SnackTypeEnum.success,
                        );
                      },
                    ),
                    const SizedBox(width: 8),
                    _buildActionButton(
                      icon: FontAwesomeIcons.shareNodes,
                      color: AppColors.primary,
                      onTap: () {
                        snackBar(
                          context: context,
                          message: 'Sharing feature coming soon',
                        );
                      },
                    ),
                  ],
                  const SizedBox(width: 8),
                  _buildActionButton(
                    icon: FontAwesomeIcons.trashCan,
                    color: AppColors.error,
                    onTap: () {
                      snackBar(
                        context: context,
                        message: 'Token deleted successfully',
                        type: SnackTypeEnum.error,
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: isActive
                          ? AppColors.primary.withValues(alpha: 0.1)
                          : AppColors.textDisabled.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      token['status']!.toUpperCase(),
                      style: AppTextStyles.labelSmall.copyWith(
                        color: isActive
                            ? AppColors.primary
                            : AppColors.textDisabled,
                        fontWeight: FontWeight.w900,
                        fontSize: 8,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(height: 32),
              _buildDetailRow(
                FontAwesomeIcons.clock,
                token['expiry']!,
                Colors.orange,
              ),
              const SizedBox(height: 12),
              _buildDetailRow(
                FontAwesomeIcons.userDoctor,
                token['doctor']!,
                Colors.blue,
              ),
              const SizedBox(height: 12),
              _buildDetailRow(
                FontAwesomeIcons.layerGroup,
                token['modules']!,
                Colors.purple,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(dynamic icon, String text, Color iconColor) {
    return Row(
      children: [
        icon is IconData
            ? Icon(icon, size: 12, color: iconColor.withValues(alpha: 0.6))
            : FaIcon(icon, size: 12, color: iconColor.withValues(alpha: 0.6)),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required dynamic icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12),
        ),
        child: icon is IconData
            ? Icon(icon, size: 14, color: color)
            : FaIcon(icon, size: 14, color: color),
      ),
    );
  }

  void _showQRCodeDialog(BuildContext context, String token) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                constraints: const BoxConstraints(maxWidth: 400),
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Access QR Code',
                      style: AppTextStyles.titleLarge.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Show this to the doctor to grant access',
                      style: AppTextStyles.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    QrCodeDisplay(token: token),
                  ],
                ),
              ),
              Positioned(
                right: 12,
                top: 12,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close_rounded),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.grey.shade100,
                    iconSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
