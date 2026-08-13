/// Raw data captured by the medical-information registration step.
class MedicalInfoData {
  MedicalInfoData({
    required this.height,
    required this.weight,
    this.lastBloodDonationDate,
    required this.bloodType,
    required this.genotype,
    required this.gender,
    required this.maritalStatus,
    required this.disabilityStatus,
    required this.smokingStatus,
    required this.alcoholUse,
    required this.pregnancyStatus,
  });

  final String height;
  final String weight;
  final DateTime? lastBloodDonationDate;
  final String bloodType;
  final String genotype;
  final String gender;
  final String maritalStatus;
  final String disabilityStatus;
  final String smokingStatus;
  final String alcoholUse;
  final String pregnancyStatus;
}
