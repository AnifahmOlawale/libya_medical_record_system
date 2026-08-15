/// Represents a medical institution or facility where a user is employed or affiliated.
class UserWorkplace {
  final String institutionName;
  final String institutionType;
  final String location;
  final String position;
  final DateTime joinedDate;
  final bool isCurrent;

  UserWorkplace({
    required this.institutionName,
    required this.institutionType,
    required this.location,
    required this.position,
    required this.joinedDate,
    this.isCurrent = true,
  });

  UserWorkplace copyWith({
    String? institutionName,
    String? institutionType,
    String? location,
    String? position,
    DateTime? joinedDate,
    bool? isCurrent,
  }) {
    return UserWorkplace(
      institutionName: institutionName ?? this.institutionName,
      institutionType: institutionType ?? this.institutionType,
      location: location ?? this.location,
      position: position ?? this.position,
      joinedDate: joinedDate ?? this.joinedDate,
      isCurrent: isCurrent ?? this.isCurrent,
    );
  }
}
