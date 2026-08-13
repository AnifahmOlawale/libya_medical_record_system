import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:libya_medical_record_system/core/constants/record_constants.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';
import 'package:libya_medical_record_system/core/shared/widgets/app_primary_button.dart';
import 'package:libya_medical_record_system/core/shared/widgets/snack_bar.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class GenerateTokenSheet extends StatefulWidget {
  const GenerateTokenSheet({super.key});

  @override
  State<GenerateTokenSheet> createState() => _GenerateTokenSheetState();
}

class _GenerateTokenSheetState extends State<GenerateTokenSheet> {
  final List<String> _selectedModules = ['Medical Information'];
  int _selectedDurationMinutes = 30;
  String? _generatedToken;
  bool _isGenerating = false;

  final List<Map<String, dynamic>> _durations = [
    {'label': '15 Mins', 'value': 15},
    {'label': '30 Mins', 'value': 30},
    {'label': '1 Hour', 'value': 60},
    {'label': '4 Hours', 'value': 240},
    {'label': '24 Hours', 'value': 1440},
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

    final random = Random();
    final token = (100000 + random.nextInt(900000)).toString();

    setState(() {
      _generatedToken = token;
      _isGenerating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        child: _generatedToken != null
            ? _buildSuccessView()
            : _buildConfigurationView(),
      ),
    );
  }

  Widget _buildConfigurationView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Configure Access',
            style: AppTextStyles.headlineSmall.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            'Select the records you want to share',
            style: AppTextStyles.bodySmall,
          ),
          const SizedBox(height: 24),
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
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal,
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
          SizedBox(
            height: 45,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _durations.length,
              separatorBuilder: (_, _) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final duration = _durations[index];
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
                    color: isSelected ? Colors.white : AppColors.textSecondary,
                    fontWeight: isSelected
                        ? FontWeight.w700
                        : FontWeight.normal,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 40),
          AppPrimaryButton(
            label: 'Generate Token',
            isLoading: _isGenerating,
            onPressed: _generate,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildSuccessView() {
    final tokenWithSpace =
        '${_generatedToken!.substring(0, 3)} ${_generatedToken!.substring(3)}';

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
            'Securely share clinical access',
            style: AppTextStyles.bodySmall,
          ),
          const SizedBox(height: 32),

          // Fixed QR Code Section with PrettyQr 3.x classes
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 30,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: SizedBox(
              width: 200,
              height: 200,
              child: PrettyQrView.data(
                data: _generatedToken!,
                decoration: const PrettyQrDecoration(
                  shape: PrettyQrSmoothSymbol(color: AppColors.primary),
                ),
              ),
            ),
          ),

          const SizedBox(height: 32),

          // Token Display
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.1),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  tokenWithSpace,
                  style: AppTextStyles.displayLarge.copyWith(
                    letterSpacing: 4,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(width: 16),
                IconButton(
                  icon: const Icon(
                    Icons.copy_rounded,
                    color: AppColors.primary,
                  ),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: _generatedToken!));
                    snackBar(
                      context: context,
                      message: 'Token copied to clipboard',
                      type: SnackTypeEnum.success,
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(
                    Icons.share_rounded,
                    color: AppColors.primary,
                  ),
                  onPressed: () {
                    snackBar(
                      context: context,
                      message: 'Sharing feature coming soon',
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),
          AppPrimaryButton(
            label: 'Dismiss',
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
