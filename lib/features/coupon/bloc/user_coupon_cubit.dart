import 'package:bloc/bloc.dart';
import 'package:vou/features/coupon/bloc/user_coupon_state.dart';

import '../../../core/logger/sentry_logger_util.dart';
import '../domain/model/coupon.dart';
import '../domain/usecases/get_user_coupon_usecase.dart';

class UserCouponCubit extends Cubit<UserCouponState> {
  UserCouponCubit({required GetUserCouponUseCase getUserCouponUseCase})
      : _getUserCouponUseCase = getUserCouponUseCase,
        super(UserCouponInitial());

  final GetUserCouponUseCase _getUserCouponUseCase;
  int _currentPage = 1;
  bool _isFetching = false;
  final List<Coupon> _coupons = [];

  Future<void> fetchCoupon({int page = 1, bool isPaginating = false}) async {
    if (_isFetching) return; // Avoid duplicate requests
    _isFetching = true;

    if (!isPaginating) emit(UserCouponLoading());

    try {
      final list = await _getUserCouponUseCase.call(
        PaginateParams(page: page, perPage: 7),
      );

      if (page == 1) {
        _coupons.clear();
      }
      _coupons.addAll(list);

      _currentPage = page;
      emit(UserCouponLoaded(list: List.unmodifiable(_coupons)));
    } catch (exception, stackTrace) {
      LoggerUtil.captureException(exception, stackTrace: stackTrace);
      emit(UserCouponError(error: exception.toString()));
    } finally {
      _isFetching = false;
    }
  }

  void loadNextPage() => fetchCoupon(page: _currentPage + 1, isPaginating: true);

  void reset() {
    _currentPage = 1;
    _coupons.clear();
    fetchCoupon(page: 1);
  }
}
