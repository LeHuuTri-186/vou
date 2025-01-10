import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ticket_clippers/ticket_clippers.dart';
import 'package:vou/features/coupon/domain/model/coupon.dart';
import 'package:vou/shared/styles/box_shadow.dart';
import 'package:vou/shared/widgets/image_icon.dart';
import 'package:vou/shared/styles/border_radius.dart';
import 'package:vou/theme/text/work_sans_style.dart';

import '../../../../theme/color/colors.dart';

class CouponWidget extends StatelessWidget {
  const CouponWidget({
    super.key,
    required this.coupon,
    this.color,
  });
  final Coupon coupon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        if (coupon.logoPath != null)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ImageIconWidget(imagePath: coupon.logoPath!),
                          ),
                        AutoSizeText(
                          coupon.brand,
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    color: TColor.doctorWhite,
                                  ),
                        ),
                      ],
                    ),
                  ),
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
                  '${coupon.discountPercentage}%',
                  style: WorkSansStyle.titleW700,
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
                  coupon.description,
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
    );
  }
}
