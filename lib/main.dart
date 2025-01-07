import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:vou/theme/app_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:vou/utils/router/app_router_config.dart';
import 'lang/app_localizations_delegate.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await HydratedStorage.build(
      storageDirectory: UniversalPlatform.isWeb ? HydratedStorage.webStorageDirectory : await getApplicationDocumentsDirectory()
  );
  HydratedBloc.storage = storage;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp.router(
      // Localization
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
      routerConfig: AppRouterConfig().router,
    );
  }
}
