import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vou/shared/styles/appbar.dart';

import '../../../../shared/styles/border_radius.dart';
import '../../../../shared/styles/horizontal_spacing.dart';
import '../../../../shared/styles/vertical_spacing.dart';
import '../../../../shared/widgets/image_icon.dart';
import '../../../../theme/color/colors.dart';
import '../../bloc/friend_share_cubit.dart';
import '../../bloc/friend_share_state.dart';
import '../widgets/give_away_tile.dart';

class FriendGiveAwayPage extends StatelessWidget {
  const FriendGiveAwayPage({super.key, required this.eventId});

  final String eventId;

  @override
  Widget build(BuildContext context) {
    final friendShareCubit = context.read<FriendShareCubit>();

    friendShareCubit.loadFriends(eventId: eventId);

    return Scaffold(
      appBar: TAppBar.buildAppBar(context: context, title: "Give away turn"),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocBuilder<FriendShareCubit, FriendShareState>(
          builder: (BuildContext context, state) {
            if (state is FriendShareLoaded) {
      
              if (state.friends.isEmpty) {
                return _buildEmptyPanel(context);
              }
      
              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Wrap(
                    children: [
                      const ImageIconWidget(
                          imagePath: "assets/images/lives.png"),
                      HSpacing.sm,
                      Text(
                        "${state.turns} turns left",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: 18),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.friends.length,
                        itemBuilder: (_, index) {
                      return GiveAwayTile(
                        friend: state.friends[index],
                        onTap: () {
                          if (state.turns > 0) {
                            friendShareCubit.shareTurn(
                              eventId: eventId,
                              userId: state.friends[index].accountId,
                              turnsLeft: state.turns,
                            );
                          }
                        },
                      );
                    }),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  SafeArea _buildEmptyPanel(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            VSpacing.sm,
            AutoSizeText(
              "No Friend found!",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: TColor.petRock,
                  ),
            ),
            VSpacing.sm,
            const ImageIconWidget(
              imagePath: 'assets/images/empty-search.png',
              width: 300,
              height: 300,
            ),
            VSpacing.sm,
            AutoSizeText(
              "Try again!",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: TColor.petRock,
                    fontSize: 16,
                  ),
            ),
            VSpacing.sm,
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  context.read<FriendShareCubit>().loadFriends(eventId: eventId);
                },
                borderRadius: TBorderRadius.md,
                child: Ink(
                  decoration: BoxDecoration(
                    color: TColor.poppySurprise,
                    borderRadius: TBorderRadius.md,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AutoSizeText(
                      "Refresh",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: TColor.doctorWhite,
                          ),
                    ),
                  ),
                ),
              ),
            ),
            VSpacing.md,
          ],
        ),
      ),
    );
  }

  SafeArea _buildErrorPanel(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            VSpacing.sm,
            AutoSizeText(
              "An Error occurred!",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: TColor.petRock,
                  ),
            ),
            VSpacing.sm,
            const ImageIconWidget(
              imagePath: 'assets/images/error.png',
              width: 300,
              height: 300,
            ),
            VSpacing.sm,
            AutoSizeText(
              "Please try again!",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: TColor.petRock,
                    fontSize: 16,
                  ),
            ),
            VSpacing.sm,
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  context.read<FriendShareCubit>().loadFriends(eventId: eventId);
                },
                borderRadius: TBorderRadius.md,
                child: Ink(
                  decoration: BoxDecoration(
                    color: TColor.poppySurprise,
                    borderRadius: TBorderRadius.md,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AutoSizeText(
                      "Try again",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: TColor.doctorWhite,
                          ),
                    ),
                  ),
                ),
              ),
            ),
            VSpacing.md,
          ],
        ),
      ),
    );
  }
}
