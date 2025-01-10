// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CouponImpl _$$CouponImplFromJson(Map<String, dynamic> json) => _$CouponImpl(
      id: json['id'] as String,
      code: json['code'] as String,
      discountPercentage: (json['discountPercentage'] as num).toDouble(),
      expiryDate: json['expiryDate'] == null
          ? null
          : DateTime.parse(json['expiryDate'] as String),
      isActive: json['isActive'] as bool?,
      brand: json['brand'] as String,
      description: json['description'] as String,
      logoPath: json['logoPath'] as String?,
    );

Map<String, dynamic> _$$CouponImplToJson(_$CouponImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'discountPercentage': instance.discountPercentage,
      'expiryDate': instance.expiryDate?.toIso8601String(),
      'isActive': instance.isActive,
      'brand': instance.brand,
      'description': instance.description,
      'logoPath': instance.logoPath,
    };
