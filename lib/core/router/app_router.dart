import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:libya_medical_record_system/core/shared/widgets/sliver_page_header.dart';
import 'package:libya_medical_record_system/data/models/diagnosis_model.dart';
import 'package:libya_medical_record_system/data/models/radiology_model.dart';
import 'package:libya_medical_record_system/data/models/user_registration_model.dart';
import 'package:libya_medical_record_system/features/auth/registration_form/registration_form.dart';
import 'package:libya_medical_record_system/features/auth/signup/login_screen.dart';
import 'package:libya_medical_record_system/features/auth/signup/signup_page.dart';
import 'package:libya_medical_record_system/features/auth/signup/forgot_password_screen.dart';
import 'package:libya_medical_record_system/features/auth/signup/otp_screen.dart';
import 'package:libya_medical_record_system/features/dashboard/app_shell.dart';
import 'package:libya_medical_record_system/features/dashboard/dashboard.dart';
import 'package:libya_medical_record_system/features/experts/expert_detail_page.dart';
import 'package:libya_medical_record_system/features/experts/search_experts_page.dart';
import 'package:libya_medical_record_system/features/home/clinical_access_entry_page.dart';
import 'package:libya_medical_record_system/features/home/home_page.dart';
import 'package:libya_medical_record_system/features/institutions/join_institution_page.dart';
import 'package:libya_medical_record_system/features/institutions/affiliated_institutions_page.dart';
import 'package:libya_medical_record_system/features/institutions/institution_requests_page.dart';
import 'package:libya_medical_record_system/features/my_records/allergies/add_allergy_page.dart';
import 'package:libya_medical_record_system/features/my_records/allergies/allergies_page.dart';
import 'package:libya_medical_record_system/features/my_records/allergies/allergy_detail_page.dart';
import 'package:libya_medical_record_system/data/models/allergy_model.dart';
import 'package:libya_medical_record_system/data/models/lab_test_model.dart';
import 'package:libya_medical_record_system/features/my_records/diagnoses/add_diagnosis_page.dart';
import 'package:libya_medical_record_system/features/my_records/diagnoses/diagnoses_page.dart';
import 'package:libya_medical_record_system/features/my_records/diagnoses/diagnosis_detail_page.dart';
import 'package:libya_medical_record_system/features/my_records/lab_tests/add_lab_test_page.dart';
import 'package:libya_medical_record_system/features/my_records/lab_tests/lab_test_detail_page.dart';
import 'package:libya_medical_record_system/features/my_records/lab_tests/lab_tests_page.dart';
import 'package:libya_medical_record_system/features/my_records/documents/add_document_page.dart';
import 'package:libya_medical_record_system/features/my_records/documents/document_detail_page.dart';
import 'package:libya_medical_record_system/features/my_records/documents/documents_page.dart';
import 'package:libya_medical_record_system/data/models/document_model.dart';
import 'package:libya_medical_record_system/features/my_records/immunizations/add_immunization_page.dart';
import 'package:libya_medical_record_system/features/my_records/immunizations/immunization_detail_page.dart';
import 'package:libya_medical_record_system/features/my_records/immunizations/immunizations_page.dart';
import 'package:libya_medical_record_system/features/my_records/medical_visits/add_medical_visit_page.dart';
import 'package:libya_medical_record_system/features/my_records/medical_visits/medical_visit_detail_page.dart';
import 'package:libya_medical_record_system/features/my_records/medical_visits/medical_visits_page.dart';
import 'package:libya_medical_record_system/features/my_records/records_page.dart';
import 'package:libya_medical_record_system/features/my_records/vitals/add_vital_page.dart';
import 'package:libya_medical_record_system/features/my_records/vitals/vitals_page.dart';
import 'package:libya_medical_record_system/data/models/medical_visit_model.dart';
import 'package:libya_medical_record_system/data/models/immunization_model.dart';
import 'package:libya_medical_record_system/features/my_records/pathology/add_pathology_page.dart';
import 'package:libya_medical_record_system/features/my_records/pathology/pathology_detail_page.dart';
import 'package:libya_medical_record_system/features/my_records/pathology/pathology_page.dart';
import 'package:libya_medical_record_system/data/models/pathology_model.dart';
import 'package:libya_medical_record_system/features/my_records/radiology/add_radiology_page.dart';
import 'package:libya_medical_record_system/features/my_records/radiology/radiology_detail_page.dart';
import 'package:libya_medical_record_system/features/my_records/radiology/radiology_page.dart';
import 'package:libya_medical_record_system/features/my_records/surgeries/add_surgery_page.dart';
import 'package:libya_medical_record_system/features/my_records/surgeries/surgery_detail_page.dart';
import 'package:libya_medical_record_system/features/my_records/surgeries/surgeries_page.dart';
import 'package:libya_medical_record_system/features/permissions/permissions_page.dart';
import 'package:libya_medical_record_system/data/models/surgery_model.dart';
import 'package:libya_medical_record_system/features/my_records/medications/add_medication_page.dart';
import 'package:libya_medical_record_system/features/my_records/medications/add_medication_reminder_page.dart';
import 'package:libya_medical_record_system/features/my_records/medications/medication_detail_page.dart';
import 'package:libya_medical_record_system/features/my_records/medications/medications_page.dart';
import 'package:libya_medical_record_system/data/models/medication_model.dart';
import 'package:libya_medical_record_system/features/my_records/medical_info/edit_medical_info.dart';
import 'package:libya_medical_record_system/features/my_records/medical_info/medical_info.dart';
import 'package:libya_medical_record_system/features/onboarding/onboarding.dart';
import 'package:libya_medical_record_system/features/profile/medical_staff_user_profile.dart';
import 'package:libya_medical_record_system/features/profile/professional_experience_page.dart';
import 'package:libya_medical_record_system/features/profile/edit_profile.dart';
import 'package:libya_medical_record_system/features/institutions/institution_detail_page.dart';
import 'package:libya_medical_record_system/data/models/institution_model.dart';
import 'package:libya_medical_record_system/features/profile/profile_page.dart';
import 'package:libya_medical_record_system/features/profile/users_profile.dart';
import '../../features/splash/splash_screen.dart';

