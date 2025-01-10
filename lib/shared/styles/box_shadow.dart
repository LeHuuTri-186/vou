import 'package:flutter/cupertino.dart';

import '../../theme/color/colors.dart';

class TBoxShadow {
  static BoxShadow normalBoxShadow = BoxShadow(
  color: TColor.petRock.withOpacity(0.5),
  offset: const Offset(5, 5),
  blurRadius: 5);
}