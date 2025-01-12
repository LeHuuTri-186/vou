import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:vou/core/helpers/app_localization_string_builder.dart';
import 'package:vou/features/authentication/bloc/auth_state.dart';
import 'package:vou/features/authentication/bloc/sign_up_form_cubit.dart';
import 'package:vou/shared/styles/border_radius.dart';
import 'package:vou/shared/styles/horizontal_spacing.dart';
import 'package:vou/shared/styles/vertical_spacing.dart';

import '../../../../core/router/app_route.dart';
import '../../../../shared/styles/appbar.dart';
import '../../../../theme/color/colors.dart';
import '../../bloc/auth_cubit.dart';
import '../widget/input_field.dart';
import '../widget/password_input_field.dart';
import '../../../../shared/widgets/text_button.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();

    authCubit.checkAuthentication();

    return BlocListener<AuthCubit, AuthState>(
      listener: (BuildContext context, state) {
        if (state is Authenticated) {
          GoRouter.of(context).go('/event');

          return;
        }

        if (state is SignInError) {
          _showErrorDialog(context);
        }
      },
      child: Scaffold(
        appBar: TAppBar.buildAppBar(context: context, title: 'VOU'),
        body: _buildBody(context, authCubit),
      ),
    );
  }

  Widget _buildBody(BuildContext context, AuthCubit authCubit) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset(
                    "assets/images/sign-in.png",
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
                  validator: (username) {
                    if (username == null || username.isEmpty) {
                      return "Username cannot be empty";
                    }

                    if (username.trim().isEmpty) {
                      return "Username cannot be blank";
                    }

                    if (username.contains(' ')) {
                      return "Username cannot contains space";
                    }

                    return null;
                  },
                  controller: _usernameController,
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
                  validator: (password) {
                    if (password == null || password.isEmpty) {
                      return "Password cannot be empty";
                    }

                    if (password.trim().isEmpty) {
                      return "Password cannot be blank";
                    }

                    return null;
                  },
                  controller: _passwordController,
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
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        await authCubit.logIn(
                            _usernameController.text, _passwordController.text);
                      }
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
      ),
    );
  }

  Row _buildNoAccountLine(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          context.getLocaleString(value: 'no-account'),
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 15,
                color: TColor.petRock,
              ),
        ),
        HSpacing.xs,
        TTextButton(
          onTap: () {
            context.push(AppRoute.signUp);
          },
          text: context.getLocaleString(
            value: 'signup',
          ),
        ),
      ],
    );
  }

  Future<dynamic> _showErrorDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: TColor.doctorWhite,
        title: Text(
          "Error",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: TColor.poppySurprise,
              ),
        ),
        content: Text(
          "Invalid Username or Password!",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        actions: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: Navigator.of(context).pop,
              borderRadius: TBorderRadius.sm,
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: TBorderRadius.sm,
                  color: TColor.poppySurprise,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 4.0),
                  child: Text(
                    'Ok',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: TColor.doctorWhite),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
