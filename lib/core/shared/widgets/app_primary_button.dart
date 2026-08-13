import 'package:flutter/material.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';

/// Primary action button for Libya School Management.
///
/// USAGE:
/// ──────────────────────────────────────────────────
/// // Normal
/// AppPrimaryButton(
///   label: 'Get Started',
///   onPressed: () {},
/// )
///
/// // Loading state (disables tap + shows spinner)
/// AppPrimaryButton(
///   label: 'Signing in...',
///   isLoading: true,
///   onPressed: () {},
/// )
///
/// // Full width (default) vs custom width
/// AppPrimaryButton(
///   label: 'Submit',
///   onPressed: () {},
///   width: 200,
/// )
///
/// // Inverted — white bg, primary text (for use on primary-colored screens)
/// AppPrimaryButton(
///   label: 'Get Started',
///   onPressed: () {},
///   inverted: true,
/// )
/// ──────────────────────────────────────────────────
class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.inverted = false,
    this.width = double.infinity,
    this.height = 54,
    this.icon,
    this.getBackgroundColor,
  });

  /// Button label text
  final String label;

  /// Tap callback — ignored while [isLoading] is true
  final VoidCallback? onPressed;

  /// Shows a circular progress indicator and disables the button
  final bool isLoading;

  /// White background with primary-colored text —
  /// use on screens where the background is already [AppColors.primary]
  final bool inverted;

  /// Defaults to full width
  final double width;

  /// Defaults to 54
  final double height;

  /// Optional leading icon
  final IconData? icon;

  //Forground Color
  final Color? getBackgroundColor;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = inverted
        ? Colors.white
        : getBackgroundColor ?? AppColors.primary;
    final foregroundColor = inverted ? AppColors.primary : Colors.white;
    final spinnerColor = inverted ? AppColors.primary : Colors.white;

    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: 600),
        width: width,
        height: height,
        child: ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            // Keep same color when disabled (loading) — no grey wash
            disabledBackgroundColor: backgroundColor.withValues(alpha: 0.85),
            disabledForegroundColor: foregroundColor.withValues(alpha: 0.7),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            padding: EdgeInsets.zero,
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: isLoading
                ? SizedBox(
                    key: const ValueKey('loader'),
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(spinnerColor),
                    ),
                  )
                : Row(
                    key: const ValueKey('label'),
                    mainAxisAlignment: .center,
                    mainAxisSize: .min,
                    children: [
                      if (icon != null) ...[
                        Icon(icon, size: 20, color: foregroundColor),
                        const SizedBox(width: 8),
                      ],
                      Text(
                        label,
                        style: AppTextStyles.labelLarge.copyWith(
                          color: foregroundColor,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
