import 'package:flutter/material.dart';
import 'package:libya_medical_record_system/data/models/allergy_model.dart';
import 'package:libya_medical_record_system/data/models/dental_record_model.dart';
import 'package:libya_medical_record_system/data/models/diagnosis_model.dart';
import 'package:libya_medical_record_system/data/models/lab_test_model.dart';
import 'package:libya_medical_record_system/data/models/medication_model.dart';
import 'package:libya_medical_record_system/data/models/radiology_model.dart';
import 'package:libya_medical_record_system/data/models/pathology_model.dart';
import 'package:libya_medical_record_system/data/models/surgery_model.dart';
import 'package:libya_medical_record_system/data/models/document_model.dart';
import 'package:libya_medical_record_system/data/models/medical_visit_model.dart';
import 'package:libya_medical_record_system/data/models/immunization_model.dart';
import 'package:libya_medical_record_system/data/models/vital_model.dart';
import 'package:libya_medical_record_system/data/models/medical_info_data.dart';
import 'package:libya_medical_record_system/data/models/permission_token_model.dart';
import 'package:libya_medical_record_system/data/models/personal_info_data.dart';
import 'package:libya_medical_record_system/data/models/institution_model.dart';
import 'package:libya_medical_record_system/data/models/professional_info_data.dart';
import 'package:libya_medical_record_system/data/models/user_registration_model.dart';
import 'package:libya_medical_record_system/data/models/user_workplace.dart';
import 'package:libya_medical_record_system/data/models/working_time_data.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Demo data for the Libya Medical Record System.
class DemoData {
  static const String currentUserId = 'user_100123';

  /// All institutions in the system
  static List<InstitutionModel> institutions() {
    return [
      InstitutionModel(
        id: 'inst_001',
        name: 'Tripoli Medical Center',
        type: 'Public Hospital',
        municipality: 'Tripoli',
        specialization: 'General Medicine',
        icon: FontAwesomeIcons.hospital,
        phoneNumber: '+218 21 444 6677',
        address: 'University District, Tripoli',
        isPublic: true,
      ),
      InstitutionModel(
        id: 'inst_002',
        name: 'Al-Jala Maternity Hospital',
        type: 'Public Hospital',
        municipality: 'Benghazi',
        specialization: 'Obstetrics & Gynecology',
        icon: FontAwesomeIcons.hospitalUser,
        phoneNumber: '+218 61 222 3344',
        address: 'Al-Jala Street, Benghazi',
        isPublic: true,
      ),
      InstitutionModel(
        id: 'inst_owned_01',
        name: 'Royal Benghazi Hospital',
        type: 'Private Hospital',
        municipality: 'Benghazi',
        specialization: 'Cardiology & Surgery',
        icon: FontAwesomeIcons.hospital,
        phoneNumber: '+218 61 555 9988',
        address: 'Venice Street, Benghazi',
        isPublic: false,
        ownerId: currentUserId,
      ),
      InstitutionModel(
        id: 'inst_owned_02',
        name: 'Al-Madina General Hospital',
        type: 'Private Hospital',
        municipality: 'Tripoli',
        specialization: 'Internal Medicine',
        icon: FontAwesomeIcons.hospital,
        phoneNumber: '+218 21 333 4455',
        address: 'Gargarish Road, Tripoli',
        isPublic: false,
        ownerId: currentUserId,
      ),
      InstitutionModel(
        id: 'inst_owned_03',
        name: 'City Care Pharmacy',
        type: 'Community Pharmacy',
        municipality: 'Tripoli',
        specialization: 'Pharmaceutical Services',
        icon: FontAwesomeIcons.pills,
        phoneNumber: '+218 21 888 1122',
        address: 'Jaraba Street, Tripoli',
        isPublic: false,
        ownerId: currentUserId,
      ),
      InstitutionModel(
        id: 'inst_owned_04',
        name: 'Family Health Clinic',
        type: 'General Clinic',
        municipality: 'Misrata',
        specialization: 'Family Medicine',
        icon: FontAwesomeIcons.houseMedical,
        phoneNumber: '+218 51 999 3344',
        address: 'Al-Madina Center, Misrata',
        isPublic: false,
        ownerId: currentUserId,
      ),
      InstitutionModel(
        id: 'inst_007',
        name: 'Central Diagnostic Lab',
        type: 'Clinical Laboratory',
        municipality: 'Zliten',
        specialization: 'Pathology & Radiology',
        icon: FontAwesomeIcons.flaskVial,
        phoneNumber: '+218 21 777 9900',
        address: 'Al-Andalus Street, Tripoli',
        isPublic: false,
      ),
      InstitutionModel(
        id: 'inst_008',
        name: 'Al-Hikma Hospital',
        type: 'Public Hospital',
        municipality: 'Misrata',
        specialization: 'Emergency Services',
        icon: FontAwesomeIcons.hospital,
        phoneNumber: '+218 51 444 8899',
        address: 'Al-Jala Street, Misrata',
        isPublic: true,
      ),
      InstitutionModel(
        id: 'inst_009',
        name: 'Zliten Teaching Hospital',
        type: 'Public Hospital',
        municipality: 'Zliten',
        specialization: 'Academic Medicine',
        icon: FontAwesomeIcons.hospital,
        phoneNumber: '+218 51 222 4455',
        address: 'University Road, Zliten',
        isPublic: true,
      ),
      InstitutionModel(
        id: 'inst_010',
        name: 'Al-Khadra Hospital',
        type: 'Public Hospital',
        municipality: 'Tripoli',
        specialization: 'General Surgery',
        icon: FontAwesomeIcons.hospital,
        phoneNumber: '+218 21 444 1122',
        address: 'Abu-Salim, Tripoli',
        isPublic: true,
      ),
    ];
  }

