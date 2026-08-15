class InstitutionModel {
  final String id;
  final String name;
  final String type;
  final String location;
  final String specialization;
  final dynamic icon;
  final String? phoneNumber;
  final String? address;
  final bool isPublic;

  InstitutionModel({
    required this.id,
    required this.name,
    required this.type,
    required this.location,
    required this.specialization,
    this.icon,
    this.phoneNumber,
    this.address,
    this.isPublic = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'location': location,
      'specialization': specialization,
      'icon': icon,
      'phoneNumber': phoneNumber,
      'address': address,
      'isPublic': isPublic,
    };
  }
}
