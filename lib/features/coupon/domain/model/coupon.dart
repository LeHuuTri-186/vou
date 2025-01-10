import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'coupon.freezed.dart';
part 'coupon.g.dart';

@freezed
class Coupon with _$Coupon {
  const factory Coupon({
    required String id,
    required String code,
    required double discountPercentage,
    DateTime? expiryDate,
    bool? isActive,
    required String brand,
    required String description,
    String? logoPath,
  }) = _Coupon;

  factory Coupon.fromJson(Map<String, dynamic> json) => _$CouponFromJson(json);
}
