import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:vou/core/helpers/app_localization_string_builder.dart';
import 'package:vou/features/authentication/bloc/sign_up_form_cubit.dart';
import 'package:vou/features/authentication/domain/entities/sign_up_data_model.dart';
import 'package:vou/shared/styles/border_radius.dart';
import 'package:vou/shared/styles/horizontal_spacing.dart';
import 'package:vou/shared/styles/vertical_spacing.dart';

import '../../../../core/router/app_route.dart';
import '../../../../shared/styles/appbar.dart';
import '../../../../theme/color/colors.dart';
import '../../bloc/auth_cubit.dart';
import '../../../../shared/widgets/text_button.dart';
import '../../bloc/auth_state.dart';
import '../widget/otp_input_field.dart';

class OtpPage extends StatelessWidget {
  OtpPage({super.key});
  final TextEditingController _otp = TextEditingController();
  late AuthCubit _authCubit;
  late SignUpFormCubit _formCubit;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _authCubit = context.read<AuthCubit>();
    _formCubit = context.read<SignUpFormCubit>();

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignInError) {
          _showErrorDialog(context);
          GoRouter.of(context).go(AppRoute.signUp);
          return;
        }

        GoRouter.of(context).go(AppRoute.signIn);
      },
      child: Scaffold(
        appBar: TAppBar.buildAppBar(context: context, title: 'VOU'),
        body: _buildBody(context, _authCubit),
      ),
    );
  }

  Widget _buildBody(BuildContext context, AuthCubit authCubit) {
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
                  "assets/images/otp.png",
                  width: MediaQuery.of(context).size.width * 0.65,
                  height: MediaQuery.of(context).size.width * 0.65,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'An OTP was sent to your Email',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              VSpacing.xs,
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Please check your Email and enter the OTP code to continue!",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              VSpacing.lg,
              Form(
                  key: _formKey,
                  child: OtpInputField(
                    controller: _otp,
                  )),
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
                      final model = SignUpDataModel(
                          email: _formCubit.state.email,
                          password: _formCubit.state.password,
                          otp: _otp.text,
                          username: _formCubit.state.username,
                          firstName: _formCubit.state.firstName,
                          lastName: _formCubit.state.lastName,
                          phone: _formCubit.state.phoneNumber);
                          await _authCubit.signUp(model);
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
                          "Confirm",
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
          'Did not received the code?',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontSize: 15, color: TColor.petRock),
        ),
        HSpacing.xs,
        TTextButton(
          onTap: () {},
          text: context.getLocaleString(
            value: 'Resend',
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
          "Expired OTP! Please try again!",
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
