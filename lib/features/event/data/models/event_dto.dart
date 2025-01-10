import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/event_model.dart';

part 'event_dto.freezed.dart';
part 'event_dto.g.dart';

@freezed
class EventDto with _$EventDto {
  const factory EventDto({
    required String id,
    required String name,
    required String description,
    required String image,
    required DateTime startDate,
    required DateTime endDate,
    required int turnsPerDay,
  }) = _EventDto;

  factory EventDto.fromJson(Map<String, dynamic> json) => _$EventDtoFromJson(json);

  // Convert DTO to Model
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

  // Convert Model to DTO
  static EventDto fromDomain(EventModel model) {
    return EventDto(
      id: model.id,
      name: model.name,
      description: model.description,
      image: model.image,
      startDate: model.startDate,
      endDate: model.endDate,
      turnsPerDay: model.turnsPerDay,
    );
  }
}
