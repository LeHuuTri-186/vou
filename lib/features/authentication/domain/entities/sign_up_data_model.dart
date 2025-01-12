import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_data_model.freezed.dart';

@freezed
class SignUpDataModel with _$SignUpDataModel {
  const factory SignUpDataModel(
      {required String email,
      required String password,
      required String otp,
      required String username,
      required String firstName,
      required String lastName,
      required String phone}) = _SignUpDataModel;
}
