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
import 'package:libya_medical_record_system/data/models/lab_test_model.dart';
import 'package:libya_medical_record_system/data/models/user_registration_model.dart';

class LabTestsPage extends StatelessWidget {
  const LabTestsPage({super.key, this.patient});

  final UserRegistrationModel? patient;

  @override
  Widget build(BuildContext context) {
    final labTests = patient != null ? patient!.labTests : DemoData.labTests();
    final bool isPatientView = patient != null;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPageHeader(
            title: isPatientView ? '${patient!.personalInfo!.fullNameEnglish}\'s Lab Tests' : 'Laboratory Tests',
            icon: FontAwesomeIcons.flask,
            showBackButton: isPatientView,
          ),
          if (labTests.isEmpty)
            const EmptyStateSliver(
              icon: FontAwesomeIcons.fileMedical,
              title: 'No Lab Tests Found',
              subtitle: 'Laboratory test history will appear here.',
            )
          else
            _buildLabTestsList(labTests, isPatientView),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppRoutes.addLabTest, extra: patient),
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add_rounded, color: Colors.white),
        label: Text(
          'Add Lab Test',
          style: AppTextStyles.labelLarge.copyWith(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildLabTestsList(List<dynamic> labTests, bool isPatientView) {
    return SliverPadding(
      padding: const EdgeInsets.all(20),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final test = labTests[index] as LabTestModel;
          return _buildLabTestCard(context, test, isPatientView);
        }, childCount: labTests.length),
      ),
    );
  }

  Widget _buildLabTestCard(BuildContext context, LabTestModel test, bool isPatientView) {
    Color statusColor;
    String statusLabel;

    switch (test.status) {
      case LabResultStatus.normal:
        statusColor = AppColors.success;
        statusLabel = 'Normal';
        break;
      case LabResultStatus.abnormal:
        statusColor = AppColors.warning;
        statusLabel = 'Abnormal';
        break;
      case LabResultStatus.critical:
        statusColor = AppColors.error;
        statusLabel = 'Critical';
        break;
    }

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
        onTap: () => context.push(AppRoutes.labTestDetail, extra: test),
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
                  color: statusColor.withValues(alpha: 0.1),
                  border: Border(
                    left: BorderSide(color: statusColor, width: 4),
                  ),
                ),
                child: Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.flask,
                      color: statusColor,
                      size: 16,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        test.testName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.titleMedium.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        statusLabel,
                        style: AppTextStyles.labelSmall.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
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
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Result',
                                style: AppTextStyles.labelSmall.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${test.resultValue ?? '--'} ${test.unit ?? ''}',
                                style: AppTextStyles.titleLarge.copyWith(
                                  color: statusColor,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: _buildDetailRow(
                            'Date',
                            _formatDate(test.testDate),
                            icon: FontAwesomeIcons.calendarDay,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildDetailRow(
                      'Lab',
                      test.laboratoryName,
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
                      'Last Updated: ${_formatDate(test.lastUpdated)}',
                      style: AppTextStyles.bodySmall.copyWith(
                        fontSize: 10,
                        color: AppColors.textDisabled,
                      ),
                    ),
                    if (!isPatientView)
                      Row(
                        children: [
                          _buildActionCircle(Icons.edit_rounded, () {}),
                          const SizedBox(width: 8),
                          _buildActionCircle(
                            Icons.delete_outline_rounded,
                            () {},
                            isDelete: true,
                          ),
                        ],
                      )
                    else
                      const Icon(Icons.arrow_forward_ios_rounded, size: 12, color: AppColors.textDisabled),
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
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
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

  Widget _buildActionCircle(
    dynamic icon,
    VoidCallback onTap, {
    bool isDelete = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: isDelete
              ? AppColors.error.withValues(alpha: 0.1)
              : Colors.grey.shade100,
          shape: BoxShape.circle,
        ),
        child: icon is IconData
            ? Icon(
                icon,
                size: 16,
                color: isDelete ? AppColors.error : AppColors.textSecondary,
              )
            : FaIcon(
                icon,
                size: 16,
                color: isDelete ? AppColors.error : AppColors.textSecondary,
              ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat("dd MMM, yyyy").format(date);
  }
}
