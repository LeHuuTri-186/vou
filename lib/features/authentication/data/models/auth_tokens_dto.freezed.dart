// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_tokens_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AuthTokensDto _$AuthTokensDtoFromJson(Map<String, dynamic> json) {
  return _AuthTokensDto.fromJson(json);
}

/// @nodoc
mixin _$AuthTokensDto {
  String get accessToken => throw _privateConstructorUsedError;
  String get refreshToken => throw _privateConstructorUsedError;

  /// Serializes this AuthTokensDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AuthTokensDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthTokensDtoCopyWith<AuthTokensDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthTokensDtoCopyWith<$Res> {
  factory $AuthTokensDtoCopyWith(
          AuthTokensDto value, $Res Function(AuthTokensDto) then) =
      _$AuthTokensDtoCopyWithImpl<$Res, AuthTokensDto>;
  @useResult
  $Res call({String accessToken, String refreshToken});
}

/// @nodoc
class _$AuthTokensDtoCopyWithImpl<$Res, $Val extends AuthTokensDto>
    implements $AuthTokensDtoCopyWith<$Res> {
  _$AuthTokensDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthTokensDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? refreshToken = null,
  }) {
    return _then(_value.copyWith(
      accessToken: null == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: null == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AuthTokensDtoImplCopyWith<$Res>
    implements $AuthTokensDtoCopyWith<$Res> {
  factory _$$AuthTokensDtoImplCopyWith(
          _$AuthTokensDtoImpl value, $Res Function(_$AuthTokensDtoImpl) then) =
      __$$AuthTokensDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String accessToken, String refreshToken});
}

/// @nodoc
class __$$AuthTokensDtoImplCopyWithImpl<$Res>
    extends _$AuthTokensDtoCopyWithImpl<$Res, _$AuthTokensDtoImpl>
    implements _$$AuthTokensDtoImplCopyWith<$Res> {
  __$$AuthTokensDtoImplCopyWithImpl(
      _$AuthTokensDtoImpl _value, $Res Function(_$AuthTokensDtoImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthTokensDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? refreshToken = null,
  }) {
    return _then(_$AuthTokensDtoImpl(
      accessToken: null == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: null == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AuthTokensDtoImpl
    with DiagnosticableTreeMixin
    implements _AuthTokensDto {
  const _$AuthTokensDtoImpl(
      {required this.accessToken, required this.refreshToken});

  factory _$AuthTokensDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthTokensDtoImplFromJson(json);

  @override
  final String accessToken;
  @override
  final String refreshToken;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthTokensDto(accessToken: $accessToken, refreshToken: $refreshToken)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AuthTokensDto'))
      ..add(DiagnosticsProperty('accessToken', accessToken))
      ..add(DiagnosticsProperty('refreshToken', refreshToken));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthTokensDtoImpl &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, accessToken, refreshToken);

  /// Create a copy of AuthTokensDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthTokensDtoImplCopyWith<_$AuthTokensDtoImpl> get copyWith =>
      __$$AuthTokensDtoImplCopyWithImpl<_$AuthTokensDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthTokensDtoImplToJson(
      this,
    );
  }

  @override
  AuthTokens toDomain() {
    // TODO: implement toDomain
    throw UnimplementedError();
  }
}

abstract class _AuthTokensDto implements AuthTokensDto {
  const factory _AuthTokensDto(
      {required final String accessToken,
      required final String refreshToken}) = _$AuthTokensDtoImpl;

  factory _AuthTokensDto.fromJson(Map<String, dynamic> json) =
      _$AuthTokensDtoImpl.fromJson;

  @override
  String get accessToken;
  @override
  String get refreshToken;

  /// Create a copy of AuthTokensDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthTokensDtoImplCopyWith<_$AuthTokensDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
