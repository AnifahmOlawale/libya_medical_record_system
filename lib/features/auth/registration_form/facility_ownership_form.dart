import 'package:flutter/material.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';
import 'package:libya_medical_record_system/core/shared/widgets/app_primary_button.dart';

class FacilityOwnershipForm extends StatefulWidget {
  const FacilityOwnershipForm({
    super.key,
    required this.onSelectionChanged,
    required this.onContinue,
    this.initialSelection,
  });

  final ValueChanged<bool> onSelectionChanged;
  final VoidCallback onContinue;
  final bool? initialSelection;

  @override
  State<FacilityOwnershipForm> createState() => _FacilityOwnershipFormState();
}

class _FacilityOwnershipFormState extends State<FacilityOwnershipForm> {
  bool? _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialSelection;
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
            'Do you own a medical facility?',
            textAlign: TextAlign.center,
            style: AppTextStyles.displayMedium.copyWith(
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Hospitals, Clinics, Medical Laboratories, Pharmacies, etc.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 40),
          _SelectionOption(
            icon: Icons.business_rounded,
            title: "Yes, I own a medical facility",
            subtitle: 'I want to register my institution on the platform.',
            value: true,
            groupValue: _selected,
            onSelected: (value) => setState(() {
              _selected = value;
              widget.onSelectionChanged(value);
            }),
          ),
          const SizedBox(height: 16),
          _SelectionOption(
            icon: Icons.person_rounded,
            title: "No, I do not own a facility",
            subtitle: 'I am using the platform as an individual.',
            value: false,
            groupValue: _selected,
            onSelected: (value) => setState(() {
              _selected = value;
              widget.onSelectionChanged(value);
            }),
          ),
          const Spacer(),
          AppPrimaryButton(
            label: 'Continue',
            onPressed: _selected != null ? widget.onContinue : null,
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

class _SelectionOption extends StatelessWidget {
  const _SelectionOption({
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
  final bool value;
  final bool? groupValue;
  final ValueChanged<bool> onSelected;

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