  /// The single demo user for the entire app.
  static UserRegistrationModel currentUser() {
    final allInst = institutions();
    return UserRegistrationModel(
      id: currentUserId,
      personalInfo: PersonalInfoData(
        nationalId: '100123456789',
        fullNameArabic: 'أحمد محمد الزهراني',
        fullNameEnglish: 'Ahmed Mohamed Al-Zahrani',
        placeOfBirth: 'Tripoli',
        occupation: 'Cardiologist',
        yearsOfExperience: 14,
        primaryPhoneNumber: '+218912345678',
        secondaryPhoneNumber: '+218923456789',
        email: 'ahmed.alzahrani@hospital.ly',
        residentialAddress: 'Al-Andalus Street, Building 45, Tripoli',
        municipality: 'Tripoli',
        dateOfBirth: DateTime(1985, 3, 15),
      ),
      professionalInfo: ProfessionalInfoData(
        specialization: 'Cardiology',
        yearsOfExperience: 14,
        aboutMe:
            'Dedicated cardiologist with over 14 years of experience in diagnosing and treating cardiovascular diseases.',
        verificationDocumentPath: '/documents/medical_license_ahmed.pdf',
        confirmsLicensed: true,
        agreesToLegitimateUse: true,
        weeklySchedule: WeeklySchedule(
          monday: WorkingTime(
            isActive: true,
            startTime: const TimeOfDay(hour: 8, minute: 0),
            endTime: const TimeOfDay(hour: 17, minute: 0),
          ),
          tuesday: WorkingTime(
            isActive: true,
            startTime: const TimeOfDay(hour: 8, minute: 0),
            endTime: const TimeOfDay(hour: 17, minute: 0),
          ),
          wednesday: WorkingTime(
            isActive: true,
            startTime: const TimeOfDay(hour: 8, minute: 0),
            endTime: const TimeOfDay(hour: 17, minute: 0),
          ),
          thursday: WorkingTime(
            isActive: true,
            startTime: const TimeOfDay(hour: 8, minute: 0),
            endTime: const TimeOfDay(hour: 17, minute: 0),
          ),
          friday: WorkingTime(
            isActive: true,
            startTime: const TimeOfDay(hour: 8, minute: 0),
            endTime: const TimeOfDay(hour: 14, minute: 0),
          ),
          saturday: const WorkingTime(isActive: false),
          sunday: const WorkingTime(isActive: false),
        ),
      ),
      medicalInfo: MedicalInfoData(
        height: '175',
        weight: '78',
        lastBloodDonationDate: DateTime(2024, 1, 20),
        bloodType: 'A+',
        genotype: 'AA',
        gender: 'Male',
        maritalStatus: 'Married',
        disabilityStatus: 'None',
        smokingStatus: 'Never',
        alcoholUse: 'Never',
        pregnancyStatus: 'Not Applicable',
      ),
      workplaces: [
        UserWorkplace(
          institutionId: allInst[0].id,
          institutionName: allInst[0].name,
          institutionType: allInst[0].type,
          location: allInst[0].municipality,
          position: 'Senior Cardiologist',
          joinedDate: DateTime(2020, 5, 12),
          status: WorkplaceApprovalStatus.approved,
        ),
        UserWorkplace(
          institutionId: allInst[6].id,
          institutionName: allInst[6].name,
          institutionType: allInst[6].type,
          location: allInst[6].municipality,
          position: 'Visiting Consultant',
          joinedDate: DateTime(2023, 1, 15),
          status: WorkplaceApprovalStatus.approved,
        ),
      ],
      vitals: vitals(),
      allergies: allergies(),
      medications: medications(),
      diagnoses: diagnoses(),
      labTests: labTests(),
      radiologyReports: radiologyReports(),
      pathologyReports: pathologyReports(),
      surgeries: surgeries(),
      immunizations: immunizations(),
      documents: documents(),
      medicalVisits: medicalVisits(),
      dentalRecords: dentalRecords(),
    );
  }

