import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:libya_medical_record_system/core/router/app_router.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';
import 'package:libya_medical_record_system/core/shared/widgets/empty_state_widget.dart';
import 'package:libya_medical_record_system/core/shared/widgets/sliver_page_header.dart';
import 'package:libya_medical_record_system/core/shared/widgets/snack_bar.dart';
import 'package:libya_medical_record_system/core/shared/widgets/text_field_input_decoration.dart';
import 'package:libya_medical_record_system/data/models/demo_data.dart';
import 'package:libya_medical_record_system/data/models/user_registration_model.dart';

class MyPatientsPage extends StatefulWidget {
  const MyPatientsPage({super.key});

  @override
  State<MyPatientsPage> createState() => _MyPatientsPageState();
}

class _MyPatientsPageState extends State<MyPatientsPage> {
  final _tokenController = TextEditingController();
  late final List<UserRegistrationModel> _patients;

  @override
  void initState() {
    super.initState();
    _patients = DemoData.patients();
  }

  @override
  void dispose() {
    _tokenController.dispose();
    super.dispose();
  }

  void _handleAddPatient() {
    final token = _tokenController.text.trim();
    if (token.isEmpty) {
      snackBar(
        context: context,
        message: 'Please enter a valid access token.',
        type: SnackTypeEnum.error,
      );
      return;
    }

    snackBar(
      context: context,
      message: 'Access granted. Patient added to your clinical list.',
      type: SnackTypeEnum.success,
    );
    _tokenController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const SliverPageHeader(
            title: 'My Patients',
            subtitle: 'Manage your clinical patient list',
            icon: FontAwesomeIcons.hospitalUser,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Add New Patient',
                    style: AppTextStyles.titleMedium.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _tokenController,
                          decoration: fieldDecoration(
                            hint: 'Enter patient access token...',
                            prefixIcon: Icons.vpn_key_rounded,
                          ).copyWith(
                            suffixIcon: IconButton(
                              onPressed: () {
                                snackBar(
                                  context: context,
                                  message: 'QR Scanner opening...',
                                );
                              },
                              icon: const FaIcon(
                                FontAwesomeIcons.qrcode,
                                size: 18,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        height: 52,
                        width: 52,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: IconButton(
                          onPressed: _handleAddPatient,
                          icon:
                              const Icon(Icons.add_rounded, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Patient Directory',
                    style: AppTextStyles.titleMedium.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_patients.isEmpty)
            const EmptyStateSliver(
              icon: FontAwesomeIcons.usersSlash,
              title: 'No Patients Added',
              subtitle:
                  'Use an access token or scan a QR code to add patients to your list.',
            )
          else
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => _PatientCard(patient: _patients[index]),
                  childCount: _patients.length,
                ),
              ),
            ),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}

class _PatientCard extends StatelessWidget {
  const _PatientCard({required this.patient});

  final UserRegistrationModel patient;

  @override
  Widget build(BuildContext context) {
    final personal = patient.personalInfo!;
    final token = patient.activeToken;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: AppColors.divider.withValues(alpha: 0.5)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Correctly replace the :id placeholder with the actual patient ID
            final path = AppRoutes.patientRecords.replaceFirst(':id', patient.id!);
            context.push(path, extra: patient);
          },
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        personal.fullNameEnglish[0].toUpperCase(),
                        style: AppTextStyles.titleLarge.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            personal.fullNameEnglish,
                            style: AppTextStyles.titleSmall.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            'ID: ${personal.nationalId}',
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Divider(height: 1),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.timer_outlined, size: 14, color: Colors.orange),
                        const SizedBox(width: 6),
                        Text(
                          'Expires in: ${_getRemainingTime(token?.expiresAt)}',
                          style: AppTextStyles.caption.copyWith(
                            color: Colors.orange.shade700,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 14,
                      color: AppColors.textDisabled,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getRemainingTime(DateTime? expiresAt) {
    if (expiresAt == null) return 'N/A';
    final diff = expiresAt.difference(DateTime.now());
    if (diff.isNegative) return 'Expired';
    
    if (diff.inHours > 0) {
      return '${diff.inHours}h ${diff.inMinutes.remainder(60)}m';
    }
    return '${diff.inMinutes}m';
  }
}
