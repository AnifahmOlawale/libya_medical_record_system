import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:libya_medical_record_system/core/router/app_router.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';
import 'package:libya_medical_record_system/core/shared/widgets/empty_state_widget.dart';
import 'package:libya_medical_record_system/core/shared/widgets/sliver_page_header.dart';
import 'package:libya_medical_record_system/data/models/demo_data.dart';
import 'package:libya_medical_record_system/data/models/dental_record_model.dart';
import 'package:libya_medical_record_system/data/models/user_registration_model.dart';

class DentalRecordsPage extends StatelessWidget {
  const DentalRecordsPage({super.key, this.patient});

  final UserRegistrationModel? patient;

  @override
  Widget build(BuildContext context) {
    final records = patient != null ? patient!.dentalRecords : DemoData.dentalRecords();
    final bool isPatientView = patient != null;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPageHeader(
            title: isPatientView ? '${patient!.personalInfo!.fullNameEnglish}\'s Dental' : 'Dental Records',
            icon: FontAwesomeIcons.tooth,
            showBackButton: isPatientView,
          ),
          if (records.isEmpty)
            const EmptyStateSliver(
              icon: FontAwesomeIcons.tooth,
              title: 'No Dental Records',
              subtitle: 'Dental history and procedures will appear here.',
            )
          else
            _buildRecordsList(records, isPatientView),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppRoutes.addDentalRecord, extra: patient),
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add_rounded, color: Colors.white),
        label: Text(
          'Add Record',
          style: AppTextStyles.labelLarge.copyWith(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildRecordsList(List<DentalRecordModel> records, bool isPatientView) {
    return SliverPadding(
      padding: const EdgeInsets.all(20),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final record = records[index];
          return _buildDentalCard(context, record, isPatientView);
        }, childCount: records.length),
      ),
    );
  }

  Widget _buildDentalCard(BuildContext context, DentalRecordModel record, bool isPatientView) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => context.push(AppRoutes.dentalRecordDetail, extra: record),
        borderRadius: BorderRadius.circular(20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primarySurface.withValues(alpha: 0.3),
                  border: Border(
                    left: BorderSide(color: AppColors.primary, width: 4),
                  ),
                ),
                child: Row(
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.tooth,
                      color: AppColors.primary,
                      size: 16,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        record.procedure,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.titleMedium.copyWith(
                          color: AppColors.primaryDark,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Text(
                      _formatDate(record.date),
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailRow(
                      'Teeth',
                      record.selectedTeeth.join(', '),
                      icon: FontAwesomeIcons.teeth,
                    ),
                    const SizedBox(height: 16),
                    _buildDetailRow(
                      'Dentist',
                      record.doctorName,
                      icon: FontAwesomeIcons.userDoctor,
                    ),
                    const SizedBox(height: 16),
                    _buildDetailRow(
                      'Facility',
                      record.institutionName,
                      icon: FontAwesomeIcons.hospital,
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Added by: ${record.addedBy ?? 'N/A'}',
                      style: AppTextStyles.bodySmall.copyWith(
                        fontSize: 10,
                        color: AppColors.textDisabled,
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 12,
                      color: AppColors.textDisabled,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {required dynamic icon}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(10),
          ),
          child: icon is IconData
              ? Icon(icon, color: AppColors.textSecondary, size: 14)
              : FaIcon(icon, color: AppColors.textSecondary, size: 14),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat("dd MMM, yyyy").format(date);
  }
}
