enum RadiologyModality {
  xRay,
  ctScan,
  mri,
  ultrasound,
  mammogram,
  petScan,
  other,
}

class RadiologyModel {
  final String id;
  final String studyName; // e.g. "MRI Brain with Contrast"
  final RadiologyModality modality;
  final String bodyPart;
  final DateTime studyDate;
  final String institutionName;
  final String? customModality; // To save detail if modality is 'other'
  final String? clinicalIndication;
  final String findings;
  final String impression;
  final String radiologistName;
  final double? cost;
  final List<String> reportPaths; // Combined images and PDFs
  final String? addedBy;
  final DateTime lastUpdated;

  RadiologyModel({
    required this.id,
    required this.studyName,
    required this.modality,
    required this.bodyPart,
    required this.studyDate,
    required this.institutionName,
    this.customModality,
    this.clinicalIndication,
    required this.findings,
    required this.impression,
    required this.radiologistName,
    this.cost,
    this.reportPaths = const [],
    this.addedBy,
    required this.lastUpdated,
  });
}
