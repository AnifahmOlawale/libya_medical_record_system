// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:libya_medical_record_system/data/models/medical_info_data.dart';
import 'package:libya_medical_record_system/data/models/personal_info_data.dart';
import 'package:libya_medical_record_system/data/models/professional_info_data.dart';

/// Combined model for user registration that includes user role
/// and all registration steps (personal, professional, medical info).
enum UserType { healthcareProfessional, patient }

class UserRegistrationModel {
  UserRegistrationModel({
    required this.userType,
    required this.personalInfo,
    required this.professionalInfo,
    required this.medicalInfo,
  });

  final UserType? userType;
  final PersonalInfoData? personalInfo;
  final ProfessionalInfoData? professionalInfo;
  final MedicalInfoData? medicalInfo;

  UserRegistrationModel copyWith({
    UserType? userType,
    PersonalInfoData? personalInfo,
    ProfessionalInfoData? professionalInfo,
    MedicalInfoData? medicalInfo,
  }) {
    return UserRegistrationModel(
      userType: userType ?? this.userType,
      personalInfo: personalInfo ?? this.personalInfo,
      professionalInfo: professionalInfo ?? this.professionalInfo,
      medicalInfo: medicalInfo ?? this.medicalInfo,
    );
  }
}
