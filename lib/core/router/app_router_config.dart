import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vou/core/storage/hive_service.dart';
import 'package:vou/features/authentication/bloc/auth_cubit.dart';
import 'package:vou/features/authentication/bloc/sign_up_form_cubit.dart';
import 'package:vou/features/authentication/domain/usecases/request_otp_usecase.dart';
import 'package:vou/features/authentication/domain/usecases/sign_in_usecase.dart';
import 'package:vou/features/authentication/domain/usecases/sign_out_usecase.dart';
import 'package:vou/features/authentication/domain/usecases/sign_up_usecase.dart';
import 'package:vou/features/authentication/presentation/pages/otp_page.dart';
import 'package:vou/features/authentication/presentation/pages/sign_in_page.dart';
import 'package:vou/features/coupon/presentation/pages/coupon_page.dart';
import 'package:vou/features/coupon/presentation/pages/coupon_usage_page.dart';
import 'package:vou/features/event/bloc/event_cubit.dart';
import 'package:vou/features/event/domain/entities/game_in_event.dart';
import 'package:vou/features/event/presentation/pages/event_page.dart';
import 'package:vou/features/event/presentation/pages/game_detail_page.dart';
import 'package:vou/features/friend/bloc/friend_share_cubit.dart';
import 'package:vou/features/friend/presentation/pages/friend_event_givaway.dart';
import 'package:vou/features/friend/presentation/pages/friend_page.dart';
import 'package:vou/features/app/presentation/pages/home_shell.dart';
import 'package:vou/features/friend/presentation/pages/friend_search_page.dart';
import 'package:vou/features/profile/bloc/user_cubit.dart';
import 'package:vou/features/profile/presentation/pages/my_account_page.dart';
import 'package:vou/features/profile/presentation/pages/profile_page.dart';
import 'package:vou/features/quiz/presentation/pages/quiz_page.dart';
import 'package:vou/features/quiz_game_socket/presentation/quiz_game.dart';
import 'package:vou/features/shaker_game/bloc/puzzle_start_cubit.dart';
import 'package:vou/features/shaker_game/presentation/pages/puzzle_start_page.dart';
import 'package:vou/features/shaker_game/presentation/pages/shaker_game_page.dart';

