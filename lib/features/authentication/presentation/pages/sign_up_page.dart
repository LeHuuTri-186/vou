import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:vou/core/helpers/app_localization_string_builder.dart';
import 'package:vou/core/helpers/validator.dart';
import 'package:vou/core/router/app_route.dart';
import 'package:vou/features/authentication/bloc/auth_state.dart';

import '../../../../shared/styles/appbar.dart';
import '../../../../shared/styles/border_radius.dart';
import '../../../../theme/color/colors.dart';
import '../../../../shared/styles/horizontal_spacing.dart';
import '../../../../shared/styles/vertical_spacing.dart';
import '../../bloc/auth_cubit.dart';
import '../../bloc/sign_up_form_cubit.dart';
import '../widget/input_field.dart';
import '../widget/number_input_field.dart';
import '../widget/password_input_field.dart';
import '../../../../shared/widgets/text_button.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  late SignUpFormCubit _formCubit;
  late AuthCubit _authCubit;

  final _formKey = GlobalKey<FormState>();
  late TextEditingController _usernameController;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _retypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _setUpSignUp(context);

    return Scaffold(
      appBar: TAppBar.buildAppBar(context: context, title: 'VOU'),
      body: _buildBody(context),
    );
  }

  void _setUpSignUp(BuildContext context) {
    _formCubit = context.read<SignUpFormCubit>();
    _authCubit = context.read<AuthCubit>();
    _usernameController =
        TextEditingController(text: _formCubit.state.username);
    _firstNameController =
        TextEditingController(text: _formCubit.state.firstName);
    _lastNameController =
        TextEditingController(text: _formCubit.state.lastName);
    _emailController = TextEditingController(text: _formCubit.state.email);
    _phoneController =
        TextEditingController(text: _formCubit.state.phoneNumber);

    _formCubit.updatePassword('');
  }

  Widget _buildBody(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
        listener: (BuildContext context, AuthState state) {
          if (state is RegisteredEmail) {
            _showErrorDialog(context);
          }
        },
        child: SafeArea(
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
                        "assets/images/sign-up.png",
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.width * 0.5,
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
                    VSpacing.md,
                    InputField(
                      validator: FormValidators.validateUsername,
                      onChanged: _formCubit.updateUsername,
                      controller: _usernameController,
                      prefixIcon: const Icon(
                        FontAwesomeIcons.user,
                        size: 22,
                      ),
                      hintText: context.getLocaleString(
                          value: 'username-description'),
                      label: context.getLocaleString(value: 'username'),
                    ),
                    VSpacing.md,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: InputField(
                            validator: FormValidators.validateFirstName,
                            onChanged: _formCubit.updateFirstName,
                            controller: _firstNameController,
                            hintText: "Your First name",
                            label: 'First name',
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: InputField(
                            validator: FormValidators.validateLastName,
                            onChanged: _formCubit.updateLastName,
                            controller: _lastNameController,
                            hintText: "Your Last name",
                            label: 'Last name',
                          ),
                        ),
                      ],
                    ),
                    VSpacing.md,
                    NumberInputField(
                      validator: FormValidators.validatePhoneNumber,
                      onChanged: _formCubit.updatePhoneNumber,
                      controller: _phoneController,
                      prefixIcon: const Icon(Icons.phone_outlined),
                      hintText: "Your Phone number",
                      label: 'Phone number',
                    ),
                    VSpacing.md,
                    InputField(
                      validator: FormValidators.validateEmail,
                      onChanged: _formCubit.updateEmail,
                      controller: _emailController,
                      prefixIcon: const Icon(Icons.mail_outline_rounded),
                      hintText:
                          context.getLocaleString(value: 'email-description'),
                      label: context.getLocaleString(value: 'email'),
                    ),
                    VSpacing.md,
                    PasswordInputField(
                      validator: FormValidators.validatePassword,
                      onChanged: _formCubit.updatePassword,
                      controller: _passwordController,
                      prefixIcon: const Icon(Icons.lock_outlined),
                      hintText: context.getLocaleString(
                          value: 'password-description'),
                      label: context.getLocaleString(value: 'password'),
                    ),
                    VSpacing.md,
                    PasswordInputField(
                      validator: (retype) {
                        if (retype == null || retype.isEmpty) {
                          return "Retype cannot be empty";
                        }

                        if (retype != _passwordController.text) {
                          return "Retype and password mismatched!";
                        }

                        return null;
                      },
                      controller: _retypeController,
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
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            await _authCubit.requestOtp(_formCubit.state.email);

                            if (_authCubit.state is RegisteredEmail) {
                              return;
                            }

                            if (context.mounted) {
                              GoRouter.of(context).push(AppRoute.otp);
                            }
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
          ),
        ));
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
                "There has already been an account associate with this Email!",
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
            _formCubit.clearState();
            GoRouter.of(context).go(AppRoute.signIn);
          },
          text: context.getLocaleString(
            value: 'login',
          ),
        ),
      ],
    );
  }
}
