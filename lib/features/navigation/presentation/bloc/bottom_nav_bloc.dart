import 'package:bloc/bloc.dart';

import 'bottom_nav_event.dart';
import 'bottom_nav_state.dart';

class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
  BottomNavBloc() : super(BottomNavState(0)) {
    on<UpdateTab>(
      (event, emit) {
        emit(BottomNavState(event.index));
      },
    );
  }
}
