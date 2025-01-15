import 'package:vou/features/coupon/domain/model/coupon.dart';

abstract class CouponRepository {
  Future<List<Coupon>> getCoupon({required int page, required int perPage});
}