  /// Demo patient list for healthcare professionals.
  static List<UserRegistrationModel> patients() {
    return [
      UserRegistrationModel(
        id: 'pat_001',
        personalInfo: PersonalInfoData(
          nationalId: '100000000006',
          fullNameArabic: 'محمد علي منصور',
          fullNameEnglish: 'Mohamed Ali Mansour',
          occupation: 'Engineer',
          primaryPhoneNumber: '+218910001122',
          email: 'mohamed.ali@email.ly',
          residentialAddress: 'Al-Dahmani, Tripoli',
          municipality: 'Tripoli',
          dateOfBirth: DateTime(1990, 5, 12),
        ),
        medicalInfo: MedicalInfoData(
          height: '180',
          weight: '85',
          bloodType: 'O+',
          genotype: 'AA',
          gender: 'Male',
          maritalStatus: 'Married',
          disabilityStatus: 'None',
          smokingStatus: 'Never',
          alcoholUse: 'Occasional',
          pregnancyStatus: 'Not Applicable',
        ),
        activeToken: PermissionTokenModel(
          id: 'token_001',
          token: '123456',
          createdAt: DateTime.now(),
          expiresAt: DateTime.now().add(const Duration(hours: 2)),
          accessibleModules: ['Vitals', 'Allergies', 'Medications'],
        ),
        vitals: [
          VitalModel(
            id: 'v_001',
            timestamp: DateTime.now(),
            temperature: 36.6,
            systolicBP: 118,
            diastolicBP: 78,
            heartRate: 70,
            weight: 85.0,
            height: 180.0,
            lastUpdated: DateTime.now(),
          ),
        ],
        allergies: [
          AllergyModel(
            id: 'a_001',
            allergen: 'Penicillin',
            reaction: 'Rash',
            onsetDate: DateTime(2010, 5, 12),
            lastUpdated: DateTime.now(),
          ),
        ],
        medications: [
          MedicationModel(
            id: 'm_001',
            medicationName: 'Amoxicillin',
            strength: '500 mg',
            form: 'Capsule',
            frequency: 'Three times daily',
            duration: 7,
            instructions: 'Take with food.',
            intakeMethod: 'Oral',
            dosage: '1 Capsule',
            lastUpdated: DateTime.now(),
          ),
        ],
      ),
      UserRegistrationModel(
        id: 'pat_002',
        personalInfo: PersonalInfoData(
          nationalId: '100000000007',
          fullNameArabic: 'فاطمة خالد',
          fullNameEnglish: 'Fatima Khaled',
          occupation: 'Teacher',
          primaryPhoneNumber: '+218920002233',
          email: 'fatima.k@email.ly',
          residentialAddress: 'Gargarish, Tripoli',
          municipality: 'Tripoli',
          dateOfBirth: DateTime(1995, 11, 20),
        ),
        medicalInfo: MedicalInfoData(
          height: '165',
          weight: '62',
          bloodType: 'A-',
          genotype: 'AS',
          gender: 'Female',
          maritalStatus: 'Single',
          disabilityStatus: 'None',
          smokingStatus: 'Never',
          alcoholUse: 'Never',
          pregnancyStatus: 'No',
        ),
        activeToken: PermissionTokenModel(
          id: 'token_002',
          token: '884102',
          createdAt: DateTime.now(),
          expiresAt: DateTime.now().add(const Duration(minutes: 45)),
          accessibleModules: ['Records', 'Dental'],
        ),
        dentalRecords: [
          DentalRecordModel(
            id: 'd_001',
            date: DateTime(2024, 6, 10),
            selectedTeeth: ['8', '9'],
            procedure: 'Filling',
            doctorName: 'Dr. Salem Al-Hadi',
            institutionName: 'Tripoli Dental Clinic',
            lastUpdated: DateTime.now(),
          ),
        ],
      ),
      UserRegistrationModel(
        id: 'pat_003',
        personalInfo: PersonalInfoData(
          nationalId: '100000000008',
          fullNameArabic: 'عمر مصطفى',
          fullNameEnglish: 'Omar Mustafa',
          occupation: 'Accountant',
          primaryPhoneNumber: '+218910003344',
          email: 'omar.m@email.ly',
          residentialAddress: 'Downtown, Benghazi',
          municipality: 'Benghazi',
          dateOfBirth: DateTime(1982, 3, 15),
        ),
        medicalInfo: MedicalInfoData(
          height: '172',
          weight: '90',
          bloodType: 'B+',
          genotype: 'AA',
          gender: 'Male',
          maritalStatus: 'Married',
          disabilityStatus: 'None',
          smokingStatus: 'Former',
          alcoholUse: 'Never',
          pregnancyStatus: 'Not Applicable',
        ),
        activeToken: PermissionTokenModel(
          id: 'token_003',
          token: '654321',
          createdAt: DateTime.now(),
          expiresAt: DateTime.now().add(const Duration(days: 1)),
          accessibleModules: ['All'],
        ),
      ),
    ];
  }

