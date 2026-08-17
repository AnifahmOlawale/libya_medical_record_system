import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';
import 'package:libya_medical_record_system/core/shared/widgets/app_primary_button.dart';
import 'package:libya_medical_record_system/core/shared/widgets/snack_bar.dart';
import 'package:libya_medical_record_system/core/shared/widgets/text_field_input_decoration.dart';
import 'package:libya_medical_record_system/data/models/diagnosis_model.dart';
import 'package:libya_medical_record_system/data/models/user_registration_model.dart';

import 'package:libya_medical_record_system/core/shared/widgets/sliver_page_header.dart';

class AddDiagnosisPage extends StatefulWidget {
  const AddDiagnosisPage({super.key, this.patient});

  final UserRegistrationModel? patient;

  @override
  State<AddDiagnosisPage> createState() => _AddDiagnosisPageState();
}

class _AddDiagnosisPageState extends State<AddDiagnosisPage> {
  final _formKey = GlobalKey<FormState>();
  final _conditionController = TextEditingController();
  final _diagnosedByController = TextEditingController();
  final _dateController = TextEditingController();
  final _symptomsController = TextEditingController();
  final _treatmentController = TextEditingController();
  final _notesController = TextEditingController();
  final _costController = TextEditingController();

  DiagnosisStatus? _selectedStatus = DiagnosisStatus.active;
  DiagnosisSeverity? _selectedSeverity = DiagnosisSeverity.moderate;
  DateTime? _diagnosisDate;
  final List<String> _selectedFiles = [];

