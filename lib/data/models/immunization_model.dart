class ImmunizationModel {
  final String id;
  final String vaccineName;
  final DateTime dateAdministered;
  final String doseNumber;
  final String? manufacturer;
  final String? batchNumber;
  final String administeredBy;
  final String? sideEffects;
  final DateTime? nextDueDate;
  final double? cost;
  final List<String> reportPaths;
  final String? addedBy;
  final DateTime lastUpdated;

  ImmunizationModel({
    required this.id,
    required this.vaccineName,
    required this.dateAdministered,
    required this.doseNumber,
    this.manufacturer,
    this.batchNumber,
    required this.administeredBy,
    this.sideEffects,
    this.nextDueDate,
    this.cost,
    this.reportPaths = const [],
    this.addedBy,
    required this.lastUpdated,
  });
}
