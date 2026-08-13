import 'package:flutter/material.dart';
import 'package:libya_medical_record_system/data/providers/dashboard_provider.dart';
import 'package:libya_medical_record_system/data/providers/switch_lang_provider.dart';

import 'package:provider/provider.dart';

class AppProviders extends StatelessWidget {
  final Widget child;
  const AppProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //APP PROVIDERS
        ChangeNotifierProvider<SwitchLangProvider>(
          create: (_) => SwitchLangProvider(),
        ),

        //DASHBOARD PROVIDER
        ChangeNotifierProvider<DashboardProvider>(
          create: (_) => DashboardProvider(),
        ),
      ],
      child: child,
    );
  }
}
