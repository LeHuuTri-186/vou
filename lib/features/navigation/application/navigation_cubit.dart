import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationState {
  final String currentPage;

  const NavigationState(this.currentPage);
}

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState('signin'));

  Future<void> navigateTo(String page) async {
    emit(const NavigationState('loading'));
    await Future.delayed(const Duration(seconds: 1));
    emit(NavigationState(page));
  }
}
