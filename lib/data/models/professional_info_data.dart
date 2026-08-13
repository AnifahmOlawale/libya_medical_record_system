import 'package:libya_medical_record_system/data/models/working_time_data.dart';

/// Raw data captured by the professional-information registration step.
///
/// Plain data holder — no JSON (de)serialization yet. Wire that up
/// once the backend (Supabase / Firebase / custom API) is decided.
class ProfessionalInfoData {
  ProfessionalInfoData({
    required this.professionalRole,
    required this.licenseNumber,
    required this.institutionName,
    this.departmentOrSpecialty,
    this.workPhoneNumber,
    this.workEmail,
    this.verificationDocumentPath,
    this.officeAddress,
    this.yearsOfExperience,
    this.aboutMe,
    required this.confirmsLicensed,
    required this.agreesToLegitimateUse,
    this.weeklySchedule,
  });

  /// One of [professionalRoleOptions], or a custom role text if the user
  /// selected "Others" and entered their own.
  final String professionalRole;

  final String? licenseNumber;
  final String institutionName;
  final String? departmentOrSpecialty;
  final String? workPhoneNumber;
  final String? workEmail;

  /// Local file path of the picked verification document, if any.
  final String? verificationDocumentPath;

  final String? officeAddress;
  final int? yearsOfExperience;
  final String? aboutMe;

  final bool confirmsLicensed;
  final bool agreesToLegitimateUse;

  final WeeklySchedule? weeklySchedule;
}
