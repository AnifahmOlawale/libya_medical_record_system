class AllergyModel {
  final String id;
  final String allergen; // e.g., "Penicillin", "Peanuts"
  final String reaction; // e.g., "Skin rash", "Difficulty breathing"
  final DateTime? onsetDate; // When it was first discovered
  final String? notes;
  final String? addedBy; // Doctor or Patient name
  final DateTime lastUpdated;

  AllergyModel({
    required this.id,
    required this.allergen,
    required this.reaction,
    this.onsetDate,
    this.notes,
    this.addedBy,
    required this.lastUpdated,
  });
}
