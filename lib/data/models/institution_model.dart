class InstitutionModel {
  final String id;
  final String name;
  final String type;
  final String municipality;
  final String specialization;
  final dynamic icon;
  final String? logoUrl;
  final String? ownerId;
  final String? legalLicensePath;
  final String? phoneNumber;
  final String? address;
  final bool isPublic;

  InstitutionModel({
    required this.id,
    required this.name,
    required this.type,
    required this.municipality,
    required this.specialization,
    this.icon,
    this.logoUrl,
    this.ownerId,
    this.legalLicensePath,
    this.phoneNumber,
    this.address,
    this.isPublic = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'municipality': municipality,
      'specialization': specialization,
      'icon': icon,
      'logoUrl': logoUrl,
      'ownerId': ownerId,
      'legalLicensePath': legalLicensePath,
      'phoneNumber': phoneNumber,
      'address': address,
      'isPublic': isPublic,
    };
  }
}
