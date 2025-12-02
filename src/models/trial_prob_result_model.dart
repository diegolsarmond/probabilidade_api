import '../domain/entities/_entities.dart';
import '../enums/_enums.dart';

class TrialProbResultModel implements TrialProbResultEntity {

  TrialProbResultModel({
    required this.id,
    required this.modelProbType,
    required this.minProbability,
    required this.ladder,
    required this.hitAndTake,
    required this.repeat,
    required this.alternation,
    required this.ticTac,
  });

  @override
  late final String id;

  @override
  late final ModelProbType modelProbType;

  @override
  late final TrialProbEntity ladder;

  @override
  late final TrialProbEntity hitAndTake;

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
    if ([ladder, hitAndTake, repeat, alternation, ticTac]
        .every((e) => e.frequencyPercent == ladder.frequencyPercent)) {
      return null;
    }

    TrialProbEntity? maxFreq;
    <TrialProbEntity, int>{
      ladder: ladder.frequencyPercent,
      hitAndTake: hitAndTake.frequencyPercent,
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

class TrialProbResult implements TrialProbEntity {

  TrialProbResult({
    required this.key1,
    required this.key2,
    required this.key3,
    required this.frequencyPercent,
    required this.suggestion,
    required this.median,
    required this.distinctNumbers,
    required this.logicType,
  });

  factory TrialProbResult.fromMap({
    required Map<String, dynamic> map,
    required String key1,
    required String key2,
    required String key3,
    required LogicType logicType,
  }) {
    return TrialProbResult(
      key1: key1,
      key2: key2,
      key3: key3,
      frequencyPercent: map['frequency'] as int,
      suggestion: map['nextKey'] as String?,
      median: map['median'] as int,
      distinctNumbers: map['distinctNumbers'] as List<String>,
      logicType: logicType,
    );
  }

  @override
  Map<String, dynamic> get toMap => {
    'porcentagem': frequencyPercent,
    'sugestao': suggestion,
    'logica': logicType.nameTr,
  };

  @override
  late final String key1;

  @override
  late final String key2;

  @override
  late final String key3;

  @override
  late final int frequencyPercent;

  @override
  late final String? suggestion;

  @override
  late final int median;

  @override
  late final List<String> distinctNumbers;

  @override
  late final LogicType logicType;
}
