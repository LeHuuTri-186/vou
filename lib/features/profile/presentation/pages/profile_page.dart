import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:vou/core/router/app_route.dart';
import 'package:vou/features/authentication/bloc/auth_cubit.dart';
import 'package:vou/features/profile/bloc/user_cubit.dart';
import 'package:vou/features/profile/bloc/user_state.dart';
import 'package:vou/shared/styles/border_radius.dart';
import 'package:vou/shared/styles/box_shadow.dart';
import 'package:vou/shared/styles/horizontal_spacing.dart';
import 'package:vou/shared/styles/vertical_spacing.dart';
import 'package:vou/shared/widgets/loading_widget.dart';

import '../../../../shared/widgets/image_icon.dart';
import '../../../../theme/color/colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext parentContext) {
    parentContext.read<UserCubit>().getUserDetail();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {
            parentContext.pop();
          },
        ),
        title: const Text("Profile"),
      ),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (userContext, state) {
          if (state is UserError) {
            return Center(child: _buildErrorPanel(userContext, state));
          }

          if (state is UserLoaded) {
            return SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Center(
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: TColor.tamarama,
                        borderRadius: TBorderRadius.full,
                        image: DecorationImage(
                          image: state.user.avatar == null ? const AssetImage(
                            "assets/images/profile.png",
                          ) : NetworkImage(state.user.avatar!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  VSpacing.sm,
                  AutoSizeText(
                    state.user.username,
                    style: Theme.of(userContext).textTheme.titleLarge,
                  ),
                  AutoSizeText(
                    state.user.email,
                    style: Theme.of(userContext)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: TColor.petRock),
                  ),
                  VSpacing.md,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: _buildProfileBtn(userContext),
                  ),
                  VSpacing.sm,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: _buildNotificationBtn(userContext),
                  ),
                  VSpacing.sm,
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: _buildLogoutBtn(parentContext),
                      ),
                    ),
                  )
                ],
              ),
            );
          }
          return Center(child: LoadingWidget.twistingDotsLoadIndicator());
        },
      ),
    );
  }

  Material _buildProfileBtn(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: InkWell(
          onTap: () {
            context.pushNamed(AppRoute.myAccount);
          },
          borderRadius: TBorderRadius.md,
          child: Ink(
            height: 60,
            decoration: BoxDecoration(
              borderRadius: TBorderRadius.md,
              color: TColor.northEastSnow,
              boxShadow: [TBoxShadow.normalBoxShadow],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Wrap(
                    children: [
                      Icon(
                        Icons.person_outline,
                        size: 25,
                        color: TColor.poppySurprise,
                      ),
                      HSpacing.sm,
                      Text(
                        "My account",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 20,
                    color: TColor.petRock,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Material _buildNotificationBtn(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: InkWell(
          onTap: () {},
          borderRadius: TBorderRadius.md,
          child: Ink(
            height: 60,
            decoration: BoxDecoration(
              borderRadius: TBorderRadius.md,
              color: TColor.northEastSnow,
              boxShadow: [TBoxShadow.normalBoxShadow],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Wrap(
                    children: [
                      Icon(
                        FontAwesomeIcons.bell,
                        size: 23,
                        color: TColor.poppySurprise,
                      ),
                      HSpacing.sm,
                      Text(
                        "Notification",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 20,
                    color: TColor.petRock,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Material _buildLogoutBtn(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: InkWell(
          onTap: () {
            context.read<AuthCubit>().logout();
            context.go(AppRoute.signIn);
          },
          borderRadius: TBorderRadius.md,
          child: Ink(
            height: 60,
            decoration: BoxDecoration(
              borderRadius: TBorderRadius.md,
              color: TColor.poppySurprise,
              boxShadow: [TBoxShadow.normalBoxShadow],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Wrap(
                    children: [
                      Icon(
                        Icons.logout_rounded,
                        size: 23,
                        color: TColor.doctorWhite,
                      ),
                      HSpacing.sm,
                      Text(
                        "Log out",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: TColor.doctorWhite,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  SafeArea _buildErrorPanel(BuildContext context, UserState state) {
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
                  try {
                    context.read<UserCubit>().getUserDetail();
                  } catch (e) {
                    debugPrint(e.toString());
                  }
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
