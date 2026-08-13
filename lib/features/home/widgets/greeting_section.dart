import 'package:flutter/material.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';
import 'package:libya_medical_record_system/data/models/demo_data.dart';
import 'package:libya_medical_record_system/data/models/user_registration_model.dart';
import 'package:libya_medical_record_system/data/providers/dashboard_provider.dart';
import 'package:provider/provider.dart';

class GreetingSection extends StatelessWidget {
  const GreetingSection({super.key});

  @override
  Widget build(BuildContext context) {
    final userType = context.watch<DashboardProvider>().userType;
    final userName = userType == UserType.patient
        ? DemoData.patientUser().personalInfo?.fullNameEnglish ?? 'User'
        : DemoData.professionalUser().personalInfo?.fullNameEnglish ?? 'User';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome back,',
          style: AppTextStyles.bodyLarge.copyWith(
            color: Colors.grey,
            fontSize: 20,
          ),
        ),
        Text(
          userName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.headlineLarge.copyWith(
            color: Colors.blue,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
