import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';

class SearchTextField extends StatelessWidget {
  final bool enabled;
  final VoidCallback? onTap;
  final bool readOnly;
  final String hintText;
  final int? maxLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final bool autofocus;
  final void Function(String)? onFieldSubmitted;

  const SearchTextField({
    super.key,
    required this.enabled,
    this.onTap,

    required this.readOnly,
    required this.hintText,
    this.maxLines = 1,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    required this.keyboardType,
    required this.textInputAction,
    required this.controller,
    this.validator,
    this.inputFormatters,
    this.autofocus = false,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      autofocus: autofocus,
      onTap: onTap,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      readOnly: readOnly,
      obscureText: obscureText,
      onFieldSubmitted: onFieldSubmitted,

      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.almarai(
          fontSize: 14,
          color: AppColors.textDisabled,
        ),
        labelStyle: GoogleFonts.almarai(
          fontSize: 14,
          color: AppColors.textSecondary,
        ),
        isDense: true,
        filled: true,
        fillColor: Theme.brightnessOf(context) == Brightness.light
            ? Colors.grey[200] // Light mode soft grey
            : const Color(
                0xFF1E1E1E,
              ), // Slightly lighter than 0xFF121212 background
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.transparent
                : Colors.grey[700]!, // faint outline in dark mode
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: BorderSide(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.transparent
                : AppColors.primary,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: BorderSide(color: AppColors.primary),
        ),

        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      ),

      keyboardType: keyboardType,
      textInputAction: textInputAction,
      maxLines: maxLines,
      validator: validator,
      inputFormatters: inputFormatters,
    );
  }
}
