class Coupon {
  final String id;
  final String userId;
  final bool redeemed;
  final int typeId;
  final CouponType type;

  Coupon({
    required this.id,
    required this.userId,
    required this.redeemed,
    required this.typeId,
    required this.type,
  });
}

class CouponType {
  final int id;
  final String name;
  final String description;
  final String? shortDescription;
  final String image;
  final String discountType;
  final double discountValue;
  final DateTime expiresAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String partnerId;

  CouponType({
    required this.id,
    required this.name,
    required this.description,
    this.shortDescription,
    required this.image,
    required this.discountType,
    required this.discountValue,
    required this.expiresAt,
    required this.createdAt,
    required this.updatedAt,
    required this.partnerId,
  });
}
