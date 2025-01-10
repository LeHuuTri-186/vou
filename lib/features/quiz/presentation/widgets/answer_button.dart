import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:vou/shared/styles/border_radius.dart';

import '../../../../theme/color/colors.dart';

class AnswerButton extends StatelessWidget {
  const AnswerButton({
    super.key,
    required this.text,
    required this.onTap,
    required this.color,
  });

  final String text;
  final void Function() onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Ink(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: TBorderRadius.sm,
            color: color,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: AutoSizeText(
                text,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: TColor.doctorWhite,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
