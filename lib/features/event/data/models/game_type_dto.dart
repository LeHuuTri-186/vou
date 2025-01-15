import '../../domain/entities/game_type_model.dart';

class GameTypeDto {
  final String id;
  final String name;
  final String description;
  final String status;

  GameTypeDto({
    required this.id,
    required this.name,
    required this.description,
    required this.status,
  });

  // Factory constructor to create a GameDTO from JSON
  factory GameTypeDto.fromJson(Map<String, dynamic> json) {
    return GameTypeDto(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      status: json['status'] as String,
    );
  }

  // Method to convert GameDTO to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'status': status,
    };
  }

  // Method to map DTO to Entity
  GameType toDomain() {
    return GameType(
      name: name,
      description: description,
      status: status,
    );
  }

  // Method to create DTO from Entity
  factory GameTypeDto.fromEntity(GameType entity) {
    return GameTypeDto(
      id: '', // ID might not be present in the entity
      name: entity.name,
      description: entity.description,
      status: entity.status,
    );
  }
}
