import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:libya_medical_record_system/core/router/app_router.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';
import 'package:libya_medical_record_system/core/shared/widgets/sliver_page_header.dart';
import 'package:libya_medical_record_system/data/models/demo_data.dart';
import 'package:libya_medical_record_system/data/models/vital_model.dart';
import 'widgets/vitals_section_title.dart';
import 'widgets/vital_summary_card.dart';
import 'widgets/bmi_card.dart';
import 'widgets/bp_trend_chart.dart';
import 'widgets/vitals_trend_chart.dart';
import 'widgets/vitals_history_item.dart';

class VitalsPage extends StatelessWidget {
  const VitalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vitals = DemoData.vitals();
    final latest = vitals.first;
    final reversedHistory = vitals.reversed.toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const SliverPageHeader(
            title: 'Vital Signs',
            icon: FontAwesomeIcons.heartPulse,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VitalsSectionTitle(
                    title: 'Latest Readings',
                    subtitle:
                        'Last updated ${DateFormat('hh:mm a').format(latest.timestamp)}',
                  ),
                  const SizedBox(height: 16),
                  _buildVitalsGrid(latest),
                  const SizedBox(height: 32),
                  VitalsSectionTitle(
                    title: 'Health Trends',
                    subtitle:
                        'Metric over Time (Last ${vitals.length} entries)',
                  ),
                  const SizedBox(height: 16),
                  BPTrendChart(history: reversedHistory),
                  const SizedBox(height: 16),
                  VitalsTrendChart(
                    title: 'Heart Rate (BPM)',
                    history: reversedHistory,
                    valSelector: (e) => e.heartRate?.toDouble() ?? 0,
                    color: Colors.pink,
                  ),
                  const SizedBox(height: 16),
                  VitalsTrendChart(
                    title: 'Weight (kg)',
                    history: reversedHistory,
                    valSelector: (e) => e.weight ?? 0,
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 32),
                  VitalsSectionTitle(
                    title: 'History Log',
                    subtitle: 'Full record of your vital signs',
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.info_outline_rounded,
                          size: 14,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Slide to edit/delete',
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => VitalsHistoryItem(item: vitals[index]),
                childCount: vitals.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppRoutes.addVital),
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add_rounded, color: Colors.white),
        label: Text(
          'Log Vitals',
          style: AppTextStyles.labelLarge.copyWith(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildVitalsGrid(VitalModel latest) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 900
            ? 4
            : constraints.maxWidth > 600
                ? 3
                : 2;

        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.1,
          children: [
            VitalSummaryCard(
              label: 'Temperature',
              value: latest.temperature?.toString() ?? '--',
              type: 'temp',
              icon: FontAwesomeIcons.temperatureHalf,
              color: Colors.orange,
            ),
            VitalSummaryCard(
              label: 'Blood Pressure',
              value:
                  '${latest.systolicBP ?? '--'}/${latest.diastolicBP ?? '--'}',
              type: 'bp',
              icon: FontAwesomeIcons.heartPulse,
              color: Colors.red,
              status: latest.bpCategory,
              statusColor: latest.bpStatusColor,
            ),
            VitalSummaryCard(
              label: 'Heart Rate',
              value: latest.heartRate?.toString() ?? '--',
              type: 'heart_rate',
              icon: FontAwesomeIcons.heartCircleCheck,
              color: Colors.pink,
            ),
            VitalSummaryCard(
              label: 'SpO2',
              value: '${latest.spo2 ?? '--'}',
              type: 'spo2',
              icon: FontAwesomeIcons.droplet,
              color: Colors.blue,
            ),
            VitalSummaryCard(
              label: 'Glucose',
              value: latest.bloodGlucose?.toString() ?? '--',
              type: 'glucose',
              icon: FontAwesomeIcons.flask,
              color: Colors.teal,
            ),
            BMICard(bmi: latest.bmi, category: latest.bmiCategory ?? 'N/A'),
          ],
        );
      },
    );
  }
}
