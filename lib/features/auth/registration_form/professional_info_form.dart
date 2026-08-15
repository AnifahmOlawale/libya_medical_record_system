import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:libya_medical_record_system/core/constants/institution_constants.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';
import 'package:libya_medical_record_system/core/shared/widgets/app_primary_button.dart';
import 'package:intl/intl.dart';
import 'package:libya_medical_record_system/core/util/validators.dart';
import 'package:libya_medical_record_system/data/models/professional_info_data.dart';
import 'package:libya_medical_record_system/data/models/working_time_data.dart';

class ProfessionalInfoForm extends StatefulWidget {
  const ProfessionalInfoForm({
    super.key,
    required this.onContinue,
    this.initialData,
  });

  final ValueChanged<ProfessionalInfoData> onContinue;
  final ProfessionalInfoData? initialData;

  @override
  State<ProfessionalInfoForm> createState() => _ProfessionalInfoFormState();
}

class _ProfessionalInfoFormState extends State<ProfessionalInfoForm> {
  final _yearsOfExperienceController = TextEditingController();
  final _aboutMeController = TextEditingController();
  final _otherSpecializationController = TextEditingController();

  String _selectedSpecialization =
      InstitutionConstants.specializationOptions.first;
  PlatformFile? _verificationDocument;
  bool _confirmsLicensed = false;
  bool _agreesToLegitimateUse = false;

