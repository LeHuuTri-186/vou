import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:vou/core/helpers/datetime_formatter.dart';
import 'package:vou/features/coupon/domain/model/coupon.dart';
import 'package:vou/shared/styles/vertical_spacing.dart';

import '../../../../shared/styles/appbar.dart';

class CouponUsagePage extends StatelessWidget {
  const CouponUsagePage({super.key, required this.coupon});
  final Coupon coupon;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar.buildAppBar(context: context, title: coupon.type.name),
      body: Column(
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(coupon.type.image))),
          ),
          BarcodeWidget(
            barcode: Barcode.qrCode(
              errorCorrectLevel: BarcodeQRCorrectionLevel.high,
            ),
            data: coupon.id,
            width: 200,
            height: 200,
          ),

          VSpacing.sm,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Name",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 20,
                ),
              ),
            ),
          ),
          VSpacing.sm,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                coupon.type.name,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontSize: 16),
              ),
            ),
          ),
          VSpacing.sm,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Description",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 20),
              ),
            ),
          ),
          VSpacing.sm,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                coupon.type.description,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontSize: 16),
              ),
            ),
          ),
          VSpacing.sm,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Expiration",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 20),
              ),
            ),
          ),
          VSpacing.sm,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                DateTimeUtil.formatDateTime(coupon.type.expiresAt),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
