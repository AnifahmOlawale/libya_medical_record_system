class MedicationModel {
  final String id;
  final String medicationName;
  final String strength; // e.g., 500 mg
  final String form; // Tablet, Capsule, etc.
  final String frequency; // Once daily, Twice daily, etc.
  final int duration; // in days
  final String instructions;
  final String intakeMethod;
  final String dosage;
  final String? addedBy;
  final DateTime lastUpdated;

  MedicationModel({
    required this.id,
    required this.medicationName,
    required this.strength,
    required this.form,
    required this.frequency,
    required this.duration,
    required this.instructions,
    required this.intakeMethod,
    required this.dosage,
    this.addedBy,
    required this.lastUpdated,
  });
}
