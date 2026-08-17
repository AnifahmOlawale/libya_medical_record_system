import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';
import 'package:libya_medical_record_system/data/models/vital_model.dart';

class VitalsTrendChart extends StatelessWidget {
  final String title;
  final List<VitalModel> history;
  final double Function(VitalModel) valSelector;
  final Color color;

  const VitalsTrendChart({
    super.key,
    required this.title,
    required this.history,
    required this.valSelector,
    this.color = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.titleSmall.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: LineChart(
              LineChartData(
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipColor: (spot) => AppColors.primaryDark,
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((spot) {
                        final vital = history[spot.x.toInt()];
                        final dateStr = DateFormat('MMM dd, hh:mm a').format(vital.timestamp);
                        return LineTooltipItem(
                          '${spot.y}\n$dateStr',
                          AppTextStyles.labelSmall.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }).toList();
                    },
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (v) => FlLine(
                    color: Colors.grey.withValues(alpha: 0.1),
                    strokeWidth: 1,
                  ),
                ),
                titlesData: _buildTitlesData(history),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: history
                        .asMap()
                        .entries
                        .map((e) => FlSpot(e.key.toDouble(), valSelector(e.value)))
                        .toList(),
                    isCurved: true,
                    color: color,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: true),
                    belowBarData: BarAreaData(
                      show: true,
                      color: color.withValues(alpha: 0.05),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  FlTitlesData _buildTitlesData(List<VitalModel> history) {
    return FlTitlesData(
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 35,
          getTitlesWidget: (v, meta) => Text(
            v.toInt().toString(),
            style: AppTextStyles.caption.copyWith(fontSize: 9),
          ),
        ),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          interval: 1,
          getTitlesWidget: (v, meta) {
            if (v.toInt() >= 0 && v.toInt() < history.length) {
              return Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  DateFormat('dd MMM').format(history[v.toInt()].timestamp),
                  style: AppTextStyles.caption.copyWith(fontSize: 8, fontWeight: FontWeight.w600),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
