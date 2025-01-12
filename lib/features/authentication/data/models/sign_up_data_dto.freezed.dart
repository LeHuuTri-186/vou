// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_up_data_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SignUpDataDto _$SignUpDataDtoFromJson(Map<String, dynamic> json) {
  return _SignUpDataDto.fromJson(json);
}

/// @nodoc
mixin _$SignUpDataDto {
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  String get otp => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;

  /// Serializes this SignUpDataDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SignUpDataDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SignUpDataDtoCopyWith<SignUpDataDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignUpDataDtoCopyWith<$Res> {
  factory $SignUpDataDtoCopyWith(
          SignUpDataDto value, $Res Function(SignUpDataDto) then) =
      _$SignUpDataDtoCopyWithImpl<$Res, SignUpDataDto>;
  @useResult
  $Res call(
      {String email,
      String password,
      String otp,
      String username,
      String firstName,
      String lastName,
      String phone});
}

/// @nodoc
class _$SignUpDataDtoCopyWithImpl<$Res, $Val extends SignUpDataDto>
    implements $SignUpDataDtoCopyWith<$Res> {
  _$SignUpDataDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SignUpDataDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
    Object? otp = null,
    Object? username = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? phone = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      otp: null == otp
          ? _value.otp
          : otp // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SignUpDataDtoImplCopyWith<$Res>
    implements $SignUpDataDtoCopyWith<$Res> {
  factory _$$SignUpDataDtoImplCopyWith(
          _$SignUpDataDtoImpl value, $Res Function(_$SignUpDataDtoImpl) then) =
      __$$SignUpDataDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String email,
      String password,
      String otp,
      String username,
      String firstName,
      String lastName,
      String phone});
}

/// @nodoc
class __$$SignUpDataDtoImplCopyWithImpl<$Res>
    extends _$SignUpDataDtoCopyWithImpl<$Res, _$SignUpDataDtoImpl>
    implements _$$SignUpDataDtoImplCopyWith<$Res> {
  __$$SignUpDataDtoImplCopyWithImpl(
      _$SignUpDataDtoImpl _value, $Res Function(_$SignUpDataDtoImpl) _then)
      : super(_value, _then);

  /// Create a copy of SignUpDataDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
    Object? otp = null,
    Object? username = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? phone = null,
  }) {
    return _then(_$SignUpDataDtoImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      otp: null == otp
          ? _value.otp
          : otp // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SignUpDataDtoImpl implements _SignUpDataDto {
  const _$SignUpDataDtoImpl(
      {required this.email,
      required this.password,
      required this.otp,
      required this.username,
      required this.firstName,
      required this.lastName,
      required this.phone});

  factory _$SignUpDataDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$SignUpDataDtoImplFromJson(json);

  @override
  final String email;
  @override
  final String password;
  @override
  final String otp;
  @override
  final String username;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String phone;

  @override
  String toString() {
    return 'SignUpDataDto(email: $email, password: $password, otp: $otp, username: $username, firstName: $firstName, lastName: $lastName, phone: $phone)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignUpDataDtoImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.otp, otp) || other.otp == otp) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.phone, phone) || other.phone == phone));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, email, password, otp, username, firstName, lastName, phone);

  /// Create a copy of SignUpDataDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SignUpDataDtoImplCopyWith<_$SignUpDataDtoImpl> get copyWith =>
      __$$SignUpDataDtoImplCopyWithImpl<_$SignUpDataDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SignUpDataDtoImplToJson(
      this,
    );
  }

  @override
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
}

abstract class _SignUpDataDto implements SignUpDataDto {
  const factory _SignUpDataDto(
      {required final String email,
      required final String password,
      required final String otp,
      required final String username,
      required final String firstName,
      required final String lastName,
      required final String phone}) = _$SignUpDataDtoImpl;

  factory _SignUpDataDto.fromJson(Map<String, dynamic> json) =
      _$SignUpDataDtoImpl.fromJson;

  @override
  String get email;
  @override
  String get password;
  @override
  String get otp;
  @override
  String get username;
  @override
  String get firstName;
  @override
  String get lastName;
  @override
  String get phone;

  /// Create a copy of SignUpDataDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SignUpDataDtoImplCopyWith<_$SignUpDataDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
