import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vou/core/theme/app_theme.dart';
import 'package:vou/features/navigation/application/navigation_cubit.dart';
import 'package:vou/features/navigation/presentation/bloc/bottom_nav_bloc.dart';
import 'package:vou/features/navigation/presentation/router/app_router_delegate.dart';
import 'package:vou/features/navigation/presentation/router/app_route_information_parser.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'features/authentication/presentation/bloc/auth_cubit.dart';
import 'lang/app_localizations_delegate.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the NavigationCubit and AuthCubit
    final navigationCubit = NavigationCubit();
    final authCubit = AuthCubit();
    final bottomNavBloc = BottomNavBloc();

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: navigationCubit),
        BlocProvider.value(value: authCubit),
        BlocProvider.value(value: bottomNavBloc),
      ],
      child: MaterialApp.router(
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

        // Navigation
        routerDelegate: AppRouterDelegate(navigationCubit, authCubit),
        routeInformationParser: AppRouteInformationParser(),
      ),
    );
  }
}
