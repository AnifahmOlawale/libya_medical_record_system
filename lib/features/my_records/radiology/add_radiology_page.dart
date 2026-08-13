import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:libya_medical_record_system/core/constants/radiology_constants.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';
import 'package:libya_medical_record_system/core/shared/widgets/app_primary_button.dart';
import 'package:libya_medical_record_system/core/shared/widgets/snack_bar.dart';
import 'package:libya_medical_record_system/core/shared/widgets/text_field_input_decoration.dart';
import 'package:libya_medical_record_system/data/models/radiology_model.dart';

import 'package:libya_medical_record_system/core/shared/widgets/sliver_page_header.dart';

class AddRadiologyPage extends StatefulWidget {
  const AddRadiologyPage({super.key});

  @override
  State<AddRadiologyPage> createState() => _AddRadiologyPageState();
}

class _AddRadiologyPageState extends State<AddRadiologyPage> {
  final _formKey = GlobalKey<FormState>();
  final _studyNameController = TextEditingController();
  final _bodyPartController = TextEditingController();
  final _institutionController = TextEditingController();
  final _dateController = TextEditingController();
  final _radiologistController = TextEditingController();
  final _findingsController = TextEditingController();
  final _impressionController = TextEditingController();
  final _indicationController = TextEditingController();
  final _otherModalityController = TextEditingController();
  final _costController = TextEditingController();

  RadiologyModality? _selectedModality = RadiologyModality.xRay;
  DateTime? _studyDate;
  final List<String> _reportFiles = [];

  @override
  void dispose() {
    _studyNameController.dispose();
    _bodyPartController.dispose();
    _institutionController.dispose();
    _dateController.dispose();
    _radiologistController.dispose();
    _findingsController.dispose();
    _impressionController.dispose();
    _indicationController.dispose();
    _otherModalityController.dispose();
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
        _studyDate = picked;
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      snackBar(
        context: context,
        message: 'Radiology report saved successfully',
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
          const SliverPageHeader(
            title: 'Add Radiology Study',
            icon: FontAwesomeIcons.xRay,
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
                      title: 'Study Information',
                      children: [
                        _buildLabel('Study Name'),
                        TextFormField(
                          controller: _studyNameController,
                          decoration: fieldDecoration(
                            hint: 'e.g., MRI Brain with Contrast',
                            prefixIcon: FontAwesomeIcons.clipboardCheck,
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
                                  _buildLabel('Modality'),
                                  DropdownButtonFormField<RadiologyModality>(
                                    isExpanded: true,
                                    initialValue: _selectedModality,
                                    items: RadiologyModality.values
                                        .map(
                                          (e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(
                                              RadiologyConstants
                                                      .modalityLabels[e] ??
                                                  e.name.toUpperCase(),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (v) =>
                                        setState(() => _selectedModality = v),
                                    decoration: fieldDecoration(hint: 'Select'),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildLabel('Body Part'),
                                  TextFormField(
                                    controller: _bodyPartController,
                                    decoration: fieldDecoration(
                                      hint: 'e.g., Chest',
                                      prefixIcon: FontAwesomeIcons.person,
                                    ),
                                    validator: (v) => v == null || v.isEmpty
                                        ? 'Required'
                                        : null,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        if (_selectedModality == RadiologyModality.other) ...[
                          const SizedBox(height: 20),
                          _buildLabel('Specify Modality'),
                          TextFormField(
                            controller: _otherModalityController,
                            decoration: fieldDecoration(
                              hint: 'e.g., Dexa Scan, Echo',
                              prefixIcon: FontAwesomeIcons.stethoscope,
                            ),
                            validator: (v) =>
                                _selectedModality == RadiologyModality.other &&
                                        (v == null || v.isEmpty)
                                    ? 'Required'
                                    : null,
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 32),
                    _buildFormSection(
                      title: 'Clinical Details',
                      children: [
                        _buildLabel('Study Date'),
                        TextFormField(
                          controller: _dateController,
                          readOnly: true,
                          onTap: () => _selectDate(context),
                          decoration: fieldDecoration(
                            hint: 'When was this performed?',
                            prefixIcon: FontAwesomeIcons.calendarDay,
                          ),
                          validator: (v) =>
                              v == null || v.isEmpty ? 'Required' : null,
                        ),
                        const SizedBox(height: 20),
                        _buildLabel('Institution / Hospital'),
                        TextFormField(
                          controller: _institutionController,
                          decoration: fieldDecoration(
                            hint: 'Imaging facility name',
                            prefixIcon: FontAwesomeIcons.hospital,
                          ),
                          validator: (v) =>
                              v == null || v.isEmpty ? 'Required' : null,
                        ),
                        const SizedBox(height: 20),
                        _buildLabel('Reporting Radiologist'),
                        TextFormField(
                          controller: _radiologistController,
                          decoration: fieldDecoration(
                            hint: 'Doctor who read the scan',
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
                        _buildLabel('Clinical Indication'),
                        TextFormField(
                          controller: _indicationController,
                          decoration: fieldDecoration(
                            hint: 'Reason for the study',
                            prefixIcon: FontAwesomeIcons.commentMedical,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildLabel('Findings'),
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
                        _buildLabel('Impression (Conclusion)'),
                        TextFormField(
                          controller: _impressionController,
                          maxLines: 3,
                          decoration: fieldDecoration(
                            hint: 'Main takeaway or diagnosis...',
                            prefixIcon: FontAwesomeIcons.quoteLeft,
                          ),
                          validator: (v) =>
                              v == null || v.isEmpty ? 'Required' : null,
                        ),
                        const SizedBox(height: 20),
                        _buildLabel('Study Cost (Optional)'),
                        TextFormField(
                          controller: _costController,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          decoration: fieldDecoration(
                            hint: 'e.g., 120.00',
                            prefixIcon: FontAwesomeIcons.moneyBillWave,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    _buildFormSection(
                      title: 'Attachments',
                      children: [
                        _buildLabel('Study Reports & Scans (Optional)'),
                        _buildFileList(_reportFiles),
                        const SizedBox(height: 12),
                        _buildUploadZone(
                          label: 'Upload Documents',
                          sublabel: 'PDF, JPG, PNG (Max 10 files)',
                          icon: FontAwesomeIcons.cloudArrowUp,
                          color: AppColors.primary,
                          onTap: _pickFiles,
                        ),
                      ],
                    ),
                    const SizedBox(height: 48),
                    AppPrimaryButton(
                      label: 'Save Radiology Study',
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

  Future<void> _pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
    );

    if (result != null) {
      setState(() {
        _reportFiles.addAll(result.paths.whereType<String>());
      });
    }
  }

  Widget _buildFileList(List<String> files) {
    if (files.isEmpty) return const SizedBox.shrink();

    return Column(
      children: files.map((path) {
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
                      isImage ? 'Image Attachment' : 'Radiology Report PDF',
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
                onPressed: () => setState(() => files.remove(path)),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildUploadZone({
    required String label,
    required String sublabel,
    required dynamic icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
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
                  color: color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: icon is IconData
                    ? Icon(icon, color: color, size: 22)
                    : FaIcon(icon, color: color, size: 22),
              ),
              const SizedBox(height: 12),
              Text(
                label,
                style: AppTextStyles.titleSmall.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                sublabel,
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
