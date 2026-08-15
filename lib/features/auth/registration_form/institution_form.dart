import 'package:flutter/material.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';
import 'package:libya_medical_record_system/core/shared/widgets/app_primary_button.dart';
import 'package:libya_medical_record_system/core/util/validators.dart';
import 'package:libya_medical_record_system/data/models/institution_data.dart';

class InstitutionForm extends StatefulWidget {
  const InstitutionForm({
    super.key,
    required this.onContinue,
    this.initialData,
  });

  final ValueChanged<InstitutionData> onContinue;
  final InstitutionData? initialData;

  @override
  State<InstitutionForm> createState() => _InstitutionFormState();
}

class _InstitutionFormState extends State<InstitutionForm> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  final _specializationController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  String _institutionType = 'Hospital';
  bool _isPublic = true;

  final List<String> _types = [
    'Hospital',
    'Clinic',
    'Medical Center',
    'Dental Center',
    'Laboratory',
    'Pharmacy',
    'Other'
  ];

  @override
  void initState() {
    super.initState();
    if (widget.initialData != null) {
      final data = widget.initialData!;
      _nameController.text = data.institutionName;
      _locationController.text = data.location;
      _specializationController.text = data.specialization;
      _phoneController.text = data.phoneNumber;
      _addressController.text = data.address;
      _institutionType = data.institutionType;
      _isPublic = data.isPublic;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _specializationController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _handleContinue() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onContinue(
        InstitutionData(
          institutionName: _nameController.text.trim(),
          location: _locationController.text.trim(),
          specialization: _specializationController.text.trim(),
          isPublic: _isPublic,
          institutionType: _institutionType,
          phoneNumber: _phoneController.text.trim(),
          address: _addressController.text.trim(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Register Medical Facility',
                style: AppTextStyles.headlineLarge.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Provide details about your healthcare institution.',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 28),
              _fieldLabel('Institution Name'),
              TextFormField(
                controller: _nameController,
                decoration: _fieldDecoration(hint: 'Enter official name'),
                validator: FormValidators.required,
              ),
              const SizedBox(height: 20),
              _fieldLabel('Institution Type'),
              DropdownButtonFormField<String>(
                value: _institutionType,
                decoration: _fieldDecoration(),
                items: _types
                    .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                    .toList(),
                onChanged: (v) => setState(() => _institutionType = v!),
              ),
              const SizedBox(height: 20),
              _fieldLabel('Ownership'),
              Row(
                children: [
                  Expanded(
                    child: _buildChoiceChip(
                      label: 'Public',
                      selected: _isPublic,
                      onSelected: (v) => setState(() => _isPublic = true),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildChoiceChip(
                      label: 'Private',
                      selected: !_isPublic,
                      onSelected: (v) => setState(() => _isPublic = false),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _fieldLabel('Location / City'),
              TextFormField(
                controller: _locationController,
                decoration: _fieldDecoration(hint: 'e.g. Tripoli, Benghazi'),
                validator: FormValidators.required,
              ),
              const SizedBox(height: 20),
              _fieldLabel('Specialization'),
              TextFormField(
                controller: _specializationController,
                decoration: _fieldDecoration(hint: 'e.g. General, Cardiology'),
                validator: FormValidators.required,
              ),
              const SizedBox(height: 20),
              _fieldLabel('Phone Number'),
              TextFormField(
                controller: _phoneController,
                decoration: _fieldDecoration(hint: 'Contact number'),
                keyboardType: TextInputType.phone,
                validator: FormValidators.validatePhone,
              ),
              const SizedBox(height: 20),
              _fieldLabel('Address'),
              TextFormField(
                controller: _addressController,
                decoration: _fieldDecoration(hint: 'Detailed street address'),
                maxLines: 2,
                validator: FormValidators.required,
              ),
              const SizedBox(height: 32),
              AppPrimaryButton(
                label: 'Continue',
                onPressed: _handleContinue,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _fieldLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: AppTextStyles.titleSmall.copyWith(
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  InputDecoration _fieldDecoration({String? hint}) {
    return InputDecoration(
      hintText: hint,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  Widget _buildChoiceChip({
    required String label,
    required bool selected,
    required ValueChanged<bool> onSelected,
  }) {
    return InkWell(
      onTap: () => onSelected(true),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: selected ? AppColors.primarySurface : Colors.white,
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.divider,
            width: selected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: AppTextStyles.labelLarge.copyWith(
            color: selected ? AppColors.primaryDark : AppColors.textSecondary,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
