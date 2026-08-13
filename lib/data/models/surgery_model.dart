enum SurgeryStatus {
  completed,
  planned,
  cancelled,
}

class SurgeryModel {
  final String id;
  final String procedureName;
  final DateTime surgeryDate;
  final String hospitalName;
  final String surgeonName;
  final String? indication;
  final String? anesthesiaType;
  final String? operationNotes;
  final String? dischargeInstructions;
  final SurgeryStatus status;
  final double? cost;
  final List<String> reportPaths;
  final String? addedBy;
  final DateTime lastUpdated;

  SurgeryModel({
    required this.id,
    required this.procedureName,
    required this.surgeryDate,
    required this.hospitalName,
    required this.surgeonName,
    this.indication,
    this.anesthesiaType,
    this.operationNotes,
    this.dischargeInstructions,
    required this.status,
    this.cost,
    this.reportPaths = const [],
    this.addedBy,
    required this.lastUpdated,
  });
}
