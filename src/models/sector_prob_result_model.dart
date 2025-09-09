import '../domain/entities/_entities.dart';
import '../enums/_enums.dart';

class SectorProbResultModel implements SectorProbResultEntity {

  SectorProbResultModel({
    required this.id,
    required this.modelProbType,
    required this.minProbability,
    required this.absence,
    required this.repeat,
    required this.alternation,
    required this.ticTac,
  });
  @override
  late final String id;

  @override
  late final ModelProbType modelProbType;

  @override
  late final TrialProbEntity absence;

  @override
  late final TrialProbEntity repeat;

  @override
  late final TrialProbEntity alternation;

  @override
  late final TrialProbEntity ticTac;

  @override
  late final int minProbability;

  @override
  bool get hasProbability {
    if (highestPercent == null) return false;
    return highestPercent!.suggestion != null && highestPercent!.frequencyPercent > minProbability;
  }

  @override
  TrialProbEntity? get highestPercent {
    if ([absence, repeat, alternation, ticTac]
        .every((e) => e.frequencyPercent == repeat.frequencyPercent)) {
      return null;
    }

    TrialProbEntity? maxFreq;
    <TrialProbEntity, int>{
      absence: absence.frequencyPercent,
      repeat: repeat.frequencyPercent,
      alternation: alternation.frequencyPercent,
      ticTac: ticTac.frequencyPercent,
    }.map((k, v) {
      if (k.suggestion != null && (maxFreq?.frequencyPercent ?? 0) < v) maxFreq = k;
      return MapEntry(k, v);
    });
    return maxFreq;
  }
}
