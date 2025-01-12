import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:vou/core/di/di_config.dart';
import 'package:path_provider/path_provider.dart' show getApplicationDocumentsDirectory;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'features/app/presentation/pages/vou_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await Hive.initFlutter();
  await Hive.openBox('authBox');

  final storage = await HydratedStorage.build(
      storageDirectory: UniversalPlatform.isWeb
          ? HydratedStorage.webStorageDirectory
          : await getApplicationDocumentsDirectory());
  HydratedBloc.storage = storage;

  configureDependencies();

  await SentryFlutter.init(
    (options) {
      options.dsn = dotenv.env['SENTRY_DSN'];
      options.tracesSampleRate = 1.0;
    },
    appRunner: () => runApp(
      VouApp(),
    ),
  );
}