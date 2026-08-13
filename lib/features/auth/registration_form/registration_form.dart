import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:libya_medical_record_system/core/constants/breakpoints.dart';
import 'package:libya_medical_record_system/core/router/app_router.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';
import 'package:libya_medical_record_system/data/models/medical_info_data.dart';
import 'package:libya_medical_record_system/data/models/user_registration_model.dart';
import 'package:libya_medical_record_system/data/providers/dashboard_provider.dart';
import 'package:libya_medical_record_system/features/auth/registration_form/medical_info_form.dart';
import 'package:libya_medical_record_system/data/models/professional_info_data.dart';
import 'package:libya_medical_record_system/features/auth/registration_form/professional_info_form.dart';
import 'package:libya_medical_record_system/data/models/personal_info_data.dart';
import 'package:libya_medical_record_system/features/auth/registration_form/personal_info_form.dart';
import 'package:provider/provider.dart';
import 'role_form.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm>
    with AutomaticKeepAliveClientMixin {
  UserType? _userType;

  PersonalInfoData? _personalInfo;
  ProfessionalInfoData? _professionalInfo;
  MedicalInfoData? _medicalInfo;

  final PageController controller = PageController();

  UserRegistrationModel? registrationData;

  int _currentPage = 0;
  int _totalPages = 4;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  // Displayed step number is different for patient vs healthcare professional
  int get _displayStep {
    if (_userType == UserType.patient) {
      switch (_currentPage) {
        case 0:
          return 1;
        case 1:
          return 2;
        case 3:
          return 3;
        default:
          return 1;
      }
    }

    return _currentPage + 1;
  }

  void _handleUserTypeSelected(UserType userType) {
    setState(() {
      _userType = userType;
      _totalPages = userType == UserType.patient ? 3 : 4;
      context.read<DashboardProvider>().changeUser(userType: userType);
    });
  }

  void _handleUserTypeOnContinue() {
    controller.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _handlePersonalInfoContinue(PersonalInfoData data) {
    setState(() {
      _personalInfo = data;
    });

    if (_userType == UserType.patient) {
      // Skip professional page completely (no animation)
      controller.jumpToPage(3);
    } else {
      controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _handleProfessionalInfoContinue(ProfessionalInfoData data) {
    setState(() {
      _professionalInfo = data;
    });

    controller.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _handleMedicalInfoContinue(MedicalInfoData data) {
    setState(() {
      _medicalInfo = data;

      registrationData = UserRegistrationModel(
        userType: _userType,
        personalInfo: _personalInfo,
        professionalInfo: _professionalInfo,
        medicalInfo: _medicalInfo,
      );
    });

    context.go(AppRoutes.dashboard);
  }

  String _getStepTitle() {
    if (_userType == UserType.patient) {
      switch (_displayStep) {
        case 1:
          return 'Account Type';
        case 2:
          return 'Personal Info';
        case 3:
          return 'Medical Info';
        default:
          return '';
      }
    }

    switch (_displayStep) {
      case 1:
        return 'Account Type';
      case 2:
        return 'Personal Info';
      case 3:
        return 'Professional Info';
      case 4:
        return 'Medical Info';
      default:
        return '';
    }
  }

  void _handleBack() {
    if (_currentPage == 0) return;

    // Personal page -> Role page
    if (_currentPage == 1) {
      controller.jumpToPage(0);
      return;
    }

    // Professional page -> Personal page
    if (_currentPage == 2) {
      controller.jumpToPage(1);
      return;
    }

    // Medical page
    if (_currentPage == 3) {
      if (_userType == UserType.patient) {
        // Patient skipped page 2, so go back to page 1
        controller.jumpToPage(1);
      } else {
        controller.jumpToPage(2);
      }
    }
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Step $_displayStep of $_totalPages',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                _getStepTitle(),
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: _displayStep / _totalPages,
            backgroundColor: AppColors.divider,
            valueColor: AlwaysStoppedAnimation(AppColors.primary),
            minHeight: 6,
            borderRadius: BorderRadius.circular(3),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: PopScope(
        canPop: _currentPage == 0,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;

          _handleBack();
        },
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: Breakpoints.mobile),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_currentPage != 0)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      child: GestureDetector(
                        onTap: _handleBack,
                        child: const Icon(Icons.arrow_back_ios_new_rounded),
                      ),
                    ),

                  _buildProgressIndicator(),

                  Expanded(
                    child: PageView(
                      controller: controller,
                      physics: const NeverScrollableScrollPhysics(),
                      onPageChanged: _onPageChanged,
                      children: [
                        RoleForm(
                          onUserTypeSelected: _handleUserTypeSelected,
                          onContinue: _handleUserTypeOnContinue,
                          initialUserType: _userType,
                        ),

                        PersonalInfoForm(
                          onContinue: _handlePersonalInfoContinue,
                          initialData: _personalInfo,
                        ),

                        ProfessionalInfoForm(
                          onContinue: _handleProfessionalInfoContinue,
                          initialData: _professionalInfo,
                        ),

                        MedicalInfoForm(
                          onContinue: _handleMedicalInfoContinue,
                          initialData: _medicalInfo,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
