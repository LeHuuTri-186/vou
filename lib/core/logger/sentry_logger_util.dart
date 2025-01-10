import 'package:sentry_flutter/sentry_flutter.dart';

class LoggerUtil {
  static Future<void> captureException(dynamic exception, {StackTrace? stackTrace}) async {
    await Sentry.captureException(
      exception,
      stackTrace: stackTrace,
    );
  }

  static Future<void> captureMessage(String message) async {
    await Sentry.captureMessage(message);
  }
}
