import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:libya_medical_record_system/data/models/document_model.dart';

abstract final class DocumentConstants {
  static const Map<DocumentCategory, String> categoryLabels = {
    DocumentCategory.medicalCertificate: 'Medical Certificate',
    DocumentCategory.referralLetter: 'Referral Letter',
    DocumentCategory.prescription: 'Prescription',
    DocumentCategory.dischargeSummary: 'Discharge Summary',
    DocumentCategory.insurance: 'Insurance Document',
    DocumentCategory.other: 'Other',
  };

  static dynamic getCategoryIcon(DocumentCategory category) {
    switch (category) {
      case DocumentCategory.medicalCertificate:
        return FontAwesomeIcons.stamp;
      case DocumentCategory.referralLetter:
        return FontAwesomeIcons.envelopeOpenText;
      case DocumentCategory.prescription:
        return FontAwesomeIcons.prescription;
      case DocumentCategory.dischargeSummary:
        return FontAwesomeIcons.fileExport;
      case DocumentCategory.insurance:
        return FontAwesomeIcons.shieldHalved;
      case DocumentCategory.other:
        return FontAwesomeIcons.fileLines;
    }
  }
}
