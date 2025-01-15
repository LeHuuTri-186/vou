import 'package:dio/dio.dart';
import 'package:vou/core/storage/hive_service.dart';
import 'package:vou/features/authentication/data/hive_keys.dart';
import 'package:vou/features/coupon/data/datasources/coupon_api_datasource.dart';
import 'package:vou/features/coupon/domain/model/coupon.dart';
import 'package:vou/features/coupon/domain/repositories/coupon_repository.dart';

import '../models/coupon_dto.dart';

class CouponRepositoryImpl implements CouponRepository {
  final CouponApiDataSource _dataSource;
  final HiveService _hiveService;

  CouponRepositoryImpl(
      {required CouponApiDataSource dataSource,
      required HiveService hiveService})
      : _dataSource = dataSource,
        _hiveService = hiveService;

  @override
  Future<List<Coupon>> getCoupon(
      {required int page, required int perPage}) async {
    Response response = await _dataSource.getUserCoupon(
        userId: _hiveService.get(HiveKeys.userId),
        perPage: perPage,
        page: page);

    if (response.statusCode == 200 || response.statusCode == 201) {
      List<Coupon> data = (response.data as List<dynamic>)
          .map((eventJson) => CouponDto.fromJson(eventJson as Map<String, dynamic>).toDomain())
          .toList();

      return data;
    } else {
      throw ("Failed to fetch coupon list with status code: ${response.statusCode}");
    }
  }
}
