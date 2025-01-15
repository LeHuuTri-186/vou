import '../../domain/entities/puzzle_detail_model.dart';

class PuzzleDto {
  final int order;
  final int rate;

  PuzzleDto({required this.order, required this.rate});

  factory PuzzleDto.fromJson(Map<String, dynamic> json) {
    return PuzzleDto(
      order: json['order'],
      rate: json['rate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order': order,
      'rate': rate,
    };
  }

  // Converts DTO to Entity
  Puzzle toDomain() {
    return Puzzle(
      order: order,
      rate: rate,
    );
  }
}

class PrizeDto {
  final String promotionId;
  final int amount;

  PrizeDto({required this.promotionId, required this.amount});

  factory PrizeDto.fromJson(Map<String, dynamic> json) {
    return PrizeDto(
      promotionId: json['promotionId'],
      amount: json['amount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'promotionId': promotionId,
      'amount': amount,
    };
  }

  // Converts DTO to Entity
  Prize toDomain() {
    return Prize(
      promotionId: promotionId,
      amount: amount,
    );
  }
}

class PuzzleGameDto {
  final String gameOfEventId;
  final int sizeX;
  final int sizeY;
  final String puzzleImage;
  final bool allowTrade;
  final List<PuzzleDto> puzzles;
  final List<PrizeDto> prizes;

  PuzzleGameDto({
    required this.gameOfEventId,
    required this.sizeX,
    required this.sizeY,
    required this.puzzleImage,
    required this.allowTrade,
    required this.puzzles,
    required this.prizes,
  });

  factory PuzzleGameDto.fromJson(Map<String, dynamic> json) {
    return PuzzleGameDto(
      gameOfEventId: json['gameOfEventId'],
      sizeX: json['sizeX'],
      sizeY: json['sizeY'],
      puzzleImage: json['puzzleImage'],
      allowTrade: json['allowTrade'],
      puzzles: (json['puzzles'] as List)
          .map((puzzle) => PuzzleDto.fromJson(puzzle))
          .toList(),
      prizes: (json['prizes'] as List)
          .map((prize) => PrizeDto.fromJson(prize))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gameOfEventId': gameOfEventId,
      'sizeX': sizeX,
      'sizeY': sizeY,
      'puzzleImage': puzzleImage,
      'allowTrade': allowTrade,
      'puzzles': puzzles.map((puzzle) => puzzle.toJson()).toList(),
      'prizes': prizes.map((prize) => prize.toJson()).toList(),
    };
  }

  // Converts DTO to Entity
  PuzzleGame toDomain() {
    return PuzzleGame(
      gameOfEventId: gameOfEventId,
      sizeX: sizeX,
      sizeY: sizeY,
      puzzleImage: puzzleImage,
      allowTrade: allowTrade,
      puzzles: puzzles.map((puzzleDto) => puzzleDto.toDomain()).toList(),
      prizes: prizes.map((prizeDto) => prizeDto.toDomain()).toList(),
    );
  }
}
