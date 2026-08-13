import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';

Widget textFormField({
  required BuildContext context,
  required bool enabled,

  void Function()? onTap,
  void Function(String)? onFieldSubmitted,
  required bool readOnly,
  required String hintText,
  int? maxLines = 1,
  Widget? prefixIcon,
  Widget? suffixIcon,
  bool obscureText = false,
  required TextInputType keyboardType,
  required TextInputAction textInputAction,
  required TextEditingController controller,
  String? Function(String?)? validator,
  List<TextInputFormatter>? inputFormatters,
}) {
  return TextFormField(
    controller: controller,
    enabled: enabled,
    onTap: onTap,
    onFieldSubmitted: onFieldSubmitted,
    readOnly: readOnly,
    obscureText: obscureText,
    onTapOutside: (event) => FocusScope.of(context).unfocus(),
    decoration: InputDecoration(
      hintText: hintText,
      filled: true,
      fillColor: AppColors.surface,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
    ),
    keyboardType: keyboardType,
    textInputAction: textInputAction,
    maxLines: maxLines,
    validator: validator,
    inputFormatters: inputFormatters,
  );
}
