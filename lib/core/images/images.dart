import 'package:flutter/material.dart';

class Images {
  static const String onboarding1 = 'assets/images/onb1.png';
  static const String onboarding2 = 'assets/images/onb2.png';
  static const String onboarding3 = 'assets/images/onb3.png';

  static void precacheImages(BuildContext context) {
    precacheImage(const AssetImage(onboarding1), context);
    precacheImage(const AssetImage(onboarding2), context);
    precacheImage(const AssetImage(onboarding3), context);
  }
}
