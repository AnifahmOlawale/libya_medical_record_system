import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:libya_medical_record_system/core/shared/theme/app_colors.dart';

class NotificationBell extends StatelessWidget {
  const NotificationBell({super.key, this.color});
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return FaIcon(
      FontAwesomeIcons.bell,
      size: 20,
      color: color ?? AppColors.textSecondary,
    );
  }
}
