import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ticket_clippers/ticket_clippers.dart';
import 'package:vou/features/coupon/domain/model/coupon.dart';
import 'package:vou/shared/styles/box_shadow.dart';
import 'package:vou/shared/styles/border_radius.dart';
import 'package:vou/theme/text/work_sans_style.dart';

import '../../../../theme/color/colors.dart';

class CouponWidget extends StatelessWidget {
  const CouponWidget({
    super.key,
    required this.coupon,
    this.color, this.onTap,
  });
  final Coupon coupon;
  final Color? color;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Ink(
            decoration: BoxDecoration(
              boxShadow: [
                TBoxShadow.normalBoxShadow
              ],
              borderRadius: TBorderRadius.md,
              color: TColor.doctorWhite,
            ),
            child: Column(
              children: [
                Flexible(
                  flex: 2,
                  child: ClipPath(
                    clipper: RoundedEdgeClipper(
                      depth: 10,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: color ?? TColor.poppySurprise,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        image: DecorationImage(image: NetworkImage(coupon.type.image))
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AutoSizeText(
                        '${coupon.type.discountValue}%',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 20,
                          decorationStyle: coupon.redeemed ? TextDecorationStyle.dashed : null,
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AutoSizeText(
                        coupon.type.description,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: TColor.slate,
                              fontSize: 16,
                            ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
