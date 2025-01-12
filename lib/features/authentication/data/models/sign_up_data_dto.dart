import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vou/features/authentication/domain/entities/sign_up_data_model.dart';

part 'sign_up_data_dto.freezed.dart';
part 'sign_up_data_dto.g.dart';

@freezed
class SignUpDataDto with _$SignUpDataDto {
  const factory SignUpDataDto(
      {required String email,
      required String password,
      required String otp,
      required String username,
      required String firstName,
      required String lastName,
      required String phone}) = _SignUpDataDto;

  factory SignUpDataDto.fromJson(Map<String, dynamic> json) =>
      _$SignUpDataDtoFromJson(json);

  SignUpDataModel toDomain() {
    return SignUpDataModel(
      email: email,
      password: password,
      otp: otp,
      username: username,
      firstName: firstName,
      lastName: lastName,
      phone: phone,
    );
  }

  static SignUpDataDto fromDomain(SignUpDataModel model) {
    return SignUpDataDto(email: model.email, password: model.password, otp: model.otp, username: model.username, firstName: model.firstName, lastName: model.lastName, phone: model.phone);
  }
}
