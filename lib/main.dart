import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:libya_medical_record_system/core/router/app_router.dart';
import 'package:libya_medical_record_system/core/shared/theme/app_theme.dart';
import 'package:libya_medical_record_system/data/hive/hive_box.dart';
import 'package:libya_medical_record_system/data/providers/app_providers.dart';
import 'package:libya_medical_record_system/data/providers/switch_lang_provider.dart';
import 'package:libya_medical_record_system/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //INITIALIZE HIVE
  await initializeHive();

  // Pre-load Tajawal before the app renders, avoiding FOUT
  GoogleFonts.config.allowRuntimeFetching = true;
  await GoogleFonts.pendingFonts([GoogleFonts.almarai()]);

  // ── Orientation ───────────────────────────────────────────────────────────
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  //RUN APP
  runApp(AppProviders(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SwitchLangProvider switchLangProvider = context.watch<SwitchLangProvider>();

    return MaterialApp.router(
      title: AppLocalizations.of(context)?.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      localizationsDelegates: <LocalizationsDelegate<Object>>[
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'), // English
        Locale('ar'), // Arabic
      ],
      locale: switchLangProvider.lang,
      routerConfig: AppRouter.router,
    );
  }
}


//flutter build web --base-href "/libya-medical-record-system/"

// flutter clean
// flutter pub get
// flutter build web --release --base-href "/libya-medical-record-system/" --pwa-strategy=none


//https://anifahm.rf.gd/libya-medical-record-system/

//https://anifahm.com/libya-medical-record-system/

//flutter build web --release --base-href "/libya-medical-record-system/" --no-tree-shake-icons