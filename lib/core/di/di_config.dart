
import 'package:vou/core/di/modules/api_interceptors_module.dart';
import 'package:vou/core/di/modules/auth_module.dart';
import 'package:vou/core/di/modules/coupon_module.dart';
import 'package:vou/core/di/modules/event_module.dart';
import 'package:vou/core/di/modules/friend_module.dart';
import 'package:vou/core/di/modules/profile_module.dart';
import 'package:vou/core/di/modules/puzzle_module.dart';
import 'package:vou/core/di/modules/quiz_module.dart';
import 'package:vou/core/di/modules/token_manager_module.dart';

Future<void> configureDependencies() async {
  setUpApiInterceptorsModule();
  setUpTokenManagerModule();
  setUpAuthModule();
  setUpEventModule();
  setUpProfileModule();
  setUpFriendModule();
  setUpCouponModule();
  setUpPuzzleModule();
  setUpQuizModule();
}