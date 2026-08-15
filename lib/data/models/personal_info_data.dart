/// Raw data captured by the personal-information registration step.
///
/// Plain data holder — no JSON (de)serialization yet. Wire that up
/// once the backend (Supabase / Firebase / custom API) is decided.
class PersonalInfoData {
  PersonalInfoData({
    required this.nationalId,
    required this.fullNameArabic,
    required this.fullNameEnglish,
    this.placeOfBirth,
    this.passportNumber,
    required this.occupation,
    this.yearsOfExperience,
    required this.primaryPhoneNumber,
    this.secondaryPhoneNumber,
    required this.email,
    required this.residentialAddress,
    required this.municipality,
    required this.dateOfBirth,
  });

  final String nationalId;
  final String? passportNumber;
  final String fullNameArabic;
  final String fullNameEnglish;
  final String? placeOfBirth;
  final String occupation;
  final int? yearsOfExperience;
  final String primaryPhoneNumber;
  final String? secondaryPhoneNumber;
  final String email;
  final String residentialAddress;
  final String municipality;
  final DateTime dateOfBirth;
}
