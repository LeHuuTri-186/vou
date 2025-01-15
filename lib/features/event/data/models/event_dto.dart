import '../../domain/entities/event_model.dart';

class EventDto {
  final String id;
  final String name;
  final String description;
  final String image;
  final DateTime startDate;
  final DateTime endDate;
  final int turnsPerDay;
  final bool hasLiked;

  EventDto({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.startDate,
    required this.endDate,
    required this.turnsPerDay,
    required this.hasLiked,
  });

  // Convert JSON to DTO
  factory EventDto.fromJson(Map<String, dynamic> json) {
    return EventDto(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      turnsPerDay: json['turnsPerDay'] as int,
      hasLiked: json['hasLiked'] as bool,
    );
  }

  // Convert DTO to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'turnsPerDay': turnsPerDay,
      'hasLiked': hasLiked,
    };
  }

  // Convert DTO to Entity
  EventModel toDomain() {
    return EventModel(
      id: id,
      name: name,
      description: description,
      image: image,
      startDate: startDate,
      endDate: endDate,
      turnsPerDay: turnsPerDay,
      hasLiked: hasLiked,
    );
  }

  // Convert Entity to DTO
  static EventDto fromDomain(EventModel model) {
    return EventDto(
      id: model.id,
      name: model.name,
      description: model.description,
      image: model.image,
      startDate: model.startDate,
      endDate: model.endDate,
      turnsPerDay: model.turnsPerDay,
      hasLiked: model.hasLiked,
    );
  }
}
