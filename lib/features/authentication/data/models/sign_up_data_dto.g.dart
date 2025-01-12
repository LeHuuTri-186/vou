// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SignUpDataDtoImpl _$$SignUpDataDtoImplFromJson(Map<String, dynamic> json) =>
    _$SignUpDataDtoImpl(
      email: json['email'] as String,
      password: json['password'] as String,
      otp: json['otp'] as String,
      username: json['username'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      phone: json['phone'] as String,
    );

Map<String, dynamic> _$$SignUpDataDtoImplToJson(_$SignUpDataDtoImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'otp': instance.otp,
      'username': instance.username,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'phone': instance.phone,
    };
