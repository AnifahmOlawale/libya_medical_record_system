import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:libya_medical_record_system/core/router/app_router.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';
import 'package:libya_medical_record_system/core/shared/widgets/sliver_page_header.dart';
import 'package:libya_medical_record_system/data/models/user_registration_model.dart';

class PatientRecordsPage extends StatelessWidget {
  const PatientRecordsPage({super.key, required this.patient});

  final UserRegistrationModel patient;

  @override
  Widget build(BuildContext context) {
    final personal = patient.personalInfo!;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPageHeader(
            title: personal.fullNameEnglish,
            subtitle: 'ID: ${personal.nationalId}',
            icon: FontAwesomeIcons.hospitalUser,
            showBackButton: true,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
              child: Text(
                'Clinical Oversight',
                style: AppTextStyles.titleMedium.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width > 900
                    ? 4
                    : (MediaQuery.of(context).size.width > 600 ? 3 : 2),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.8,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => _PatientRecordCard(
                  data: _patientRecords[index],
                  patient: patient,
                ),
                childCount: _patientRecords.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}

class _PatientRecordCard extends StatelessWidget {
  const _PatientRecordCard({required this.data, required this.patient});

  final _RecordCardData data;
  final UserRegistrationModel patient;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
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
            // Fix: Create the patient-specific path (e.g., /patients/pat_001/records/vitals)
            final basePath = AppRoutes.patientRecords.replaceFirst(':id', patient.id!);
            final subPath = data.route;
            final fullPath = '$basePath/$subPath';
            
            context.push(fullPath, extra: patient);
          },
          borderRadius: BorderRadius.circular(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(
                data.icon,
                color: AppColors.primary,
                size: 20,
              ),
              const SizedBox(height: 8),
              Text(
                data.title,
                textAlign: TextAlign.center,
                style: AppTextStyles.labelMedium.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                  fontSize: 12,
                ),
              ),
              Text(
                data.subtitle,
                textAlign: TextAlign.center,
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 9,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RecordCardData {
  const _RecordCardData({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.route,
  });

  final dynamic icon;
  final String title;
  final String subtitle;
  final String route;
}

// Routes here are relative to the patient base path
final _patientRecords = [
  _RecordCardData(
    icon: FontAwesomeIcons.idCardClip,
    title: 'Medical Info',
    subtitle: 'Baseline health data',
    route: 'medical-info',
  ),
  _RecordCardData(
    icon: FontAwesomeIcons.heartPulse,
    title: 'Vital Signs',
    subtitle: 'Health metrics trends',
    route: 'vitals',
  ),
  _RecordCardData(
    icon: FontAwesomeIcons.triangleExclamation,
    title: 'Allergies',
    subtitle: 'Known reactions',
    route: 'allergies',
  ),
  _RecordCardData(
    icon: FontAwesomeIcons.pills,
    title: 'Medications',
    subtitle: 'Active prescriptions',
    route: 'medications',
  ),
  _RecordCardData(
    icon: FontAwesomeIcons.tooth,
    title: 'Dental History',
    subtitle: 'Procedures mapping',
    route: 'dental',
  ),
  _RecordCardData(
    icon: FontAwesomeIcons.stethoscope,
    title: 'Diagnoses',
    subtitle: 'Clinical conditions',
    route: 'diagnoses',
  ),
  _RecordCardData(
    icon: FontAwesomeIcons.flask,
    title: 'Lab Results',
    subtitle: 'Diagnostic reports',
    route: 'lab-tests',
  ),
  _RecordCardData(
    icon: FontAwesomeIcons.xRay,
    title: 'Imaging',
    subtitle: 'Radiology scans',
    route: 'radiology',
  ),
  _RecordCardData(
    icon: FontAwesomeIcons.calendarCheck,
    title: 'Visits',
    subtitle: 'Appointment history',
    route: 'visits',
  ),
  _RecordCardData(
    icon: FontAwesomeIcons.microscope,
    title: 'Pathology',
    subtitle: 'Lab specimen reports',
    route: 'pathology',
  ),
  _RecordCardData(
    icon: FontAwesomeIcons.kitMedical,
    title: 'Surgeries',
    subtitle: 'Surgical history',
    route: 'surgeries',
  ),
  _RecordCardData(
    icon: FontAwesomeIcons.syringe,
    title: 'Immunizations',
    subtitle: 'Vaccination records',
    route: 'immunizations',
  ),
  _RecordCardData(
    icon: FontAwesomeIcons.fileShield,
    title: 'Documents',
    subtitle: 'Medical certificates',
    route: 'documents',
  ),
];
