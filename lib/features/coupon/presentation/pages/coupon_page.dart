import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vou/core/router/app_router_config.dart';
import 'package:vou/features/coupon/bloc/user_coupon_cubit.dart';
import 'package:vou/features/coupon/bloc/user_coupon_state.dart';
import 'package:vou/shared/styles/vertical_spacing.dart';
import 'package:vou/shared/widgets/loading_widget.dart';

import '../../../../shared/styles/border_radius.dart';
import '../../../../shared/widgets/image_icon.dart';
import '../../../../theme/color/colors.dart';
import '../widgets/coupon_widget.dart';

class CouponPage extends StatefulWidget {
  const CouponPage({super.key});

  @override
  _CouponPageState createState() => _CouponPageState();
}

class _CouponPageState extends State<CouponPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final couponCubit = context.read<UserCouponCubit>();
    couponCubit.fetchCoupon();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 300) {
        couponCubit.loadNextPage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCouponCubit, UserCouponState>(
      listener: (BuildContext context, UserCouponState state) {},
      child: BlocBuilder<UserCouponCubit, UserCouponState>(
          builder: (context, state) {
        if (state is UserCouponError) {
          return _buildErrorPanel(context);
        }

        if (state is UserCouponLoaded) {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    VSpacing.sm,
                    Expanded(
                      child: GridView.builder(
                        controller: _scrollController,
                        itemCount: state.list.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10),
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: CouponWidget(coupon: state.list[index], onTap:() => context.push("/coupon/use", extra: state.list[index]),),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return Scaffold(
          body: Center(
            child: LoadingWidget.twistingDotsLoadIndicator(),
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

SafeArea _buildEmptyPanel(BuildContext context) {
  return SafeArea(
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          VSpacing.sm,
          AutoSizeText(
            "Out of coupon!",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: TColor.petRock,
                ),
          ),
          VSpacing.sm,
          const ImageIconWidget(
            imagePath: 'assets/images/hunt-event.png',
            width: 300,
            height: 300,
          ),
          VSpacing.sm,
          AutoSizeText(
            "Let's go on a hunt for more in Event!",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: TColor.petRock,
                  fontSize: 16,
                ),
          ),
          VSpacing.md,
        ],
      ),
    ),
  );
}

SafeArea _buildErrorPanel(BuildContext context) {
  return SafeArea(
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          VSpacing.sm,
          AutoSizeText(
            "An Error occurred!",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: TColor.petRock,
                ),
          ),
          VSpacing.sm,
          const ImageIconWidget(
            imagePath: 'assets/images/error.png',
            width: 300,
            height: 300,
          ),
          VSpacing.sm,
          AutoSizeText(
            "Please try again!",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: TColor.petRock,
                  fontSize: 16,
                ),
          ),
          VSpacing.sm,
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                context.read<UserCouponCubit>().fetchCoupon();
                context.read<UserCouponCubit>().reset();
              },
              borderRadius: TBorderRadius.md,
              child: Ink(
                decoration: BoxDecoration(
                  color: TColor.poppySurprise,
                  borderRadius: TBorderRadius.md,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AutoSizeText(
                    "Try again",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: TColor.doctorWhite,
                        ),
                  ),
                ),
              ),
            ),
          ),
          VSpacing.md,
        ],
      ),
    ),
  );
}
