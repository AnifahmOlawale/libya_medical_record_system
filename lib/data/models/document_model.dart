enum DocumentCategory {
  medicalCertificate,
  referralLetter,
  prescription,
  dischargeSummary,
  insurance,
  other,
}

class DocumentModel {
  final String id;
  final String title;
  final DocumentCategory category;
  final String? customCategory; // Detail if category is 'other'
  final DateTime issueDate;
  final String issuedBy;
  final String? description;
  final List<String> filePaths;
  final String? addedBy;
  final DateTime lastUpdated;

  DocumentModel({
    required this.id,
    required this.title,
    required this.category,
    this.customCategory,
    required this.issueDate,
    required this.issuedBy,
    this.description,
    this.filePaths = const [],
    this.addedBy,
    required this.lastUpdated,
  });
}
