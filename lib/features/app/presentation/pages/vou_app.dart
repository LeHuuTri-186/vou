import 'package:flutter/material.dart';

import '../../../../lang/app_localizations_delegate.dart';
import 'package:vou/theme/app_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:vou/core/router/app_router_config.dart';

class VouApp extends StatelessWidget {
  VouApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // Localization
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizationDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'), // English
        Locale('vi', 'VN'), // Vietnamese
      ],
      title: 'VOU',
      theme: AppTheme.light,
      routerConfig: $config.router,
    );
  }
}
