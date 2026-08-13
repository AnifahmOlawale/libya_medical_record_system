import 'package:flutter/material.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';
import 'package:libya_medical_record_system/core/shared/widgets/app_primary_button.dart';
import 'package:libya_medical_record_system/data/models/user_registration_model.dart';

/// First step of registration — asks whether the person is a
/// healthcare professional or a patient, since that determines which
/// registration flow / permissions they get.

class RoleForm extends StatefulWidget {
  const RoleForm({
    super.key,
    required this.onUserTypeSelected,
    required this.onContinue,
    this.initialUserType,
  });

  final ValueChanged<UserType> onUserTypeSelected;
  final VoidCallback onContinue;

  /// Restores the previously-made selection when the person navigates
  /// back to this page — without this, the selection resets to
  /// nothing every time this page is rebuilt.
  final UserType? initialUserType;

  @override
  State<RoleForm> createState() => _RoleFormState();
}

class _RoleFormState extends State<RoleForm> {
  UserType? _selectedUserType;

  @override
  void initState() {
    super.initState();
    _selectedUserType = widget.initialUserType;
  }

  void _handleUserTypeSelected() {
    if (_selectedUserType != null) {
      widget.onUserTypeSelected(_selectedUserType!);
    }
  }

  void _handleContinue() {
    if (_selectedUserType != null) {
      widget.onContinue();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 40),

          Text(
            'Are you a healthcare\nprofessional?',
            textAlign: TextAlign.center,
            style: AppTextStyles.displayMedium.copyWith(
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
              height: 1.2,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            'This helps us give you the right experience.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 40),

          _UserTypeOption(
            icon: Icons.medical_services_outlined,
            title: "Yes, I'm a healthcare professional",
            subtitle:
                'Doctors, pharmacists, lab, radiology, and other licensed providers.',
            value: UserType.healthcareProfessional,
            groupValue: _selectedUserType,
            onSelected: (value) => setState(() {
              _selectedUserType = value;
              _handleUserTypeSelected();
            }),
          ),

          const SizedBox(height: 16),

          _UserTypeOption(
            icon: Icons.person_outline_rounded,
            title: "No, I'm using this as a patient",
            subtitle: 'Manage and share your own medical records.',
            value: UserType.patient,
            groupValue: _selectedUserType,
            onSelected: (value) => setState(() {
              _selectedUserType = value;
              _handleUserTypeSelected();
            }),
          ),

          const Spacer(),

          AppPrimaryButton(
            label: 'Continue',
            onPressed: _selectedUserType != null ? _handleContinue : null,
            inverted: false,
          ),

          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

/// A single selectable user-type card — replaces the plain
/// [RadioListTile] with something that matches the app's card-based
/// visual language (selection shown via border + background tint +
/// check icon, rather than a bare radio dot).
class _UserTypeOption extends StatelessWidget {
  const _UserTypeOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.groupValue,
    required this.onSelected,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final UserType value;
  final UserType? groupValue;
  final ValueChanged<UserType> onSelected;

  bool get _selected => value == groupValue;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onSelected(value),
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _selected ? AppColors.primarySurface : AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _selected ? AppColors.primary : AppColors.divider,
            width: _selected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: (_selected ? AppColors.primary : AppColors.textSecondary)
                    .withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: _selected ? AppColors.primary : AppColors.textSecondary,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.titleSmall.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              _selected ? Icons.check_circle_rounded : Icons.circle_outlined,
              color: _selected ? AppColors.primary : AppColors.textDisabled,
            ),
          ],
        ),
      ),
    );
  }
}
