import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:libya_medical_record_system/core/constants/medication_constants.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';
import 'package:libya_medical_record_system/core/shared/widgets/app_primary_button.dart';
import 'package:libya_medical_record_system/core/shared/widgets/snack_bar.dart';
import 'package:libya_medical_record_system/core/shared/widgets/text_field_input_decoration.dart';

import 'package:libya_medical_record_system/core/shared/widgets/sliver_page_header.dart';

class AddMedicationPage extends StatefulWidget {
  const AddMedicationPage({super.key});

  @override
  State<AddMedicationPage> createState() => _AddMedicationPageState();
}

class _AddMedicationPageState extends State<AddMedicationPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _strengthController = TextEditingController();
  final _durationController = TextEditingController();
  final _instructionsController = TextEditingController();

  String? _selectedForm;
  String? _selectedFrequency;
  String? _selectedIntakeMethod;
  int _dosageCount = 1;

  @override
  void dispose() {
    _nameController.dispose();
    _strengthController.dispose();
    _durationController.dispose();
    _instructionsController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      snackBar(
        context: context,
        message: 'Medication saved successfully',
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
            title: 'Add Medication',
            icon: FontAwesomeIcons.pills,
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
                      title: 'General Info',
                      children: [
                        _buildLabel('Medication Name'),
                        TextFormField(
                          controller: _nameController,
                          decoration: fieldDecoration(
                            hint: 'e.g., Amoxicillin',
                            prefixIcon: FontAwesomeIcons.pills,
                          ),
                          validator: (v) =>
                              v == null || v.isEmpty ? 'Required' : null,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildLabel('Strength'),
                                  TextFormField(
                                    controller: _strengthController,
                                    decoration:
                                        fieldDecoration(hint: 'e.g., 500 mg'),
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
                                  _buildLabel('Form'),
                                  DropdownButtonFormField<String>(
                                    isExpanded: true,
                                    initialValue: _selectedForm,
                                    items: MedicationConstants.forms
                                        .map(
                                          (e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(
                                              e,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (v) =>
                                        setState(() => _selectedForm = v),
                                    decoration:
                                        fieldDecoration(hint: 'Select Form'),
                                    validator: (v) =>
                                        v == null ? 'Required' : null,
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
                      title: 'Dosage & Schedule',
                      children: [
                        _buildLabel('Dosage'),
                        _buildDosageCounter(),
                        const SizedBox(height: 20),
                        _buildLabel('Frequency'),
                        DropdownButtonFormField<String>(
                          isExpanded: true,
                          initialValue: _selectedFrequency,
                          items: MedicationConstants.frequencies
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child:
                                      Text(e, overflow: TextOverflow.ellipsis),
                                ),
                              )
                              .toList(),
                          onChanged: (v) =>
                              setState(() => _selectedFrequency = v),
                          decoration: fieldDecoration(
                            hint: 'Select Frequency',
                            prefixIcon: FontAwesomeIcons.clock,
                          ),
                          validator: (v) => v == null ? 'Required' : null,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildLabel('Duration (Days)'),
                                  TextFormField(
                                    controller: _durationController,
                                    keyboardType: TextInputType.number,
                                    decoration: fieldDecoration(
                                      hint: 'e.g., 7',
                                      prefixIcon:
                                          FontAwesomeIcons.hourglassHalf,
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
                                  _buildLabel('Intake Method'),
                                  DropdownButtonFormField<String>(
                                    isExpanded: true,
                                    initialValue: _selectedIntakeMethod,
                                    items: MedicationConstants.intakeMethods
                                        .map(
                                          (e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(
                                              e,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (v) => setState(
                                        () => _selectedIntakeMethod = v),
                                    decoration: fieldDecoration(hint: 'Method'),
                                    validator: (v) =>
                                        v == null ? 'Required' : null,
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
                      title: 'Instructions',
                      children: [
                        _buildLabel('Special Instructions'),
                        TextFormField(
                          controller: _instructionsController,
                          maxLines: 3,
                          decoration: fieldDecoration(
                            hint: 'e.g., Take with food...',
                            prefixIcon: FontAwesomeIcons.circleInfo,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 48),
                    AppPrimaryButton(
                      label: 'Save Medication',
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

  Widget _buildDosageCounter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              FaIcon(
                FontAwesomeIcons.scaleBalanced,
                size: 18,
                color: AppColors.primary.withValues(alpha: 0.6),
              ),
              const SizedBox(width: 16),
              Text(
                'Amount per dose',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          Row(
            children: [
              _buildCounterButton(
                icon: Icons.remove,
                onTap: () {
                  if (_dosageCount > 1) {
                    setState(() => _dosageCount--);
                  }
                },
              ),
              Container(
                constraints: const BoxConstraints(minWidth: 40),
                alignment: Alignment.center,
                child: Text(
                  _dosageCount.toString(),
                  style: AppTextStyles.titleMedium.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _buildCounterButton(
                icon: Icons.add,
                onTap: () => setState(() => _dosageCount++),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCounterButton({
    required dynamic icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primarySurface.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: icon is IconData
            ? Icon(icon, size: 18, color: AppColors.primary)
            : FaIcon(icon, size: 18, color: AppColors.primary),
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
