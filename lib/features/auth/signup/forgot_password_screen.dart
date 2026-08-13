import 'package:flutter/material.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';
import 'package:libya_medical_record_system/core/shared/widgets/ambient_gradient_background.dart';
import 'package:libya_medical_record_system/core/shared/widgets/app_primary_button.dart';
import 'package:libya_medical_record_system/core/shared/widgets/snack_bar.dart';
import 'package:libya_medical_record_system/core/shared/widgets/text_field_form.dart';
import 'package:libya_medical_record_system/core/util/validators.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key, this.onBackToLogin, this.onResetSent});

  /// Called to navigate back to the login screen.
  final VoidCallback? onBackToLogin;

  /// Called after a password reset email has been successfully sent.
  final ValueChanged<String>? onResetSent;

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handleResetPassword() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    setState(() => _isLoading = true);

    try {
      // TODO: replace with the real auth repository call.
      await Future<void>.delayed(const Duration(seconds: 2));

      if (!mounted) return;

      // Success feedback
      snackBar(
        context: context,
        message: 'Password reset link sent to your email.',
        type: SnackTypeEnum.success,
      );

      widget.onResetSent?.call(_emailController.text.trim());
    } catch (e) {
      if (!mounted) return;
      snackBar(
        context: context,
        message: 'Failed to send reset link.',
        type: SnackTypeEnum.error,
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: AmbientGradientBackground(
        child: SafeArea(
          child: Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(32, 48, 32, 32),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Back Button
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          onPressed: _isLoading ? null : widget.onBackToLogin,
                          icon: const Icon(Icons.arrow_back_ios_new_rounded),
                          color: AppColors.textPrimary,
                          iconSize: 20,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Icon
                      Center(
                        child: Container(
                          width: 72,
                          height: 72,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                AppColors.primaryLight,
                                AppColors.primary,
                                AppColors.primaryDark,
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withValues(alpha: 0.3),
                                blurRadius: 15,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.lock_reset_rounded,
                            color: Colors.white,
                            size: 36,
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Title
                      Text(
                        'Forgot Password',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.displayMedium.copyWith(
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -1,
                          color: AppColors.textPrimary,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Text(
                        'Enter your email address and we\'ll send you instructions to reset your password.',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: AppColors.textSecondary,
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 48),

                      // Email
                      Text(
                        'Email address',
                        style: AppTextStyles.labelLarge.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 10),

                      textFormField(
                        context: context,
                        enabled: !_isLoading,
                        readOnly: false,
                        hintText: 'you@example.com',
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => _handleResetPassword(),
                        prefixIcon: const Icon(
                          Icons.mail_outline_rounded,
                          color: AppColors.textSecondary,
                        ),
                        validator: FormValidators.email,
                      ),

                      const SizedBox(height: 40),

                      // Button
                      AppPrimaryButton(
                        label: _isLoading ? 'Sending...' : 'Reset Password',
                        isLoading: _isLoading,
                        onPressed: _handleResetPassword,
                      ),

                      const SizedBox(height: 24),

                      // Back to login link
                      Center(
                        child: TextButton(
                          onPressed: _isLoading ? null : widget.onBackToLogin,
                          child: Text(
                            'Back to Login',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
