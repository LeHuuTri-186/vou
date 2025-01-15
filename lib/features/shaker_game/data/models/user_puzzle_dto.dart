import 'package:vou/features/shaker_game/domain/entities/user_puzzle.dart';

class UserPuzzleDto {
  final int order;
  final int amount;

  UserPuzzleDto({required this.order, required this.amount});

  factory UserPuzzleDto.fromJson(
    Map<String, dynamic> json,
  ) =>
      UserPuzzleDto(
        order: json["order"] as int,
        amount: json["amount"] as int,
      );

  Map<String, dynamic> toJson() => {
        "order": order,
        "amount": amount,
      };

  UserPuzzle toDomain() => UserPuzzle(
        order: order,
        amount: amount,
      );
}
