import 'package:flutter/material.dart';
import 'package:libya_medical_record_system/data/models/user_registration_model.dart';

class DashboardProvider extends ChangeNotifier {
  int _indexOfNavigation = 0;
  UserType _userType = UserType.patient;

  //GETTERS
  int get indexOfNavigation => _indexOfNavigation;
  UserType get userType => _userType;

  void changeNavigationIndex({required int newIndex}) {
    _indexOfNavigation = newIndex;
    notifyListeners();
  }

  void changeUser({required UserType userType}) {
    _userType = userType;
    notifyListeners();
  }
}
