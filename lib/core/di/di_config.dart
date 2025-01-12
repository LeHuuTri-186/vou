
import 'package:vou/core/di/modules/api_interceptors_module.dart';
import 'package:vou/core/di/modules/auth_module.dart';
import 'package:vou/core/di/modules/event_module.dart';
import 'package:vou/core/di/modules/token_manager_module.dart';

void configureDependencies() {
  setUpApiInterceptorsModule();
  setUpTokenManagerModule();
  setUpAuthModule();
  setUpEventModule();
}