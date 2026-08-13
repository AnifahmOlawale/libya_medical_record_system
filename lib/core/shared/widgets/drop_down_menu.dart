import 'package:flutter/material.dart';

class DropDownMenu extends StatelessWidget {
  final bool enable;
  final int? initialValue;
  final String hintText;
  final List dropDownItems;
  final ValueChanged<int?> onChanged;
  final FormFieldValidator<int>? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const DropDownMenu({
    super.key,
    required this.hintText,
    required this.dropDownItems,
    required this.onChanged,
    this.validator,
    this.enable = true,
    this.initialValue,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
      isExpanded: true,
      initialValue: initialValue,
      items: List.generate(
        dropDownItems.length,
        (index) => DropdownMenuItem(
          value: index,
          child: Text(
            dropDownItems.elementAtOrNull(index),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ),
      onChanged: enable ? onChanged : null,
      hint: Text(hintText, style: Theme.of(context).textTheme.bodySmall),
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 12,
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5),
        ),
      ),
      validator: validator,
    );
  }
}
