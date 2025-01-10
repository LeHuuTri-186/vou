import 'package:flutter/material.dart';
import 'package:vou/shared/styles/vertical_spacing.dart';

import '../../../../shared/styles/appbar.dart';
import '../../../../shared/widgets/search_bar.dart';
import '../../../../theme/color/colors.dart';
import '../../../../utils/helpers/coupon_sample_data.dart';
import '../../domain/model/coupon.dart';
import '../widgets/coupon_widget.dart';

class CouponPage extends StatelessWidget {
  const CouponPage({super.key});
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar.buildAppBar(context: context, title: 'Coupon'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              CustomSearchBar(
                onChanged: (value) {
                  // Handle search logic
                },
              ),
              VSpacing.sm,
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
                  itemCount: $sampleCoupons.length, // Replace with the actual number of items
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: CouponWidget(coupon: $sampleCoupons[index]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
