import 'package:vou/features/coupon/domain/repositories/coupon_repository.dart';

import '../../../../core/usecases/usecase.dart';
import '../model/coupon.dart';

class GetUserCouponUseCase extends UseCase<List<Coupon>, PaginateParams> {

  final CouponRepository _repository;

  GetUserCouponUseCase({required CouponRepository repository}) : _repository = repository;

  @override
  Future<List<Coupon>> call(PaginateParams params) async {
    return await _repository.getCoupon(page: params.page, perPage: params.perPage);
  }
}

class PaginateParams {
  final int page;
  final int perPage;

  PaginateParams({required this.page, required this.perPage});
}