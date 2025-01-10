import 'package:flutter/material.dart';
import 'package:vou/shared/styles/horizontal_spacing.dart';
import 'package:vou/shared/widgets/image_icon.dart';

import '../../../../theme/color/colors.dart';

class FriendTile extends StatelessWidget {
  const FriendTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: TColor.doctorWhite,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: const Row(
          children: [
            ImageIconWidget(imagePath: 'assets/images/profile.png'),
            HSpacing.sm,
            Text("Friend"),
          ],
        ),
      ),
    );
  }
}
