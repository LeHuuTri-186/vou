import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vou/core/router/app_route.dart';
import 'package:vou/features/authentication/bloc/auth_cubit.dart';
import 'package:vou/shared/styles/border_radius.dart';
import 'package:vou/shared/styles/horizontal_spacing.dart';
import 'package:vou/shared/widgets/image_icon.dart';

import '../../../../theme/color/colors.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  late AuthCubit _authCubit;

  @override
  Widget build(BuildContext context) {
    _authCubit = context.read<AuthCubit>();
    return Drawer(
      backgroundColor: TColor.poppySurprise,
      elevation: 8,
      width: MediaQuery.of(context).size.width * 0.7,
      child: Column(
        children: [
          const SafeArea(
            child: Center(
              child: ImageIconWidget(
                imagePath: 'assets/images/vou.png',
                width: 120,
                height: 120,
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: TColor.doctorWhite,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        context.pop();
                        context.pushNamed(AppRoute.profile);
                      },
                      borderRadius: TBorderRadius.sm,
                      child: Ink(
                        decoration: const BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: TBorderRadius.sm),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  backgroundColor: TColor.petRock.withOpacity(0.3),
                                  child: Icon(
                                    Icons.person_outline_rounded,
                                    color: TColor.slate,
                                  ),
                                ),
                              ),
                              HSpacing.sm,
                              AutoSizeText(
                                'Profile',
                                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SafeArea(
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () async {
                              await _authCubit.logout();

                              if (context.mounted) {
                                GoRouter.of(context).go(AppRoute.signIn);
                              }
                            },
                            borderRadius: TBorderRadius.sm,
                            child: Ink(
                              decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: TBorderRadius.sm),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CircleAvatar(
                                        backgroundColor: TColor.petRock.withOpacity(0.3),
                                        child: Icon(
                                          Icons.logout_rounded,
                                          color: TColor.slate,
                                        ),
                                      ),
                                    ),
                                    HSpacing.sm,
                                    AutoSizeText(
                                      'Log out',
                                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                        color: TColor.poppySurprise,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
