import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:vou/shared/styles/box_shadow.dart';
import 'package:vou/shared/styles/horizontal_spacing.dart';

import '../../../../shared/styles/border_radius.dart';
import '../../../../theme/color/colors.dart';
import '../../domain/entities/friend.dart';

class FriendTile extends StatelessWidget {
  const FriendTile({super.key, required this.friend, this.onTap});

  final Friend friend;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container (
      decoration: BoxDecoration(
        borderRadius: TBorderRadius.sm,
        boxShadow: [TBoxShadow.normalBoxShadow],
        color: TColor.northEastSnow,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Wrap(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: TColor.tamarama,
                    borderRadius: TBorderRadius.full,
                    image: DecorationImage(
                      image: friend.avatar == null
                          ? const AssetImage(
                        "assets/images/profile.png",
                      )
                          : NetworkImage(friend.avatar!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                HSpacing.sm,
                Text('${friend.firstName} ${friend.lastName}', style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                borderRadius: TBorderRadius.md,
                child: Ink(
                  decoration: BoxDecoration(
                    color: TColor.poppySurprise,
                    borderRadius: TBorderRadius.md,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: AutoSizeText(
                      "Unfriend",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: TColor.doctorWhite,
                            fontSize: 15,
                          ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
