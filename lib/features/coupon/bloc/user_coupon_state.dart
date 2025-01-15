import '../domain/model/coupon.dart';

class UserCouponState {}

class UserCouponInitial extends UserCouponState {}

class UserCouponLoading extends UserCouponState {}

class UserCouponLoaded extends UserCouponState {
  final List<Coupon> list;

  UserCouponLoaded({required this.list});
}

class UserCouponError extends UserCouponState {
  final String error;

  UserCouponError({required this.error});
}
