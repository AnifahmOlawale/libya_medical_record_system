import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';
import 'package:libya_medical_record_system/data/models/vital_model.dart';

class VitalsHistoryItem extends StatelessWidget {
  final VitalModel item;

  const VitalsHistoryItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Slidable(
        key: ValueKey(item.id),
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          extentRatio: 0.5,
          children: [
            SlidableAction(
              onPressed: (context) {},
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              icon: Icons.edit_rounded,
              label: 'Edit',
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
            ),
            SlidableAction(
              onPressed: (context) {},
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
              icon: Icons.delete_outline_rounded,
              label: 'Delete',
              borderRadius: const BorderRadius.horizontal(right: Radius.circular(16)),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat('MMM dd, yyyy').format(item.timestamp),
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    DateFormat('hh:mm a').format(item.timestamp),
                    style: AppTextStyles.bodySmall,
                  ),
                ],
              ),
              const Spacer(),
              _buildLogMetric(
                'BP',
                '${item.systolicBP ?? '--'}/${item.diastolicBP ?? '--'}',
                item.bpStatusColor,
              ),
              const SizedBox(width: 16),
              _buildLogMetric('HR', '${item.heartRate}', Colors.pink),
              const SizedBox(width: 16),
              _buildLogMetric('Temp', '${item.temperature}°', Colors.orange),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogMetric(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: AppTextStyles.labelSmall.copyWith(
            fontSize: 9,
            color: AppColors.textSecondary,
          ),
        ),
        Text(
          value,
          style: AppTextStyles.labelMedium.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