  /// Demo allergies for testing.
  static List<AllergyModel> allergies() {
    return [
      AllergyModel(
        id: '1',
        allergen: 'Penicillin',
        reaction: 'Hives, rash, and swelling of the face.',
        onsetDate: DateTime(2010, 5, 12),
        notes: 'Strictly avoid all penicillin-based antibiotics.',
        addedBy: 'Dr. Ahmed Al-Zahrani',
        lastUpdated: DateTime.now(),
      ),
    ];
  }

  /// Demo medications for testing.
  static List<MedicationModel> medications() {
    return [
      MedicationModel(
        id: '1',
        medicationName: 'Amoxicillin',
        strength: '500 mg',
        form: 'Capsule',
        frequency: 'Three times daily',
        duration: 7,
        instructions: 'Take with food to avoid stomach upset.',
        intakeMethod: 'Oral',
        dosage: '1 Capsule',
        addedBy: 'Dr. Ahmed Al-Zahrani',
        lastUpdated: DateTime.now(),
      ),
    ];
  }

  /// Demo diagnoses for testing.
  static List<DiagnosisModel> diagnoses() {
    return [
      DiagnosisModel(
        id: '1',
        conditionName: 'Hypertension',
        diagnosisDate: DateTime(2022, 3, 15),
        status: DiagnosisStatus.chronic,
        severity: DiagnosisSeverity.moderate,
        diagnosedBy: 'Dr. Ahmed Al-Zahrani',
        symptoms: 'Occasional headaches, dizziness.',
        treatmentPlan: 'Daily Amlodipine 5mg, low-sodium diet.',
        notes: 'Patient advised to monitor BP daily.',
        cost: 50.0,
        diagnosisDocumentPaths: const ['hypertension_report_march_2022.pdf'],
        addedBy: 'Dr. Ahmed Al-Zahrani',
        lastUpdated: DateTime.now(),
      ),
    ];
  }