/// Central place for every route path string in the app.
/// Reference these instead of hardcoding paths, e.g.:
///   context.go(AppRoutes.login);
abstract final class AppRoutes {
  static const splash = '/splash';
  static const onboarding = '/onboarding';
  static const login = '/auth/login';
  static const signup = '/auth/signup';
  static const forgotPassword = '/auth/forgot-password';
  static const otp = '/auth/otp';
  static const registrationForm = '/auth/registration-form';
  static const dashboard = '/dashboard';
  static const home = '/dashboard/home';
  static const records = '/dashboard/records';
  static const experts = '/dashboard/experts';
  static const profile = '/dashboard/profile';
  static const usersProfile = '/profile/users-profile';
  static const medicalStaffProfile = '/profile/medical-staff-profile';
  static const professionalExperience = '/profile/professional-experience';
  static const joinInstitution = '/dashboard/join-institution';
  static const affiliatedInstitutions = '/dashboard/affiliated-institutions';
  static const institutionRequests = '/dashboard/institution-requests';
  static const institutionDetail = '/dashboard/join-institution/detail';
  static const permissions = '/profile/permissions';
  static const editProfile = '/profile/edit-profile-info';
  static const medicalInfo = '/records/medical-info';
  static const expertDetail = '/experts/detail';
  static const vitals = '/records/vitals';
  static const addVital = '/records/vitals/add';
  static const allergies = '/records/allergies';
  static const addAllergy = '/records/allergies/add';
  static const allergyDetail = '/records/allergies/detail';
  static const medications = '/records/medications';
  static const addMedication = '/records/medications/add';
  static const medicationDetail = '/records/medications/detail';
  static const addMedicationReminder = '/records/medications/add-reminder';
  static const diagnoses = '/records/diagnoses';
  static const addDiagnosis = '/records/diagnoses/add';
  static const diagnosisDetail = '/records/diagnoses/detail';
  static const labTests = '/records/lab-tests';
  static const addLabTest = '/records/lab-tests/add';
  static const labTestDetail = '/records/lab-tests/detail';
  static const medicalVisits = '/records/medical-visits';
  static const addMedicalVisit = '/records/medical-visits/add';
  static const medicalVisitDetail = '/records/medical-visits/detail';
  static const radiology = '/records/radiology';
  static const addRadiology = '/records/radiology/add';
  static const radiologyDetail = '/records/radiology/detail';
  static const pathology = '/records/pathology';
  static const addPathology = '/records/pathology/add';
  static const pathologyDetail = '/records/pathology/detail';
  static const surgeries = '/records/surgeries';
  static const addSurgery = '/records/surgeries/add';
  static const surgeryDetail = '/records/surgeries/detail';
  static const immunizations = '/records/immunizations';
  static const addImmunization = '/records/immunizations/add';
  static const immunizationDetail = '/records/immunizations/detail';
  static const documents = '/records/documents';
  static const addDocument = '/records/documents/add';
  static const documentDetail = '/records/documents/detail';
  static const editMedicalInfo = '/records/medical-info/edit-medical-info';
  static const clinicalAccessEntry = '/clinical-access/entry';
}

