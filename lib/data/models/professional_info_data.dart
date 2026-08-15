import 'package:libya_medical_record_system/data/models/working_time_data.dart';

/// Raw data captured by the professional-information registration step.
class ProfessionalInfoData {
  ProfessionalInfoData({
    required this.specialization,
    this.verificationDocumentPath,
    this.yearsOfExperience,
    this.aboutMe,
    required this.confirmsLicensed,
    required this.agreesToLegitimateUse,
    this.weeklySchedule,
  });

  final String specialization;

  /// Local file path of the picked verification document, if any.
  final String? verificationDocumentPath;

  final int? yearsOfExperience;
  final String? aboutMe;

  final bool confirmsLicensed;
  final bool agreesToLegitimateUse;

  final WeeklySchedule? weeklySchedule;
}
