// lib/features/navigation/presentation/navigation_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vou/features/coupon/presentation/pages/coupon_page.dart';
import 'package:vou/features/event/presentation/pages/event_page.dart';
import 'package:vou/features/friend/presentation/friend_page.dart';
import 'package:vou/features/shaker_game/presentation/pages/shaker_game.dart';

import '../bloc/bottom_nav_bloc.dart';
import '../bloc/bottom_nav_event.dart';
import '../bloc/bottom_nav_state.dart';
import '../widgets/bottom_nav_bar.dart';

class NavigationPage extends StatelessWidget {
  final List<Widget> _screens = [
    const EventPage(),
    const CouponPage(),
    const FriendPage(),
    const GameScreen(),
  ];

  NavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavBloc(),
      child: BlocBuilder<BottomNavBloc, BottomNavState>(
        builder: (context, state) {
          return Scaffold(
            body: _screens[state.currentIndex],
            bottomNavigationBar: BottomNavBar(
              currentIndex: state.currentIndex,
              onTap: (index) {
                BlocProvider.of<BottomNavBloc>(context).add(UpdateTab(index));
              },
            ),
          );
        },
      ),
    );
  }
}
