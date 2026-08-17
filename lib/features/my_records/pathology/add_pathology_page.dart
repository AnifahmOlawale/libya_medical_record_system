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
import 'package:libya_medical_record_system/data/models/pathology_model.dart';
import 'package:libya_medical_record_system/data/models/user_registration_model.dart';

import 'package:libya_medical_record_system/core/shared/widgets/sliver_page_header.dart';

class AddPathologyPage extends StatefulWidget {
  const AddPathologyPage({super.key, this.patient});

  final UserRegistrationModel? patient;

  @override
  State<AddPathologyPage> createState() => _AddPathologyPageState();
}

class _AddPathologyPageState extends State<AddPathologyPage> {
  final _formKey = GlobalKey<FormState>();
  final _specimenController = TextEditingController();
  final _siteController = TextEditingController();
  final _institutionController = TextEditingController();
  final _dateController = TextEditingController();
  final _pathologistController = TextEditingController();
  final _findingsController = TextEditingController();
  final _diagnosisController = TextEditingController();
  final _costController = TextEditingController();

  PathologyStatus? _selectedStatus = PathologyStatus.normal;
  DateTime? _collectionDate;
  final List<String> _selectedFiles = [];

  @override
  void dispose() {
    _specimenController.dispose();
    _siteController.dispose();
    _institutionController.dispose();
    _dateController.dispose();
    _pathologistController.dispose();
    _findingsController.dispose();
    _diagnosisController.dispose();
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
        _collectionDate = picked;
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      debugPrint(
        'Saving pathology record with collection date: $_collectionDate',
      );
      snackBar(
        context: context,
        message: 'Pathology record saved successfully',
        type: SnackTypeEnum.success,
      );
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
                ? 'Pathology: ${widget.patient!.personalInfo!.fullNameEnglish}'
                : 'Add Pathology Study',
            icon: FontAwesomeIcons.microscope,
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
                      title: 'Specimen Details',
                      children: [
                        _buildLabel('Specimen Type'),
                        TextFormField(
                          controller: _specimenController,
                          decoration: fieldDecoration(
                            hint: 'e.g., Skin Biopsy, Cervical Smear',
                            prefixIcon: FontAwesomeIcons.vials,
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
                                  _buildLabel('Anatomic Site'),
                                  TextFormField(
                                    controller: _siteController,
                                    decoration: fieldDecoration(
                                      hint: 'e.g., Right Breast',
                                      prefixIcon:
                                          FontAwesomeIcons.personDotsFromLine,
                                    ),
                                    validator: (v) => v == null || v.isEmpty
                                        ? 'Required'
                                        : null,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildLabel('Status'),
                                  DropdownButtonFormField<PathologyStatus>(
                                    isExpanded: true,
                                    initialValue: _selectedStatus,
                                    items: PathologyStatus.values
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
                                    decoration: fieldDecoration(hint: 'Status'),
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
                        _buildLabel('Collection Date'),
                        TextFormField(
                          controller: _dateController,
                          readOnly: true,
                          onTap: () => _selectDate(context),
                          decoration: fieldDecoration(
                            hint: 'When was sample taken?',
                            prefixIcon: FontAwesomeIcons.calendarDay,
                          ),
                          validator: (v) =>
                              v == null || v.isEmpty ? 'Required' : null,
                        ),
                        const SizedBox(height: 20),
                        _buildLabel('Institution / Lab'),
                        TextFormField(
                          controller: _institutionController,
                          decoration: fieldDecoration(
                            hint: 'Pathology facility name',
                            prefixIcon: FontAwesomeIcons.hospital,
                          ),
                          validator: (v) =>
                              v == null || v.isEmpty ? 'Required' : null,
                        ),
                        const SizedBox(height: 20),
                        _buildLabel('Reporting Pathologist'),
                        TextFormField(
                          controller: _pathologistController,
                          decoration: fieldDecoration(
                            hint: 'Doctor who read the sample',
                            prefixIcon: FontAwesomeIcons.userDoctor,
                          ),
                          validator: (v) =>
                              v == null || v.isEmpty ? 'Required' : null,
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    _buildFormSection(
                      title: 'Observations',
                      children: [
                        _buildLabel('Findings (Macro & Micro)'),
                        TextFormField(
                          controller: _findingsController,
                          maxLines: 4,
                          decoration: fieldDecoration(
                            hint: 'Detailed observations...',
                            prefixIcon: FontAwesomeIcons.fileLines,
                          ),
                          validator: (v) =>
                              v == null || v.isEmpty ? 'Required' : null,
                        ),
                        const SizedBox(height: 20),
                        _buildLabel('Final Diagnosis'),
                        TextFormField(
                          controller: _diagnosisController,
                          maxLines: 3,
                          decoration: fieldDecoration(
                            hint: 'Definitive conclusion...',
                            prefixIcon: FontAwesomeIcons.clipboardCheck,
                          ),
                          validator: (v) =>
                              v == null || v.isEmpty ? 'Required' : null,
                        ),
                        const SizedBox(height: 20),
                        _buildLabel('Analysis Cost (Optional)'),
                        TextFormField(
                          controller: _costController,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          decoration: fieldDecoration(
                            hint: 'e.g., 150.00',
                            prefixIcon: FontAwesomeIcons.moneyBillWave,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    _buildFormSection(
                      title: 'Supporting Documents',
                      children: [
                        _buildLabel('Reports & Micro-photos (Optional)'),
                        _buildUploadedFiles(),
                        const SizedBox(height: 12),
                        _buildDocumentPicker(),
                      ],
                    ),
                    const SizedBox(height: 48),
                    AppPrimaryButton(
                      label: 'Save Pathology Study',
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
                      isImage ? 'Image Attachment' : 'Pathology Report PDF',
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
                onPressed: () => setState(() => _selectedFiles.remove(path)),
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
                'Upload documents',
                style: AppTextStyles.titleSmall.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Select reports or scans (PDF, JPG, PNG)',
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
