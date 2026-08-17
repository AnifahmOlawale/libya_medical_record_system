import 'package:libya_medical_record_system/data/models/allergy_model.dart';
import 'package:libya_medical_record_system/data/models/dental_record_model.dart';
import 'package:libya_medical_record_system/data/models/diagnosis_model.dart';
import 'package:libya_medical_record_system/data/models/document_model.dart';
import 'package:libya_medical_record_system/data/models/immunization_model.dart';
import 'package:libya_medical_record_system/data/models/institution_data.dart';
import 'package:libya_medical_record_system/data/models/lab_test_model.dart';
import 'package:libya_medical_record_system/data/models/medical_info_data.dart';
import 'package:libya_medical_record_system/data/models/medical_visit_model.dart';
import 'package:libya_medical_record_system/data/models/medication_model.dart';
import 'package:libya_medical_record_system/data/models/pathology_model.dart';
import 'package:libya_medical_record_system/data/models/permission_token_model.dart';
import 'package:libya_medical_record_system/data/models/personal_info_data.dart';
import 'package:libya_medical_record_system/data/models/professional_info_data.dart';
import 'package:libya_medical_record_system/data/models/radiology_model.dart';
import 'package:libya_medical_record_system/data/models/surgery_model.dart';
import 'package:libya_medical_record_system/data/models/user_workplace.dart';
import 'package:libya_medical_record_system/data/models/vital_model.dart';

/// Combined model for user registration that includes 
/// all registration steps and full medical history.
class UserRegistrationModel {
  UserRegistrationModel({
    this.id,
    this.personalInfo,
    this.institutionInfo,
    this.professionalInfo,
    this.medicalInfo,
    this.activeToken,
    this.workplaces = const [],
    this.vitals = const [],
    this.allergies = const [],
    this.medications = const [],
    this.diagnoses = const [],
    this.labTests = const [],
    this.radiologyReports = const [],
    this.pathologyReports = const [],
    this.surgeries = const [],
    this.immunizations = const [],
    this.documents = const [],
    this.medicalVisits = const [],
    this.dentalRecords = const [],
  });

  final String? id;
  final PersonalInfoData? personalInfo;
  final InstitutionData? institutionInfo;
  final ProfessionalInfoData? professionalInfo;
  final MedicalInfoData? medicalInfo;
  final PermissionTokenModel? activeToken;
  final List<UserWorkplace> workplaces;
  
  // Full Medical History
  final List<VitalModel> vitals;
  final List<AllergyModel> allergies;
  final List<MedicationModel> medications;
  final List<DiagnosisModel> diagnoses;
  final List<LabTestModel> labTests;
  final List<RadiologyModel> radiologyReports;
  final List<PathologyModel> pathologyReports;
  final List<SurgeryModel> surgeries;
  final List<ImmunizationModel> immunizations;
  final List<DocumentModel> documents;
  final List<MedicalVisitModel> medicalVisits;
  final List<DentalRecordModel> dentalRecords;

  UserRegistrationModel copyWith({
    String? id,
    PersonalInfoData? personalInfo,
    InstitutionData? institutionInfo,
    ProfessionalInfoData? professionalInfo,
    MedicalInfoData? medicalInfo,
    PermissionTokenModel? activeToken,
    List<UserWorkplace>? workplaces,
    List<VitalModel>? vitals,
    List<AllergyModel>? allergies,
    List<MedicationModel>? medications,
    List<DiagnosisModel>? diagnoses,
    List<LabTestModel>? labTests,
    List<RadiologyModel>? radiologyReports,
    List<PathologyModel>? pathologyReports,
    List<SurgeryModel>? surgeries,
    List<ImmunizationModel>? immunizations,
    List<DocumentModel>? documents,
    List<MedicalVisitModel>? medicalVisits,
    List<DentalRecordModel>? dentalRecords,
  }) {
    return UserRegistrationModel(
      id: id ?? this.id,
      personalInfo: personalInfo ?? this.personalInfo,
      institutionInfo: institutionInfo ?? this.institutionInfo,
      professionalInfo: professionalInfo ?? this.professionalInfo,
      medicalInfo: medicalInfo ?? this.medicalInfo,
      activeToken: activeToken ?? this.activeToken,
      workplaces: workplaces ?? this.workplaces,
      vitals: vitals ?? this.vitals,
      allergies: allergies ?? this.allergies,
      medications: medications ?? this.medications,
      diagnoses: diagnoses ?? this.diagnoses,
      labTests: labTests ?? this.labTests,
      radiologyReports: radiologyReports ?? this.radiologyReports,
      pathologyReports: pathologyReports ?? this.pathologyReports,
      surgeries: surgeries ?? this.surgeries,
      immunizations: immunizations ?? this.immunizations,
      documents: documents ?? this.documents,
      medicalVisits: medicalVisits ?? this.medicalVisits,
      dentalRecords: dentalRecords ?? this.dentalRecords,
    );
  }
}