  WeeklySchedule _weeklySchedule = const WeeklySchedule(
    monday: WorkingTime(),
    tuesday: WorkingTime(),
    wednesday: WorkingTime(),
    thursday: WorkingTime(),
    friday: WorkingTime(),
    saturday: WorkingTime(),
    sunday: WorkingTime(),
  );

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.initialData != null) {
      _loadInitialData(widget.initialData!);
    }
  }

  void _loadInitialData(ProfessionalInfoData data) {
    if (InstitutionConstants.specializationOptions.contains(
      data.specialization,
    )) {
      _selectedSpecialization = data.specialization;
    } else {
      _selectedSpecialization = 'Other';
      _otherSpecializationController.text = data.specialization;
    }

    _yearsOfExperienceController.text =
        data.yearsOfExperience?.toString() ?? '';
    _aboutMeController.text = data.aboutMe ?? '';
    _confirmsLicensed = data.confirmsLicensed;
    _agreesToLegitimateUse = data.agreesToLegitimateUse;
    _weeklySchedule =
        data.weeklySchedule ??
        const WeeklySchedule(
          monday: WorkingTime(),
          tuesday: WorkingTime(),
          wednesday: WorkingTime(),
          thursday: WorkingTime(),
          friday: WorkingTime(),
          saturday: WorkingTime(),
          sunday: WorkingTime(),
        );
  }

  bool get _isOtherSpecialization => _selectedSpecialization == 'Other';

  Future<void> _pickDocument() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
    );
    if (result == null || result.files.isEmpty) return;

    setState(() => _verificationDocument = result.files.first);
  }

  void _handleContinue() {
    if (_formKey.currentState?.validate() ?? false) {
      final specialization = _isOtherSpecialization
          ? _otherSpecializationController.text.trim()
          : _selectedSpecialization;

      widget.onContinue(
        ProfessionalInfoData(
          specialization: specialization,
          verificationDocumentPath: _verificationDocument?.path ?? "",
          yearsOfExperience: int.tryParse(
            _yearsOfExperienceController.text.trim(),
          ),
          aboutMe: _aboutMeController.text.trim(),
          confirmsLicensed: _confirmsLicensed,
          agreesToLegitimateUse: _agreesToLegitimateUse,
          weeklySchedule: _weeklySchedule,
        ),
      );
    }
  }

  @override
  void dispose() {
    _yearsOfExperienceController.dispose();
    _aboutMeController.dispose();
    _otherSpecializationController.dispose();
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
                'Professional Information',
                style: AppTextStyles.headlineLarge.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Provide details about your specialization and experience.',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 28),
              _fieldLabel('Specialization'),
              DropdownButtonFormField<String>(
                initialValue: _selectedSpecialization,
                decoration: _fieldDecoration(
                  hint: 'Select your specialization',
                ),
                items: InstitutionConstants.specializationOptions
                    .map(
                      (e) => DropdownMenuItem(value: e, child: Text(e)),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) return;
                  setState(() {
                    _selectedSpecialization = value;
                  });
                },
                validator: FormValidators.required,
              ),
              if (_isOtherSpecialization) ...[
                const SizedBox(height: 16),
                _fieldLabel('Please specify your specialization'),
                TextFormField(
                  controller: _otherSpecializationController,
                  decoration: _fieldDecoration(
                    hint: 'Enter your specialization',
                  ),
                  validator: FormValidators.required,
                ),
              ],
              const SizedBox(height: 20),
              _fieldLabel('Years of experience'),
              TextFormField(
                controller: _yearsOfExperienceController,
                decoration: _fieldDecoration(
                  hint: 'Enter your years of experience',
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              _fieldLabel('About me'),
              TextFormField(
                controller: _aboutMeController,
                decoration: _fieldDecoration(
                  hint:
                      'Tell us about yourself, your background, and your professional interests',
                ),
                maxLines: 4,
              ),
              const SizedBox(height: 28),
              _buildWeeklySchedule(),
              const SizedBox(height: 28),
              _fieldLabel('Verification document'),
              const SizedBox(height: 8),
              _buildUploadZone(),
              const SizedBox(height: 28),
              const Divider(color: AppColors.divider),
              const SizedBox(height: 20),
              _buildCheckbox(
                value: _confirmsLicensed,
                label:
                    'I confirm that I am a licensed or authorized healthcare professional',
                onChanged: (v) => setState(() => _confirmsLicensed = v ?? false),
              ),
              _buildCheckbox(
                value: _agreesToLegitimateUse,
                label:
                    'I agree to use the platform only for legitimate healthcare purposes',
                onChanged: (v) =>
                    setState(() => _agreesToLegitimateUse = v ?? false),
              ),
              const SizedBox(height: 24),
              AppPrimaryButton(
                label: 'Save Professional Details',
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

  Widget _buildUploadZone() {
    final hasFile = _verificationDocument != null;

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
                    : Icons.upload_rounded,
                color: hasFile ? AppColors.primary : AppColors.textSecondary,
                size: 26,
              ),
              const SizedBox(height: 10),
              Text(
                hasFile
                    ? _verificationDocument!.name
                    : 'Upload verification document',
                textAlign: TextAlign.center,
                style: AppTextStyles.titleSmall.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Medical license, professional ID, or employment document (PDF, JPG, PNG)',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 14),
              OutlinedButton(
                onPressed: _pickDocument,
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

  Widget _buildCheckbox({
    required bool value,
    required String label,
    required ValueChanged<bool?> onChanged,
  }) {
    return InkWell(
      onTap: () => onChanged(!value),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(
              value: value,
              onChanged: onChanged,
              activeColor: AppColors.primary,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  label,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeeklySchedule() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _fieldLabel('Working Hours'),
        const SizedBox(height: 12),
        ...List.generate(7, (index) {
          final days = [
            'Monday',
            'Tuesday',
            'Wednesday',
            'Thursday',
            'Friday',
            'Saturday',
            'Sunday',
          ];
          final day = days[index];
          final workingTime = _getWorkingTimeForDay(index);

          return _buildDaySchedule(day, workingTime, index);
        }),
      ],
    );
  }

  WorkingTime _getWorkingTimeForDay(int index) {
    switch (index) {
      case 0:
        return _weeklySchedule.monday;
      case 1:
        return _weeklySchedule.tuesday;
      case 2:
        return _weeklySchedule.wednesday;
      case 3:
        return _weeklySchedule.thursday;
      case 4:
        return _weeklySchedule.friday;
      case 5:
        return _weeklySchedule.saturday;
      case 6:
        return _weeklySchedule.sunday;
      default:
        return const WorkingTime();
    }
  }

  Widget _buildDaySchedule(String day, WorkingTime workingTime, int dayIndex) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.divider),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                day,
                style: AppTextStyles.titleSmall.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              Switch(
                value: workingTime.isActive,
                onChanged: (value) {
                  setState(() {
                    _updateDaySchedule(
                      dayIndex,
                      workingTime.copyWith(isActive: value),
                    );
                  });
                },
                activeThumbColor: AppColors.primary,
              ),
            ],
          ),
          if (workingTime.isActive) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildTimePicker(
                    label: 'Start Time',
                    time: workingTime.startTime,
                    onTimeSelected: (time) {
                      setState(() {
                        _updateDaySchedule(
                          dayIndex,
                          workingTime.copyWith(startTime: time),
                        );
                      });
                    },
                    error: workingTime.startTime == null ? 'Required' : null,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildTimePicker(
                    label: 'End Time',
                    time: workingTime.endTime,
                    onTimeSelected: (time) {
                      setState(() {
                        _updateDaySchedule(
                          dayIndex,
                          workingTime.copyWith(endTime: time),
                        );
                      });
                    },
                    error: workingTime.endTime == null ? 'Required' : null,
                  ),
                ),
              ],
            ),
            if (workingTime.startTime != null && workingTime.endTime != null)
              Builder(
                builder: (context) {
                  final error = workingTime.validationError;
                  if (error != null) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8, left: 4),
                      child: Text(
                        error,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: Colors.red.shade600,
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
          ],
        ],
      ),
    );
  }

  void _updateDaySchedule(int dayIndex, WorkingTime updatedWorkingTime) {
    switch (dayIndex) {
      case 0:
        _weeklySchedule = _weeklySchedule.copyWith(monday: updatedWorkingTime);
        break;
      case 1:
        _weeklySchedule = _weeklySchedule.copyWith(tuesday: updatedWorkingTime);
        break;
      case 2:
        _weeklySchedule = _weeklySchedule.copyWith(
          wednesday: updatedWorkingTime,
        );
        break;
      case 3:
        _weeklySchedule = _weeklySchedule.copyWith(
          thursday: updatedWorkingTime,
        );
        break;
      case 4:
        _weeklySchedule = _weeklySchedule.copyWith(friday: updatedWorkingTime);
        break;
      case 5:
        _weeklySchedule = _weeklySchedule.copyWith(
          saturday: updatedWorkingTime,
        );
        break;
      case 6:
        _weeklySchedule = _weeklySchedule.copyWith(sunday: updatedWorkingTime);
        break;
    }
  }

  Widget _buildTimePicker({
    required String label,
    required TimeOfDay? time,
    required ValueChanged<TimeOfDay> onTimeSelected,
    String? error,
  }) {
    String timeString = 'Not set';
    if (time != null) {
      final now = DateTime(2024, 1, 1, time.hour, time.minute);
      timeString = DateFormat('h:mm a').format(now);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.labelSmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 6),
        InkWell(
          onTap: () async {
            final picked = await showTimePicker(
              context: context,
              initialTime: time ?? TimeOfDay.now(),
            );
            if (picked != null) {
              onTimeSelected(picked);
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(
              border: Border.all(
                color: error != null ? Colors.red.shade600 : AppColors.divider,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  timeString,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: time != null
                        ? AppColors.textPrimary
                        : AppColors.textSecondary,
                  ),
                ),
                Icon(
                  Icons.access_time_rounded,
                  size: 20,
                  color: AppColors.primary,
                ),
              ],
            ),
          ),
        ),
        if (error != null)
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 4),
            child: Text(
              error,
              style: AppTextStyles.bodySmall.copyWith(
                color: Colors.red.shade600,
              ),
            ),
          ),
      ],
    );
  }
}
