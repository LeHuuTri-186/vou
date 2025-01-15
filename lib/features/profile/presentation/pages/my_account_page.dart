import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vou/core/helpers/app_localization_string_builder.dart';
import 'package:vou/shared/styles/appbar.dart';

import '../../../../core/helpers/validator.dart';
import '../../../../shared/styles/border_radius.dart';
import '../../../../shared/styles/vertical_spacing.dart';
import '../../../../shared/widgets/image_icon.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../../../theme/color/colors.dart';
import '../../../authentication/presentation/widget/input_field.dart';
import '../../../authentication/presentation/widget/number_input_field.dart';
import '../../bloc/user_cubit.dart';
import '../../bloc/user_state.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({super.key});

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _retypeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar.buildAppBar(context: context, title: "My Account"),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserError) {
            return Center(
              child: _buildErrorPanel(context, state),
            );
          }

          if (state is UserLoaded) {
            _firstNameController.text = state.user.firstName;
            _lastNameController.text = state.user.lastName;
            _phoneController.text = state.user.phone;
            _emailController.text = state.user.email;

            return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: InputField(
                                validator: FormValidators.validateFirstName,
                                controller: _firstNameController,
                                hintText: "Your First name",
                                label: 'First name',
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: InputField(
                                validator: FormValidators.validateLastName,
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
                          controller: _phoneController,
                          prefixIcon: const Icon(Icons.phone_outlined),
                          hintText: "Your Phone number",
                          label: 'Phone number',
                        ),
                        VSpacing.md,
                        InputField(
                          validator: FormValidators.validateEmail,
                          controller: _emailController,
                          prefixIcon: const Icon(Icons.mail_outline_rounded),
                          hintText:
                              context.getLocaleString(value: 'email-description'),
                          label: context.getLocaleString(value: 'email'),
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
                                context.read<UserCubit>().updateUser(
                                  firstName: _firstNameController.text,
                                  lastName: _lastNameController.text,
                                  email: _emailController.text,
                                  phoneNum: _phoneController.text,
                                );
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
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Edit",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(color: TColor.doctorWhite),
                                      ),
                                    ],
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
              ),
            );
          }
          return Center(child: LoadingWidget.twistingDotsLoadIndicator());
        },
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
