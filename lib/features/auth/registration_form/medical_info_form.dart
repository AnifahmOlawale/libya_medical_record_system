import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:libya_medical_record_system/core/constants/medical_info_drop_down.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';
import 'package:libya_medical_record_system/core/shared/widgets/app_primary_button.dart';
import 'package:libya_medical_record_system/core/util/validators.dart';
import 'package:libya_medical_record_system/data/models/medical_info_data.dart';

class MedicalInfoForm extends StatefulWidget {
  const MedicalInfoForm({
    super.key,
    required this.onContinue,
    this.initialData,
  });

  final ValueChanged<MedicalInfoData> onContinue;
  final MedicalInfoData? initialData;

  @override
  State<MedicalInfoForm> createState() => _MedicalInfoFormState();
}

class _MedicalInfoFormState extends State<MedicalInfoForm> {
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final donationDateController = TextEditingController();
  DateTime? _lastBloodDonationDate;

  String? _selectedGender;
  String? _selectedMaritalStatus;
  String? _selectedBloodType;
  String? _selectedGenotype;
  String? _selectedDisabilityStatus;
  String? _selectedSmokingStatus;
  String? _selectedAlcoholUse;
  String? _selectedPregnancyStatus;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.initialData != null) {
      _loadInitialData(widget.initialData!);
    }
  }

  void _loadInitialData(MedicalInfoData data) {
    heightController.text = data.height;
    weightController.text = data.weight;
    _lastBloodDonationDate = data.lastBloodDonationDate;
    donationDateController.text = _formattedBloodDonationDate;
    _selectedGender = data.gender;
    _selectedMaritalStatus = data.maritalStatus;
    _selectedBloodType = data.bloodType;
    _selectedGenotype = data.genotype;
    _selectedDisabilityStatus = data.disabilityStatus;
    _selectedSmokingStatus = data.smokingStatus;
    _selectedAlcoholUse = data.alcoholUse;
    _selectedPregnancyStatus = data.pregnancyStatus;
  }

  // bool get _isFormValid {
  //   return _formKey.currentState?.validate() ?? false;
  // }

  Future<void> _pickBloodDonationDate() async {
    final now = DateTime.now();
    final initialDate = _lastBloodDonationDate ?? DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: now,
    );
    if (picked != null) {
      setState(() {
        _lastBloodDonationDate = picked;
        donationDateController.text = _formattedBloodDonationDate;
      });
    }
  }

  String get _formattedBloodDonationDate {
    if (_lastBloodDonationDate == null) return '';
    return DateFormat('dd MMM, yyyy').format(_lastBloodDonationDate!);
  }

  void _handleContinue() {
    widget.onContinue(
      MedicalInfoData(
        height: heightController.text.trim(),
        weight: weightController.text.trim(),
        lastBloodDonationDate: _lastBloodDonationDate,
        bloodType: _selectedBloodType ?? "",
        genotype: _selectedGenotype ?? "",
        gender: _selectedGender ?? "",
        maritalStatus: _selectedMaritalStatus ?? "",
        disabilityStatus: _selectedDisabilityStatus ?? "",
        smokingStatus: _selectedSmokingStatus ?? "",
        alcoholUse: _selectedAlcoholUse ?? "",
        pregnancyStatus: _selectedPregnancyStatus ?? "",
      ),
    );
  }

  @override
  void dispose() {
    heightController.dispose();
    weightController.dispose();
    donationDateController.dispose();
    super.dispose();
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
                'Medical Information',
                style: AppTextStyles.headlineLarge.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Please provide your medical details below.',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 28),
              _fieldLabel('Height (cm)'),
              TextFormField(
                controller: heightController,
                keyboardType: TextInputType.number,
                validator: FormValidators.required,
                decoration: _fieldDecoration(hint: 'Enter your height in cm'),
              ),
              const SizedBox(height: 20),
              _fieldLabel('Weight (kg)'),
              TextFormField(
                controller: weightController,
                keyboardType: TextInputType.number,
                validator: FormValidators.required,
                decoration: _fieldDecoration(hint: 'Enter your weight in kg'),
              ),
              const SizedBox(height: 20),
              _fieldLabel('Last Blood Donation Date (Optional)'),
              TextFormField(
                controller: donationDateController,
                readOnly: true,
                onTap: _pickBloodDonationDate,
                decoration: _fieldDecoration(
                  hint: 'Select last blood donation date',
                ),
              ),
              const SizedBox(height: 20),
              _fieldLabel('Blood Type'),
              DropdownButtonFormField<String>(
                initialValue: _selectedBloodType,
                decoration: _fieldDecoration(hint: 'Select blood type'),
                items: bloodTypeOptions
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) {
                  if (value == null) return;
                  setState(() => _selectedBloodType = value);
                },
                validator: FormValidators.required,
              ),
              const SizedBox(height: 20),
              _fieldLabel('Genotype'),
              DropdownButtonFormField<String>(
                initialValue: _selectedGenotype,
                decoration: _fieldDecoration(hint: 'Select genotype'),
                items: genotypeOptions
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) {
                  if (value == null) return;
                  setState(() => _selectedGenotype = value);
                },
                validator: FormValidators.required,
              ),
              const SizedBox(height: 20),
              _fieldLabel('Gender'),
              DropdownButtonFormField<String>(
                initialValue: _selectedGender,
                decoration: _fieldDecoration(hint: 'Select gender'),
                items: genderOptions
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) {
                  if (value == null) return;
                  setState(() => _selectedGender = value);
                },
                validator: FormValidators.required,
              ),
              const SizedBox(height: 20),
              _fieldLabel('Marital Status'),
              DropdownButtonFormField<String>(
                initialValue: _selectedMaritalStatus,
                decoration: _fieldDecoration(hint: 'Select marital status'),
                items: maritalStatusOptions
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) {
                  if (value == null) return;
                  setState(() => _selectedMaritalStatus = value);
                },
                validator: FormValidators.required,
              ),
              const SizedBox(height: 20),
              _fieldLabel('Disability Status'),
              DropdownButtonFormField<String>(
                initialValue: _selectedDisabilityStatus,
                decoration: _fieldDecoration(hint: 'Select disability status'),
                items: disabilityStatusOptions
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) {
                  if (value == null) return;
                  setState(() => _selectedDisabilityStatus = value);
                },
                validator: FormValidators.required,
              ),
              const SizedBox(height: 20),
              _fieldLabel('Smoking Status'),
              DropdownButtonFormField<String>(
                initialValue: _selectedSmokingStatus,
                decoration: _fieldDecoration(hint: 'Select smoking status'),
                items: smokingStatusOptions
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) {
                  if (value == null) return;
                  setState(() => _selectedSmokingStatus = value);
                },
                validator: FormValidators.required,
              ),
              const SizedBox(height: 20),
              _fieldLabel('Alcohol Use'),
              DropdownButtonFormField<String>(
                initialValue: _selectedAlcoholUse,
                decoration: _fieldDecoration(hint: 'Select alcohol use'),
                items: alcoholUseOptions
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) {
                  if (value == null) return;
                  setState(() => _selectedAlcoholUse = value);
                },
                validator: FormValidators.required,
              ),
              const SizedBox(height: 20),
              _fieldLabel('Pregnancy Status'),
              DropdownButtonFormField<String>(
                initialValue: _selectedPregnancyStatus,
                decoration: _fieldDecoration(hint: 'Select pregnancy status'),
                items: pregnancyStatusOptions
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) {
                  if (value == null) return;
                  setState(() => _selectedPregnancyStatus = value);
                },
                validator: FormValidators.required,
              ),
              const SizedBox(height: 28),
              AppPrimaryButton(
                label: 'Save Information',
                onPressed: _handleContinue,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===================== HELPERS =====================

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
}
