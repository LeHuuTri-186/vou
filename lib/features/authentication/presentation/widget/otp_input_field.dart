import 'package:flutter/material.dart';

import '../../../../shared/styles/border_radius.dart';
import '../../../../theme/color/colors.dart';

class OtpInputField extends StatefulWidget {
  final TextEditingController? controller;

  const OtpInputField({super.key, this.controller});

  @override
  State<OtpInputField> createState() => _OtpInputFieldState();
}

class _OtpInputFieldState extends State<OtpInputField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

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
      focusNode: _focusNode,
      textAlign: TextAlign.center,
      controller: widget.controller,
      keyboardType: TextInputType.number,
      maxLength: 6,
      cursorColor: TColor.petRock,
      decoration: InputDecoration(
        errorBorder: OutlineInputBorder(
          borderRadius: TBorderRadius.lg,
          borderSide: BorderSide(
            color: TColor.poppySurprise,
            width: 1.5,
          ),
        ),
        fillColor: _isFocused
            ? TColor.doctorWhite // Background when focused
            : TColor.northEastSnow,
        labelStyle: !_isFocused
            ? Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: TColor.petRock,
        )
            : Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: TColor.petRock,
        ),
        hintStyle: Theme.of(context).textTheme.bodyMedium,
        filled: true,
        labelText: 'Enter OTP',
        hintText: '6-digit code',
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
        counterText: '', // Hides the counter below the input
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter the OTP';
        }
        if (value.length != 6) {
          return 'OTP must be 6 digits';
        }
        if (!RegExp(r'^\d{6}$').hasMatch(value)) {
          return 'OTP must contain only numbers';
        }
        return null;
      },
    );
  }
}
