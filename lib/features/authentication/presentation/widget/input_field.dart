import 'package:flutter/material.dart';

import '../../../../shared/styles/border_radius.dart';
import '../../../../theme/color/colors.dart';

class InputField extends StatefulWidget {
  const InputField({
    super.key,
    this.hintText,
    this.validator,
    this.label,
    this.prefixIcon, this.controller, this.onChanged,
  });

  final String? hintText;
  final String? label;
  final Icon? prefixIcon;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final Function(String?)? onChanged;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
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
      onChanged: widget.onChanged,
      controller: widget.controller,
      maxLength: 30,
      enableSuggestions: false,
      autocorrect: false,
      cursorColor: TColor.petRock,
      focusNode: _focusNode,
      validator: widget.validator,
      decoration: InputDecoration(
        errorMaxLines: 2,
        errorBorder: OutlineInputBorder(
          borderRadius: TBorderRadius.lg,
          borderSide: BorderSide(
            color: TColor.poppySurprise,
            width: 1.5,
          ),
        ),
        counterText: '',
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
