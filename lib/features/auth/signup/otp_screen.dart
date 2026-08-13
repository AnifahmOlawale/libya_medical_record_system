import 'dart:async';
import 'package:flutter/material.dart';
import 'package:libya_medical_record_system/core/shared/widgets/snack_bar.dart';
import 'package:pinput/pinput.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';
import 'package:libya_medical_record_system/core/shared/widgets/ambient_gradient_background.dart';
import 'package:libya_medical_record_system/core/shared/widgets/app_primary_button.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({
    super.key,
    required this.email,
    this.onBack,
    this.onVerify,
    this.onResend,
  });

  final String email;
  final VoidCallback? onBack;
  final ValueChanged<String>? onVerify;
  final VoidCallback? onResend;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _pinController = TextEditingController();
  final _focusNode = FocusNode();
  bool _isLoading = false;

  Timer? _timer;
  int _secondsRemaining = 60;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    setState(() => _secondsRemaining = 30);
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() => _secondsRemaining--);
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pinController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _handleResend() async {
    if (_secondsRemaining > 0 || _isLoading) return;

    widget.onResend?.call();
    _startTimer();
    snackBar(
      context: context,
      message: 'Verification code resent.',
      type: SnackTypeEnum.success,
    );
  }

  Future<void> _handleVerify() async {
    final pin = _pinController.text;
    if (pin.length < 6) return;

    setState(() => _isLoading = true);

    try {
      // TODO: replace with real verification call
      await Future<void>.delayed(const Duration(seconds: 2));

      if (!mounted) return;
      widget.onVerify?.call(pin);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Verification failed: $e')));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // OTP layout constants — kept together so the box-size math below
  // stays easy to follow.
  static const _pinLength = 6;
  static const _separatorWidth = 8.0;
  static const _outerHorizontalPadding = 32.0 * 2; // matches the padding below
  static const _maxBoxSize = 60.0;
  static const _minBoxSize = 44.0;

  @override
  Widget build(BuildContext context) {
    // Compute a box size that always fits 6 boxes + separators on the
    // actual screen width, so each box stays perfectly square
    // (width == height) instead of getting squeezed non-square or
    // overflowing on narrower phones.
    final screenWidth = MediaQuery.sizeOf(context).width;
    final usableWidth = screenWidth - _outerHorizontalPadding;
    final rawBoxSize =
        (usableWidth - _separatorWidth * (_pinLength - 1)) / _pinLength;
    final boxSize = rawBoxSize.clamp(_minBoxSize, _maxBoxSize);

    final defaultPinTheme = PinTheme(
      width: boxSize,
      height: boxSize,
      textStyle: AppTextStyles.headlineLarge.copyWith(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryDark,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.8),
        // Sharp corners for a true square box look (was
        // BorderRadius.circular(4)). focusedPinTheme and
        // submittedPinTheme below inherit this via .copyWith on this
        // same decoration, so changing it here is enough.
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: Colors.white,
        border: Border.all(color: AppColors.primary, width: 2.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.1),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: AppColors.primarySurface.withValues(alpha: 0.4),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.6),
          width: 1.5,
        ),
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      body: AmbientGradientBackground(
        child: SafeArea(
          child: Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(32, 48, 32, 32),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 440),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: _isLoading ? null : widget.onBack,
                        icon: const Icon(Icons.arrow_back_ios_new_rounded),
                        color: AppColors.textPrimary,
                        iconSize: 20,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ),
                    const SizedBox(height: 8),
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
                          Icons.mark_email_read_rounded,
                          color: Colors.white,
                          size: 36,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Verify Email',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.displayMedium.copyWith(
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -1,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text.rich(
                      TextSpan(
                        text: 'We\'ve sent a verification code to\n',
                        children: [
                          TextSpan(
                            text: widget.email,
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: AppColors.primaryDark,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 48),
                    Center(
                      child: Pinput(
                        controller: _pinController,
                        focusNode: _focusNode,
                        length: 6,
                        defaultPinTheme: defaultPinTheme,
                        focusedPinTheme: focusedPinTheme,
                        submittedPinTheme: submittedPinTheme,
                        onCompleted: (pin) => _handleVerify(),
                        hapticFeedbackType: HapticFeedbackType.lightImpact,
                        separatorBuilder: (index) =>
                            const SizedBox(width: _separatorWidth),
                      ),
                    ),
                    const SizedBox(height: 48),
                    AppPrimaryButton(
                      label: _isLoading ? 'Verifying...' : 'Verify Code',
                      isLoading: _isLoading,
                      onPressed: _handleVerify,
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Didn't receive a code? ",
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        _secondsRemaining > 0
                            ? Text(
                                'Resend in ${_secondsRemaining}s',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: AppColors.textSecondary,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : TextButton(
                                onPressed: _isLoading ? null : _handleResend,
                                style: TextButton.styleFrom(
                                  minimumSize: Size.zero,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Text(
                                  'Resend',
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
