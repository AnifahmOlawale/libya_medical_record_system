import 'package:flutter/material.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/data/models/demo_data.dart';
import 'package:libya_medical_record_system/features/home/widgets/clinical_access_card.dart';
import 'package:libya_medical_record_system/features/home/widgets/emergency_contact.dart';
import 'package:libya_medical_record_system/features/home/widgets/greeting_section.dart';
import 'package:libya_medical_record_system/features/home/widgets/health_metrics.dart';
import 'package:libya_medical_record_system/features/home/widgets/profile_card.dart';
import 'package:libya_medical_record_system/features/home/widgets/quick_stats.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userData = DemoData.currentUser();
    final isProfessional = userData.workplaces.isNotEmpty;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const GreetingSection(),
              const SizedBox(height: 24),
              const ProfileCard(),
              const SizedBox(height: 24),
              const QuickStats(),
              const SizedBox(height: 28),
              if (isProfessional) ...[
                const ClinicalAccessCard(),
                const SizedBox(height: 28),
              ],
              const HealthMetrics(),
              const SizedBox(height: 28),
              const EmergencyContact(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
