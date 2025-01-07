import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:vou/utils/helpers/app_localization_string_builder.dart';
import 'package:vou/shared/styles/border_radius.dart';
import 'package:vou/shared/styles/horizontal_spacing.dart';
import 'package:vou/shared/styles/vertical_spacing.dart';
import 'package:vou/utils/router/app_route.dart';
import 'package:vou/utils/router/app_router_config.dart';

import '../../../../shared/styles/appbar.dart';
import '../../../../theme/color/colors.dart';
import '../../bloc/auth_cubit.dart';
import '../../bloc/auth_state.dart';
import '../widget/input_field.dart';
import '../widget/password_input_field.dart';
import '../widget/text_button.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    if (authCubit.state is Authenticated) {
      GoRouter.of(context).go(AppRoute.events);
    }

    return Scaffold(
      appBar: TAppBar.buildAppBar(context: context, title: 'VOU'),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset(
                  "images/sign-in.png",
                  width: MediaQuery.of(context).size.width * 0.65,
                  height: MediaQuery.of(context).size.width * 0.65,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  context.getLocaleString(
                    value: 'login',
                  ),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              VSpacing.xs,
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  context.getLocaleString(
                    value: 'login-description',
                  ),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              VSpacing.lg,
              InputField(
                prefixIcon: const Icon(
                  FontAwesomeIcons.user,
                  size: 22,
                ),
                hintText:
                    context.getLocaleString(value: 'username-description'),
                label: context.getLocaleString(value: 'username'),
              ),
              VSpacing.lg,
              PasswordInputField(
                prefixIcon: const Icon(Icons.lock_outlined),
                hintText:
                    context.getLocaleString(value: 'password-description'),
                label: context.getLocaleString(value: 'password'),
              ),
              VSpacing.xs,
              Align(
                alignment: Alignment.centerRight,
                child: TTextButton(
                    text: context.getLocaleString(
                  value: 'forgot-password',
                )),
              ),
              VSpacing.lg,
              Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: Colors.red.withOpacity(
                    0.5,
                  ),
                  borderRadius: TBorderRadius.md,
                  onTap: () {
                    final token = 'dummyAuthToken';
                    context.read<AuthCubit>().login(token);

                    // Navigate to the next screen after login.
                    GoRouter.of(context).go(AppRoute.events);
                  },
                  child: Ink(
                    decoration: BoxDecoration(
                      borderRadius: TBorderRadius.md,
                      color: TColor.poppySurprise,
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          context.getLocaleString(
                            value: 'login',
                          ),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: TColor.doctorWhite),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              VSpacing.md,
              _buildNoAccountLine(context),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildNoAccountLine(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          context.getLocaleString(value: 'no-account'),
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontSize: 15, color: TColor.petRock),
        ),
        HSpacing.xs,
        TTextButton(
          onTap: () {
            context.go(AppRoute.signUp);
          },
          text: context.getLocaleString(
            value: 'signup',
          ),
        ),
      ],
    );
  }
}
