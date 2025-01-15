

class EventModel {
  final String id;
  final String name;
  final String description;
  final String image;
  final DateTime startDate;
  final DateTime endDate;
  final int turnsPerDay;
  final bool hasLiked;

  EventModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.startDate,
    required this.endDate,
    required this.turnsPerDay,
    required this.hasLiked,
  });

  EventModel copyWith({
    String? id,
    String? name,
    String? description,
    String? image,
    DateTime? startDate,
    DateTime? endDate,
    int? turnsPerDay,
    bool? hasLiked,
  }) {
    return EventModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      turnsPerDay: turnsPerDay ?? this.turnsPerDay,
      hasLiked: hasLiked ?? this.hasLiked,
    );
  }
}
