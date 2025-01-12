import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vou/features/app/presentation/widgets/app_drawer.dart';
import 'package:vou/shared/styles/appbar.dart';

import '../widgets/bottom_nav_bar.dart';

class HomeScaffold extends StatelessWidget {
  const HomeScaffold({
    Key? key,
    required this.navigationShell,
  }) : super(key: key ?? const ValueKey<String>('home-scaffold'));
  final StatefulNavigationShell navigationShell;

  String _getTitle(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return 'Event';
      case 1:
        return 'Coupon';
      case 2:
        return 'Friend';
      case 3:
        return 'Shop';
      default:
        return 'No found';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar.buildAppBar(context: context, title: _getTitle(navigationShell.currentIndex)),
      drawer: AppDrawer(),
      body: SafeArea(child: navigationShell),
      bottomNavigationBar: BottomNavBar(currentIndex: navigationShell.currentIndex, onTap: navigationShell.goBranch),
    );
  }
}
