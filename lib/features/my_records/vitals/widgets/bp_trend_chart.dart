import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_text_styles.dart';
import 'package:libya_medical_record_system/data/models/vital_model.dart';

class BPTrendChart extends StatelessWidget {
  final List<VitalModel> history;

  const BPTrendChart({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Blood Pressure Trend',
                style: AppTextStyles.titleSmall.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              Row(
                children: [
                  _buildLegendDot('Sys', Colors.red),
                  const SizedBox(width: 8),
                  _buildLegendDot('Dia', Colors.blue),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: LineChart(
              LineChartData(
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipColor: (spot) => AppColors.primaryDark,
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.asMap().entries.map((entry) {
                        final index = entry.key;
                        final spot = entry.value;

                        // Identify if it's Systolic (index 0) or Diastolic (index 1)
                        final label = index == 0 ? 'Sys' : 'Dia';

                        if (index == touchedSpots.length - 1) {
                          final vital = history[spot.x.toInt()];
                          final dateStr = DateFormat('MMM dd, hh:mm a').format(vital.timestamp);
                          return LineTooltipItem(
                            '$label: ${spot.y.toInt()} mmHg\n$dateStr',
                            AppTextStyles.labelSmall.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        } else {
                          return LineTooltipItem(
                            '$label: ${spot.y.toInt()} mmHg',
                            AppTextStyles.labelSmall.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }
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
                  _buildLineBarData(
                    history
                        .asMap()
                        .entries
                        .map(
                          (e) => FlSpot(
                            e.key.toDouble(),
                            e.value.systolicBP?.toDouble() ?? 0,
                          ),
                        )
                        .toList(),
                    Colors.red,
                  ),
                  _buildLineBarData(
                    history
                        .asMap()
                        .entries
                        .map(
                          (e) => FlSpot(
                            e.key.toDouble(),
                            e.value.diastolicBP?.toDouble() ?? 0,
                          ),
                        )
                        .toList(),
                    Colors.blue,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  LineChartBarData _buildLineBarData(List<FlSpot> spots, Color color) {
    return LineChartBarData(
      spots: spots,
      isCurved: true,
      color: color,
      barWidth: 3,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: true),
      belowBarData: BarAreaData(
        show: true,
        color: color.withValues(alpha: 0.05),
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

  Widget _buildLegendDot(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: AppTextStyles.caption.copyWith(
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
