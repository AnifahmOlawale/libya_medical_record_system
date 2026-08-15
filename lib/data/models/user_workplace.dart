enum WorkplaceApprovalStatus { pending, rejected, approved }

/// Represents a medical institution or facility where a user is employed or affiliated.
class UserWorkplace {
  final String institutionId;
  final String institutionName;
  final String institutionType;
  final String location;
  final String position;
  final DateTime joinedDate;
  final WorkplaceApprovalStatus status;

  UserWorkplace({
    required this.institutionId,
    required this.institutionName,
    required this.institutionType,
    required this.location,
    required this.position,
    required this.joinedDate,
    this.status = WorkplaceApprovalStatus.pending,
  });

  UserWorkplace copyWith({
    String? institutionId,
    String? institutionName,
    String? institutionType,
    String? location,
    String? position,
    DateTime? joinedDate,
    WorkplaceApprovalStatus? status,
  }) {
    return UserWorkplace(
      institutionId: institutionId ?? this.institutionId,
      institutionName: institutionName ?? this.institutionName,
      institutionType: institutionType ?? this.institutionType,
      location: location ?? this.location,
      position: position ?? this.position,
      joinedDate: joinedDate ?? this.joinedDate,
      status: status ?? this.status,
    );
  }
}
