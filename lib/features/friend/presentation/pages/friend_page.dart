import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vou/core/router/app_route.dart';

import '../../../../shared/styles/border_radius.dart';
import '../../../../shared/styles/vertical_spacing.dart';
import '../../../../shared/widgets/image_icon.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../../../theme/color/colors.dart';
import '../../bloc/friend_cubit.dart';
import '../../bloc/friend_state.dart';
import '../widgets/friend_tile.dart';

class FriendPage extends StatelessWidget {
  const FriendPage({super.key});

  @override
  Widget build(BuildContext parentContext) {
    parentContext.read<FriendCubit>().fetchFriends();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      parentContext.pushNamed(AppRoute.searchFriend);
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
                          "+ Add friend",
                          style:
                              Theme.of(parentContext).textTheme.titleMedium!.copyWith(
                                    color: TColor.doctorWhite,
                                    fontSize: 18,
                                  ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              VSpacing.md,
              Expanded(
                child: BlocBuilder<FriendCubit, FriendState>(
                    builder: (context, state) {
                  if (state is FriendError) {
                    _buildErrorPanel(context);
                  }
                  if (state is FriendLoaded) {
                    if (state.friendList.isEmpty) {
                      return Align(
                          alignment: Alignment.topCenter,
                          child: _buildEmptyPanel(context));
                    }

                    return ListView.builder(
                      itemCount: state.friendList.length,
                      itemBuilder: (_, int index) {
                        return FriendTile(
                          friend: state.friendList[index],
                          onTap: () => context.read<FriendCubit>().unfriend(userId: state.friendList[index].accountId),
                        );
                      },
                    );
                  }
                  return SafeArea(
                    child: Center(
                      child: LoadingWidget.twistingDotsLoadIndicator(),
                    ),
                  );
                }),
              ),
            ],
          ),
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
                  context.read<FriendCubit>().fetchFriends();
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
                  context.read<FriendCubit>().fetchFriends();
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
