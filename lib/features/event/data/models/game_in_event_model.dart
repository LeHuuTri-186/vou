import '../../domain/entities/game_in_event.dart';

class GameInEventDto {
  final String id;
  final String eventId;
  final String name;
  final String description;
  final String guide;
  final String image;
  final String gameId;

  GameInEventDto({
    required this.id,
    required this.eventId,
    required this.name,
    required this.description,
    required this.guide,
    required this.image,
    required this.gameId,
  });

  // Convert JSON to DTO
  factory GameInEventDto.fromJson(Map<String, dynamic> json) {
    return GameInEventDto(
      id: json['id'] as String,
      eventId: json['eventId'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      guide: json['guide'] as String,
      image: json['image'] as String,
      gameId: json['gameId'] as String,
    );
  }

  // Convert DTO to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'eventId': eventId,
      'name': name,
      'description': description,
      'guide': guide,
      'image': image,
      'gameId': gameId,
    };
  }

  // Convert DTO to Entity
  GameInEvent toDomain() {
    return GameInEvent(
      id: id,
      eventId: eventId,
      name: name,
      description: description,
      guide: guide,
      image: image,
      gameId: gameId,
    );
  }

  // Convert Entity to DTO
  static GameInEventDto fromDomain(GameInEvent entity) {
    return GameInEventDto(
      id: entity.id,
      eventId: entity.eventId,
      name: entity.name,
      description: entity.description,
      guide: entity.guide,
      image: entity.image,
      gameId: entity.gameId,
    );
  }
}
