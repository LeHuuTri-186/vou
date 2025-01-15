import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vou/shared/styles/appbar.dart';

import '../../../../shared/styles/border_radius.dart';
import '../../../../shared/styles/vertical_spacing.dart';
import '../../../../shared/widgets/image_icon.dart';
import '../../../../theme/color/colors.dart';
import '../../../authentication/presentation/widget/number_input_field.dart';
import '../../bloc/friend_cubit.dart';
import '../../bloc/friend_search_cubit.dart';
import '../../bloc/friend_search_state.dart';
import '../widgets/user_result_tile.dart';

class FriendSearchPage extends StatelessWidget {
  const FriendSearchPage({super.key});

  @override
  Widget build(BuildContext parentContext) {
    return Scaffold(
      appBar: TAppBar.buildAppBar(context: parentContext, title: "Find friend"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              NumberInputField(
                prefixIcon: const Icon(Icons.phone_outlined),
                label: "Phone number",
                hintText: "Your friend phone number",
                onChanged: (val) {
                  if (val == null) {
                    return;
                  }
                  debugPrint(val);
                  parentContext
                      .read<FriendSearchCubit>()
                      .searchFriend(phoneNum: val);
                },
              ),
              VSpacing.md,
              BlocBuilder<FriendSearchCubit, FriendSearchState>(
                builder: (BuildContext context, FriendSearchState state) {
                  if (state is FriendSearched) {
                    return UserResultTile(friend: state.friend, onTap: () => context.read<FriendSearchCubit>().addFriend(userId: state.friend.accountId),);
                  }
                  return const SizedBox.shrink();
                },
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