  /// Demo lab tests for testing.
  static List<LabTestModel> labTests() {
    return [
      LabTestModel(
        id: '1',
        testName: 'Fast Blood Glucose',
        testDate: DateTime(2024, 5, 10),
        laboratoryName: 'Tripoli Medical Center Lab',
        resultValue: '95',
        unit: 'mg/dL',
        referenceRange: '70 - 99 mg/dL',
        status: LabResultStatus.normal,
        orderedBy: 'Dr. Ahmed Al-Zahrani',
        notes: 'Result within normal limits.',
        cost: 45.0,
        reportPaths: const ['glucose_test_report.pdf'],
        addedBy: 'Lab Staff',
        lastUpdated: DateTime.now(),
      ),
    ];
  }

  /// Demo radiology reports for testing.
  static List<RadiologyModel> radiologyReports() {
    return [
      RadiologyModel(
        id: '1',
        studyName: 'Chest X-Ray PA View',
        modality: RadiologyModality.xRay,
        bodyPart: 'Chest',
        studyDate: DateTime(2024, 2, 10),
        institutionName: 'Tripoli Medical Center',
        clinicalIndication: 'Persistent dry cough for 2 weeks.',
        findings: 'Lung fields are clear. Heart size is normal.',
        impression: 'Normal study of the chest.',
        radiologistName: 'Dr. Ali Mahmoud',
        cost: 120.0,
        reportPaths: const ['chest_xray_report.pdf', 'chest_xray_scan.jpg'],
        addedBy: 'Dr. Ali Mahmoud',
        lastUpdated: DateTime.now(),
      ),
    ];
  }

  /// Demo pathology reports for testing.
  static List<PathologyModel> pathologyReports() {
    return [
      PathologyModel(
        id: '1',
        specimenType: 'Skin Biopsy',
        anatomicSite: 'Left Forearm',
        collectionDate: DateTime(2024, 1, 15),
        institutionName: 'Tripoli Medical Center Lab',
        findings: 'Macroscopic: 4mm punch biopsy of skin.',
        finalDiagnosis: 'Benign Junctional Nevus. No evidence of malignancy.',
        status: PathologyStatus.benign,
        pathologistName: 'Dr. Sara Mansour',
        cost: 150.0,
        reportPaths: const ['skin_biopsy_report.pdf'],
        addedBy: 'Lab Staff',
        lastUpdated: DateTime.now(),
      ),
    ];
  }

  /// Demo surgeries for testing.
  static List<SurgeryModel> surgeries() {
    return [
      SurgeryModel(
        id: '1',
        procedureName: 'Appendectomy',
        surgeryDate: DateTime(2021, 8, 12),
        hospitalName: 'Tripoli Medical Center',
        surgeonName: 'Dr. Ali Mahmoud',
        indication: 'Acute appendicitis.',
        anesthesiaType: 'General',
        operationNotes: 'Standard laparoscopic appendectomy.',
        dischargeInstructions: 'Restrict heavy lifting for 4 weeks.',
        status: SurgeryStatus.completed,
        cost: 2500.0,
        reportPaths: const ['appendectomy_discharge_summary.pdf'],
        addedBy: 'Dr. Ali Mahmoud',
        lastUpdated: DateTime.now(),
      ),
    ];
  }

  /// Demo immunizations for testing.
  static List<ImmunizationModel> immunizations() {
    return [
      ImmunizationModel(
        id: '1',
        vaccineName: 'COVID-19 (Pfizer-BioNTech)',
        dateAdministered: DateTime(2021, 10, 5),
        doseNumber: '1st Dose',
        manufacturer: 'Pfizer',
        administeredBy: 'Tripoli Vaccination Center',
        lastUpdated: DateTime.now(),
      ),
    ];
  }

  /// Demo documents for testing.
  static List<DocumentModel> documents() {
    return [
      DocumentModel(
        id: '1',
        title: 'Sick Leave Certificate',
        category: DocumentCategory.medicalCertificate,
        issueDate: DateTime(2024, 6, 15),
        issuedBy: 'Tripoli Medical Center',
        filePaths: const ['sick_leave_june_2024.pdf'],
        lastUpdated: DateTime.now(),
      ),
    ];
  }

  /// Demo medical visits for testing.
  static List<MedicalVisitModel> medicalVisits() {
    return [
      MedicalVisitModel(
        id: '1',
        visitDate: DateTime(2024, 5, 20, 10, 30),
        visitType: VisitType.specialist,
        doctorName: 'Dr. Ahmed Al-Zahrani',
        facilityName: 'Tripoli Medical Center',
        reasonForVisit: 'Cardiac check-up.',
        findings: 'Blood pressure is stable.',
        instructions: 'Continue current medications.',
        addedBy: 'Dr. Ahmed Al-Zahrani',
        lastUpdated: DateTime.now(),
      ),
    ];
  }

