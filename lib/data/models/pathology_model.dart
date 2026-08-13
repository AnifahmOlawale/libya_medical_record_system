enum PathologyStatus {
  normal,
  benign,
  malignant,
  inconclusive,
}

class PathologyModel {
  final String id;
  final String specimenType;
  final String anatomicSite;
  final DateTime collectionDate;
  final String institutionName;
  final String findings; // Macroscopic + Microscopic details
  final String finalDiagnosis;
  final PathologyStatus status;
  final String pathologistName;
  final double? cost;
  final List<String> reportPaths;
  final String? addedBy;
  final DateTime lastUpdated;

  PathologyModel({
    required this.id,
    required this.specimenType,
    required this.anatomicSite,
    required this.collectionDate,
    required this.institutionName,
    required this.findings,
    required this.finalDiagnosis,
    required this.status,
    required this.pathologistName,
    this.cost,
    this.reportPaths = const [],
    this.addedBy,
    required this.lastUpdated,
  });
}
