// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_up_data_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SignUpDataModel {
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  String get otp => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;

  /// Create a copy of SignUpDataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SignUpDataModelCopyWith<SignUpDataModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignUpDataModelCopyWith<$Res> {
  factory $SignUpDataModelCopyWith(
          SignUpDataModel value, $Res Function(SignUpDataModel) then) =
      _$SignUpDataModelCopyWithImpl<$Res, SignUpDataModel>;
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
class _$SignUpDataModelCopyWithImpl<$Res, $Val extends SignUpDataModel>
    implements $SignUpDataModelCopyWith<$Res> {
  _$SignUpDataModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SignUpDataModel
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
abstract class _$$SignUpDataModelImplCopyWith<$Res>
    implements $SignUpDataModelCopyWith<$Res> {
  factory _$$SignUpDataModelImplCopyWith(_$SignUpDataModelImpl value,
          $Res Function(_$SignUpDataModelImpl) then) =
      __$$SignUpDataModelImplCopyWithImpl<$Res>;
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
class __$$SignUpDataModelImplCopyWithImpl<$Res>
    extends _$SignUpDataModelCopyWithImpl<$Res, _$SignUpDataModelImpl>
    implements _$$SignUpDataModelImplCopyWith<$Res> {
  __$$SignUpDataModelImplCopyWithImpl(
      _$SignUpDataModelImpl _value, $Res Function(_$SignUpDataModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of SignUpDataModel
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
    return _then(_$SignUpDataModelImpl(
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

class _$SignUpDataModelImpl implements _SignUpDataModel {
  const _$SignUpDataModelImpl(
      {required this.email,
      required this.password,
      required this.otp,
      required this.username,
      required this.firstName,
      required this.lastName,
      required this.phone});

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
    return 'SignUpDataModel(email: $email, password: $password, otp: $otp, username: $username, firstName: $firstName, lastName: $lastName, phone: $phone)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignUpDataModelImpl &&
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

  @override
  int get hashCode => Object.hash(
      runtimeType, email, password, otp, username, firstName, lastName, phone);

  /// Create a copy of SignUpDataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SignUpDataModelImplCopyWith<_$SignUpDataModelImpl> get copyWith =>
      __$$SignUpDataModelImplCopyWithImpl<_$SignUpDataModelImpl>(
          this, _$identity);
}

abstract class _SignUpDataModel implements SignUpDataModel {
  const factory _SignUpDataModel(
      {required final String email,
      required final String password,
      required final String otp,
      required final String username,
      required final String firstName,
      required final String lastName,
      required final String phone}) = _$SignUpDataModelImpl;

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

  /// Create a copy of SignUpDataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SignUpDataModelImplCopyWith<_$SignUpDataModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
