class DentalRecordModel {
  final String id;
  final DateTime date;
  final List<String> selectedTeeth;
  final String procedure;
  final String doctorName;
  final String institutionName;
  final String? notes;
  final List<String> reportPaths;
  final DateTime lastUpdated;
  final String? addedBy;

  DentalRecordModel({
    required this.id,
    required this.date,
    required this.selectedTeeth,
    required this.procedure,
    required this.doctorName,
    required this.institutionName,
    this.notes,
    this.reportPaths = const [],
    required this.lastUpdated,
    this.addedBy,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'selectedTeeth': selectedTeeth,
      'procedure': procedure,
      'doctorName': doctorName,
      'institutionName': institutionName,
      'notes': notes,
      'reportPaths': reportPaths,
      'lastUpdated': lastUpdated.toIso8601String(),
      'addedBy': addedBy,
    };
  }
}
