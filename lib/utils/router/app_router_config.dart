import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vou/features/app/presentation/pages/shared_header_shell.dart';
import 'package:vou/features/authentication/bloc/auth_cubit.dart';
import 'package:vou/features/authentication/presentation/pages/sign_in_page.dart';
import 'package:vou/features/coupon/presentation/pages/coupon_page.dart';
import 'package:vou/features/event/presentation/pages/event_page.dart';
import 'package:vou/features/friend/presentation/friend_page.dart';
import 'package:vou/features/app/presentation/pages/home_shell.dart';

import '../../features/authentication/presentation/pages/sign_up_page.dart';
import 'app_route.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorEventKey = GlobalKey<NavigatorState>(debugLabel: 'event');
final _shellNavigatorCouponKey =
    GlobalKey<NavigatorState>(debugLabel: 'coupon');
final _shellNavigatorFriendKey =
    GlobalKey<NavigatorState>(debugLabel: 'friend');
final _shellNavigatorProfileKey =
    GlobalKey<NavigatorState>(debugLabel: 'profile');
final _shellSharedHeaderKey = GlobalKey<NavigatorState>(debugLabel: 'header');

class AppRouterConfig {
  late final GoRouter router = GoRouter(
      routes: _routes,
      initialLocation: AppRoute.signIn,
      navigatorKey: _rootNavigatorKey);

  void dispose() {}

  late final _routes = <RouteBase>[
    GoRoute(
      path: '/',
      name: AppRoute.root,
      redirect: (_, __) => '/sign-in',
    ),
    GoRoute(
      path: '/sign-in',
      name: AppRoute.signIn,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AuthCubit(),
          ),
        ],
        child: const SignInPage(),
      ),
    ),
    GoRoute(
      path: '/sign-up',
      name: AppRoute.signUp,
      builder: (context, state) => const SignUpPage(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        // the UI shell
        return HomePage(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorEventKey,
          routes: [
            GoRoute(
              path: '/event',
              pageBuilder: (_, __) => const NoTransitionPage(
                child: SharedAppBarScaffold(
                  title: 'Event',
                  child: EventPage(),
                ),
              ),
            )
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorCouponKey,
          routes: [
            GoRoute(
              path: '/coupon',
              pageBuilder: (_, __) => const NoTransitionPage(
                child: SharedAppBarScaffold(
                  title: 'Coupon',
                  child: CouponPage(),
                ),
              ),
            )
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorFriendKey,
          routes: [
            GoRoute(
              path: '/friends',
              pageBuilder: (_, __) => const NoTransitionPage(
                child: SharedAppBarScaffold(
                  title: 'Friend',
                  child: FriendPage(),
                ),
              ),
            )
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorProfileKey,
          routes: [
            GoRoute(
              path: '/profile',
              pageBuilder: (_, __) => const NoTransitionPage(
                child: FriendPage(),
              ),
            )
          ],
        ),
      ],
    )
  ];
}
