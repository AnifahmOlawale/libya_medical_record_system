import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';
import 'package:libya_medical_record_system/core/shared/widgets/ambient_gradient_background.dart';
import 'package:libya_medical_record_system/core/shared/widgets/app_primary_button.dart';
import 'package:libya_medical_record_system/core/shared/widgets/snack_bar.dart';

class ClinicalAccessEntryPage extends StatefulWidget {
  const ClinicalAccessEntryPage({super.key});

  @override
  State<ClinicalAccessEntryPage> createState() =>
      _ClinicalAccessEntryPageState();
}

class _ClinicalAccessEntryPageState extends State<ClinicalAccessEntryPage> {
  final TextEditingController _tokenController = TextEditingController();
  bool _isLoading = false;

  void _handleAccess() async {
    if (_tokenController.text.trim().isEmpty) {
      snackBar(
        context: context,
        message: 'Please enter a valid access token',
        type: SnackTypeEnum.error,
      );
      return;
    }

    setState(() => _isLoading = true);

    // Simulate verification
    await Future.delayed(const Duration(seconds: 2));

    setState(() => _isLoading = false);

    if (mounted) {
      snackBar(
        context: context,
        message: 'Access Granted. Redirecting to patient records...',
        type: SnackTypeEnum.success,
      );
      // In a real app, you'd navigate to the patient records view here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AmbientGradientBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: IconButton(
                  onPressed: () => context.pop(),
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.all(12),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: FaIcon(
                          FontAwesomeIcons.shield,
                          color: AppColors.primary,
                          size: 40,
                        ),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        'Secure Clinical Access',
                        style: AppTextStyles.displayMedium.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Enter the 6-digit token or UUID provided by the patient to view their records.',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 48),

                      // QR Scan Option
                      _buildScanOption(),

                      const SizedBox(height: 32),
                      Row(
                        children: [
                          const Expanded(child: Divider()),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'OR ENTER MANUALLY',
                              style: AppTextStyles.labelSmall.copyWith(
                                color: AppColors.textDisabled,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          const Expanded(child: Divider()),
                        ],
                      ),
                      const SizedBox(height: 32),

                      // Token Input
                      TextField(
                        controller: _tokenController,
                        decoration: InputDecoration(
                          hintText: 'Enter Access Token',
                          prefixIcon: const Icon(
                            Icons.key_rounded,
                            color: AppColors.primary,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: const BorderSide(
                              color: AppColors.primary,
                              width: 2,
                            ),
                          ),
                        ),
                        style: AppTextStyles.titleMedium.copyWith(
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w800,
                        ),
                      ),

                      const SizedBox(height: 32),
                      AppPrimaryButton(
                        label: 'Verify & Access',
                        isLoading: _isLoading,
                        onPressed: _handleAccess,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScanOption() {
    return InkWell(
      onTap: () {
        snackBar(context: context, message: 'Camera scanner initializing...');
      },
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.1),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const FaIcon(
                FontAwesomeIcons.qrcode,
                color: AppColors.primary,
                size: 24,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Scan QR Code',
                    style: AppTextStyles.titleMedium.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    'Use camera to scan patient\'s code',
                    style: AppTextStyles.bodySmall,
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: AppColors.textDisabled,
            ),
          ],
        ),
      ),
    );
  }
}
