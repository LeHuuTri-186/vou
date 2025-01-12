import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vou/core/storage/hive_service.dart';
import 'package:vou/features/app/presentation/pages/shared_header_shell.dart';
import 'package:vou/features/authentication/bloc/auth_cubit.dart';
import 'package:vou/features/authentication/bloc/sign_up_form_cubit.dart';
import 'package:vou/features/authentication/domain/usecases/request_otp_usecase.dart';
import 'package:vou/features/authentication/domain/usecases/sign_in_usecase.dart';
import 'package:vou/features/authentication/domain/usecases/sign_out_usecase.dart';
import 'package:vou/features/authentication/domain/usecases/sign_up_usecase.dart';
import 'package:vou/features/authentication/presentation/pages/otp_page.dart';
import 'package:vou/features/authentication/presentation/pages/sign_in_page.dart';
import 'package:vou/features/coupon/presentation/pages/coupon_page.dart';
import 'package:vou/features/event/bloc/event_cubit.dart';
import 'package:vou/features/event/presentation/pages/event_page.dart';
import 'package:vou/features/friend/presentation/pages/friend_page.dart';
import 'package:vou/features/app/presentation/pages/home_shell.dart';

import '../../features/authentication/bloc/auth_state.dart';
import '../../features/authentication/presentation/pages/sign_up_page.dart';
import '../../features/quiz/presentation/pages/quiz_page.dart';
import '../di/service_locator.dart';
import 'app_route.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorEventKey = GlobalKey<NavigatorState>(debugLabel: 'event');
final _shellNavigatorCouponKey =
    GlobalKey<NavigatorState>(debugLabel: 'coupon');
final _shellNavigatorFriendKey =
    GlobalKey<NavigatorState>(debugLabel: 'friend');
final _shellNavigatorProfileKey =
    GlobalKey<NavigatorState>(debugLabel: 'profile');

final $config = AppRouterConfig(AuthCubit(
  hiveService: $serviceLocator<HiveService>(),
  signOutUseCase: $serviceLocator<SignOutUseCase>(),
  requestOtpUseCase: $serviceLocator<RequestOtpUseCase>(),
  signUpUseCase: $serviceLocator<SignUpUseCase>(),
  signInUseCase: $serviceLocator<SignInUseCase>(),
));

class AppRouterConfig {
  final AuthCubit authCubit;

  AppRouterConfig(this.authCubit);

  late final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/sign-in', // Adjust based on your requirements
    routes: _routes,
    redirect: _redirectHandling,
    debugLogDiagnostics: true, // Enable debugging
  );

  late final _routes = <RouteBase>[
    GoRoute(path: '/', redirect: (_, __) => '/event'),

    GoRoute(
      path: '/sign-in',
      name: AppRoute.signIn,
      builder: (context, state) => BlocProvider.value(
        value: authCubit,
        child: SignInPage(),
      ),
    ),

    // Sign-up Route
    GoRoute(
      path: '/sign-up',
      name: AppRoute.signUp,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: authCubit),
          BlocProvider.value(value: $serviceLocator<SignUpFormCubit>())
        ],
        child: SignUpPage(),
      ),
      routes: [
        GoRoute(
          path: 'otp',
          builder: (context, state) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: authCubit),
              BlocProvider.value(value: $serviceLocator<SignUpFormCubit>())
            ],
            child: OtpPage(),
          ),
        ),
      ],
    ),

    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MultiBlocProvider(
          providers: [
            BlocProvider.value(value: authCubit),
          ],
          child: HomeScaffold(navigationShell: navigationShell),
        );
      },
      branches: [
        // Events Tab
        StatefulShellBranch(
          navigatorKey: _shellNavigatorEventKey,
          routes: [
            GoRoute(
              path: '/event',
              name: AppRoute.events,
              pageBuilder: (_, __) => NoTransitionPage(
                child: MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: $serviceLocator<EventCubit>(),
                    )
                  ],
                  child: EventPage(),
                ),
              ),
            ),
          ],
        ),

        // Coupons Tab
        StatefulShellBranch(
          navigatorKey: _shellNavigatorCouponKey,
          routes: [
            GoRoute(
              path: '/coupon',
              name: AppRoute.myCoupon,
              pageBuilder: (_, __) => const NoTransitionPage(
                child: CouponPage(),
              ),
            ),
          ],
        ),

        // Friends Tab
        StatefulShellBranch(
          navigatorKey: _shellNavigatorFriendKey,
          routes: [
            GoRoute(
              path: '/friend',
              name: AppRoute.friendList,
              pageBuilder: (_, __) => const NoTransitionPage(
                child: FriendPage(),
              ),
            ),
          ],
        ),

        // Profile Tab
        StatefulShellBranch(
          navigatorKey: _shellNavigatorProfileKey,
          routes: [
            GoRoute(
              path: '/profile',
              name: AppRoute.profile,
              pageBuilder: (_, __) => const NoTransitionPage(
                child: Quiz(),
              ),
            ),
          ],
        ),
      ],
    ),
  ];

  /// Redirect Function for Global Navigation
  FutureOr<String?> _redirectHandling(
      BuildContext context, GoRouterState state) {
    final authState = authCubit.state;
    final authenticated = authState is Authenticated;

    if (!authenticated &&
        (state.location != AppRoute.signIn &&
            !state.location.contains(AppRoute.signUp))) {
      return '/sign-in';
    }

    if (authenticated &&
        (state.location == AppRoute.signIn ||
            state.location == AppRoute.signUp)) {
      return '/event';
    }

    return null;
  }
}
