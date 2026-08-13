import 'package:flutter/material.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';

abstract final class VitalConstants {
  /// Clinical status based on reading value
  static Color getStatusColor(String type, double value) {
    switch (type) {
      case 'temp':
        if (value < 36.0 || value > 38.0) return AppColors.error;
        if (value > 37.5) return AppColors.warning;
        return AppColors.success;
      case 'heart_rate':
        if (value < 60 || value > 100) return AppColors.error;
        return AppColors.success;
      case 'spo2':
        if (value < 90) return AppColors.error;
        if (value < 95) return AppColors.warning;
        return AppColors.success;
      case 'glucose':
        if (value > 140) return AppColors.error;
        if (value > 110) return AppColors.warning;
        return AppColors.success;
      default:
        return AppColors.primary;
    }
  }

  static String getUnit(String type) {
    switch (type) {
      case 'temp': return '°C';
      case 'heart_rate': return 'bpm';
      case 'bp': return 'mmHg';
      case 'spo2': return '%';
      case 'glucose': return 'mg/dL';
      case 'weight': return 'kg';
      case 'height': return 'cm';
      case 'resp': return 'br/m';
      default: return '';
    }
  }
}
