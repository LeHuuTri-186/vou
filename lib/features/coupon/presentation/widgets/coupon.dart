import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ticket_clippers/ticket_clippers.dart';
import 'package:vou/theme/text/nunito_style.dart';
import 'package:vou/shared/styles/border_radius.dart';

import '../../../../theme/color/colors.dart';

class CouponWidget extends StatelessWidget {
  const CouponWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: TColor.petRock.withOpacity(0.5),
              offset: const Offset(3, 3),
              blurRadius: 4)
        ],
      ),
      child: ClipPath(
        clipper: TicketRoundedEdgeClipper(
          edge: Edge.vertical,
          position: 105,
          radius: 10,
        ),
        child: Container(
          height: 100,
          width: max(200, MediaQuery.of(context).size.width * 0.9),
          decoration: BoxDecoration(
            color: TColor.poppySurprise,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: Center(
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: TBorderRadius.full,
                      color: TColor.doctorWhite,
                      image: const DecorationImage(
                          image: AssetImage('lib/core/assets/img/sign-in.png'),
                          fit: BoxFit.fill),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: TColor.doctorWhite,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Giảm 8% Giảm tối đa 3tr vnđ',
                          style: NunitoStyle.basicW600.copyWith(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'Đơn tối thiểu 300k',
                          style: NunitoStyle.basic.copyWith(
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
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
