// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EventDto _$EventDtoFromJson(Map<String, dynamic> json) {
  return _EventDto.fromJson(json);
}

/// @nodoc
mixin _$EventDto {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get image => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime get endDate => throw _privateConstructorUsedError;
  int get turnsPerDay => throw _privateConstructorUsedError;

  /// Serializes this EventDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EventDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EventDtoCopyWith<EventDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventDtoCopyWith<$Res> {
  factory $EventDtoCopyWith(EventDto value, $Res Function(EventDto) then) =
      _$EventDtoCopyWithImpl<$Res, EventDto>;
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      String image,
      DateTime startDate,
      DateTime endDate,
      int turnsPerDay});
}

/// @nodoc
class _$EventDtoCopyWithImpl<$Res, $Val extends EventDto>
    implements $EventDtoCopyWith<$Res> {
  _$EventDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EventDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? image = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? turnsPerDay = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      turnsPerDay: null == turnsPerDay
          ? _value.turnsPerDay
          : turnsPerDay // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EventDtoImplCopyWith<$Res>
    implements $EventDtoCopyWith<$Res> {
  factory _$$EventDtoImplCopyWith(
          _$EventDtoImpl value, $Res Function(_$EventDtoImpl) then) =
      __$$EventDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      String image,
      DateTime startDate,
      DateTime endDate,
      int turnsPerDay});
}

/// @nodoc
class __$$EventDtoImplCopyWithImpl<$Res>
    extends _$EventDtoCopyWithImpl<$Res, _$EventDtoImpl>
    implements _$$EventDtoImplCopyWith<$Res> {
  __$$EventDtoImplCopyWithImpl(
      _$EventDtoImpl _value, $Res Function(_$EventDtoImpl) _then)
      : super(_value, _then);

  /// Create a copy of EventDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? image = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? turnsPerDay = null,
  }) {
    return _then(_$EventDtoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      turnsPerDay: null == turnsPerDay
          ? _value.turnsPerDay
          : turnsPerDay // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EventDtoImpl implements _EventDto {
  const _$EventDtoImpl(
      {required this.id,
      required this.name,
      required this.description,
      required this.image,
      required this.startDate,
      required this.endDate,
      required this.turnsPerDay});

  factory _$EventDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$EventDtoImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final String image;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
  @override
  final int turnsPerDay;

  @override
  String toString() {
    return 'EventDto(id: $id, name: $name, description: $description, image: $image, startDate: $startDate, endDate: $endDate, turnsPerDay: $turnsPerDay)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.turnsPerDay, turnsPerDay) ||
                other.turnsPerDay == turnsPerDay));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, description, image,
      startDate, endDate, turnsPerDay);

  /// Create a copy of EventDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EventDtoImplCopyWith<_$EventDtoImpl> get copyWith =>
      __$$EventDtoImplCopyWithImpl<_$EventDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EventDtoImplToJson(
      this,
    );
  }

  @override
  EventModel toDomain() {
    return EventModel(
      id: id,
      name: name,
      description: description,
      image: image,
      startDate: startDate,
      endDate: endDate,
      turnsPerDay: turnsPerDay,
    );
  }
}

abstract class _EventDto implements EventDto {
  const factory _EventDto(
      {required final String id,
      required final String name,
      required final String description,
      required final String image,
      required final DateTime startDate,
      required final DateTime endDate,
      required final int turnsPerDay}) = _$EventDtoImpl;

  factory _EventDto.fromJson(Map<String, dynamic> json) =
      _$EventDtoImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  String get image;
  @override
  DateTime get startDate;
  @override
  DateTime get endDate;
  @override
  int get turnsPerDay;

  /// Create a copy of EventDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EventDtoImplCopyWith<_$EventDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
