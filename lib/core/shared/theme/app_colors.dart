import 'package:flutter/material.dart';

/// Color palette for Libya Medical Record System.
/// Same structural pattern as Libya School Management's AppColors —
/// only the brand hue changes (emerald green instead of steel blue).
abstract final class AppColors {
  // Primary brand — emerald green
  static const Color primary = Color(0xFF10B981); // Emerald 500
  static const Color primaryLight = Color(0xFF34D399); // Emerald 400
  static const Color primaryDark = Color(
    0xFF059669,
  ); // Emerald 600 — use for text-on-white when contrast matters
  static const Color primarySurface = Color(
    0xFFD1FAE5,
  ); // Emerald 100 — soft tint for backgrounds

  // Accent — warm amber (for CTAs, badges, highlights)
  static const Color accent = Color(0xFFF59E0B);
  static const Color accentLight = Color(0xFFFCD34D);
  static const Color accentDark = Color(0xFFD97706);

  // Role-specific accent tints (for role cards / avatars)
  static const Color doctorTint = Color(0xFF0EA5E9); // sky blue
  static const Color nurseTint = Color(0xFF8B5CF6); // violet
  static const Color patientTint = Color(0xFFF59E0B); // amber
  static const Color adminTint = Color(0xFFEF4444); // red

  // Neutrals
  static const Color surface = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFF4F7FA);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color divider = Color(0xFFE2E8F0);

  // Text
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textDisabled = Color(0xFFCBD5E1);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // Semantic
  // NOTE: `success` is intentionally a different, more yellow-leaning green
  // than `primary` (which is teal-leaning) so status badges don't visually
  // collide with primary buttons/branding.
  static const Color success = Color(0xFF16A34A);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);
}
