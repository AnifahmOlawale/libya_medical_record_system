import 'package:flutter/material.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';
import 'package:libya_medical_record_system/core/shared/widgets/app_primary_button.dart';

/// Optional step of registration — asks whether the person wants to provide
/// professional healthcare information to be listed as an expert.
class RoleForm extends StatefulWidget {
  const RoleForm({
    super.key,
    required this.onProfessionalStatusChanged,
    required this.onContinue,
    this.isProfessional = false,
  });

  final ValueChanged<bool> onProfessionalStatusChanged;
  final VoidCallback onContinue;
  final bool isProfessional;

  @override
  State<RoleForm> createState() => _RoleFormState();
}

class _RoleFormState extends State<RoleForm> {
  bool? _isProfessional;

  @override
  void initState() {
    super.initState();
    _isProfessional = widget.isProfessional;
  }

  void _handleContinue() {
    if (_isProfessional != null) {
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
            'Providing your professional details allows you to be verified and listed as an expert.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 40),
          _StatusOption(
            icon: Icons.medical_services_outlined,
            title: "Yes, I'm a healthcare professional",
            subtitle:
                'Register as a doctor, nurse, pharmacist, or other licensed provider.',
            isSelected: _isProfessional == true,
            onSelected: () => setState(() {
              _isProfessional = true;
              widget.onProfessionalStatusChanged(true);
            }),
          ),
          const SizedBox(height: 16),
          _StatusOption(
            icon: Icons.person_outline_rounded,
            title: "No, I'm just a patient",
            subtitle: 'Manage and share your own medical records.',
            isSelected: _isProfessional == false,
            onSelected: () => setState(() {
              _isProfessional = false;
              widget.onProfessionalStatusChanged(false);
            }),
          ),
          const Spacer(),
          AppPrimaryButton(
            label: 'Continue',
            onPressed: _isProfessional != null ? _handleContinue : null,
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

class _StatusOption extends StatelessWidget {
  const _StatusOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onSelected,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelected,
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primarySurface : AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.divider,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: (isSelected ? AppColors.primary : AppColors.textSecondary)
                    .withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
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
              isSelected ? Icons.check_circle_rounded : Icons.circle_outlined,
              color: isSelected ? AppColors.primary : AppColors.textDisabled,
            ),
          ],
        ),
      ),
    );
  }
}
