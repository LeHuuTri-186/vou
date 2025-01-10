// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EventDtoImpl _$$EventDtoImplFromJson(Map<String, dynamic> json) =>
    _$EventDtoImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      turnsPerDay: (json['turnsPerDay'] as num).toInt(),
    );

Map<String, dynamic> _$$EventDtoImplToJson(_$EventDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'turnsPerDay': instance.turnsPerDay,
    };
