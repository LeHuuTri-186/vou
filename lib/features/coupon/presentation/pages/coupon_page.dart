import 'package:flutter/material.dart';
import 'package:vou/shared/styles/vertical_spacing.dart';

import '../../../../shared/styles/appbar.dart';
import '../../../../shared/widgets/search_bar.dart';
import '../widgets/coupon.dart';

class CouponPage extends StatelessWidget {
  const CouponPage({super.key});

  @override
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
                child: ListView.builder(
                  itemCount: 10, // Replace with the actual number of items
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: CouponWidget(),
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
