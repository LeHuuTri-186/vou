import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vou/shared/styles/border_radius.dart';
import 'package:vou/shared/widgets/image_icon.dart';

import '../../../../theme/color/colors.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 8,
      useLegacyColorScheme: false,
      selectedFontSize: 1,
      unselectedFontSize: 1,
      showUnselectedLabels: false,
      showSelectedLabels: false,
      backgroundColor: TColor.doctorWhite,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: Theme.of(context).textTheme.bodyMedium,
      unselectedLabelStyle: Theme.of(context).textTheme.bodyMedium,
      selectedItemColor: Colors.redAccent,
      unselectedItemColor: TColor.petRock,// Color for the selected icon
      currentIndex: currentIndex,
      onTap: onTap,
      items: [
        currentIndex == 0 ? 
        BottomNavigationBarItem(
          label: '',
          icon: AnimatedContainer(duration: const Duration(milliseconds: 200),
            curve: Curves.easeIn,
            decoration: BoxDecoration(
              border: Border.all(color: TColor.poppySurprise.withOpacity(0.5), width: 2),
              borderRadius: TBorderRadius.sm,
              color: TColor.poppySurprise.withOpacity(0.2)
            ),
              child: const Padding(
                padding: EdgeInsets.all(2.0),
                child: ImageIconWidget(imagePath: 'assets/images/event.png'),
              )),
        ) : const BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.all(2.0),
            child: ImageIconWidget(imagePath: 'assets/images/event.png'),
          ),
          label: '',
        ),
        currentIndex == 1 ?
        BottomNavigationBarItem(
          label: '',
          icon: AnimatedContainer(duration: Duration(milliseconds: 100),
              curve: Curves.linear,
              decoration: BoxDecoration(
                  border: Border.all(color: TColor.poppySurprise.withOpacity(0.5), width: 2),
                  borderRadius: TBorderRadius.sm,
                  color: TColor.poppySurprise.withOpacity(0.2)
              ),
              child: const Padding(
                padding: EdgeInsets.all(2.0),
                child: ImageIconWidget(imagePath: 'assets/images/coupon.png'),
              )),
        ) : const BottomNavigationBarItem(
          label: '',
          icon: Padding(
            padding: EdgeInsets.all(2.0),
            child: ImageIconWidget(imagePath: 'assets/images/coupon.png'),

          ),
        ),
        currentIndex == 2 ?
        BottomNavigationBarItem(
          label: '',
          icon: AnimatedContainer(duration: Duration(milliseconds: 100),
              curve: Curves.linear,
              decoration: BoxDecoration(
                  border: Border.all(color: TColor.poppySurprise.withOpacity(0.5), width: 2),
                  borderRadius: TBorderRadius.sm,
                  color: TColor.poppySurprise.withOpacity(0.2)
              ),
              child: const Padding(
                padding: EdgeInsets.all(2.0),
                child: ImageIconWidget(imagePath: 'assets/images/friend.png'),
              )),
        ) : const BottomNavigationBarItem(
          label: '',
          icon: Padding(
            padding: EdgeInsets.all(2.0),
            child: ImageIconWidget(imagePath: 'assets/images/friend.png'),
          ),
        ),
        currentIndex == 3 ?
        BottomNavigationBarItem(
          label: '',
          icon: AnimatedContainer(duration: Duration(milliseconds: 100),
              curve: Curves.linear,
              decoration: BoxDecoration(
                  border: Border.all(color: TColor.poppySurprise.withOpacity(0.5), width: 2),
                  borderRadius: TBorderRadius.sm,
                  color: TColor.poppySurprise.withOpacity(0.2)
              ),
              child: const Padding(
                padding: EdgeInsets.all(2.0),
                child: ImageIconWidget(imagePath: 'assets/images/shop.png'),
              )),
        ) : const BottomNavigationBarItem(
          label: '',
          icon: Padding(
            padding: EdgeInsets.all(2.0),
            child: ImageIconWidget(imagePath: 'assets/images/shop.png'),
          ),
        ),
      ],
    );
  }
}
