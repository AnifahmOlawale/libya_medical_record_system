import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:libya_medical_record_system/core/constants/libya_municipalities.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';
import 'package:libya_medical_record_system/core/shared/widgets/app_primary_button.dart';
import 'package:libya_medical_record_system/core/util/validators.dart';
import 'package:libya_medical_record_system/data/models/personal_info_data.dart';

class PersonalInfoForm extends StatefulWidget {
  const PersonalInfoForm({
    super.key,
    required this.onContinue,
    this.initialData,
    this.buttonText = 'Continue',
  });
  final String buttonText;
  final ValueChanged<PersonalInfoData> onContinue;
  final PersonalInfoData? initialData;

  @override
  State<PersonalInfoForm> createState() => _PersonalInfoFormState();
}

class _PersonalInfoFormState extends State<PersonalInfoForm> {
  final nationalIdController = TextEditingController();
  final passportController = TextEditingController();
  final fullNameArabicController = TextEditingController();
  final fullNameEnglishController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final placeOfBirthController = TextEditingController();
  final occupationController = TextEditingController();
  final yearsOfExperienceController = TextEditingController();
  final primaryPhoneController = TextEditingController();
  final secondaryPhoneController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  String? _selectedMunicipality;

  DateTime? _selectedDate;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.initialData != null) {
      _loadInitialData(widget.initialData!);
    }
  }

  void _loadInitialData(PersonalInfoData data) {
    nationalIdController.text = data.nationalId;
    passportController.text = data.passportNumber ?? '';
    fullNameArabicController.text = data.fullNameArabic;
    fullNameEnglishController.text = data.fullNameEnglish;
    placeOfBirthController.text = data.placeOfBirth ?? '';
    occupationController.text = data.occupation;
    yearsOfExperienceController.text = data.yearsOfExperience?.toString() ?? '';
    primaryPhoneController.text = data.primaryPhoneNumber;
    secondaryPhoneController.text = data.secondaryPhoneNumber ?? '';
    emailController.text = data.email;
    addressController.text = data.residentialAddress;
    _selectedMunicipality = LibyaMunicipalities.all.contains(data.municipality)
        ? data.municipality
        : null;
    _selectedDate = data.dateOfBirth;
  }

  // bool get _isFormValid {
  //   return _formKey.currentState?.validate() ?? false;
  // }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final initialDate = _selectedDate ?? DateTime(now.year - 18);
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: now,
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        dateOfBirthController.text = _formattedDate;
      });
    }
  }

  String get _formattedDate {
    if (_selectedDate == null) return '';
    return DateFormat('dd MMM, yyyy').format(_selectedDate!);
  }

  void _handleContinue() {
    // TODO: uncomment this when the form is ready
    // if (!_isFormValid) return;

    widget.onContinue(
      PersonalInfoData(
        nationalId: nationalIdController.text.trim(),
        passportNumber: passportController.text.trim().isEmpty
            ? null
            : passportController.text.trim(),
        fullNameArabic: fullNameArabicController.text.trim(),
        fullNameEnglish: fullNameEnglishController.text.trim(),
        placeOfBirth: placeOfBirthController.text.trim().isEmpty
            ? null
            : placeOfBirthController.text.trim(),

        occupation: occupationController.text.trim(),
        yearsOfExperience: int.tryParse(
          yearsOfExperienceController.text.trim(),
        ),
        primaryPhoneNumber: primaryPhoneController.text.trim(),
        secondaryPhoneNumber: secondaryPhoneController.text.trim().isEmpty
            ? null
            : secondaryPhoneController.text.trim(),
        email: emailController.text.trim(),
        municipality: _selectedMunicipality ?? "",
        residentialAddress: addressController.text.trim(),
        dateOfBirth: _selectedDate ?? DateTime.now(),
      ),
    );
  }

  @override
  void dispose() {
    nationalIdController.dispose();
    passportController.dispose();
    fullNameArabicController.dispose();
    fullNameEnglishController.dispose();
    placeOfBirthController.dispose();
    occupationController.dispose();
    yearsOfExperienceController.dispose();
    primaryPhoneController.dispose();
    secondaryPhoneController.dispose();
    emailController.dispose();
    addressController.dispose();
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
                'Personal Information',
                style: AppTextStyles.headlineLarge.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Please provide your personal details below.',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 28),
              _fieldLabel('National ID'),
              TextFormField(
                controller: nationalIdController,
                validator: (value) =>
                    FormValidators.required(value, fieldName: 'National ID'),
                decoration: _fieldDecoration(
                  hint: 'Enter your national ID number',
                ),
              ),
              const SizedBox(height: 20),
              _fieldLabel('Passport Number (Optional)'),
              TextFormField(
                controller: passportController,
                decoration: _fieldDecoration(
                  hint: 'Enter your passport number',
                ),
              ),
              const SizedBox(height: 20),
              _fieldLabel('Full Name (Arabic)'),
              TextFormField(
                controller: fullNameArabicController,
                validator: (value) => FormValidators.required(
                  value,
                  fieldName: 'Full Name (Arabic)',
                ),
                decoration: _fieldDecoration(
                  hint: 'أدخل اسمك الكامل باللغة العربية',
                ),
              ),
              const SizedBox(height: 20),
              _fieldLabel('Full Name (English)'),
              TextFormField(
                controller: fullNameEnglishController,
                validator: (value) => FormValidators.required(
                  value,
                  fieldName: 'Full Name (English)',
                ),
                decoration: _fieldDecoration(
                  hint: 'Enter your full name in English',
                ),
              ),
              const SizedBox(height: 20),
              _fieldLabel('Date of Birth'),
              TextFormField(
                controller: dateOfBirthController,
                keyboardType: TextInputType.datetime,
                readOnly: true,
                onTap: _pickDate,
                validator: FormValidators.required,
                decoration: _fieldDecoration(hint: 'Select your date of birth'),
              ),
              const SizedBox(height: 20),
              _fieldLabel('Place of Birth'),
              TextFormField(
                controller: placeOfBirthController,
                decoration: _fieldDecoration(hint: 'Enter your place of birth'),
              ),
              const SizedBox(height: 20),
              _fieldLabel('Occupation'),
              TextFormField(
                controller: occupationController,
                validator: FormValidators.required,
                decoration: _fieldDecoration(hint: 'Enter your occupation'),
              ),
              const SizedBox(height: 20),
              _fieldLabel('Working years experience (Optional)'),
              TextFormField(
                controller: yearsOfExperienceController,
                keyboardType: TextInputType.number,
                decoration: _fieldDecoration(
                  hint: 'Enter your years of experience',
                ),
              ),
              const SizedBox(height: 20),
              _fieldLabel('Primary Phone Number'),
              TextFormField(
                controller: primaryPhoneController,
                keyboardType: TextInputType.phone,
                validator: FormValidators.validatePhone,
                decoration: _fieldDecoration(
                  hint: 'Enter your primary phone number',
                ),
              ),
              const SizedBox(height: 20),
              _fieldLabel('Secondary Phone Number'),
              TextFormField(
                controller: secondaryPhoneController,
                keyboardType: TextInputType.phone,
                decoration: _fieldDecoration(
                  hint: 'Enter your secondary phone number (optional)',
                ),
              ),
              const SizedBox(height: 20),
              _fieldLabel('Email Address'),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: FormValidators.email,
                decoration: _fieldDecoration(hint: 'Enter your email address'),
              ),
              const SizedBox(height: 20),
              _fieldLabel('Municipality'),
              DropdownButtonFormField<String>(
                initialValue: _selectedMunicipality,
                decoration: _fieldDecoration(hint: 'Select your municipality'),
                items: LibyaMunicipalities.all
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) {
                  if (value == null) return;
                  setState(() => _selectedMunicipality = value);
                },
                validator: FormValidators.required,
              ),
              const SizedBox(height: 20),
              _fieldLabel('Residential Address'),
              TextFormField(
                controller: addressController,
                maxLines: 2,
                validator: FormValidators.required,
                decoration: _fieldDecoration(
                  hint: 'Enter your residential address',
                ),
              ),
              const SizedBox(height: 28),
              AppPrimaryButton(
                label: widget.buttonText,
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
