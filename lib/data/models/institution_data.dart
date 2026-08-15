class InstitutionData {
  InstitutionData({
    required this.institutionName,
    required this.location,
    required this.specialization,
    required this.isPublic,
    required this.institutionType,
    this.legalLicensePath,
    required this.phoneNumber,
    required this.address,
  });

  final String institutionName;
  final String location;
  final String specialization;
  final bool isPublic;
  final String institutionType; // Hospital, Clinic, etc.
  final String? legalLicensePath;
  final String phoneNumber;
  final String address;

  InstitutionData copyWith({
    String? institutionName,
    String? location,
    String? specialization,
    bool? isPublic,
    String? institutionType,
    String? legalLicensePath,
    String? phoneNumber,
    String? address,
  }) {
    return InstitutionData(
      institutionName: institutionName ?? this.institutionName,
      location: location ?? this.location,
      specialization: specialization ?? this.specialization,
      isPublic: isPublic ?? this.isPublic,
      institutionType: institutionType ?? this.institutionType,
      legalLicensePath: legalLicensePath ?? this.legalLicensePath,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
    );
  }
}
