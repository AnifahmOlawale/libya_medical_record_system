enum VisitType {
  routine,
  emergency,
  followUp,
  specialist,
  telemedicine,
  consultation,
  other,
}

class MedicalVisitModel {
  final String id;
  final DateTime visitDate;
  final VisitType visitType;
  final String? customVisitType; // For "Other"
  final String doctorName;
  final String facilityName;
  final String reasonForVisit;
  final String? findings;
  final String? instructions;
  final double? cost;
  final List<String> reportPaths;
  final String? addedBy;
  final DateTime lastUpdated;

  MedicalVisitModel({
    required this.id,
    required this.visitDate,
    required this.visitType,
    this.customVisitType,
    required this.doctorName,
    required this.facilityName,
    required this.reasonForVisit,
    this.findings,
    this.instructions,
    this.cost,
    this.reportPaths = const [],
    this.addedBy,
    required this.lastUpdated,
  });
}
