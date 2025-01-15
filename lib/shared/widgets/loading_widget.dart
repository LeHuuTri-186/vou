import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../theme/color/colors.dart';

class LoadingWidget {
  static Widget twistingDotsLoadIndicator() =>
      LoadingAnimationWidget.twistingDots(
        size: 50,
        leftDotColor: TColor.poppySurprise,
        rightDotColor: TColor.tamarama,
      );

  static Widget twistingDotsLoadIndicatorBtn() =>
      LoadingAnimationWidget.twistingDots(
        size: 20,
        leftDotColor: TColor.doctorWhite,
        rightDotColor: TColor.tamarama,
      );
}
