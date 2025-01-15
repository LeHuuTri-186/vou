import 'package:vou/features/shaker_game/domain/entities/roll_history_item.dart';

class RollHistoryItemDto {
  final DateTime date;
  final int order;

  RollHistoryItemDto({
    required this.date,
    required this.order,
  });

  factory RollHistoryItemDto.fromJson(
    Map<String, dynamic> json,
  ) =>
      RollHistoryItemDto(
        date: DateTime.parse(json["date"]),
        order: json["order"] as int,
      );

  RollHistoryItem toDomain() => RollHistoryItem(date: date, order: order);
}
