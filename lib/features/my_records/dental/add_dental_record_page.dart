import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:dental_teeth_selector/dental_teeth_selector.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';
import 'package:libya_medical_record_system/core/shared/widgets/app_primary_button.dart';
import 'package:libya_medical_record_system/core/shared/widgets/sliver_page_header.dart';
import 'package:libya_medical_record_system/core/shared/widgets/snack_bar.dart';
import 'package:libya_medical_record_system/core/shared/widgets/text_field_input_decoration.dart';
import 'package:libya_medical_record_system/data/models/user_registration_model.dart';

class AddDentalRecordPage extends StatefulWidget {
  const AddDentalRecordPage({super.key, this.patient});

  final UserRegistrationModel? patient;

  @override
  State<AddDentalRecordPage> createState() => _AddDentalRecordPageState();
}

class _AddDentalRecordPageState extends State<AddDentalRecordPage> {
  final _formKey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();
  List<String> _selectedTeeth = [];
  final _procedureController = TextEditingController();
  final _doctorController = TextEditingController();
  final _facilityController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _procedureController.dispose();
    _doctorController.dispose();
    _facilityController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: AppColors.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  void _saveRecord() {
    if (_formKey.currentState!.validate()) {
      if (_selectedTeeth.isEmpty) {
        snackBar(
          context: context,
          message: 'Please select at least one tooth.',
          type: SnackTypeEnum.error,
        );
        return;
      }
      // Save logic here
      snackBar(
        context: context,
        message: 'Dental record added successfully!',
        type: SnackTypeEnum.success,
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverPageHeader(
            title: widget.patient != null
                ? 'Dental: ${widget.patient!.personalInfo!.fullNameEnglish}'
                : 'Add Dental Record',
            icon: FontAwesomeIcons.tooth,
            showBackButton: true,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle('Procedure Date'),
                    const SizedBox(height: 12),
                    _buildDatePicker(),
                    const SizedBox(height: 32),
                    _buildSectionTitle('Select Teeth'),
                    const SizedBox(height: 4),
                    Text(
                      'Tap on the teeth to select/deselect',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildTeethSelector(),
                    const SizedBox(height: 32),
                    _buildSectionTitle('Procedure Details'),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _procedureController,
                      label: 'Procedure Name',
                      hint: 'e.g. Filling, Extraction, Root Canal',
                      icon: FontAwesomeIcons.briefcaseMedical,
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      controller: _doctorController,
                      label: 'Dentist Name',
                      hint: 'Enter doctor name',
                      icon: FontAwesomeIcons.userDoctor,
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      controller: _facilityController,
                      label: 'Dental Facility',
                      hint: 'Enter clinic or hospital name',
                      icon: FontAwesomeIcons.hospital,
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      controller: _notesController,
                      label: 'Clinical Notes',
                      hint: 'Add any specific details or observations...',
                      icon: FontAwesomeIcons.notesMedical,
                      maxLines: 4,
                    ),
                    const SizedBox(height: 40),
                    AppPrimaryButton(
                      label: 'Save Dental Record',
                      onPressed: _saveRecord,
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: AppTextStyles.titleMedium.copyWith(
        fontWeight: FontWeight.w800,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildDatePicker() {
    return InkWell(
      onTap: _selectDate,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.divider),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.calendar_today_rounded,
              color: AppColors.primary,
              size: 20,
            ),
            const SizedBox(width: 12),
            Text(
              DateFormat('dd MMMM, yyyy').format(_selectedDate),
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: AppColors.textDisabled,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeethSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.divider),
      ),
      child: Center(
        child: DentalTeethSelector(
          initiallySelected: _selectedTeeth,
          selectedColor: AppColors.primary,
          toothColor: AppColors.textPrimary,
          numberColor: AppColors.textPrimary,
          rightLabel: 'Right',
          leftLabel: 'Left',
          labelColor: AppColors.textSecondary,
          width: MediaQuery.of(context).size.width * 0.8,
          height: 400,
          onSelected: (teeth) {
            setState(() => _selectedTeeth = teeth);
          },
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required dynamic icon,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.labelMedium.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          style: AppTextStyles.bodyMedium,
          decoration: fieldDecoration(hint: hint, prefixIcon: icon),

          validator: (value) =>
              value == null || value.isEmpty ? 'This field is required' : null,
        ),
      ],
    );
  }
}
