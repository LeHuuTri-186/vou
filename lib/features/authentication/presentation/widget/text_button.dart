import 'package:flutter/material.dart';

import '../../../../shared/styles/colors.dart';

class TTextButton extends StatelessWidget {
  const TTextButton({
    super.key,
    this.onTap,
    required this.text,
  });

  final GestureTapCallback? onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: onTap,
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontSize: 16, color: TColor.poppySurprise),
        ),
      ),
    );
  }
}