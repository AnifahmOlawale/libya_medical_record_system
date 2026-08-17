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
import 'package:libya_medical_record_system/data/models/user_registration_model.dart';

import 'package:libya_medical_record_system/core/shared/widgets/sliver_page_header.dart';

class AddImmunizationPage extends StatefulWidget {
  const AddImmunizationPage({super.key, this.patient});

  final UserRegistrationModel? patient;

  @override
  State<AddImmunizationPage> createState() => _AddImmunizationPageState();
}

class _AddImmunizationPageState extends State<AddImmunizationPage> {
  final _formKey = GlobalKey<FormState>();
  final _vaccineController = TextEditingController();
  final _doseController = TextEditingController();
  final _manufacturerController = TextEditingController();
  final _batchController = TextEditingController();
  final _adminByController = TextEditingController();
  final _dateController = TextEditingController();
  final _nextDueController = TextEditingController();
  final _effectsController = TextEditingController();
  final _costController = TextEditingController();

  DateTime? _dateAdministered;
  DateTime? _nextDueDate;
  final List<String> _selectedFiles = [];

  @override
  void dispose() {
    _vaccineController.dispose();
    _doseController.dispose();
    _manufacturerController.dispose();
    _batchController.dispose();
    _adminByController.dispose();
    _dateController.dispose();
    _nextDueController.dispose();
    _effectsController.dispose();
    _costController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isAdminDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: isAdminDate ? DateTime.now() : DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isAdminDate) {
          _dateAdministered = picked;
          _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
        } else {
          _nextDueDate = picked;
          _nextDueController.text = DateFormat('yyyy-MM-dd').format(picked);
        }
      });
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      debugPrint(
        'Saving immunization: Administered on $_dateAdministered, Next due: $_nextDueDate',
      );
      snackBar(
        context: context,
        message: 'Immunization record saved successfully',
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
                ? 'Vaccinate ${widget.patient!.personalInfo!.fullNameEnglish}'
                : 'Add Vaccination',
            icon: FontAwesomeIcons.syringe,
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
                      title: 'Vaccine Details',
                      children: [
                        _buildLabel('Vaccine Name'),
                        TextFormField(
                          controller: _vaccineController,
                          decoration: fieldDecoration(
                            hint: 'e.g., Hepatitis B, Influenza',
                            prefixIcon: FontAwesomeIcons.syringe,
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
                                  _buildLabel('Dose Number'),
                                  TextFormField(
                                    controller: _doseController,
                                    decoration: fieldDecoration(
                                      hint: 'e.g., 1st Dose',
                                      prefixIcon: FontAwesomeIcons.listOl,
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
                                  _buildLabel('Administered Date'),
                                  TextFormField(
                                    controller: _dateController,
                                    readOnly: true,
                                    onTap: () => _selectDate(context, true),
                                    decoration: fieldDecoration(
                                      hint: 'Select date',
                                      prefixIcon: FontAwesomeIcons.calendarDay,
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
                      ],
                    ),
                    const SizedBox(height: 32),
                    _buildFormSection(
                      title: 'Safety & Manufacturer',
                      children: [
                        _buildLabel('Manufacturer (Optional)'),
                        TextFormField(
                          controller: _manufacturerController,
                          decoration: fieldDecoration(
                            hint: 'e.g., Pfizer, Sanofi',
                            prefixIcon: FontAwesomeIcons.industry,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildLabel('Batch / Lot Number (Optional)'),
                        TextFormField(
                          controller: _batchController,
                          decoration: fieldDecoration(
                            hint: 'Safety tracking number',
                            prefixIcon: FontAwesomeIcons.barcode,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildLabel('Administered By'),
                        TextFormField(
                          controller: _adminByController,
                          decoration: fieldDecoration(
                            hint: 'Clinic or provider name',
                            prefixIcon: FontAwesomeIcons.hospital,
                          ),
                          validator: (v) =>
                              v == null || v.isEmpty ? 'Required' : null,
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    _buildFormSection(
                      title: 'Schedule & Reactions',
                      children: [
                        _buildLabel('Next Dose Due (Optional)'),
                        TextFormField(
                          controller: _nextDueController,
                          readOnly: true,
                          onTap: () => _selectDate(context, false),
                          decoration: fieldDecoration(
                            hint: 'Booster due date',
                            prefixIcon: FontAwesomeIcons.calendarCheck,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildLabel('Side Effects (Optional)'),
                        TextFormField(
                          controller: _effectsController,
                          maxLines: 2,
                          decoration: fieldDecoration(
                            hint: 'Any reactions noted...',
                            prefixIcon: FontAwesomeIcons.commentMedical,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildLabel('Vaccination Cost (Optional)'),
                        TextFormField(
                          controller: _costController,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          decoration: fieldDecoration(
                            hint: 'e.g., 25.00',
                            prefixIcon: FontAwesomeIcons.moneyBillWave,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    _buildFormSection(
                      title: 'Supporting Documents',
                      children: [
                        _buildLabel('Vaccination Card Scans (Optional)'),
                        _buildUploadedFiles(),
                        const SizedBox(height: 12),
                        _buildDocumentPicker(),
                      ],
                    ),
                    const SizedBox(height: 48),
                    AppPrimaryButton(
                      label: 'Save Vaccination Record',
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
                      isImage ? 'Card Photo' : 'Official Document PDF',
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
                'Select card photos or certificates (PDF, JPG, PNG)',
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
