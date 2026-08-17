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

class AddAllergyPage extends StatefulWidget {
  const AddAllergyPage({super.key, this.patient});

  final UserRegistrationModel? patient;

  @override
  State<AddAllergyPage> createState() => _AddAllergyPageState();
}

class _AddAllergyPageState extends State<AddAllergyPage> {
  final _formKey = GlobalKey<FormState>();
  final _allergenController = TextEditingController();
  final _reactionController = TextEditingController();
  final _notesController = TextEditingController();
  final _dateController = TextEditingController();
  DateTime? _onsetDate;

  @override
  void dispose() {
    _allergenController.dispose();
    _reactionController.dispose();
    _notesController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final now = DateTime.now();
    final initialDate = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: now,
    );
    if (picked != null) {
      setState(() {
        _onsetDate = picked;
        _dateController.text = DateFormat('dd MMM, yyyy').format(picked);
      });
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      debugPrint('Saving allergy with onset date: $_onsetDate');
      // TODO: Implementation for saving the allergy
      snackBar(
        context: context,
        message: 'Allergy record saved successfully',
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
                ? 'Allergy: ${widget.patient!.personalInfo!.fullNameEnglish}'
                : 'Add New Allergy',
            icon: FontAwesomeIcons.triangleExclamation,
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
                      title: 'Basic Information',
                      children: [
                        _buildLabel('Allergen Name'),
                        TextFormField(
                          controller: _allergenController,
                          decoration: fieldDecoration(
                            hint: 'e.g., Penicillin, Peanuts, Pollen',
                            prefixIcon: FontAwesomeIcons.virus,
                          ),
                          validator: (value) => value == null || value.isEmpty
                              ? 'Allergen name is required'
                              : null,
                        ),
                        const SizedBox(height: 20),
                        _buildLabel('Reaction Details'),
                        TextFormField(
                          controller: _reactionController,
                          maxLines: 2,
                          decoration: fieldDecoration(
                            hint:
                                'Describe what happens (e.g., Hives, Swelling)',
                            prefixIcon: FontAwesomeIcons.bolt,
                          ),
                          validator: (value) => value == null || value.isEmpty
                              ? 'Reaction details are required'
                              : null,
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    _buildFormSection(
                      title: 'History & Notes',
                      children: [
                        _buildLabel('Discovery Date (Optional)'),
                        TextFormField(
                          controller: _dateController,
                          readOnly: true,
                          onTap: () => _selectDate(context),
                          decoration: fieldDecoration(
                            hint: 'Select onset date',
                            suffixIcon: Icons.calendar_today_rounded,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildLabel('Additional Notes'),
                        TextFormField(
                          controller: _notesController,
                          maxLines: 4,
                          decoration: fieldDecoration(
                            hint:
                                'Any other information or medical precautions...',
                            prefixIcon: FontAwesomeIcons.fileMedical,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 48),
                    AppPrimaryButton(
                      label: 'Save Allergy Record',
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