  /// Demo vitals for testing trends.
  static List<VitalModel> vitals() {
    final now = DateTime.now();
    return [
      VitalModel(
        id: '1',
        timestamp: now,
        temperature: 36.8,
        systolicBP: 120,
        diastolicBP: 80,
        heartRate: 72,
        respiratoryRate: 16,
        spo2: 99,
        bloodGlucose: 95.0,
        weight: 78.5,
        height: 175.0,
        addedBy: 'Patient',
        lastUpdated: now,
      ),
      VitalModel(
        id: '2',
        timestamp: now.subtract(const Duration(days: 1)),
        temperature: 37.2,
        systolicBP: 125,
        diastolicBP: 82,
        heartRate: 75,
        respiratoryRate: 18,
        spo2: 98,
        bloodGlucose: 102.0,
        weight: 79.0,
        height: 175.0,
        addedBy: 'Dr. Ahmed Al-Zahrani',
        lastUpdated: now.subtract(const Duration(days: 1)),
      ),
      VitalModel(
        id: '3',
        timestamp: now.subtract(const Duration(days: 2)),
        temperature: 36.6,
        systolicBP: 118,
        diastolicBP: 78,
        heartRate: 70,
        respiratoryRate: 16,
        spo2: 99,
        bloodGlucose: 92.0,
        weight: 78.2,
        height: 175.0,
        addedBy: 'Patient',
        lastUpdated: now.subtract(const Duration(days: 2)),
      ),
      VitalModel(
        id: '4',
        timestamp: now.subtract(const Duration(days: 3)),
        temperature: 36.9,
        systolicBP: 122,
        diastolicBP: 80,
        heartRate: 74,
        respiratoryRate: 17,
        spo2: 99,
        bloodGlucose: 98.0,
        weight: 78.8,
        height: 175.0,
        addedBy: 'Tripoli Medical Center',
        lastUpdated: now.subtract(const Duration(days: 3)),
      ),
      VitalModel(
        id: '5',
        timestamp: now.subtract(const Duration(days: 4)),
        temperature: 37.0,
        systolicBP: 128,
        diastolicBP: 85,
        heartRate: 78,
        respiratoryRate: 19,
        spo2: 97,
        bloodGlucose: 105.0,
        weight: 79.5,
        height: 175.0,
        addedBy: 'Patient',
        lastUpdated: now.subtract(const Duration(days: 4)),
      ),
      VitalModel(
        id: '6',
        timestamp: now.subtract(const Duration(days: 5)),
        temperature: 36.7,
        systolicBP: 121,
        diastolicBP: 79,
        heartRate: 71,
        respiratoryRate: 16,
        spo2: 99,
        bloodGlucose: 96.0,
        weight: 78.4,
        height: 175.0,
        addedBy: 'Dr. Sara Mansour',
        lastUpdated: now.subtract(const Duration(days: 5)),
      ),
      VitalModel(
        id: '7',
        timestamp: now.subtract(const Duration(days: 6)),
        temperature: 36.8,
        systolicBP: 119,
        diastolicBP: 77,
        heartRate: 68,
        respiratoryRate: 15,
        spo2: 100,
        bloodGlucose: 90.0,
        weight: 78.0,
        height: 175.0,
        addedBy: 'Patient',
        lastUpdated: now.subtract(const Duration(days: 6)),
      ),
    ];
  }

  /// Demo dental records for testing.
  static List<DentalRecordModel> dentalRecords() {
    return [
      DentalRecordModel(
        id: '1',
        date: DateTime(2024, 6, 10),
        selectedTeeth: const ['8', '9'],
        procedure: 'Filling',
        doctorName: 'Dr. Salem Al-Hadi',
        institutionName: 'Tripoli Dental Clinic',
        notes: 'Composite filling on upper front teeth.',
        lastUpdated: DateTime.now(),
        addedBy: 'Dr. Salem Al-Hadi',
      ),
      DentalRecordModel(
        id: '2',
        date: DateTime(2024, 2, 15),
        selectedTeeth: const ['18', '31'],
        procedure: 'Scaling and Polishing',
        doctorName: 'Dr. Amna Zaid',
        institutionName: 'Benghazi Specialized Clinic',
        notes: 'Routine cleaning. Recommended follow-up in 6 months.',
        lastUpdated: DateTime.now(),
        addedBy: 'Patient',
      ),
    ];
  }

