import 'package:hive_ce_flutter/hive_flutter.dart';

/// Initializes Hive database with all required boxes.
/// This function must be called before any Hive operations in main.dart
Future<void> initializeHive() async {
  try {
    // Initialize Hive for Flutter - sets up local storage
    await Hive.initFlutter();

    await Hive.openBox(HiveBox.currentLangTag);
  } catch (e) {
    // Log the error and rethrow to prevent app from starting with corrupted state
    rethrow;
  }
}

class HiveBox {
  //HIVEBOX NAMES
  static String currentLangTag = "currentLang";

  //HIVE TAG NAMES
  static String currentLangBoxName = "currentLang";

  //GETTERS
  static Box get currentLang => Hive.box(currentLangTag);
}
