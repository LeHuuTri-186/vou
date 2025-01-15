part of 'shaker_cubit.dart';

class ShakerState {
  final int score;
  final int shakeChance;
  final String stateShake;
  final bool isProcessingShake;

  const ShakerState({
    required this.score,
    required this.shakeChance,
    required this.stateShake,
    this.isProcessingShake = false,
  });

  ShakerState copyWith({
    int? score,
    int? shakeChance,
    String? stateShake,
    bool? isProcessingShake,
  }) {
    return ShakerState(
      score: score ?? this.score,
      shakeChance: shakeChance ?? this.shakeChance,
      stateShake: stateShake ?? this.stateShake,
      isProcessingShake: isProcessingShake ?? this.isProcessingShake,
    );
  }
}
