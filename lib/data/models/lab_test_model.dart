enum LabResultStatus {
  normal,
  abnormal,
  critical,
}

class LabTestModel {
  final String id;
  final String testName;
  final DateTime testDate;
  final String laboratoryName;
  final String? resultValue;
  final String? unit;
  final String? referenceRange;
  final LabResultStatus status;
  final String? orderedBy;
  final String? notes;
  final double? cost;
  final List<String> reportPaths;
  final String? addedBy;
  final DateTime lastUpdated;

  LabTestModel({
    required this.id,
    required this.testName,
    required this.testDate,
    required this.laboratoryName,
    this.resultValue,
    this.unit,
    this.referenceRange,
    required this.status,
    this.orderedBy,
    this.notes,
    this.cost,
    this.reportPaths = const [],
    this.addedBy,
    required this.lastUpdated,
  });
}
