import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CouponApiDataSource {
  final Dio _dio;

  CouponApiDataSource({
    required Dio dio,
  }) : _dio = dio;

  Future<Response> getUserCoupon({required String userId, required int perPage, required int page}) async {
      Response response = await _dio.get('${dotenv.env["USER_COUPON_END_POINT"]}/$userId?perPage=$perPage&page=$page');

      return response;
  }

  Future<Response> getCoupon({required String userId, required int perPage, required int page}) async {
    Response response = await _dio.get('${dotenv.env["USER_COUPON_END_POINT"]}/$userId?perPage=$perPage&page=$page');

    return response;
  }
}
