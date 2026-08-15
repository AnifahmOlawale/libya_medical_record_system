import 'package:flutter/material.dart';

/// Tracks state for the main dashboard (which tab is active, etc.)
class DashboardProvider extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  /// Update the current active tab index.
  void changeNavigationIndex({required int newIndex}) {
    _currentIndex = newIndex;
    notifyListeners();
  }
}
