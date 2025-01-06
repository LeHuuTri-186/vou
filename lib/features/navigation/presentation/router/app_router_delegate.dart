import 'package:flutter/material.dart';
import 'package:vou/features/authentication/presentation/pages/sign_in_page.dart';
import 'package:vou/features/authentication/presentation/pages/sign_up_page.dart';
import 'package:vou/features/navigation/application/navigation_cubit.dart';

import '../../../../shared/styles/colors.dart';
import '../../../authentication/presentation/bloc/auth_cubit.dart';
import '../pages/navigation_page.dart';
import '../widgets/loading_widget.dart';

class AppRouterDelegate extends RouterDelegate<String>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<String>  {
  final NavigationCubit navigationCubit;
  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final AuthCubit authCubit;


  AppRouterDelegate(this.navigationCubit, this.authCubit) {
    navigationCubit.stream.listen((_) => notifyListeners());
    authCubit.stream.listen((_) => notifyListeners());
  }

  @override
  Widget build(BuildContext context) {
    final currentPage = navigationCubit.state.currentPage;

    final List<Page> pages = [
      if (currentPage == 'signin')
        const FadeTransitionPage(
          child: SignInPage(),
          key: ValueKey('SignInPage'),
        ),
      if (currentPage == 'signup')
        const FadeTransitionPage(
          child: SignUpPage(),
          key: ValueKey('SignUpPage'),
        ),
      if (currentPage == 'navigationpage')
        FadeTransitionPage(
          child: NavigationPage(), // Replace with your HomePage
          key: const ValueKey('NavigationPage'),
        ),
      if (currentPage == 'loading')
        FadeTransitionPage(
          child: Container(color: TColor.doctorWhite, child: Container(color: TColor.mcFanning.withOpacity(0.2),child: Center(child: LoadingWidget.twistingDotsLoadIndicator()))),
          key: const ValueKey('LoadingPage'),
        ),
    ];

    return Navigator(
      key: navigatorKey,
      pages: pages,
      onDidRemovePage: (Page<Object?> page) {

        pages.remove(page);
      },
    );
  }

  @override
  Future<void> setNewRoutePath(String configuration) async {
    navigationCubit.navigateTo(configuration);
  }

  @override
  String? get currentConfiguration => navigationCubit.state.currentPage;
}

class FadeTransitionPage<T> extends Page<T> {
  final Widget child;

  const FadeTransitionPage({required this.child, required LocalKey key})
      : super(key: key);

  @override
  Route<T> createRoute(BuildContext context) {
    return PageRouteBuilder<T>(
      settings: this,
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const curve = Curves.easeInOut; // Change curve as needed
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );

        return FadeTransition(

          opacity: curvedAnimation,
          child: child,
        );
      },
    );
  }
}
