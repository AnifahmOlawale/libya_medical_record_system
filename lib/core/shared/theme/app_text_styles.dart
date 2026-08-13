import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Central typography system for Libya Medical Record System.
/// All text styles use the almarai font (Google Fonts) for Arabic/Latin support.
///
/// USAGE GUIDE:
/// ────────────────────────────────────────────────────
/// Text('Hello', style: AppTextStyles.bodyMedium)
///
/// To override color only:
/// Text('Hello', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary))
/// ────────────────────────────────────────────────────
abstract final class AppTextStyles {
  // ─────────────────────────────────────────
  // DISPLAY — Hero text, splash screen, app name
  // Use for: app name on splash, large banners
  // ─────────────────────────────────────────

  /// 32px · ExtraBold · Use for app name / splash hero text
  static TextStyle displayLarge = GoogleFonts.almarai(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
    height: 1.2,
  );

  /// 26px · Bold · Use for welcome headings, large section titles
  static TextStyle displayMedium = GoogleFonts.almarai(
    fontSize: 26,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.3,
    height: 1.25,
  );

  // ─────────────────────────────────────────
  // HEADLINE — Page titles, section headers
  // Use for: screen titles, dashboard section headings
  // ─────────────────────────────────────────

  /// 22px · Bold · Use for main page headings (e.g. "Patient Records")
  static TextStyle headlineLarge = GoogleFonts.almarai(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  /// 18px · SemiBold · Use for sub-page headings (e.g. "Lab Results")
  static TextStyle headlineMedium = GoogleFonts.almarai(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.35,
  );

  /// 16px · SemiBold · Use for card section headers, grouped list titles
  static TextStyle headlineSmall = GoogleFonts.almarai(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  // ─────────────────────────────────────────
  // TITLE — AppBar, card titles, dialog titles, list item primary text
  // Sits between headline and body — use when something needs weight but not full headline size
  // ─────────────────────────────────────────

  /// 18px · Bold · Use for AppBar titles, modal/dialog titles
  static TextStyle titleLarge = GoogleFonts.almarai(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  /// 16px · SemiBold · Use for card titles, list tile primary text, tab labels
  static TextStyle titleMedium = GoogleFonts.almarai(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.35,
  );

  /// 14px · SemiBold · Use for small card titles, drawer item text, chip labels
  static TextStyle titleSmall = GoogleFonts.almarai(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  // ─────────────────────────────────────────
  // BODY — Paragraphs, descriptions, general content
  // Use for: reading content, form descriptions, notices
  // ─────────────────────────────────────────

  /// 16px · Regular · Use for long-form content, notices, clinical notes
  static TextStyle bodyLarge = GoogleFonts.almarai(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 1.6,
  );

  /// 14px · Regular · Use for general body text, form field values, list subtitles
  static TextStyle bodyMedium = GoogleFonts.almarai(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 1.55,
  );

  /// 12px · Regular · Use for secondary descriptions, metadata, timestamps
  static TextStyle bodySmall = GoogleFonts.almarai(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.5,
  );

  // ─────────────────────────────────────────
  // LABEL — Buttons, form labels, tags, badges
  // Use for: button text, input field labels, status badges
  // ─────────────────────────────────────────

  /// 15px · SemiBold · white · Use for primary/elevated button text
  static TextStyle labelLarge = GoogleFonts.almarai(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.textOnPrimary,
    letterSpacing: 0.2,
  );

  /// 13px · SemiBold · Use for outlined button text, form field labels, tab bar labels
  static TextStyle labelMedium = GoogleFonts.almarai(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
    letterSpacing: 0.1,
  );

  /// 11px · Medium · Use for badge text, status chips, small tags (e.g. "Normal", "Critical")
  static TextStyle labelSmall = GoogleFonts.almarai(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    letterSpacing: 0.3,
  );

  // ─────────────────────────────────────────
  // CAPTION — Hints, footnotes, helper text
  // Use for: form helper text, image captions, empty state subtitles
  // ─────────────────────────────────────────

  /// 11px · Regular · disabled color · Use for hints, helper text, empty state captions
  static TextStyle caption = GoogleFonts.almarai(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: AppColors.textDisabled,
    height: 1.4,
  );
}
