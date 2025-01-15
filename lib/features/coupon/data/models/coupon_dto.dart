import '../../domain/model/coupon.dart';

class CouponDto {
  final String id;
  final String userId;
  final bool redeemed;
  final int typeId;
  final CouponTypeDto type;

  CouponDto({
    required this.id,
    required this.userId,
    required this.redeemed,
    required this.typeId,
    required this.type,
  });

  factory CouponDto.fromJson(Map<String, dynamic> json) {
    return CouponDto(
      id: json['id'],
      userId: json['userId'],
      redeemed: json['redeemed'],
      typeId: json['typeId'] as int,
      type: CouponTypeDto.fromJson(json['type']),
    );
  }

  Coupon toDomain() {
    return Coupon(
      id: id,
      userId: userId,
      redeemed: redeemed,
      typeId: typeId,
      type: type.toEntity(),
    );
  }
}

class CouponTypeDto {
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

  CouponTypeDto({
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

  factory CouponTypeDto.fromJson(Map<String, dynamic> json) {
    return CouponTypeDto(
      id: json['id'] as int,
      name: json['name'],
      description: json['description'],
      shortDescription: json['shortDescription'],
      image: json['image'],
      discountType: json['discountType'],
      discountValue: (json['discountValue'] as num).toDouble(),
      expiresAt: DateTime.parse(json['expiresAt']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      partnerId: json['partnerId'],
    );
  }

  CouponType toEntity() {
    return CouponType(
      id: id,
      name: name,
      description: description,
      shortDescription: shortDescription,
      image: image,
      discountType: discountType,
      discountValue: discountValue,
      expiresAt: expiresAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
      partnerId: partnerId,
    );
  }
}
