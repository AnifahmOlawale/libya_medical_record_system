import 'package:flutter/material.dart';
import 'package:libya_medical_record_system/data/models/allergy_model.dart';
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
import 'package:libya_medical_record_system/data/models/personal_info_data.dart';
import 'package:libya_medical_record_system/data/models/institution_model.dart';
import 'package:libya_medical_record_system/data/models/professional_info_data.dart';
import 'package:libya_medical_record_system/data/models/user_registration_model.dart';
import 'package:libya_medical_record_system/data/models/user_workplace.dart';
import 'package:libya_medical_record_system/data/models/working_time_data.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Demo data for the Libya Medical Record System.
class DemoData {
  /// All institutions in the system
  static List<InstitutionModel> institutions() {
    return [
      InstitutionModel(
        id: 'inst_001',
        name: 'Tripoli University Hospital',
        type: 'Public Hospital',
        location: 'Tripoli Central',
        specialization: 'General Medicine',
        icon: FontAwesomeIcons.hospital,
        phoneNumber: '+218 21 444 6677',
        address: 'University District, Tripoli',
      ),
      InstitutionModel(
        id: 'inst_002',
        name: 'Al-Jala Maternity Hospital',
        type: 'Public Hospital',
        location: 'Benghazi',
        specialization: 'Obstetrics & Gynecology',
        icon: FontAwesomeIcons.hospitalUser,
        phoneNumber: '+218 61 222 3344',
        address: 'Al-Jala Street, Benghazi',
      ),
      InstitutionModel(
        id: 'inst_003',
        name: 'Life Care Clinic',
        type: 'Private Clinic',
        location: 'Misrata',
        specialization: 'Pediatrics',
        icon: FontAwesomeIcons.houseMedical,
        phoneNumber: '+218 51 555 1234',
        address: 'Downtown, Misrata',
      ),
      InstitutionModel(
        id: 'inst_004',
        name: 'Al-Shifa Pharmacy',
        type: 'Private Pharmacy',
        location: 'Zuwara',
        specialization: 'Pharmaceutical Services',
        icon: FontAwesomeIcons.pills,
        phoneNumber: '+218 23 666 7788',
        address: 'Coast Road, Zuwara',
      ),
      InstitutionModel(
        id: 'inst_005',
        name: 'Central Diagnostic Lab',
        type: 'Private Laboratory',
        location: 'Tripoli',
        specialization: 'Pathology & Radiology',
        icon: FontAwesomeIcons.flaskVial,
        phoneNumber: '+218 21 777 9900',
        address: 'Al-Andalus Street, Tripoli',
      ),
    ];
  }