/// Central GoRouter configuration for Libya Medical Record System.
/// Add every GoRoute to the `routes` list below — this is the single
/// source of truth for app navigation.
abstract final class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: kIsWeb ? AppRoutes.login : AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: SplashScreen(
            onComplete: () => context.go(AppRoutes.onboarding),
          ),
          transitionDuration: const Duration(
            milliseconds: 500,
          ), 
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),

      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) =>
            OnboardingPage(onGetStarted: () => context.go(AppRoutes.login)),
      ),

      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => LoginScreen(
          onLoginSuccess: () => context.go(AppRoutes.registrationForm),
          onSignUp: () => context.go(AppRoutes.signup),
          onForgotPassword: () => context.go(
            AppRoutes.forgotPassword,
          ), 
        ),
      ),

      GoRoute(
        path: AppRoutes.signup,
        builder: (context, state) => SignUpScreen(
          onSignIn: () => context.go(AppRoutes.login),
          onSignUpSuccess: () => context.go(AppRoutes.registrationForm),
        ),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        builder: (context, state) => ForgotPasswordScreen(
          onBackToLogin: () => context.go(AppRoutes.login),
          onResetSent: (email) => context.push(AppRoutes.otp, extra: email),
        ),
      ),
      GoRoute(
        path: AppRoutes.otp,
        builder: (context, state) {
          final email = state.extra as String? ?? '';
          return OtpScreen(
            email: email,
            onBack: () => context.pop(),
            onVerify: (pin) => context.go(AppRoutes.registrationForm),
            onResend: () {
              // Logic to resend OTP
            },
          );
        },
      ),
      GoRoute(
        path: AppRoutes.registrationForm,
        builder: (context, state) => const RegistrationForm(),
      ),

      //DASHBOARD
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => AppShell(child: child),

        routes: [
          GoRoute(
            path: AppRoutes.dashboard,
            redirect: (context, state) {
              if (state.matchedLocation == AppRoutes.dashboard) {
                return AppRoutes.home;
              }
              return null;
            },
          ),

          StatefulShellRoute.indexedStack(
            builder: (context, state, navigationShell) {
              return DashboardScreen(navigationShell: navigationShell);
            },
            branches: [
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: AppRoutes.home,
                    builder: (context, state) => const HomePage(),
                  ),
                ],
              ),
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: AppRoutes.records,
                    builder: (context, state) => const RecordsPage(),
                  ),
                ],
              ),
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: AppRoutes.experts,
                    builder: (context, state) => const SearchExpertsPage(),
                  ),
                ],
              ),
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: AppRoutes.joinInstitution,
                    builder: (context, state) => const JoinInstitutionPage(),
                  ),
                  GoRoute(
                    path: AppRoutes.affiliatedInstitutions,
                    builder: (context, state) => const AffiliatedInstitutionsPage(),
                  ),
                  GoRoute(
                    path: AppRoutes.institutionRequests,
                    builder: (context, state) => const InstitutionRequestsPage(),
                  ),
                ],
              ),
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: AppRoutes.profile,
                    builder: (context, state) => const ProfilePage(),
                  ),
                ],
              ),
            ],
          ),

          GoRoute(
            path: AppRoutes.usersProfile,
            builder: (context, state) => const UsersProfile(),
          ),

          GoRoute(
            path: AppRoutes.medicalStaffProfile,
            builder: (context, state) => const MedicalStaffUserProfile(),
          ),

          GoRoute(
            path: AppRoutes.professionalExperience,
            builder: (context, state) => const ProfessionalExperiencePage(),
          ),

          GoRoute(
            path: AppRoutes.expertDetail,
            builder: (context, state) {
              final expert = state.extra as UserRegistrationModel;
              return ExpertDetailPage(expert: expert);
            },
          ),

          GoRoute(
            path: AppRoutes.institutionDetail,
            builder: (context, state) {
              final institution = state.extra as InstitutionModel;
              return InstitutionDetailPage(institution: institution);
            },
          ),

          GoRoute(
            path: AppRoutes.permissions,
            builder: (context, state) => const PermissionsPage(),
          ),

          GoRoute(
            path: AppRoutes.editProfile,
            builder: (context, state) => const EditProfileInfo(),
          ),

          GoRoute(
            path: AppRoutes.medicalInfo,
            builder: (context, state) => const MedicalInfo(),
          ),

          GoRoute(
            path: AppRoutes.vitals,
            builder: (context, state) => const VitalsPage(),
          ),

          GoRoute(
            path: AppRoutes.addVital,
            builder: (context, state) => const AddVitalPage(),
          ),

          GoRoute(
            path: AppRoutes.allergies,
            builder: (context, state) => const AllergiesPage(),
          ),

          GoRoute(
            path: AppRoutes.addAllergy,
            builder: (context, state) => const AddAllergyPage(),
          ),

          GoRoute(
            path: AppRoutes.allergyDetail,
            builder: (context, state) {
              final allergy = state.extra as AllergyModel;
              return AllergyDetailPage(allergy: allergy);
            },
          ),

          GoRoute(
            path: AppRoutes.medications,
            builder: (context, state) => const MedicationsPage(),
          ),

          GoRoute(
            path: AppRoutes.addMedication,
            builder: (context, state) => const AddMedicationPage(),
          ),

          GoRoute(
            path: AppRoutes.medicationDetail,
            builder: (context, state) {
              final medication = state.extra as MedicationModel;
              return MedicationDetailPage(medication: medication);
            },
          ),

          GoRoute(
            path: AppRoutes.addMedicationReminder,
            builder: (context, state) {
              final medication = state.extra as MedicationModel;
              return AddMedicationReminderPage(medication: medication);
            },
          ),

          GoRoute(
            path: AppRoutes.diagnoses,
            builder: (context, state) => const DiagnosesPage(),
          ),

          GoRoute(
            path: AppRoutes.addDiagnosis,
            builder: (context, state) => const AddDiagnosisPage(),
          ),
          GoRoute(
            path: AppRoutes.diagnosisDetail,
            builder: (context, state) {
              final diagnosis = state.extra as DiagnosisModel;
              return DiagnosisDetailPage(diagnosis: diagnosis);
            },
          ),

          GoRoute(
            path: AppRoutes.labTests,
            builder: (context, state) => const LabTestsPage(),
          ),

          GoRoute(
            path: AppRoutes.addLabTest,
            builder: (context, state) => const AddLabTestPage(),
          ),

          GoRoute(
            path: AppRoutes.labTestDetail,
            builder: (context, state) {
              final test = state.extra as LabTestModel;
              return LabTestDetailPage(test: test);
            },
          ),

          GoRoute(
            path: AppRoutes.medicalVisits,
            builder: (context, state) => const MedicalVisitsPage(),
          ),

          GoRoute(
            path: AppRoutes.addMedicalVisit,
            builder: (context, state) => const AddMedicalVisitPage(),
          ),

          GoRoute(
            path: AppRoutes.medicalVisitDetail,
            builder: (context, state) {
              final visit = state.extra as MedicalVisitModel;
              return MedicalVisitDetailPage(visit: visit);
            },
          ),

          GoRoute(
            path: AppRoutes.radiology,
            builder: (context, state) => const RadiologyPage(),
          ),

          GoRoute(
            path: AppRoutes.addRadiology,
            builder: (context, state) => const AddRadiologyPage(),
          ),

          GoRoute(
            path: AppRoutes.radiologyDetail,
            builder: (context, state) {
              final report = state.extra as RadiologyModel;
              return RadiologyDetailPage(report: report);
            },
          ),

          GoRoute(
            path: AppRoutes.pathology,
            builder: (context, state) => const PathologyPage(),
          ),

          GoRoute(
            path: AppRoutes.addPathology,
            builder: (context, state) => const AddPathologyPage(),
          ),

          GoRoute(
            path: AppRoutes.pathologyDetail,
            builder: (context, state) {
              final report = state.extra as PathologyModel;
              return PathologyDetailPage(report: report);
            },
          ),

          GoRoute(
            path: AppRoutes.surgeries,
            builder: (context, state) => const SurgeriesPage(),
          ),

          GoRoute(
            path: AppRoutes.addSurgery,
            builder: (context, state) => const AddSurgeryPage(),
          ),

          GoRoute(
            path: AppRoutes.surgeryDetail,
            builder: (context, state) {
              final surgery = state.extra as SurgeryModel;
              return SurgeryDetailPage(surgery: surgery);
            },
          ),

          GoRoute(
            path: AppRoutes.immunizations,
            builder: (context, state) => const ImmunizationsPage(),
          ),

          GoRoute(
            path: AppRoutes.addImmunization,
            builder: (context, state) => const AddImmunizationPage(),
          ),

          GoRoute(
            path: AppRoutes.immunizationDetail,
            builder: (context, state) {
              final immunization = state.extra as ImmunizationModel;
              return ImmunizationDetailPage(immunization: immunization);
            },
          ),

          GoRoute(
            path: AppRoutes.documents,
            builder: (context, state) => const DocumentsPage(),
          ),

          GoRoute(
            path: AppRoutes.addDocument,
            builder: (context, state) => const AddDocumentPage(),
          ),

          GoRoute(
            path: AppRoutes.documentDetail,
            builder: (context, state) {
              final doc = state.extra as DocumentModel;
              return DocumentDetailPage(document: doc);
            },
          ),

          GoRoute(
            path: AppRoutes.editMedicalInfo,
            builder: (context, state) => const EditMedicalInfo(),
          ),

          GoRoute(
            path: AppRoutes.clinicalAccessEntry,
            builder: (context, state) => const ClinicalAccessEntryPage(),
          ),
        ],
      ),
    ],
  );
}
