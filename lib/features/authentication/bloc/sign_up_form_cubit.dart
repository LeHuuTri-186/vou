import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vou/features/authentication/bloc/sign_up_form_state.dart';

class SignUpFormCubit extends Cubit<SignUpFormState> {
  SignUpFormCubit() : super(SignUpFormState());

  void updateUsername(String? username) =>
      emit(state.copyWith(username: username));
  void updateFirstName(String? firstName) =>
      emit(state.copyWith(firstName: firstName));
  void updateLastName(String? lastName) =>
      emit(state.copyWith(lastName: lastName));
  void updatePhoneNumber(String? phoneNumber) =>
      emit(state.copyWith(phoneNumber: phoneNumber));
  void updateEmail(String? email) => emit(state.copyWith(email: email));
  void updatePassword(String? password) =>
      emit(state.copyWith(password: password));
  void clearState() => emit(
        state.copyWith(
          username: '',
          firstName: '',
          lastName: '',
          email: '',
          password: '',
          phoneNumber: '',
        ),
      );
}
