import '../../data/models/puzzle_detail_dto.dart';

class Puzzle {
  final int order;
  final int rate;

  Puzzle({required this.order, required this.rate});

  factory Puzzle.fromDto(PuzzleDto dto) {
    return Puzzle(
      order: dto.order,
      rate: dto.rate,
    );
  }

  PuzzleDto toDto() {
    return PuzzleDto(
      order: order,
      rate: rate,
    );
  }
}

class Prize {
  final String promotionId;
  final int amount;

  Prize({required this.promotionId, required this.amount});

  factory Prize.fromDto(PrizeDto dto) {
    return Prize(
      promotionId: dto.promotionId,
      amount: dto.amount,
    );
  }

  PrizeDto toDto() {
    return PrizeDto(
      promotionId: promotionId,
      amount: amount,
    );
  }
}

class PuzzleGame {
  final String gameOfEventId;
  final int sizeX;
  final int sizeY;
  final String puzzleImage;
  final bool allowTrade;
  final List<Puzzle> puzzles;
  final List<Prize> prizes;

  PuzzleGame({
    required this.gameOfEventId,
    required this.sizeX,
    required this.sizeY,
    required this.puzzleImage,
    required this.allowTrade,
    required this.puzzles,
    required this.prizes,
  });

  factory PuzzleGame.fromDto(PuzzleGameDto dto) {
    return PuzzleGame(
      gameOfEventId: dto.gameOfEventId,
      sizeX: dto.sizeX,
      sizeY: dto.sizeY,
      puzzleImage: dto.puzzleImage,
      allowTrade: dto.allowTrade,
      puzzles: dto.puzzles.map((puzzleDto) => Puzzle.fromDto(puzzleDto)).toList(),
      prizes: dto.prizes.map((prizeDto) => Prize.fromDto(prizeDto)).toList(),
    );
  }

  PuzzleGameDto toDto() {
    return PuzzleGameDto(
      gameOfEventId: gameOfEventId,
      sizeX: sizeX,
      sizeY: sizeY,
      puzzleImage: puzzleImage,
      allowTrade: allowTrade,
      puzzles: puzzles.map((puzzle) => puzzle.toDto()).toList(),
      prizes: prizes.map((prize) => prize.toDto()).toList(),
    );
  }
}