  /// Demo medical experts for the directory.
  static List<UserRegistrationModel> experts() {
    return [
      UserRegistrationModel(
        id: 'exp_001',
        personalInfo: PersonalInfoData(
          fullNameEnglish: 'Dr. Ahmed Al-Mabrouk',
          occupation: 'Senior Cardiologist',
          email: 'ahmed@hospital.ly',
          primaryPhoneNumber: '+218912345678',
          nationalId: '100000000001',
          fullNameArabic: 'د. أحمد المبروك',
          placeOfBirth: 'Tripoli',
          municipality: 'Tripoli',
          dateOfBirth: DateTime(1980, 1, 1),
          residentialAddress: 'Tripoli, Libya',
        ),
        professionalInfo: ProfessionalInfoData(
          specialization: 'Cardiology',
          yearsOfExperience: 15,
          aboutMe: 'Dedicated cardiologist with 15 years of experience.',
          confirmsLicensed: true,
          agreesToLegitimateUse: true,
          weeklySchedule: _buildDemoSchedule(),
        ),
        workplaces: [
          UserWorkplace(
            institutionId: 'inst_owned_01',
            institutionName: 'Royal Benghazi Hospital',
            institutionType: 'Private Hospital',
            location: 'Benghazi',
            position: 'Chief Cardiologist',
            joinedDate: DateTime(2010, 1, 1),
            status: WorkplaceApprovalStatus.approved,
          ),
        ],
      ),
      UserRegistrationModel(
        id: 'exp_002',
        personalInfo: PersonalInfoData(
          fullNameEnglish: 'Dr. Fatima Ben Ali',
          occupation: 'Pediatrician',
          email: 'fatima@hospital.ly',
          primaryPhoneNumber: '+218912345679',
          nationalId: '100000000002',
          fullNameArabic: 'د. فاطمة بن علي',
          placeOfBirth: 'Benghazi',
          municipality: 'Benghazi',
          dateOfBirth: DateTime(1985, 5, 20),
          residentialAddress: 'Benghazi, Libya',
        ),
        professionalInfo: ProfessionalInfoData(
          specialization: 'Pediatrics',
          yearsOfExperience: 10,
          aboutMe: 'Compassionate pediatrician.',
          confirmsLicensed: true,
          agreesToLegitimateUse: true,
          weeklySchedule: _buildDemoSchedule(),
        ),
        workplaces: [
          UserWorkplace(
            institutionId: 'inst_owned_01',
            institutionName: 'Royal Benghazi Hospital',
            institutionType: 'Private Hospital',
            location: 'Benghazi',
            position: 'Consultant Pediatrician',
            joinedDate: DateTime(2015, 6, 1),
            status: WorkplaceApprovalStatus.pending,
          ),
        ],
      ),
      UserRegistrationModel(
        id: 'exp_003',
        personalInfo: PersonalInfoData(
          fullNameEnglish: 'Dr. Omar El-Sherif',
          occupation: 'Neurologist',
          email: 'omar@hospital.ly',
          primaryPhoneNumber: '+218912345680',
          nationalId: '100000000003',
          fullNameArabic: 'د. عمر الشريف',
          placeOfBirth: 'Misrata',
          municipality: 'Misrata',
          dateOfBirth: DateTime(1975, 10, 12),
          residentialAddress: 'Misrata, Libya',
        ),
        professionalInfo: ProfessionalInfoData(
          specialization: 'Neurology',
          yearsOfExperience: 20,
          aboutMe: 'Senior Neurologist.',
          confirmsLicensed: true,
          agreesToLegitimateUse: true,
          weeklySchedule: _buildDemoSchedule(),
        ),
        workplaces: [
          UserWorkplace(
            institutionId: 'inst_owned_02',
            institutionName: 'Al-Madina General Hospital',
            institutionType: 'Private Hospital',
            location: 'Tripoli',
            position: 'Chief of Neurology',
            joinedDate: DateTime(2005, 3, 1),
            status: WorkplaceApprovalStatus.approved,
          ),
        ],
      ),
      UserRegistrationModel(
        id: 'exp_004',
        personalInfo: PersonalInfoData(
          fullNameEnglish: 'Dr. Sara Mansour',
          occupation: 'Dermatologist',
          email: 'sara@hospital.ly',
          primaryPhoneNumber: '+218912345681',
          nationalId: '100000000004',
          fullNameArabic: 'د. سارة منصور',
          placeOfBirth: 'Tripoli',
          municipality: 'Tripoli',
          dateOfBirth: DateTime(1988, 3, 4),
          residentialAddress: 'Tripoli, Libya',
        ),
        professionalInfo: ProfessionalInfoData(
          specialization: 'Dermatology',
          yearsOfExperience: 8,
          aboutMe: 'Expert in clinical dermatology.',
          confirmsLicensed: true,
          agreesToLegitimateUse: true,
          weeklySchedule: _buildDemoSchedule(),
        ),
        workplaces: [
          UserWorkplace(
            institutionId: 'inst_owned_02',
            institutionName: 'Al-Madina General Hospital',
            institutionType: 'Private Hospital',
            location: 'Tripoli',
            position: 'Dermatology Specialist',
            joinedDate: DateTime(2018, 9, 1),
            status: WorkplaceApprovalStatus.pending,
          ),
        ],
      ),
      UserRegistrationModel(
        id: 'exp_005',
        personalInfo: PersonalInfoData(
          fullNameEnglish: 'Dr. Ali Mahmoud',
          occupation: 'Radiologist',
          email: 'ali@lab.ly',
          primaryPhoneNumber: '+218912345682',
          nationalId: '100000000005',
          fullNameArabic: 'د. علي محمود',
          placeOfBirth: 'Zliten',
          municipality: 'Zliten',
          dateOfBirth: DateTime(1982, 7, 18),
          residentialAddress: 'Zliten, Libya',
        ),
        professionalInfo: ProfessionalInfoData(
          specialization: 'Radiology',
          yearsOfExperience: 12,
          aboutMe: 'Experienced radiologist.',
          confirmsLicensed: true,
          agreesToLegitimateUse: true,
          weeklySchedule: _buildDemoSchedule(),
        ),
        workplaces: [
          UserWorkplace(
            institutionId: 'inst_owned_01',
            institutionName: 'Royal Benghazi Hospital',
            institutionType: 'Private Hospital',
            location: 'Benghazi',
            position: 'Imaging Specialist',
            joinedDate: DateTime(2024, 2, 1),
            status: WorkplaceApprovalStatus.pending, // This will be "Sent Invite"
          ),
        ],
      ),
    ];
  }

