import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:libya_medical_record_system/core/constants/record_constants.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';
import 'package:libya_medical_record_system/core/shared/widgets/app_primary_button.dart';
import 'package:libya_medical_record_system/features/permissions/widgets/qr_code_display.dart';

class GenerateTokenDialog extends StatefulWidget {
  const GenerateTokenDialog({super.key});

  @override
  State<GenerateTokenDialog> createState() => _GenerateTokenDialogState();
}

class _GenerateTokenDialogState extends State<GenerateTokenDialog> {
  final List<String> _selectedModules = ['Medical Information'];
  int _selectedDurationMinutes = 30;
  String? _generatedToken;
  bool _isGenerating = false;

  final List<Map<String, dynamic>> _durations = [
    {'label': '15 M', 'value': 15},
    {'label': '30 M', 'value': 30},
    {'label': '1 H', 'value': 60},
    {'label': '4 H', 'value': 240},
    {'label': '24 H', 'value': 1440},
  ];

  void _toggleModule(String module) {
    setState(() {
      if (_selectedModules.contains(module)) {
        if (_selectedModules.length > 1) _selectedModules.remove(module);
      } else {
        _selectedModules.add(module);
      }
    });
  }

  Future<void> _generate() async {
    setState(() => _isGenerating = true);

    // Simulate API/Generation delay
    await Future.delayed(const Duration(milliseconds: 1500));

    // Generate a unique token using UUID
    const uuid = Uuid();
    final token = uuid.v4();

    setState(() {
      _generatedToken = token;
      _isGenerating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500),
        child: Stack(
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              child: _generatedToken != null
                  ? _buildSuccessView()
                  : _buildConfigurationView(),
            ),
            Positioned(
              right: 12,
              top: 12,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close_rounded),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.grey.shade100,
                  iconSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConfigurationView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 48, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Configure Access',
                style: AppTextStyles.titleLarge.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                'What records will you share?',
                style: AppTextStyles.bodySmall,
              ),
            ],
          ),
        ),
        const Divider(),
        Flexible(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Permissions',
                  style: AppTextStyles.labelMedium.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: RecordConstants.categories.map((module) {
                    final isSelected = _selectedModules.contains(module);
                    return FilterChip(
                      label: Text(module),
                      selected: isSelected,
                      onSelected: (_) => _toggleModule(module),
                      selectedColor: AppColors.primary.withValues(alpha: 0.1),
                      checkmarkColor: AppColors.primary,
                      labelStyle: AppTextStyles.labelSmall.copyWith(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.textSecondary,
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.normal,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: isSelected
                              ? AppColors.primary
                              : Colors.grey.withValues(alpha: 0.2),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 32),
                Text(
                  'Access Duration',
                  style: AppTextStyles.labelMedium.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: _durations.map((duration) {
                    final isSelected =
                        _selectedDurationMinutes == duration['value'];
                    return ChoiceChip(
                      label: Text(duration['label']),
                      selected: isSelected,
                      onSelected: (val) => setState(
                        () => _selectedDurationMinutes = duration['value'],
                      ),
                      selectedColor: AppColors.primary,
                      labelStyle: AppTextStyles.labelSmall.copyWith(
                        color:
                            isSelected ? Colors.white : AppColors.textSecondary,
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.normal,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(24),
          child: AppPrimaryButton(
            label: 'Generate Token',
            isLoading: _isGenerating,
            onPressed: _generate,
          ),
        ),
      ],
    );
  }

  Widget _buildSuccessView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.success.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_circle_rounded,
              color: AppColors.success,
              size: 40,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Access Token Ready',
            style: AppTextStyles.titleLarge.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            'Show this to your healthcare provider',
            style: AppTextStyles.bodySmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          QrCodeDisplay(token: _generatedToken!, qrSize: 160),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
