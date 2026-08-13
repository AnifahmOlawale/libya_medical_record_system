class PermissionTokenModel {
  final String id;
  final String token; // The generated 6-digit or alpha-numeric code
  final DateTime createdAt;
  final DateTime expiresAt;
  final bool isUsed;
  final String? accessedByDoctor; // Name of the doctor who used the token
  final List<String> accessibleModules; // List of module IDs or names e.g. ['Vitals', 'Lab Tests']

  PermissionTokenModel({
    required this.id,
    required this.token,
    required this.createdAt,
    required this.expiresAt,
    this.isUsed = false,
    this.accessedByDoctor,
    required this.accessibleModules,
  });

  bool get isExpired => DateTime.now().isAfter(expiresAt);
}
