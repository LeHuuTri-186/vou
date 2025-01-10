import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/bottom_nav_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
    required this.navigationShell,
  }) : super(key: key ?? const ValueKey<String>('home-page'));
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: navigationShell),
      bottomNavigationBar: BottomNavBar(currentIndex: navigationShell.currentIndex, onTap: navigationShell.goBranch),
    );
  }
}