  /// The single demo user for the entire app.
  static UserRegistrationModel currentUser() {
    final allInst = institutions();
    return UserRegistrationModel(
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
        municipality: 'Tripoli Central',
        dateOfBirth: DateTime(1985, 3, 15),
      ),
      professionalInfo: ProfessionalInfoData(
        specialization: 'Cardiology',
        yearsOfExperience: 14,
        aboutMe:
            'Dedicated cardiologist with over 14 years of experience in diagnosing and treating cardiovascular diseases. Committed to providing compassionate care and staying updated with the latest medical advancements.',
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
          location: allInst[0].location,
          position: 'Senior Cardiologist',
          joinedDate: DateTime(2020, 5, 12),
          status: WorkplaceApprovalStatus.pending,
        ),
        UserWorkplace(
          institutionId: allInst[4].id,
          institutionName: allInst[4].name,
          institutionType: allInst[4].type,
          location: allInst[4].location,
          position: 'Visiting Consultant',
          joinedDate: DateTime(2023, 1, 15),
          status: WorkplaceApprovalStatus.approved,
        ),
        UserWorkplace(
          institutionId: allInst[2].id,
          institutionName: allInst[2].name,
          institutionType: allInst[2].type,
          location: allInst[2].location,
          position: 'Lead Pediatric Cardiologist',
          joinedDate: DateTime(2022, 10, 10),
          status: WorkplaceApprovalStatus.rejected,
        ),
      ],
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
      AllergyModel(
        id: '2',
        allergen: 'Peanuts',
        reaction: 'Anaphylaxis, difficulty breathing.',
        onsetDate: DateTime(1995, 8, 20),
        notes: 'Carry EpiPen at all times.',
        addedBy: 'Self-Reported',
        lastUpdated: DateTime.now(),
      ),
      AllergyModel(
        id: '3',
        allergen: 'Dust Mites',
        reaction: 'Sneezing, runny nose, and itchy eyes.',
        onsetDate: DateTime(2015, 3, 10),
        notes: 'Worse during winter months.',
        addedBy: 'Dr. Sara Mansour',
        lastUpdated: DateTime.now(),
      ),
      AllergyModel(
        id: '4',
        allergen: 'Latex',
        reaction: 'Skin irritation and redness.',
        onsetDate: DateTime(2018, 11, 5),
        notes: 'Inform medical staff before any procedure.',
        addedBy: 'Tripoli Central Hospital',
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
      MedicationModel(
        id: '2',
        medicationName: 'Paracetamol',
        strength: '500 mg',
        form: 'Tablet',
        frequency: 'As needed',
        duration: 3,
        instructions: 'Do not exceed 8 tablets in 24 hours.',
        intakeMethod: 'Oral',
        dosage: '2 Tablets',
        addedBy: 'Self-Reported',
        lastUpdated: DateTime.now(),
      ),
      MedicationModel(
        id: '3',
        medicationName: 'Salbutamol',
        strength: '100 mcg',
        form: 'Inhaler',
        frequency: 'As needed',
        duration: 30,
        instructions: '1-2 puffs when experiencing shortness of breath.',
        intakeMethod: 'Inhalation',
        dosage: '2 Puffs',
        addedBy: 'Dr. Sara Mansour',
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
      DiagnosisModel(
        id: '2',
        conditionName: 'Type 2 Diabetes',
        diagnosisDate: DateTime(2023, 6, 10),
        status: DiagnosisStatus.active,
        severity: DiagnosisSeverity.moderate,
        diagnosedBy: 'Dr. Sara Mansour',
        symptoms: 'Increased thirst, frequent urination.',
        treatmentPlan: 'Metformin 500mg twice daily, sugar-free diet.',
        notes: 'Follow-up appointment in 3 months.',
        cost: 75.0,
        diagnosisDocumentPaths: const ['diabetes_diagnosis_scan.jpg'],
        addedBy: 'Dr. Sara Mansour',
        lastUpdated: DateTime.now(),
      ),
      DiagnosisModel(
        id: '3',
        conditionName: 'Acute Bronchitis',
        diagnosisDate: DateTime(2024, 1, 20),
        status: DiagnosisStatus.resolved,
        severity: DiagnosisSeverity.mild,
        diagnosedBy: 'Tripoli Central Clinic',
        symptoms: 'Persistent cough, chest congestion.',
        treatmentPlan: 'Cough syrup, rest, increased fluid intake.',
        notes: 'Symptoms cleared after 10 days.',
        cost: 30.0,
        addedBy: 'Self-Reported',
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
        laboratoryName: 'Tripoli Central Lab',
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
      LabTestModel(
        id: '2',
        testName: 'Lipid Profile (LDL)',
        testDate: DateTime(2024, 4, 15),
        laboratoryName: 'Al-Jala Hospital Lab',
        resultValue: '165',
        unit: 'mg/dL',
        referenceRange: '< 100 mg/dL',
        status: LabResultStatus.abnormal,
        orderedBy: 'Dr. Sara Mansour',
        notes: 'LDL is elevated. Diet modification recommended.',
        cost: 85.0,
        reportPaths: const ['lipid_scan_result.png'],
        addedBy: 'Dr. Sara Mansour',
        lastUpdated: DateTime.now(),
      ),
      LabTestModel(
        id: '3',
        testName: 'Hemoglobin A1c',
        testDate: DateTime(2024, 3, 20),
        laboratoryName: 'Misrata Medical Lab',
        resultValue: '8.2',
        unit: '%',
        referenceRange: '4.0 - 5.6 %',
        status: LabResultStatus.critical,
        orderedBy: 'Dr. Ahmed Al-Zahrani',
        notes: 'Poor glycemic control. Immediate follow-up required.',
        cost: 60.0,
        reportPaths: const [
          'hba1c_certified_report.pdf',
          'clinical_note_attachment.jpg',
        ],
        addedBy: 'Self-Reported',
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
        findings:
            'Lung fields are clear. Heart size is normal. No pleural effusion or pneumothorax.',
        impression: 'Normal study of the chest.',
        radiologistName: 'Dr. Ali Mahmoud',
        cost: 120.0,
        reportPaths: const ['chest_xray_report.pdf', 'chest_xray_scan.jpg'],
        addedBy: 'Dr. Ali Mahmoud',
        lastUpdated: DateTime.now(),
      ),
      RadiologyModel(
        id: '2',
        studyName: 'MRI Lumbar Spine',
        modality: RadiologyModality.mri,
        bodyPart: 'Lower Back',
        studyDate: DateTime(2023, 11, 15),
        institutionName: 'Misrata Diagnostic Imaging',
        clinicalIndication: 'Chronic lower back pain with sciatica.',
        findings:
            'Mild disc protrusion at L4-L5 level causing slight impingement on the nerve root.',
        impression: 'Lumbar spondylosis with L4-L5 disc protrusion.',
        radiologistName: 'Dr. Fatima Salem',
        cost: 450.0,
        reportPaths: const [
          'lumbar_mri_official.pdf',
          'mri_scan_1.png',
          'mri_scan_2.png',
        ],
        addedBy: 'Lab Staff',
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
        institutionName: 'Tripoli Central Pathology Lab',
        findings:
            'Macroscopic: 4mm punch biopsy of skin. Microscopic: The epidermis shows normal maturation. There is a small nested melanocytic proliferation at the dermo-epidermal junction.',
        finalDiagnosis: 'Benign Junctional Nevus. No evidence of malignancy.',
        status: PathologyStatus.benign,
        pathologistName: 'Dr. Sara Mansour',
        cost: 150.0,
        reportPaths: const ['skin_biopsy_report.pdf'],
        addedBy: 'Lab Staff',
        lastUpdated: DateTime.now(),
      ),
      PathologyModel(
        id: '2',
        specimenType: 'Cervical Smear',
        anatomicSite: 'Cervix',
        collectionDate: DateTime(2023, 12, 05),
        institutionName: 'Al-Jala Women\'s Hospital',
        findings:
            'Satisfactory for evaluation. Squamous cells are normal. No intraepithelial lesion or malignancy identified.',
        finalDiagnosis:
            'Negative for Intraepithelial Lesion or Malignancy (NILM).',
        status: PathologyStatus.normal,
        pathologistName: 'Dr. Ahmed Al-Zahrani',
        cost: 80.0,
        reportPaths: const ['pap_smear_result.png'],
        addedBy: 'Dr. Ahmed Al-Zahrani',
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
        operationNotes:
            'Standard laparoscopic appendectomy. Appendix was inflamed but intact.',
        dischargeInstructions:
            'Restrict heavy lifting for 4 weeks. Keep incision site clean and dry.',
        status: SurgeryStatus.completed,
        cost: 2500.0,
        reportPaths: const ['appendectomy_discharge_summary.pdf'],
        addedBy: 'Dr. Ali Mahmoud',
        lastUpdated: DateTime.now(),
      ),
      SurgeryModel(
        id: '2',
        procedureName: 'Knee Arthroscopy',
        surgeryDate: DateTime(2023, 5, 20),
        hospitalName: 'Al-Khadra Hospital',
        surgeonName: 'Dr. Mustafa Al-Faitouri',
        indication: 'Meniscal tear of the right knee.',
        anesthesiaType: 'Spinal',
        operationNotes: 'Repair of medial meniscus tear via arthroscopy.',
        dischargeInstructions:
            'Physical therapy twice a week. Ice packs for swelling.',
        status: SurgeryStatus.completed,
        cost: 1800.0,
        reportPaths: const ['knee_surgery_photos.jpg'],
        addedBy: 'Hospital Staff',
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
        batchNumber: 'FK0124',
        administeredBy: 'Tripoli Vaccination Center',
        sideEffects: 'Mild arm soreness.',
        nextDueDate: DateTime(2021, 11, 5),
        cost: 0.0,
        reportPaths: const ['vaccination_card_p1.jpg'],
        addedBy: 'Self-Reported',
        lastUpdated: DateTime.now(),
      ),
      ImmunizationModel(
        id: '2',
        vaccineName: 'Influenza (Flu Shot)',
        dateAdministered: DateTime(2023, 11, 20),
        doseNumber: 'Annual Booster',
        manufacturer: 'Sanofi Pasteur',
        batchNumber: 'U5678-1',
        administeredBy: 'Al-Khadra Hospital',
        nextDueDate: DateTime(2024, 11, 20),
        cost: 25.0,
        addedBy: 'Dr. Ali Mahmoud',
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
        description: 'Recovery from acute influenza.',
        filePaths: const ['sick_leave_june_2024.pdf'],
        addedBy: 'Patient',
        lastUpdated: DateTime.now(),
      ),
      DocumentModel(
        id: '2',
        title: 'Cardiology Referral',
        category: DocumentCategory.referralLetter,
        issueDate: DateTime(2024, 4, 10),
        issuedBy: 'Dr. Ali Mahmoud',
        description: 'Referral for cardiac stress test.',
        filePaths: const ['referral_cardiology.jpg'],
        addedBy: 'Dr. Ali Mahmoud',
        lastUpdated: DateTime.now(),
      ),
      DocumentModel(
        id: '3',
        title: 'Health Insurance Policy',
        category: DocumentCategory.insurance,
        issueDate: DateTime(2024, 1, 01),
        issuedBy: 'Libya Insurance Co.',
        description: 'Annual premium plan details.',
        filePaths: const ['insurance_policy_2024.pdf'],
        addedBy: 'Patient',
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
        facilityName: 'Tripoli University Hospital',
        reasonForVisit: 'Cardiac check-up and stress test results review.',
        findings:
            'Blood pressure is stable. Stress test showed normal cardiac function.',
        instructions: 'Continue current medications. Return in 6 months.',
        cost: 150.0,
        reportPaths: const ['visit_summary_may_2024.pdf'],
        addedBy: 'Dr. Ahmed Al-Zahrani',
        lastUpdated: DateTime.now(),
      ),
      MedicalVisitModel(
        id: '2',
        visitDate: DateTime(2024, 2, 10, 14, 00),
        visitType: VisitType.routine,
        doctorName: 'Dr. Sara Mansour',
        facilityName: 'Al-Jala Hospital',
        reasonForVisit: 'Annual wellness exam.',
        findings: 'Patient is in good health. No new concerns reported.',
        instructions: 'Maintain healthy diet and exercise.',
        cost: 75.0,
        addedBy: 'Lab Staff',
        lastUpdated: DateTime.now(),
      ),
    ];
  }

  /// Demo vitals for testing trends.
  static List<VitalModel> vitals() {
    return [
      VitalModel(
        id: '1',
        timestamp: DateTime.now(),
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
        lastUpdated: DateTime.now(),
      ),
      VitalModel(
        id: '2',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        temperature: 37.2,
        systolicBP: 125,
        diastolicBP: 82,
        heartRate: 75,
        spo2: 98,
        weight: 79.0,
        height: 175.0,
        lastUpdated: DateTime.now(),
      ),
      VitalModel(
        id: '3',
        timestamp: DateTime.now().subtract(const Duration(days: 2)),
        temperature: 36.6,
        systolicBP: 118,
        diastolicBP: 78,
        heartRate: 70,
        spo2: 99,
        weight: 78.2,
        height: 175.0,
        lastUpdated: DateTime.now(),
      ),
    ];
  }

  /// Demo medical experts for the directory.
  static List<UserRegistrationModel> experts() {
    final allInst = institutions();
    return [
      UserRegistrationModel(
        personalInfo: PersonalInfoData(
          fullNameEnglish: 'Dr. Ahmed Al-Mabrouk',
          occupation: 'Senior Cardiologist',
          email: 'ahmed@hospital.ly',
          primaryPhoneNumber: '+218912345678',
          nationalId: '100000000001',
          fullNameArabic: 'د. أحمد المبروك',
          placeOfBirth: 'Tripoli',
          municipality: 'Tripoli Central',
          dateOfBirth: DateTime(1980, 1, 1),
          residentialAddress: 'Tripoli, Libya',
        ),
        professionalInfo: ProfessionalInfoData(
          specialization: 'Cardiology',
          yearsOfExperience: 15,
          aboutMe:
              'Dedicated cardiologist with 15 years of experience in cardiovascular care and complex procedures.',
          confirmsLicensed: true,
          agreesToLegitimateUse: true,
          weeklySchedule: WeeklySchedule(
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
            friday: const WorkingTime(isActive: false),
            saturday: const WorkingTime(isActive: false),
            sunday: const WorkingTime(isActive: false),
          ),
        ),
        workplaces: [
          UserWorkplace(
            institutionId: allInst[0].id,
            institutionName: allInst[0].name,
            institutionType: allInst[0].type,
            location: allInst[0].location,
            position: 'Senior Cardiologist',
            joinedDate: DateTime(2010, 1, 1),
            status: WorkplaceApprovalStatus.approved,
          ),
        ],
      ),
      UserRegistrationModel(
        personalInfo: PersonalInfoData(
          fullNameEnglish: 'Dr. Fatima Ben Ali',
          occupation: 'Pediatrician',
          email: 'fatima@hospital.ly',
          primaryPhoneNumber: '+218912345679',
          nationalId: '100000000002',
          fullNameArabic: 'د. فاطمة بن علي',
          placeOfBirth: 'Benghazi',
          municipality: 'Benghazi Central',
          dateOfBirth: DateTime(1985, 5, 20),
          residentialAddress: 'Benghazi, Libya',
        ),
        professionalInfo: ProfessionalInfoData(
          specialization: 'Pediatrics',
          yearsOfExperience: 10,
          aboutMe:
              'Compassionate pediatrician focused on comprehensive child healthcare and developmental wellness.',
          confirmsLicensed: true,
          agreesToLegitimateUse: true,
          weeklySchedule: WeeklySchedule(
            monday: WorkingTime(
              isActive: true,
              startTime: const TimeOfDay(hour: 8, minute: 30),
              endTime: const TimeOfDay(hour: 15, minute: 30),
            ),
            tuesday: WorkingTime(
              isActive: true,
              startTime: const TimeOfDay(hour: 8, minute: 30),
              endTime: const TimeOfDay(hour: 15, minute: 30),
            ),
            wednesday: WorkingTime(
              isActive: true,
              startTime: const TimeOfDay(hour: 8, minute: 30),
              endTime: const TimeOfDay(hour: 15, minute: 30),
            ),
            thursday: WorkingTime(
              isActive: true,
              startTime: const TimeOfDay(hour: 8, minute: 30),
              endTime: const TimeOfDay(hour: 15, minute: 30),
            ),
            friday: WorkingTime(
              isActive: true,
              startTime: const TimeOfDay(hour: 8, minute: 30),
              endTime: const TimeOfDay(hour: 12, minute: 00),
            ),
            saturday: const WorkingTime(isActive: false),
            sunday: const WorkingTime(isActive: false),
          ),
        ),
        workplaces: [
          UserWorkplace(
            institutionId: allInst[1].id,
            institutionName: allInst[1].name,
            institutionType: allInst[1].type,
            location: allInst[1].location,
            position: 'Consultant Pediatrician',
            joinedDate: DateTime(2015, 6, 1),
            status: WorkplaceApprovalStatus.approved,
          ),
        ],
      ),
      UserRegistrationModel(
        personalInfo: PersonalInfoData(
          fullNameEnglish: 'Dr. Omar El-Sherif',
          occupation: 'Neurologist',
          email: 'omar@hospital.ly',
          primaryPhoneNumber: '+218912345680',
          nationalId: '100000000003',
          fullNameArabic: 'د. عمر الشريف',
          placeOfBirth: 'Misrata',
          municipality: 'Misrata Central',
          dateOfBirth: DateTime(1975, 10, 12),
          residentialAddress: 'Misrata, Libya',
        ),
        professionalInfo: ProfessionalInfoData(
          specialization: 'Neurology',
          yearsOfExperience: 20,
          aboutMe:
              'Senior Neurologist specializing in neurodegenerative disorders and advanced clinical neurology.',
          confirmsLicensed: true,
          agreesToLegitimateUse: true,
        ),
        workplaces: [
          UserWorkplace(
            institutionId: allInst[2].id,
            institutionName: allInst[2].name,
            institutionType: allInst[2].type,
            location: allInst[2].location,
            position: 'Chief of Neurology',
            joinedDate: DateTime(2005, 3, 1),
            status: WorkplaceApprovalStatus.approved,
          ),
        ],
      ),
      UserRegistrationModel(
        personalInfo: PersonalInfoData(
          fullNameEnglish: 'Dr. Sara Mansour',
          occupation: 'Dermatologist',
          email: 'sara@hospital.ly',
          primaryPhoneNumber: '+218912345681',
          nationalId: '100000000004',
          fullNameArabic: 'د. سارة منصور',
          placeOfBirth: 'Tripoli',
          municipality: 'Tripoli Central',
          dateOfBirth: DateTime(1988, 3, 4),
          residentialAddress: 'Tripoli, Libya',
        ),
        professionalInfo: ProfessionalInfoData(
          specialization: 'Dermatology',
          yearsOfExperience: 8,
          aboutMe:
              'Expert in clinical dermatology and aesthetic procedures with a focus on evidence-based skin care.',
          confirmsLicensed: true,
          agreesToLegitimateUse: true,
        ),
        workplaces: [
          UserWorkplace(
            institutionId: allInst[4].id,
            institutionName: allInst[4].name,
            institutionType: allInst[4].type,
            location: allInst[4].location,
            position: 'Dermatology Specialist',
            joinedDate: DateTime(2018, 9, 1),
            status: WorkplaceApprovalStatus.approved,
          ),
        ],
      ),
    ];
  }
}
