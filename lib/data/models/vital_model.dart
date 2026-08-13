import 'package:flutter/material.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';

class VitalModel {
  final String id;
  final DateTime timestamp;
  final double? temperature; // °C
  final int? systolicBP; // mmHg
  final int? diastolicBP; // mmHg
  final int? heartRate; // bpm
  final int? respiratoryRate; // breaths/min
  final int? spo2; // %
  final double? bloodGlucose; // mg/dL
  final double? weight; // kg
  final double? height; // cm
  final String? addedBy;
  final DateTime lastUpdated;

  VitalModel({
    required this.id,
    required this.timestamp,
    this.temperature,
    this.systolicBP,
    this.diastolicBP,
    this.heartRate,
    this.respiratoryRate,
    this.spo2,
    this.bloodGlucose,
    this.weight,
    this.height,
    this.addedBy,
    required this.lastUpdated,
  });

  /// Auto-calculates BMI: weight(kg) / (height(m)^2)
  double? get bmi {
    if (weight == null || height == null || height == 0) return null;
    final heightInMeters = height! / 100;
    return weight! / (heightInMeters * heightInMeters);
  }

  /// Returns BMI classification
  String? get bmiCategory {
    final val = bmi;
    if (val == null) return null;
    if (val < 18.5) return 'Underweight';
    if (val < 25.0) return 'Normal';
    if (val < 30.0) return 'Overweight';
    return 'Obese';
  }

  /// Returns BP Classification based on AHA guidelines
  String? get bpCategory {
    if (systolicBP == null || diastolicBP == null) return null;
    final sys = systolicBP!;
    final dia = diastolicBP!;

    if (sys < 120 && dia < 80) return 'Normal';
    if (sys >= 120 && sys <= 129 && dia < 80) return 'Elevated';
    if ((sys >= 130 && sys <= 139) || (dia >= 80 && dia <= 89)) return 'High (Stage 1)';
    if (sys >= 140 || dia >= 90) return 'High (Stage 2)';
    if (sys > 180 || dia > 120) return 'Crisis';
    return 'Uncategorized';
  }

  /// Returns color coding for BP status
  Color get bpStatusColor {
    final category = bpCategory;
    if (category == 'Normal') return AppColors.success;
    if (category == 'Elevated') return AppColors.warning;
    if (category == null) return AppColors.primary;
    return AppColors.error;
  }
}
