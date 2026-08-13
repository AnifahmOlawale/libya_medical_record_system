import 'package:libya_medical_record_system/data/models/radiology_model.dart';

abstract final class RadiologyConstants {
  static const Map<RadiologyModality, String> modalityLabels = {
    RadiologyModality.xRay: 'X-Ray',
    RadiologyModality.ctScan: 'CT Scan',
    RadiologyModality.mri: 'MRI',
    RadiologyModality.ultrasound: 'Ultrasound',
    RadiologyModality.mammogram: 'Mammogram',
    RadiologyModality.petScan: 'PET Scan',
    RadiologyModality.other: 'Other',
  };
}
