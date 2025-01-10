import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vou/features/app/presentation/pages/shared_header_shell.dart';
import 'package:vou/features/authentication/bloc/auth_cubit.dart';
import 'package:vou/features/authentication/presentation/pages/sign_in_page.dart';
import 'package:vou/features/coupon/presentation/pages/coupon_page.dart';
import 'package:vou/features/event/presentation/pages/event_page.dart';
import 'package:vou/features/friend/presentation/pages/friend_page.dart';
import 'package:vou/features/app/presentation/pages/home_shell.dart';

import '../../features/authentication/bloc/auth_state.dart';
import '../../features/authentication/presentation/pages/sign_up_page.dart';
import '../../features/quiz/presentation/pages/quiz_page.dart';
import 'app_route.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorEventKey = GlobalKey<NavigatorState>(debugLabel: 'event');
final _shellNavigatorCouponKey =
    GlobalKey<NavigatorState>(debugLabel: 'coupon');
final _shellNavigatorFriendKey =
    GlobalKey<NavigatorState>(debugLabel: 'friend');
final _shellNavigatorProfileKey =
    GlobalKey<NavigatorState>(debugLabel: 'profile');


final $config = AppRouterConfig(AuthCubit());

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
    GoRoute(
      path: '/',
      redirect: (_, __) => '/event'
    ),
    // Sign-in Route
    GoRoute(
      path: '/sign-in',
      name: AppRoute.signIn,
      builder: (context, state) => BlocProvider.value(
        value: authCubit,
        child: const SignInPage(),
      ),
    ),

    // Sign-up Route
    GoRoute(
      path: '/sign-up',
      name: AppRoute.signUp,
      builder: (context, state) => const SignUpPage(),
    ),

    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return HomePage(navigationShell: navigationShell);
      },
      branches: [
        // Events Tab
        StatefulShellBranch(
          navigatorKey: _shellNavigatorEventKey,
          routes: [
            GoRoute(
              path: '/event',
              name: AppRoute.events,
              pageBuilder: (_, __) => const NoTransitionPage(
                child: SharedAppBarScaffold(
                  title: 'Event',
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
                child: SharedAppBarScaffold(
                  title: 'Coupon',
                  child: CouponPage(),
                ),
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
                child: SharedAppBarScaffold(
                  title: 'Friend',
                  child: FriendPage(),
                ),
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

    // If not authenticated, redirect to sign-in
    if (!authenticated && state.location != AppRoute.signIn) {
      return '/sign-in';
    }

    // If already authenticated, prevent access to sign-in or sign-up
    if (authenticated &&
        (state.location == AppRoute.signIn ||
            state.location == AppRoute.signUp)) {
      return '/event';
    }

    // No redirection needed
    return null;
  }
}