import '../../features/authentication/bloc/auth_state.dart';
import '../../features/authentication/presentation/pages/sign_up_page.dart';
import '../../features/coupon/bloc/user_coupon_cubit.dart';
import '../../features/coupon/domain/model/coupon.dart';
import '../../features/event/bloc/game_detail_cubit.dart';
import '../../features/event/bloc/game_in_event_cubit.dart';
import '../../features/event/presentation/pages/event_detail_page.dart';
import '../../features/friend/bloc/friend_cubit.dart';
import '../../features/friend/bloc/friend_search_cubit.dart';
import '../../features/quiz_game_socket/bloc/quiz_game_cubit.dart';
import '../../features/shaker_game/bloc/shaker_cubit.dart';
import '../di/service_locator.dart';
import 'app_route.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorEventKey = GlobalKey<NavigatorState>(debugLabel: 'event');
final _shellGameKey = GlobalKey<NavigatorState>(debugLabel: 'game');
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
      parentNavigatorKey: _rootNavigatorKey,
      path: '/sign-in',
      name: AppRoute.signIn,
      builder: (context, state) => BlocProvider.value(
        value: authCubit,
        child: SignInPage(),
      ),
    ),

    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/profile',
      name: AppRoute.profile,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: $serviceLocator<UserCubit>()),
          BlocProvider.value(value: authCubit),
        ],
        child: const ProfilePage(),
      ),
      routes: [
        GoRoute(
          parentNavigatorKey: _rootNavigatorKey,
          path: 'my-account',
          name: AppRoute.myAccount,
          builder: (context, state) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: $serviceLocator<UserCubit>()),
            ],
            child: const MyAccountPage(),
          ),
        )
      ],
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
        child: const SignUpPage(),
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
    GoRoute(
        path: "/shaker-game",
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: $serviceLocator<PuzzleStartCubit>(),
              )
            ],
            child: PuzzleStartPage(game: state.extra as GameInEvent),
          );
        },
        routes: [
          GoRoute(
            path: "play",
            builder: (context, state) {
              return MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: $serviceLocator<ShakerCubit>(),
                    )
                  ],
                  child: ShakerGamePage(
                    game: state.extra as GameInEvent,
                  ));
            },
          )
        ]),

    GoRoute(
      path: "/quiz-game",
      builder: (context, state) {
        return MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: $serviceLocator<QuizGameCubit>(),
            )
          ],
          child: QuizGamePage(gameInEvent: state.extra as GameInEvent),
        );
      },
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
                  child: const EventPage(),
                ),
              ),
              routes: [
                GoRoute(
                  parentNavigatorKey: _rootNavigatorKey,
                  path: ":id",
                  builder: (context, state) {
                    final eventId = state.pathParameters['id']!;
                    return MultiBlocProvider(
                      providers: [
                        BlocProvider.value(
                          value: $serviceLocator<GameCubit>(),
                        )
                      ],
                      child: EventDetailPage(
                        eventId: eventId,
                      ),
                    );
                  },
                  routes: [
                    GoRoute(
                      parentNavigatorKey: _rootNavigatorKey,
                      path: ":id",
                      builder: (context, state) {
                        final eventId = state.pathParameters['id']!;
                        return MultiBlocProvider(
                          providers: [
                            BlocProvider.value(
                              value: $serviceLocator<GameDetailCubit>(),
                            )
                          ],
                          child: GameDetailPage(
                            eventGameId: eventId,
                            eventId: state.extra as String,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
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
                pageBuilder: (_, __) => NoTransitionPage(
                      child: MultiBlocProvider(
                        providers: [
                          BlocProvider.value(
                            value: $serviceLocator<UserCouponCubit>(),
                          )
                        ],
                        child: const CouponPage(),
                      ),
                    ),
                routes: [

                  GoRoute(
                    parentNavigatorKey: _rootNavigatorKey,
                    path: 'use',
                    pageBuilder: (_, state) => NoTransitionPage(
                      child: CouponUsagePage(coupon: state.extra as Coupon),
                    ),
                  )
                ]),
          ],
        ),

        // Friends Tab
        StatefulShellBranch(
          navigatorKey: _shellNavigatorFriendKey,
          routes: [
            GoRoute(
              path: '/friend',
              name: AppRoute.friendList,
              pageBuilder: (_, __) => NoTransitionPage(
                child: MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: $serviceLocator<FriendCubit>(),
                    )
                  ],
                  child: const FriendPage(),
                ),
              ),
              routes: [
                GoRoute(
                  parentNavigatorKey: _rootNavigatorKey,
                  path: "share",
                  builder: (context, state) {
                    return MultiBlocProvider(
                      providers: [
                        BlocProvider.value(
                          value: $serviceLocator<FriendShareCubit>(),
                        )
                      ],
                      child: FriendGiveAwayPage(eventId: state.extra as String),
                    );
                  },
                ),
                GoRoute(
                  parentNavigatorKey: _rootNavigatorKey,
                  path: 'find',
                  name: AppRoute.searchFriend,
                  pageBuilder: (_, __) => NoTransitionPage(
                    child: MultiBlocProvider(
                      providers: [
                        BlocProvider.value(
                          value: $serviceLocator<FriendSearchCubit>(),
                        )
                      ],
                      child: const FriendSearchPage(),
                    ),
                  ),
                )
              ],
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
        (state.uri.toString() != AppRoute.signIn &&
            !state.uri.toString().contains(AppRoute.signUp))) {
      return '/sign-in';
    }

    if (authenticated &&
        (state.uri.toString() == AppRoute.signIn ||
            state.uri.toString() == AppRoute.signUp)) {
      return '/event';
    }

    return null;
  }
}
