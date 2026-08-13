import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';
import 'package:libya_medical_record_system/core/shared/widgets/app_primary_button.dart';
import 'package:libya_medical_record_system/core/shared/widgets/snack_bar.dart';
import 'package:libya_medical_record_system/core/shared/widgets/text_field_input_decoration.dart';

import 'package:libya_medical_record_system/core/shared/widgets/sliver_page_header.dart';

class AddVitalPage extends StatefulWidget {
  const AddVitalPage({super.key});

  @override
  State<AddVitalPage> createState() => _AddVitalPageState();
}

class _AddVitalPageState extends State<AddVitalPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _tempController = TextEditingController();
  final _systolicController = TextEditingController();
  final _diastolicController = TextEditingController();
  final _heartRateController = TextEditingController();
  final _respRateController = TextEditingController();
  final _spo2Controller = TextEditingController();
  final _glucoseController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();

  @override
  void dispose() {
    for (var c in [
      _tempController,
      _systolicController,
      _diastolicController,
      _heartRateController,
      _respRateController,
      _spo2Controller,
      _glucoseController,
      _weightController,
      _heightController,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      snackBar(
        context: context,
        message: 'Vital signs logged successfully',
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
            title: 'Log Vitals',
            icon: FontAwesomeIcons.heartPulse,
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
                      title: 'Core Vitals',
                      children: [
                        _buildLabel('Body Temperature (°C)'),
                        TextFormField(
                          controller: _tempController,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          decoration: fieldDecoration(
                            hint: 'e.g., 36.8',
                            prefixIcon: FontAwesomeIcons.temperatureHalf,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildLabel('Systolic (BP)'),
                                  TextFormField(
                                    controller: _systolicController,
                                    keyboardType: TextInputType.number,
                                    decoration:
                                        fieldDecoration(hint: 'e.g., 120'),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildLabel('Diastolic (BP)'),
                                  TextFormField(
                                    controller: _diastolicController,
                                    keyboardType: TextInputType.number,
                                    decoration:
                                        fieldDecoration(hint: 'e.g., 80'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        _buildLabel('Heart Rate (BPM)'),
                        TextFormField(
                          controller: _heartRateController,
                          keyboardType: TextInputType.number,
                          decoration: fieldDecoration(
                            hint: 'e.g., 72',
                            prefixIcon: FontAwesomeIcons.heartPulse,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    _buildFormSection(
                      title: 'Respiratory & Metabolic',
                      children: [
                        _buildLabel('Oxygen Saturation (SpO2 %)'),
                        TextFormField(
                          controller: _spo2Controller,
                          keyboardType: TextInputType.number,
                          decoration: fieldDecoration(
                            hint: 'e.g., 99',
                            prefixIcon: FontAwesomeIcons.droplet,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildLabel('Blood Glucose (mg/dL)'),
                        TextFormField(
                          controller: _glucoseController,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          decoration: fieldDecoration(
                            hint: 'e.g., 95',
                            prefixIcon: FontAwesomeIcons.flask,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildLabel('Respiratory Rate (br/m)'),
                        TextFormField(
                          controller: _respRateController,
                          keyboardType: TextInputType.number,
                          decoration: fieldDecoration(
                            hint: 'e.g., 16',
                            prefixIcon: FontAwesomeIcons.wind,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    _buildFormSection(
                      title: 'Body Measurements',
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildLabel('Weight (kg)'),
                                  TextFormField(
                                    controller: _weightController,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                      decimal: true,
                                    ),
                                    decoration:
                                        fieldDecoration(hint: 'e.g., 75.5'),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildLabel('Height (cm)'),
                                  TextFormField(
                                    controller: _heightController,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                      decimal: true,
                                    ),
                                    decoration:
                                        fieldDecoration(hint: 'e.g., 175'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 48),
                    AppPrimaryButton(label: 'Save Vitals', onPressed: _submit),
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
