import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:libya_medical_record_system/core/constants/institution_constants.dart';
import 'package:libya_medical_record_system/core/constants/libya_municipalities.dart';
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
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _otherTypeController = TextEditingController();
  final _otherSpecializationController = TextEditingController();

  String? _selectedMunicipality;
  String _institutionType = InstitutionConstants.institutionTypes.first;
  String _specialization = InstitutionConstants.specializationOptions.first;
  bool _isPublic = true;
  PlatformFile? _legalLicenseFile;

  @override
  void initState() {
    super.initState();
    if (widget.initialData != null) {
      final data = widget.initialData!;
      _nameController.text = data.institutionName;
      _phoneController.text = data.phoneNumber;
      _addressController.text = data.address;

      _selectedMunicipality = LibyaMunicipalities.all.contains(data.location)
          ? data.location
          : null;

      if (InstitutionConstants.institutionTypes.contains(data.institutionType)) {
        _institutionType = data.institutionType;
      } else {
        _institutionType = 'Other';
        _otherTypeController.text = data.institutionType;
      }

      if (InstitutionConstants.specializationOptions.contains(
        data.specialization,
      )) {
        _specialization = data.specialization;
      } else {
        _specialization = 'Other';
        _otherSpecializationController.text = data.specialization;
      }

      _isPublic = data.isPublic;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _otherTypeController.dispose();
    _otherSpecializationController.dispose();
    super.dispose();
  }

  Future<void> _pickLicense() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
    );
    if (result == null || result.files.isEmpty) return;

    setState(() => _legalLicenseFile = result.files.first);
  }

  void _handleContinue() {
    if (_formKey.currentState?.validate() ?? false) {
      final type = _institutionType == 'Other'
          ? _otherTypeController.text.trim()
          : _institutionType;

      final specialization = _specialization == 'Other'
          ? _otherSpecializationController.text.trim()
          : _specialization;

      widget.onContinue(
        InstitutionData(
          institutionName: _nameController.text.trim(),
          location: _selectedMunicipality ?? "",
          specialization: specialization,
          isPublic: _isPublic,
          institutionType: type,
          legalLicensePath: _legalLicenseFile?.path,
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
                initialValue: _institutionType,
                decoration: _fieldDecoration(),
                items: InstitutionConstants.institutionTypes
                    .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                    .toList(),
                onChanged: (v) => setState(() => _institutionType = v!),
              ),
              if (_institutionType == 'Other') ...[
                const SizedBox(height: 16),
                _fieldLabel('Specify Institution Type'),
                TextFormField(
                  controller: _otherTypeController,
                  decoration: _fieldDecoration(hint: 'e.g. Specialized Center'),
                  validator: FormValidators.required,
                ),
              ],
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
              _fieldLabel('Municipality'),
              DropdownButtonFormField<String>(
                initialValue: _selectedMunicipality,
                decoration: _fieldDecoration(
                  hint: 'Select municipality',
                ),
                items: LibyaMunicipalities.all
                    .map(
                      (e) => DropdownMenuItem(value: e, child: Text(e)),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) return;
                  setState(() => _selectedMunicipality = value);
                },
                validator: FormValidators.required,
              ),
              const SizedBox(height: 20),
              _fieldLabel('Address'),
              TextFormField(
                controller: _addressController,
                decoration: _fieldDecoration(hint: 'Detailed street address'),
                maxLines: 2,
                validator: FormValidators.required,
              ),
              const SizedBox(height: 20),
              _fieldLabel('Specialization'),
              DropdownButtonFormField<String>(
                initialValue: _specialization,
                decoration: _fieldDecoration(),
                items: InstitutionConstants.specializationOptions
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (v) => setState(() => _specialization = v!),
              ),
              if (_specialization == 'Other') ...[
                const SizedBox(height: 16),
                _fieldLabel('Specify Specialization'),
                TextFormField(
                  controller: _otherSpecializationController,
                  decoration:
                      _fieldDecoration(hint: 'e.g. Specialized Medicine'),
                  validator: FormValidators.required,
                ),
              ],
              const SizedBox(height: 20),
              _fieldLabel('Phone Number'),
              TextFormField(
                controller: _phoneController,
                decoration: _fieldDecoration(hint: 'Contact number'),
                keyboardType: TextInputType.phone,
                validator: FormValidators.validatePhone,
              ),
              const SizedBox(height: 20),
              _fieldLabel('Institution Legal License (Optional)'),
              const SizedBox(height: 8),
              _buildUploadZone(),
              const SizedBox(height: 32),
              AppPrimaryButton(label: 'Continue', onPressed: _handleContinue),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUploadZone() {
    final hasFile = _legalLicenseFile != null;

    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        radius: const Radius.circular(14),
        dashPattern: const [8, 5],
        color: hasFile ? AppColors.primary : Colors.grey.shade400,
        strokeCap: StrokeCap.round,
        strokeWidth: 1.5,
        padding: const EdgeInsets.all(16),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            children: [
              Icon(
                hasFile
                    ? Icons.check_circle_outline_rounded
                    : Icons.upload_file_rounded,
                color: hasFile ? AppColors.primary : AppColors.textSecondary,
                size: 26,
              ),
              const SizedBox(height: 10),
              Text(
                hasFile ? _legalLicenseFile!.name : 'Upload legal license',
                textAlign: TextAlign.center,
                style: AppTextStyles.titleSmall.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Facility registration certificate or license (PDF, JPG, PNG)',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 14),
              OutlinedButton(
                onPressed: _pickLicense,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.primary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                ),
                child: Text(
                  hasFile ? 'Change file' : 'Choose file',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
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
