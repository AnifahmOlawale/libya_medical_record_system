import 'package:flutter/material.dart';
import 'package:libya_medical_record_system/data/hive/hive_box.dart';

class SwitchLangProvider extends ChangeNotifier {
  late Locale _lang;

  //set defult
  SwitchLangProvider() {
    final langCode = HiveBox.currentLang.get(HiveBox.currentLangTag);

    if (langCode != null && langCode is String && langCode.isNotEmpty) {
      _lang = Locale(langCode); // assigned here if langCode exists
    } else {
      _lang = const Locale("en"); // assigned here as default
      HiveBox.currentLang.put(HiveBox.currentLangTag, "en");
    }
  }

  //Get lang

  Locale get lang => _lang;

  //set lang

  void toggleLang({required String setLang}) {
    _lang = Locale(setLang);
    HiveBox.currentLang.put(HiveBox.currentLangTag, _lang.languageCode);
    notifyListeners();
  }
}
