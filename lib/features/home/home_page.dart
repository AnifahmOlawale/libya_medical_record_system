import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:libya_medical_record_system/core/shared/widgets/snack_bar.dart';
import 'package:libya_medical_record_system/data/models/user_registration_model.dart';
import 'package:libya_medical_record_system/data/providers/dashboard_provider.dart';
import 'package:libya_medical_record_system/features/home/widgets/clinical_access_card.dart';
import 'package:libya_medical_record_system/features/home/widgets/emergency_contact.dart';
import 'package:libya_medical_record_system/features/home/widgets/greeting_section.dart';
import 'package:libya_medical_record_system/features/home/widgets/health_metrics.dart';
import 'package:libya_medical_record_system/features/home/widgets/notification_bell.dart';
import 'package:libya_medical_record_system/features/home/widgets/profile_card.dart';
import 'package:libya_medical_record_system/features/home/widgets/quick_stats.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userType = context.watch<DashboardProvider>().userType;
    final isProfessional = userType == UserType.healthcareProfessional;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: const GreetingSection()),
                if (!kIsWeb)
                  IconButton(
                    icon: const NotificationBell(),
                    onPressed: () {
                      snackBar(
                        context: context,
                        message: 'Notifications coming soon',
                      );
                    },
                  ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const ProfileCard(),
                    const SizedBox(height: 24),
                    if (isProfessional) ...[
                      const ClinicalAccessCard(),
                      const SizedBox(height: 24),
                    ],
                    const QuickStats(),
                    const SizedBox(height: 24),
                    if (!isProfessional) ...[
                      const HealthMetrics(),
                      const SizedBox(height: 24),
                      const EmergencyContact(),
                      const SizedBox(height: 100),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