  @override
  void dispose() {
    _conditionController.dispose();
    _diagnosedByController.dispose();
    _dateController.dispose();
    _symptomsController.dispose();
    _treatmentController.dispose();
    _notesController.dispose();
    _costController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _diagnosisDate = picked;
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      debugPrint('Saving diagnosis with date: $_diagnosisDate');
      final message = _selectedFiles.isEmpty
          ? 'Diagnosis record saved successfully'
          : 'Diagnosis record saved with ${_selectedFiles.length} document(s)';

      snackBar(context: context, message: message, type: SnackTypeEnum.success);
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPageHeader(
            title: widget.patient != null
                ? 'Diagnose ${widget.patient!.personalInfo!.fullNameEnglish}'
                : 'Add New Diagnosis',
            icon: FontAwesomeIcons.stethoscope,
            showBackButton: true,
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            sliver: SliverToBoxAdapter(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFormSection(
                      title: 'Core Condition',
                      children: [
                        _buildLabel('Condition Name'),
                        TextFormField(
                          controller: _conditionController,
                          decoration: fieldDecoration(
                            hint: 'e.g., Hypertension, Diabetes',
                            prefixIcon: FontAwesomeIcons.clipboardList,
                          ),
                          validator: (v) =>
                              v == null || v.isEmpty ? 'Required' : null,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildLabel('Status'),
                                  DropdownButtonFormField<DiagnosisStatus>(
                                    isExpanded: true,
                                    initialValue: _selectedStatus,
                                    items: DiagnosisStatus.values
                                        .map(
                                          (e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(
                                              e.name.toUpperCase(),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (v) =>
                                        setState(() => _selectedStatus = v),
                                    decoration: fieldDecoration(
                                      hint: 'Select Status',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildLabel('Severity'),
                                  DropdownButtonFormField<DiagnosisSeverity>(
                                    isExpanded: true,
                                    initialValue: _selectedSeverity,
                                    items: DiagnosisSeverity.values
                                        .map(
                                          (e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(
                                              e.name.toUpperCase(),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (v) =>
                                        setState(() => _selectedSeverity = v),
                                    decoration: fieldDecoration(
                                      hint: 'Select Severity',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    _buildFormSection(
                      title: 'Clinical Details',
                      children: [
                        _buildLabel('Diagnosis Date'),
                        TextFormField(
                          controller: _dateController,
                          readOnly: true,
                          onTap: () => _selectDate(context),
                          decoration: fieldDecoration(
                            hint: 'When was this diagnosed?',
                            prefixIcon: FontAwesomeIcons.calendarDay,
                            suffixIcon: Icons.calendar_today_rounded,
                          ),
                          validator: (v) =>
                              v == null || v.isEmpty ? 'Required' : null,
                        ),
                        const SizedBox(height: 20),
                        _buildLabel('Diagnosed By'),
                        TextFormField(
                          controller: _diagnosedByController,
                          decoration: fieldDecoration(
                            hint: 'Doctor or Hospital name',
                            prefixIcon: FontAwesomeIcons.userDoctor,
                          ),
                          validator: (v) =>
                              v == null || v.isEmpty ? 'Required' : null,
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    _buildFormSection(
                      title: 'Management & Notes',
                      children: [
                        _buildLabel('Symptoms'),
                        TextFormField(
                          controller: _symptomsController,
                          maxLines: 2,
                          decoration: fieldDecoration(
                            hint: 'What were the symptoms?',
                            prefixIcon: FontAwesomeIcons.notesMedical,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildLabel('Treatment Plan'),
                        TextFormField(
                          controller: _treatmentController,
                          maxLines: 2,
                          decoration: fieldDecoration(
                            hint: 'Current treatment or lifestyle changes',
                            prefixIcon: FontAwesomeIcons.handHoldingMedical,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildLabel('Additional Notes'),
                        TextFormField(
                          controller: _notesController,
                          maxLines: 3,
                          decoration: fieldDecoration(
                            hint: 'Any other information...',
                            prefixIcon: FontAwesomeIcons.fileLines,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildLabel('Service Cost (Optional)'),
                        TextFormField(
                          controller: _costController,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          decoration: fieldDecoration(
                            hint: 'e.g., 50.00',
                            prefixIcon: FontAwesomeIcons.moneyBillWave,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    _buildFormSection(
                      title: 'Supporting Documents',
                      children: [
                        _buildLabel('Diagnosis Documents (Optional)'),
                        _buildUploadedFiles(),
                        const SizedBox(height: 12),
                        _buildDocumentPicker(),
                      ],
                    ),
                    const SizedBox(height: 48),
                    AppPrimaryButton(
                      label: 'Save Diagnosis',
                      onPressed: _submit,
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadedFiles() {
    if (_selectedFiles.isEmpty) return const SizedBox.shrink();

    return Column(
      children: _selectedFiles.map((path) {
        final fileName = path.split('/').last;
        final isImage =
            path.toLowerCase().endsWith('.jpg') ||
            path.toLowerCase().endsWith('.jpeg') ||
            path.toLowerCase().endsWith('.png');
        final themeColor = isImage ? AppColors.accent : AppColors.primary;

        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: themeColor.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: themeColor.withValues(alpha: 0.1)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: themeColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: FaIcon(
                  isImage
                      ? FontAwesomeIcons.fileImage
                      : FontAwesomeIcons.filePdf,
                  size: 14,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fileName,
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      isImage ? 'Image Attachment' : 'PDF Report',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary.withValues(alpha: 0.6),
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.close_rounded,
                  size: 18,
                  color: AppColors.error,
                ),
                onPressed: () {
                  setState(() {
                    _selectedFiles.remove(path);
                  });
                },
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDocumentPicker() {
    return GestureDetector(
      onTap: () async {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          allowMultiple: true,
          type: FileType.custom,
          allowedExtensions: ['pdf', 'jpg', 'png'],
        );

        if (result != null) {
          setState(() {
            _selectedFiles.addAll(result.paths.whereType<String>());
          });
        }
      },
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          radius: const Radius.circular(14),
          dashPattern: const [8, 5],
          color: Colors.grey.shade400,
          strokeCap: StrokeCap.round,
          strokeWidth: 1.5,
          padding: const EdgeInsets.all(16),
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const FaIcon(
                  FontAwesomeIcons.cloudArrowUp,
                  color: AppColors.primary,
                  size: 24,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Upload medical records',
                style: AppTextStyles.titleSmall.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Select one or more files (PDF, JPG, PNG)',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.headlineSmall.copyWith(
            color: AppColors.primaryDark,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 20),
        ...children,
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Text(
        text,
        style: AppTextStyles.labelMedium.copyWith(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
