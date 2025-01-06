import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../theme/color/colors.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: TColor.doctorWhite,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: Theme.of(context).textTheme.bodyMedium,
      unselectedLabelStyle: Theme.of(context).textTheme.bodyMedium,
      selectedItemColor: Colors.redAccent,
      unselectedItemColor: TColor.petRock,// Color for the selected icon
      currentIndex: currentIndex,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.event_rounded,),
          label: 'Event',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.ticket,),
          label: 'My coupon',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people_sharp,),
          label: 'Friend',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person,),
          label: 'Profile',
        ),
      ],
    );
  }
}
