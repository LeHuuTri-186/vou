import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../shared/styles/border_radius.dart';
import '../../../../theme/color/colors.dart';

class PasswordInputField extends StatefulWidget {
  const PasswordInputField({
    super.key,
    this.hintText,
    this.validator,
    this.label,
    this.prefixIcon,
  });

  final String? hintText;
  final String? label;
  final Icon? prefixIcon;
  final FormFieldValidator<String>? validator;

  @override
  State<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  bool _showPassword = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enableSuggestions: false,
      autocorrect: false,
      obscureText: _showPassword,
      cursorColor: TColor.petRock,
      focusNode: _focusNode,
      validator: widget.validator,
      decoration: InputDecoration(
        suffixIcon: InkWell(
          onTap: () {
            setState(() {
              _showPassword = !_showPassword;
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.asset(
              _showPassword ? "lib/core/assets/img/eye-closed.png" : "lib/core/assets/img/eye.png",
              width: 15,
              height: 15,
            ),
          ),
          ),
        prefixIcon: widget.prefixIcon,
        labelStyle: !_isFocused
            ? Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: TColor.petRock,
                )
            : Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: TColor.petRock,
                ),
        hintStyle: Theme.of(context).textTheme.bodyMedium,
        filled: true,
        hintText: widget.hintText,
        fillColor: _isFocused
            ? TColor.doctorWhite // Background when focused
            : TColor.northEastSnow,
        label: Container(
            decoration: BoxDecoration(
              color: _isFocused ? TColor.doctorWhite : Colors.transparent,
              borderRadius: TBorderRadius.sm,
            ),
            child: Padding(
              padding: const EdgeInsets.all(
                5.0,
              ),
              child: SizedBox(
                child: Text(widget.label ?? ""),
              ),
            )),
        border: const OutlineInputBorder(
          borderRadius: TBorderRadius.md,
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: TBorderRadius.lg,
          borderSide: BorderSide(
            color: TColor.petRock,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