  static WeeklySchedule _buildDemoSchedule() {
    return WeeklySchedule(
      monday: WorkingTime(
        isActive: true,
        startTime: const TimeOfDay(hour: 9, minute: 0),
        endTime: const TimeOfDay(hour: 17, minute: 0),
      ),
      tuesday: WorkingTime(
        isActive: true,
        startTime: const TimeOfDay(hour: 9, minute: 0),
        endTime: const TimeOfDay(hour: 17, minute: 0),
      ),
      wednesday: WorkingTime(
        isActive: true,
        startTime: const TimeOfDay(hour: 9, minute: 0),
        endTime: const TimeOfDay(hour: 17, minute: 0),
      ),
      thursday: WorkingTime(
        isActive: true,
        startTime: const TimeOfDay(hour: 9, minute: 0),
        endTime: const TimeOfDay(hour: 17, minute: 0),
      ),
      friday: WorkingTime(
        isActive: true,
        startTime: const TimeOfDay(hour: 9, minute: 0),
        endTime: const TimeOfDay(hour: 14, minute: 0),
      ),
      saturday: const WorkingTime(isActive: false),
      sunday: const WorkingTime(isActive: false),
    );
  }

  /// Empty registration model that can be used as a starting point.
  static UserRegistrationModel empty() {
    return UserRegistrationModel(
      personalInfo: null,
      professionalInfo: null,
      medicalInfo: null,
    );
  }
}
