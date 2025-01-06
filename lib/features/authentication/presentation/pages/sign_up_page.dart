import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vou/utils/helpers/app_localization_string_builder.dart';
import 'package:vou/features/navigation/application/navigation_cubit.dart';

import '../../../../shared/styles/appbar.dart';
import '../../../../shared/styles/border_radius.dart';
import '../../../../theme/color/colors.dart';
import '../../../../shared/styles/horizontal_spacing.dart';
import '../../../../shared/styles/vertical_spacing.dart';
import '../../bloc/auth_cubit.dart';
import '../widget/input_field.dart';
import '../widget/password_input_field.dart';
import '../widget/text_button.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                  "lib/core/assets/img/sign-up.png",
                  width: MediaQuery.of(context).size.width * 0.65,
                  height: MediaQuery.of(context).size.width * 0.65,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  context.getLocaleString(
                    value: 'signup',
                  ),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              VSpacing.xs,
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  context.getLocaleString(
                    value: 'signup-description',
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
              InputField(
                prefixIcon: const Icon(Icons.mail_outline_rounded),
                hintText:
                context.getLocaleString(value: 'email-description'),
                label: context.getLocaleString(value: 'email'),
              ),
              VSpacing.lg,
              PasswordInputField(
                prefixIcon: const Icon(Icons.lock_outlined),
                hintText:
                    context.getLocaleString(value: 'password-description'),
                label: context.getLocaleString(value: 'password'),
              ),
              VSpacing.lg,
              PasswordInputField(
                prefixIcon: const Icon(Icons.lock_outlined),
                hintText:
                context.getLocaleString(value: 'retype-description'),
                label: context.getLocaleString(value: 'retype'),
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
                    context.read<AuthCubit>().navigateToSignUp();
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
                            value: 'signup',
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
              _buildHasAccountLine(context),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildHasAccountLine(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          context.getLocaleString(value: 'has-account'),
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontSize: 15, color: TColor.petRock),
        ),
        HSpacing.xs,
        TTextButton(
          onTap: () {
            context.read<NavigationCubit>().navigateTo("signin");
          },
          text: context.getLocaleString(
            value: 'login',
          ),
        ),
      ],
    );
  }
}
