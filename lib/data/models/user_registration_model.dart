// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:libya_medical_record_system/data/models/institution_data.dart';
import 'package:libya_medical_record_system/data/models/medical_info_data.dart';
import 'package:libya_medical_record_system/data/models/personal_info_data.dart';
import 'package:libya_medical_record_system/data/models/professional_info_data.dart';
import 'package:libya_medical_record_system/data/models/user_workplace.dart';

/// Combined model for user registration that includes 
/// all registration steps (personal, professional, medical info).
class UserRegistrationModel {
  UserRegistrationModel({
    this.personalInfo,
    this.institutionInfo,
    this.professionalInfo,
    this.medicalInfo,
    this.workplaces = const [],
  });

  final PersonalInfoData? personalInfo;
  final InstitutionData? institutionInfo;
  final ProfessionalInfoData? professionalInfo;
  final MedicalInfoData? medicalInfo;
  final List<UserWorkplace> workplaces;

  UserRegistrationModel copyWith({
    PersonalInfoData? personalInfo,
    InstitutionData? institutionInfo,
    ProfessionalInfoData? professionalInfo,
    MedicalInfoData? medicalInfo,
    List<UserWorkplace>? workplaces,
  }) {
    return UserRegistrationModel(
      personalInfo: personalInfo ?? this.personalInfo,
      institutionInfo: institutionInfo ?? this.institutionInfo,
      professionalInfo: professionalInfo ?? this.professionalInfo,
      medicalInfo: medicalInfo ?? this.medicalInfo,
      workplaces: workplaces ?? this.workplaces,
    );
  }
}
