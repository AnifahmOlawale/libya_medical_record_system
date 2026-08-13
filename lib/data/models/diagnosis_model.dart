enum DiagnosisStatus {
  active,
  chronic,
  resolved,
}

enum DiagnosisSeverity {
  mild,
  moderate,
  severe,
}

class DiagnosisModel {
  final String id;
  final String conditionName;
  final DateTime diagnosisDate;
  final DiagnosisStatus status;
  final DiagnosisSeverity severity;
  final String diagnosedBy;
  final String? symptoms;
  final String? treatmentPlan;
  final String? notes;
  final double? cost;
  final List<String> diagnosisDocumentPaths; // Support for multiple documents
  final String? addedBy;
  final DateTime lastUpdated;

  DiagnosisModel({
    required this.id,
    required this.conditionName,
    required this.diagnosisDate,
    required this.status,
    required this.severity,
    required this.diagnosedBy,
    this.symptoms,
    this.treatmentPlan,
    this.notes,
    this.cost,
    this.diagnosisDocumentPaths = const [],
    this.addedBy,
    required this.lastUpdated,
  });
}
